library(tidyverse)
source('R/UtilityFunctions.R')
source('R/CountyEmployment.R')

#' getCountyTotalGDP
#' 
#' It returns the original county total GDP of one specified state 
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
  countyTotal = countyData[-1, c('GeoFIPS','GeoName', as.character(year))] %>% arrange(GeoName)
  countyTotal[[as.character(year)]] = 1000 * as.numeric(countyTotal[[as.character(year)]])
  return(countyTotal)
  
}
#a = getCountyTotalGDP(year, state)



#' getStateSectorGDP
#' 
#' It returns the original BEA-sector level GDP of one specified state 
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
#



#' getCountyRawSectorGDP
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



#' calculateStateSummarySectorGDPRatio
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
  cw = utils::read.table('inst/extdata/Crosswalk_CountyGDPtoBEASummaryIO2012Schema.csv', 
                         sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE)
  
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
    mutate(GDPRatio = 0) %>%
    select(-DescriptionSec, -DescriptionSum, -BEA_2012_Summary_Name)
  
  # assign GDPratio to each subsector
  for (i in 1:nrow(GDPRatio)) {
    if (!is.na(GDPRatio$LineCodeSec[i])) {
      GDPRatio$GDPRatio[i] = GDPRatio[[as.character(year)]][i] / GDPRatio[[as.character(year)]][which(GDPRatio$LineCode == GDPRatio$LineCodeSec[i])]
    }
  }
  
  # drop NA, which only exists in rows for sectors
  GDPRatio = na.omit(GDPRatio[,c('LineCode', 'LineCodeSec', 'GDPRatio')])
  
  return(GDPRatio)
}



#' estimateCountySummaryGDP
#' 
#' Break down sector-level GDP into summary-level GDP by state ratio and RAS
#' 
#' 
#' @param year Integer, A numeric value between 2015-2017 specifying the year of interest
#' @param ite Integer, times of iteration for RAS data reconciliation, 10000 as default
#' @return two data frames containing data asked for at a specific year: Column Error, Row Error
estimateCountySummaryGDP = function(year, iteration = 1000) {
  
  load("../data/extdata/State_GDP_2007_2019.rda")
  ## step1: initial allocation based on LQ-weighted gdp ratio
  rawratio = GetGeorgiaSummarySectorGDPRatio(year) %>% select(1,4,6)
  filename = paste0("../data/GACounty_SectorGDP_", paste0(year,'.csv'))
  sectorGDP = readr::read_csv(filename)
  summaryGDP = data.frame(LineCode = unique(rawratio$LineCode))
  
  filename2 = paste0("../data/GACounty_SummaryEstabsLQ_", paste0(year,'.csv'))
  LQ = readr::read_csv(filename2)
  
  for (c in 2:ncol(sectorGDP)) {
    countysector = sectorGDP %>% select(1,c) %>% right_join(.,rawratio, by = c('LineCode'='LineCodeSec'))
    colnames(countysector)[3] = 'LineCodeSum'
    countyLQ = LQ %>% select(1,c)
    colnames(countyLQ)[2] = "LQ"
    county = countysector %>% left_join(., countyLQ, by = 'LineCodeSum') %>% mutate(weightedRatio = 0, normalizedRatio = 0, adjusted = 0)
    
    for (sec in unique(county$LineCode)) {
      sumcodelist = unique(county[county$LineCode == sec,]$LineCodeSum)
      totalLQ = sum(county[county$LineCode == sec,]$LQ)
      if (totalLQ == 0) { next } else {
        for (sum in sumcodelist) {
          county[county$LineCodeSum == sum,]$weightedRatio = county[county$LineCodeSum == sum,]$GDPRatio * (county[county$LineCodeSum == sum,]$LQ / totalLQ)
        }
        for (sum in sumcodelist) {
          county[county$LineCodeSum == sum,]$normalizedRatio = county[county$LineCodeSum == sum,]$weightedRatio / sum (county[county$LineCode == sec,]$weightedRatio)
        }
      }
    }
    
    # compute new gdp ratio
    county[,'adjusted'] = county[2] * county$normalizedRatio
    # obtain original ratio for gov spending back becasue 85 is missing
    county[county$LineCode =='83',]$adjusted = as.numeric(county[county$LineCode =='83',][2,2]) * county[county$LineCode =='83',]$GDPRatio
    county[2] = county[8]
    summaryGDP = cbind(summaryGDP, county[2])
  }
  
  
  ### step2: RAS method to reconcile matrix (RAS based on sector)
  M2 = data.frame()
  
  for (code in unique(county$LineCode)) {
    sumcode = county[county$LineCode == code, ]$LineCodeSum
    M0 = as.matrix(summaryGDP[summaryGDP$LineCode %in% sumcode, 2:ncol(summaryGDP)])
    t_rs = State_GDP_2007_2019 %>% filter(GeoName == 'Georgia', LineCode %in% sumcode) %>% select(year - 2003)
    colnames(t_rs)[1] = 'sectorGDP'
    t_rs = t_rs$sectorGDP
    t_cs = t(as.matrix(sectorGDP[sectorGDP$LineCode == code, 2:ncol(sectorGDP)]))
    t_cs = as.vector(t_cs[,1])
    
    M1 = applyRAS(M0, t_rs, t_cs, relative_diff = NULL, absolute_diff = 0, max_itr = iteration)
    M2 = rbind(M2, M1)
  }
  M2 = cbind(summaryGDP[,'LineCode'], M2)
  colnames(M2)[1] = 'LineCode'

  return(M2)

}


#for (year in seq(2015,2017,1)) {
  #filename = paste0("../data/GACounty_SummaryGDP_", paste0(year,'.csv'))
  #gdp = EstimateCountySummaryGDP(year, iteration = 1000)
  #write_csv(gdp, filename)
#}







