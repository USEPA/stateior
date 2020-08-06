library(tidyverse)
source('R/UtilityFunctions.R')
source('R/CountyEmployment.R')

#' getCountyTotalGDP (MODIFIED)
#' 
#' It returns the original county total GDP of one state 
#' 
#' @param year A numeric value between 2001 and 2018 specifying the year of interest. If 0 ,return a dataframe with data from all years available
#' @param state A string character specifying the state of interest, 'Georgia' 
#' @return A data frame contains selected county GDP by BEA sector industries at a specific year.
getCountyTotalGDP = function(year, state) {
  # filter for specified state
  fileName = paste0('inst/extdata/CAGDP2/CAGDP2_', paste0(getStateAbbreviation(state),'_2001_2018.csv'))
  # read data 
  countyData = utils::read.table(fileName, 
                                 sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE) %>% filter(LineCode == 1)
  # select year
  countyTotal = countyData[-1, c('GeoFIPS','GeoName', as.character(year))] %>% arrange(GeoName)
  # change unit
  countyTotal[[as.character(year)]] = 1000 * as.numeric(countyTotal[[as.character(year)]])
  return(countyTotal)
  
}
#a = getCountyTotalGDP(year, state)



#' getStateSectorGDP (MODIFIED)
#' 
#' It returns the original BEA-sector level GDP of one state 
#' 
#' @param year A numeric value between 2007 and 2019 specifying the year of interest. If 0 ,return a dataframe with data from all years available
#' @param state A string character specifying the state of interest, 'Georgia' 
#' @return A data frame contains selected state GDP by BEA sector industries at a specific year.
getStateSectorGDP = function(year, state) {
  load('data/State_GDP_2007_2019.rda')
  sectorLineCode = c(3, 6, 10, 11, 12, 34, 35, 36, 45, 50, 59, 68, 75, 82, 83)
  stateGDP = State_GDP_2007_2019 %>% filter(GeoName == state, LineCode %in% sectorLineCode)
  stateGDP = stateGDP[, c('LineCode', as.character(year))]
  return(stateGDP)
}
#b = getStateSectorGDP(year, state)



#' getCountyRawSectorGDP (MODIFIED)
#' 
#' It returns the original county GDP at BEA sector level of one specified state 
#' 
#' @param year A numeric value between 2001 and 2018 specifying the year of interest. If 0 ,return a dataframe with data from all years available
#' @param state A string character specifying the state of interest, 'Georgia' 
#' @return A data frame contains selected county GDP by BEA sector industries at a specific year.
getCountyRawSectorGDP = function(year, state) {
  load('data/CountyGA_BEASectorGDP_2001_2018.rda')
  # filter for state and year
  namelist = getCountyFIPS(state)
  CountyRawGDP = CountyGA_BEASectorGDP_2001_2018[as.numeric(CountyGA_BEASectorGDP_2001_2018$GeoFIPS) %in% namelist$fips, c('GeoName', 'LineCode', as.character(year))] 
  colnames(CountyRawGDP)[ncol(CountyRawGDP)] = 'GDP'
  # spread to column
  CountyRawGDP_Column = CountyRawGDP %>% filter(LineCode != 1) %>%arrange(GeoName) %>% spread(GeoName, GDP)
  
  return(CountyRawGDP_Column)
}
#b = getCountyRawSectorGDP(year, state)



#' estimateCountySectorGDP (MODIFIED)
#' 
#' Make estimation of blank rows from what GetBEACountyGDP returned by county-state establishment count ratio
#' 
#' @param state A string character specifying the state of interest, default 'Georgia' 
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
estimateCountySectorGDP = function(state, year) {
  # CrossWalk estab count data to BEA sector
  cw = unique(getCrossWalk('bea_sector', 'naics2012') %>% 
                mutate(NAICS_2012_Code = as.numeric(NAICS_2012_Code)) %>% 
                na.omit() %>%
                filter(NAICS_2012_Code >= 1e+4, NAICS_2012_Code < 1e+5)
             )
  CountyEstabCount_Summary = getCountyEstablishmentCount(state, year)
  CountyEstabCount_Sector = CountyEstabCount_Summary %>% 
                                                     mutate(industry_code = floor(as.numeric(industry_code) / 10)) %>%
                                                     left_join(., cw, by = c('industry_code' = 'NAICS_2012_Code')) %>% 
                                                     group_by(area_fips, BEA_2012_Sector_Code) %>%
                                                     summarise(estabs_count = sum(estabs_count))
  
  # append county name to table, spread to column
  namelist = getCountyFIPS(state)
  CountyEstabCount_Sector = CountyEstabCount_Sector %>% 
                                                    left_join(., namelist, by = c('area_fips' = 'fips')) %>%
                                                    arrange(Name)
  CountyEstabCount_Sector_Column = CountyEstabCount_Sector[,c('BEA_2012_Sector_Code', 
                                                              'estabs_count', 
                                                              'Name')] %>% 
                                                                       spread(Name, estabs_count) %>%
                                                                       filter(!is.na(BEA_2012_Sector_Code))
  CountyEstabCount_Sector_Column[is.na(CountyEstabCount_Sector_Column)] = 0
  
  #load raw GDP
  CountyRawSectorGDP = getCountyRawSectorGDP(year,state)
    
  # Calculate GDP difference
  t_cs = getCountyTotalGDP(year, state)[[as.character(year)]]
  t_rs = getStateSectorGDP(year, state)[[as.character(year)]]
  diff = calculateRowColumnDiffernce(matrix = CountyRawSectorGDP[,2:ncol(CountyRawSectorGDP)], t_cs, t_rs)
    
  # Replace NA by Estimated GDP
  # Step 1. estimate by county/state raio for each subsector (rowdiff down to 0)
  matrixKEY = is.na(CountyRawSectorGDP[, 2:ncol(CountyRawSectorGDP)])
  M0 = fillNAwithRatioMatrix(matrix_to_fill = as.matrix(CountyRawSectorGDP[, 2:ncol(CountyRawSectorGDP)]), 
                        ratio_matrix = as.matrix(CountyEstabCount_Sector_Column[, 2:ncol(CountyEstabCount_Sector_Column)]), 
                        row_difference = diff$rowdiff)

  # Step 2. RAS for data reconciliation
  # update rowdiff and coldiff
  M0 = createMatrixForRASM0(matrixKEY, M0)
  M1 = applyRAS(as.matrix(M0), diff$rowdiff, diff$coldiff, relative_diff = NULL, absolute_diff = 1e+4, max_itr = 1e+4)
  
  # merge M1 and original raw table
  RawColumn = CountyRawSectorGDP[, 2:ncol(CountyRawSectorGDP)]
  for (row in 1:nrow(RawColumn)) {
    for (col in (1:ncol(RawColumn))) {
      if (matrixKEY[row,col] == TRUE) {
        RawColumn[row,col] = M1[row,col]
      } else if (matrixKEY[row,col] == FALSE) {
        next
      }
    }
  }
  # Add back original Column to the table
  CountySectorGDP = cbind(LineCode = CountyRawSectorGDP[,1], RawColumn)
  return(CountySectorGDP)
}
#a = estimateCountySectorGDP('Georgia', 2014)



#' calculateStateSummarySectorGDPRatio (MODIFIED)
#' 
#' It returns the state ratio of subsector level GDP to GDP of the sector which 
#' the subsector belongs to. All ratios from one sector sums up to 1.0. For instance,
#' Sector-level A is made up of A1 and A2, A1 makes up of 40% and A2 other 60%.  
#' 
#' @param year numeric, A numeric value between 2007 and 2017 specifying the year of interest. (2018/2019 data not available now)
#' @param state character string, the state of interest, full name with first letter capitalized, 'Georgia'. 
calculateStateSummarySectorGDPRatio = function(year, state) {
  #load raw state gdp data from stateio
  State_GDP_2007_2019 = stateio::State_GDP_2007_2019
  # load crosswalk file
  cw = unique(utils::read.table('inst/extdata/Crosswalk_CountyGDPtoBEASummaryIO2012Schema.csv', 
                         sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE) %>% select(LineCodeSec, LineCodeSum)
              )
  # obtain sector/summary linecode
  sector_linecode = unique(cw$LineCodeSec)
  summary_linecode = unique(cw$LineCodeSum)
  # specify state and year
  GDPRatio = State_GDP_2007_2019[State_GDP_2007_2019$GeoName == state, c('LineCode', as.character(year))] 
  # drop redundant line code 
  GDPRatio = GDPRatio[GDPRatio$LineCode %in% combine(sector_linecode, summary_linecode), ]
  # crosswalk by left join
  GDPRatio = GDPRatio %>%
                      left_join(., cw, by = c('LineCode' = 'LineCodeSum')) %>%
                      mutate(GDPRatio = 0)
  # assign GDPratio to each subsector
  for (i in 1:nrow(GDPRatio)) {
    if (!is.na(GDPRatio$LineCodeSec[i])) {
      GDPRatio$GDPRatio[i] = GDPRatio[[as.character(year)]][i] / GDPRatio[[as.character(year)]][which(GDPRatio$LineCode == GDPRatio$LineCodeSec[i])]
    }
  }
  # drop NA, which only exists in rows for sectors
  GDPRatio = na.omit(GDPRatio[,c('LineCode', 'LineCodeSec', 'GDPRatio')])
  
  # map line code to BEA summary
  cw2 = unique(utils::read.table('inst/extdata/Crosswalk_CountyGDPtoBEASummaryIO2012Schema.csv', 
                                sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE) %>% select(LineCodeSum, BEA_2012_Summary_Code)
              )
  GDPRatio_Summary = GDPRatio %>% left_join(., cw2[,c('LineCodeSum', 'BEA_2012_Summary_Code')], by = c('LineCode' = 'LineCodeSum'))
  # handle double count by even allocation
  doubleCount = GDPRatio_Summary %>% count(LineCode) %>% filter(n > 1)
  for (lc in doubleCount$LineCode) {
    GDPRatio_Summary[GDPRatio_Summary$LineCode == lc,]$GDPRatio =  GDPRatio_Summary[GDPRatio_Summary$LineCode == lc,]$GDPRatio / doubleCount[doubleCount$LineCode == lc,]$n
  }
  
  return(GDPRatio_Summary[, c('LineCodeSec', 'BEA_2012_Summary_Code', 'GDPRatio')] %>% arrange(BEA_2012_Summary_Code))
}
#a = calculateStateSummarySectorGDPRatio(2010, 'Georgia')



#' estimateCountySummaryGDP (MODIFIED)
#' 
#' Break down sector-level GDP into summary-level GDP by SummarySectorGDPRatio and RAS
#' 
#' 
#' @param year Integer, A numeric value between 2015-2017 specifying the year of interest
#' @param state character string, the state of interest, full name with first letter capitalized, 'Georgia'. 
#' @return A data frame containing data asked for at a specific year.
estimateCountySummaryGDP = function(year, state) {
  
  ## Step1: initial allocation based on LQ-weighted gdp ratio
  # load ratio, gdp data
  rawratio = calculateStateSummarySectorGDPRatio(year, state)
  sectorGDP = estimateCountySectorGDP(state, year)
  summaryGDP = data.frame(BEA_2012_Summary_Code = unique(rawratio$BEA_2012_Summary_Code))
  # load LQ data
  LQ = calculateEstabLocationQuotient(state, year)
  
  for (c in 2:ncol(sectorGDP)) {
    countysector = sectorGDP %>% select(1,c) %>% right_join(.,rawratio, by = c('LineCode'='LineCodeSec'))
    countyLQ = LQ %>% select(1,c)
    colnames(countyLQ)[2] = "LQ"
    county = countysector %>% left_join(., countyLQ, by = 'BEA_2012_Summary_Code') %>% mutate(weightedRatio = 0, normalizedRatio = 0, adjustedGDP = 0)
    
    if (length(county[is.na(county$LQ),]$LQ) != 0) {
      county[is.na(county$LQ),]$LQ = 0
    }
    
    for (sec in unique(county$LineCode)) {
      summaryCodeList = unique(county[county$LineCode == sec,]$BEA_2012_Summary_Code)
      
      totalLQ = sum(county[county$LineCode == sec,]$LQ)
      if (totalLQ == 0) { 
        county[county$BEA_2012_Summary_Code %in% summaryCodeList,]$normalizedRatio = 0
      } else {
        for (sum in summaryCodeList) {
          county[county$BEA_2012_Summary_Code == sum,]$weightedRatio = county[county$BEA_2012_Summary_Code == sum,]$GDPRatio * (county[county$BEA_2012_Summary_Code == sum,]$LQ / totalLQ)
        }
        for (sum in summaryCodeList) {
          county[county$BEA_2012_Summary_Code == sum,]$normalizedRatio = county[county$BEA_2012_Summary_Code == sum,]$weightedRatio / sum (county[county$LineCode == sec,]$weightedRatio)
        }
      }
    }
    
    # compute adjusted gdp 
    county[,'adjustedGDP'] = county[2] * county$normalizedRatio
    summaryGDP = left_join(summaryGDP, county[, c('BEA_2012_Summary_Code', 'adjustedGDP')], by = 'BEA_2012_Summary_Code')
    colnames(summaryGDP)[ncol(summaryGDP)] = colnames(county)[2]
  }
  
  ### step2: RAS method to reconcile matrix (RAS based on sector)
  M2 = data.frame()
  # map state gdp from line code to summary code
  yr = year
  State_GDP_2007_2019 = stateio::State_GDP_2007_2019
  stateGDP = State_GDP_2007_2019[State_GDP_2007_2019$GeoName == state,c('LineCode', as.character(year))]
  cw = unique(utils::read.table('inst/extdata/Crosswalk_CountyGDPtoBEASummaryIO2012Schema.csv', 
                                sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE) %>% select(LineCodeSum, BEA_2012_Summary_Code)
              )
  stateGDP_summary = stateGDP %>% filter(LineCode %in% cw$LineCodeSum) %>% left_join(., cw, by = c('LineCode' = 'LineCodeSum'))
  doubleCount = stateGDP_summary %>% count(LineCode) %>% filter(n > 1)
  for (lc in doubleCount$LineCode) {
    stateGDP_summary[stateGDP_summary$LineCode == lc,][[as.character(year)]] =  stateGDP_summary[stateGDP_summary$LineCode == lc,][[as.character(year)]] / doubleCount[doubleCount$LineCode == lc,]$n
  }
  # apply RAS to each sector
  for (code in unique(county$LineCode)) {
    sumcode = county[county$LineCode == code, ]$BEA_2012_Summary_Code
    M0 = as.matrix(summaryGDP[summaryGDP$BEA_2012_Summary_Code %in% sumcode, 2:ncol(summaryGDP)])
    stateRow = stateGDP_summary[stateGDP_summary$BEA_2012_Summary_Code %in% sumcode, ] %>% arrange(BEA_2012_Summary_Code)
    t_rs = stateRow[[as.character(year)]]
    t_cs = t(as.matrix(sectorGDP[sectorGDP$LineCode == code, 2:ncol(sectorGDP)]))
    t_cs = as.vector(t_cs[,1])
    
    M1 = round(applyRAS(M0, t_rs, t_cs, relative_diff = NULL, absolute_diff = 1e+4, max_itr = 1e+4), 1)
    M1 = cbind(stateRow$BEA_2012_Summary_Code, M1)
    M2 = rbind(M2, M1)
  }

  return(M2)

}
#a = estimateCountySummaryGDP(2016,'Georgia')







