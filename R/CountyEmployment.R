library(tidyverse)
source('R/supporter.R')
#source('data-raw/BEAData.R')
#' getStateEstablishmentCount (MODIFIED)
#' 
#' This function is to return dataframes containing establishment count data at 
#' NAICS 6-digit level from the year of 2007 to 2019, during which QCEW data is available. 
#' 
#' @source CountyGA_QCEWEmployment_2007_2019.rda  (WARNING: THIS DATA SOURCE IS FOR GA ONLY NOW.)
#' @param state A string character specifying the state of interest, default 'Georgia' 
#' WARNING: only 'Georgia' is supported now, please do not attempt to give input other than that
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
getStateEstablishmentCount = function(state = 'Georgia', year) {
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
getCountyEstablishmentCount = function(state = 'Georgia', year) {
  # load total data (now GA only)
  load('data/CountyGA_QCEWEmployment_2007_2019.rda')
  # load County FIPS yellow page
  countyFIPS = getCountyFIPS(state = 'GA')
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


#' calculateEstabLocationQuotient
#' 
#' Compute Establishment count LQ for each industry of each county
#' @source getCountyEstablishmentCount, getStateEstablishmentCount, mapEstablishmentCountFromNAICStoBEA
#' @param state A string character specifying the state of interest, default 'Georgia' 
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
calculateEstabLocationQuotient = function(state = 'Georgia', year) {
  # load state and county data
  stateEstab = mapEstablishmentCountFromNAICStoBEA(state, year, 'state')
  countyEstab = mapEstablishmentCountFromNAICStoBEA(state, year, 'county')  
  
  # append county names to each row
  countyFIPS = getCountyFIPS(state = 'GA') ## ONLY OBTAIN GA
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
  }
  return(countyEstabColumn)
}









#####################################################################################
################## DEPRECATED FUNCTIONS, PLEASE DO NOT USE THEM  ####################
#####################################################################################    
#' EstimateCountyEmploymentData
#' 
#' This function is to return dataframes containing county-level employement data from
#' the year of 2015 to 2018, during which QCEW data is available, using the export from 
#' GetCountyEmployment Data. There are three types of employment data returned: employment count, 
#' emp compensation, and establishment counts, among which emp count and emp compensation.
#' 
#' 
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @param type Character, types of employment data,  'emp', 'comp' 'estabs'
#' @return A data frame containing data asked for at a specific year.
#' @export GACounty_Emp/estabs/Comp_xxxx.csv
EstimateCountyEmploymentData = function(year, type) {
  
  # preparation
  filename = paste0('../data/GACounty_Emp_Raw_', paste0(year,'.csv')) #export from GetCountyEmploymentData
  raw = readr::read_csv(filename) # raw county-lvl data
  GAlevel = GetGeorgiaEmploymentData(year) # call GA emp data
  NAICS2 = GAlevel$industry_code # industry codes
  GAcountyFIPS = getGACountyFIPS() %>% arrange(Name) # county fips
  Countytotal = raw %>% filter(own_code ==0) %>% left_join(., GAcountyFIPS, by = c('area_fips' = 'fips')) %>% arrange(Name) #call caounty total data
  CountyTable = data.frame() %>% rbind(as.data.frame(NAICS2)) # blank df
  
  
  
  ### ESTABLISHMENT 
  if (type == 'estabs') { # no estimation needed，true value output
    estabsTable = raw %>% 
      select(area_fips, industry_code, annual_avg_estabs) %>%
      filter(industry_code %in% NAICS2) %>%
      group_by(area_fips, industry_code) %>%
      summarise(estabs = sum(annual_avg_estabs)) %>% left_join(., GAcountyFIPS, by = c('area_fips' = 'fips')) %>%
      mutate(Name = paste0(Name, paste0('/',area_fips))) %>%
      rename(NAICS2 = industry_code)
    
    output = estabsTable[,c(2,3,4)] %>% arrange(Name) %>% spread(Name, estabs) #spread rows to columns
    output[is.na(output)] = 0  #set NA to 0 (no data loss here since NA appears when there is 0 estab in one industry of a county)
    
    return(output)
  }
  ##filename = paste0('../data/GACounty_estabs_', paste0(year,'.csv'))
  ##readr::write_csv(output, filename)
  
  
  ### EMPLOYMENT/EMP COMP 
  if (type %in% c('emp','comp')) { 
    empcompTable = raw %>% 
      select(area_fips, industry_code, annual_avg_estabs, annual_avg_emplvl, total_annual_wages) %>%
      filter(industry_code %in% NAICS2) %>% left_join(., GAlevel, by = 'industry_code')
    
    # Step1: use state average to fill in NAs
    filter = which(empcompTable$annual_avg_emplvl == 0) # find non-zero estab with zero emp and comp
    empcompTable$annual_avg_emplvl[filter] = empcompTable$annual_avg_estabs[filter] * empcompTable$empPerEstab[filter]
    empcompTable$total_annual_wages[filter] = empcompTable$annual_avg_estabs[filter] * empcompTable$compPerEstab[filter]
    empcompTable$isEst = 0
    empcompTable$isEst[filter] = 1
    
    step1table = empcompTable %>% 
      group_by(area_fips, industry_code) %>%
      summarise(estabs = sum(annual_avg_estabs), empEST = sum(annual_avg_emplvl), compEST = sum(total_annual_wages), isEST = sum(isEst) ) %>% left_join(., GAcountyFIPS, by = c('area_fips' = 'fips')) %>%
      mutate(Name = paste0(Name, paste0('/',area_fips))) %>%
      rename(NAICS2 = industry_code) %>% arrange(Name)
    
  }
  
  # Step2: RAS
  if (type == 'emp') {
    # divide original data into two matrices: true matrix containing with all NA equal 0 and adjuested matrix with all true value equal 0
    empstep1ADJ = step1table[step1table$isEST != 0, c(2,4,7)] %>% arrange(Name) %>% spread(Name, empEST)
    empstep1ADJ[is.na(empstep1ADJ)] = 0
    step1table$empEST[step1table$isEST != 0] = 0
    empstep1TRUE = step1table[, c(2,4,7)] %>% arrange(Name) %>% spread(Name, empEST)
    empstep1TRUE[is.na(empstep1TRUE)] = 0
    
    # apply RAS method
    M0 = as.matrix(empstep1ADJ %>% select(-1))
    rowDifference = GAlevel$emp - rowSums(empstep1TRUE %>% select(-1))
    colDifference = Countytotal$annual_avg_emplvl - colSums(empstep1TRUE %>% select(-1))
    M1 = applyRAS(M0, rowDifference, colDifference, relative_diff = NULL, absolute_diff = 100, max_itr = 10000)
    
    # add back and get final output
    output = cbind(empstep1TRUE[,1],round(empstep1TRUE[,2:160] + M1,0))
    
    return(output)
  }
  
  if (type == 'comp') {
    # divide original data into two matrices: true matrix containing with all NA equal 0 and adjuested matrix with all true value equal 0
    compstep1ADJ = step1table[step1table$isEST != 0, c(2,5,7)] %>% arrange(Name) %>% spread(Name, compEST)
    compstep1ADJ[is.na(compstep1ADJ)] = 0
    step1table$compEST[step1table$isEST != 0] = 0
    compstep1TRUE = step1table[, c(2,5,7)] %>% arrange(Name) %>% spread(Name, compEST)
    compstep1TRUE[is.na(compstep1TRUE)] = 0
    
    # apply RAS method
    M0 = as.matrix(compstep1ADJ %>% select(-1))
    rowDifference = GAlevel$comp - rowSums(compstep1TRUE %>% select(-1))
    colDifference = Countytotal$total_annual_wages - colSums(compstep1TRUE %>% select(-1))
    M1 = applyRAS(M0, rowDifference, colDifference, relative_diff = NULL, absolute_diff = 100, max_itr = 100000)
    
    # add back and get final output
    output = cbind(compstep1TRUE[,1],round(compstep1TRUE[,2:160] + M1,0))
    
    return(output)
  }
  
}





