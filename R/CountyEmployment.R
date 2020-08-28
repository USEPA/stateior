library(tidyverse)
#source('R/UtilityFunctions.R')
#' getStateEstablishmentCount (MODIFIED)
#' 
#' This function is to return dataframes containing establishment count data at 
#' NAICS 6-digit level from the year of 2007 to 2019, during which QCEW data is available. 
#' 
#' @source CountyGA_QCEWEmployment_2007_2019.rda  (WARNING: THIS DATA SOURCE IS FOR GA ONLY NOW.)
#' @param state A string character specifying the state of interest, 'Georgia' 
#' WARNING: only 'Georgia' is supported now, please do not attempt to give input other than that
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
getStateEstablishmentCount = function(state, year) {
  # load total data (now GA only)
  ####TODO: find a way to load total df without having too much time and memory cost
  load('data/CountyGA_QCEWEmployment_2007_2019.rda')
  
  # load State FIPS yellow page
  StateFIPS = utils::read.table('inst/extdata/StateFIPS.csv', 
                                sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE)
  
  # filter statewide only
  fips = paste0(StateFIPS$State_FIPS[which(StateFIPS$State == state)], '000')
  yr = year # to avoid confusion in 'filter' operation below
  StateEmp = CountyGA_QCEWEmployment_2007_2019 %>% 
                         filter(area_fips == fips, year == yr) %>% # filter for area and time 
                         mutate(industry_code = as.numeric(industry_code)) %>% # NA coerced for industry codes like '44-45'
                         filter(industry_code >= 1e+5) %>%  # only retain NAICS6
                         select(area_fips, own_code, industry_code, year, annual_avg_estabs_count) %>%
                         group_by(industry_code, own_code) %>%
                         summarise(estabs_count = sum(annual_avg_estabs_count)) %>%
                         select(-own_code)
  
  
  return(StateEmp)
}
#a = getStateEstablishmentCount(year = 2015, state = 'Georgia')



#' getCountyEstablishmentCount (MODIFIED)
#' 
#' This function is to return dataframes containing establishment count data of each county in
#' NAICS 6-digit level from the year of 2007 to 2019, during which QCEW data is available and map 
#' it to BEA-summary level 
#' 
#' @source CountyGA_QCEWEmployment_2007_2019.rda (WARNING: THIS DATA SOURCE IS FOR GA ONLY NOW.)
#' @param state A string character specifying the state of interest, default 'Georgia' 
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
getCountyEstablishmentCount = function(state, year) {
  # load total data (now GA only)
  load('data/CountyGA_QCEWEmployment_2007_2019.rda')
  
  # load County FIPS yellow page
  countyFIPS = getCountyFIPS(state)
  yr = year
  
  # data wrangling
  countyEmp = CountyGA_QCEWEmployment_2007_2019 %>%
                                                filter(year == yr, area_fips %in% countyFIPS$fips) %>%
                                                mutate(industry_code = as.numeric(industry_code)) %>%
                                                filter(industry_code >= 1e+5) %>%  # only retain NAICS6
                                                select(area_fips, own_code, industry_code, year, annual_avg_estabs_count) %>%
                                                group_by(area_fips, industry_code, own_code) %>%
                                                summarise(estabs_count = sum(annual_avg_estabs_count))  %>%
                                                select(-own_code)
  
  return(countyEmp)
}
#a = getCountyEstablishmentCount(year = 2015, state = 'Georgia')



#' mapEstablishmentCountFromNAICSToBEA (MODIFIED)
#' 
#' This function is to return dataframes containing establishment count data of each county at
#' BEA sumamry or sector level from the year of 2007 to 2019, during which QCEW data is available 
#' 
#' @param state  character string specifying the state of interest, 'Georgia' 
#' @param type  character string, 'state' or 'county'
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
mapEstablishmentCountFromNAICStoBEASummary = function(type, year, state) {
  # load cw file and perform level filtering
  cw = unique(getCrossWalk('bea_summary', 'naics2012') %>% 
                                                mutate(NAICS_2012_Code = as.numeric(NAICS_2012_Code)) %>% 
                                                na.omit() %>%
                                                filter(NAICS_2012_Code >= 1e+4, NAICS_2012_Code < 1e+5)
              )
  # type choice
  if (type == 'state') {
    raw = getStateEstablishmentCount(state, year)
    # Coerce 6-digit NAICS to 5-digit
    raw$industry_code = floor(raw$industry_code / 10)
    # CrossWalk
    crossed = raw %>% 
      left_join(., cw, by = c('industry_code' = 'NAICS_2012_Code')) %>%
      group_by(BEA_2012_Summary_Code) %>%
      summarise(estabs_count = sum(estabs_count)) %>%
      filter(!is.na(BEA_2012_Summary_Code))
    
    crossed = full_join(crossed, data.frame(BEA_2012_Summary_Code = unique(cw$BEA_2012_Summary_Code)), by = 'BEA_2012_Summary_Code') %>% arrange(BEA_2012_Summary_Code)
    crossed[is.na(crossed$estabs_count),]$estabs_count = 0
    
    return(crossed)
  } else {
    raw = getCountyEstablishmentCount(state, year)
    # Coerce 6-digit NAICS to 5-digit
    raw$industry_code = floor(raw$industry_code / 10)
    # CrossWalk
    crossed = raw %>% 
      left_join(., cw, by = c('industry_code' = 'NAICS_2012_Code')) %>%
      group_by(BEA_2012_Summary_Code, area_fips) %>%
      summarise(estabs_count = sum(estabs_count)) %>%
      filter(!is.na(BEA_2012_Summary_Code))
  
    return(crossed)
  }
}
#a = mapEstablishmentCountFromNAICStoBEASummary('county', 2015, 'Georgia')



#' calculateEstabLocationQuotient (MODIFIED)
#' 
#' Compute Establishment count LQ for each industry of each county
#' @source getCountyEstablishmentCount, getStateEstablishmentCount, mapEstablishmentCountFromNAICStoBEA
#' @param state A string character specifying the state of interest, default 'Georgia' 
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
calculateEstabLocationQuotient = function(state, year) {
  # load state and county data
  stateEstab = mapEstablishmentCountFromNAICStoBEASummary('state', year, state)
  countyEstab = mapEstablishmentCountFromNAICStoBEASummary('county', year, state)  
  # append county names to each row
  countyFIPS = getCountyFIPS(state) ## ONLY OBTAIN GA
  countyEstab = countyEstab %>%
                            left_join(., countyFIPS, by = c('area_fips' = 'fips')) %>%
                            mutate(Name = paste0(Name, paste0('/',as.character(area_fips)))) %>%
                            arrange(Name)
  # spread countyEstab 
  countyEstabColumn = countyEstab[, c('Name', 'BEA_2012_Summary_Code', 'estabs_count')] %>%
                            spread(Name, estabs_count)
  # fill NA with 0 
  countyEstabColumn[is.na(countyEstabColumn)] = 0
  # calculate state industry ratio
  stateRatio = stateEstab$estabs_count / sum(stateEstab$estabs_count)
  # calculate county industry ratio
  for (ct in (2:ncol(countyEstabColumn))) {
    countyEstabColumn[, ct] = as.vector(countyEstabColumn[, ct] / sum(countyEstabColumn[, ct]) / stateRatio)
    countyEstabColumn[[ct]][is.na(countyEstabColumn[[ct]])] = 0
    countyEstabColumn[[ct]][!is.finite(countyEstabColumn[[ct]])] = 0
    
  }
  # append row that have 0 estabs
  LQ = countyEstabColumn %>% right_join(., stateEstab[,c('BEA_2012_Summary_Code')], by = 'BEA_2012_Summary_Code') %>% arrange(BEA_2012_Summary_Code)
  LQ[is.na(LQ)] = 0
  
  return(LQ)
}
#a = calculateEstabLocationQuotient(state, year)













