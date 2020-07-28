if (!require(tidyverse)) { install.packages(tidyverse) }
library(tidyverse)
setwd("~/Documents/GitHub/stateio")
# source('CrosswalkGenerator.R')
# source('CountyEmployment.R')
source('../../stateio/R/UtilityFunctions.R')


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
  
  # assign ratio to each subsector
  for (i in 1:nrow(GDPRatio)) {
    if (!is.na(GDPRatio$LineCodeSec[i])) {
      GDPRatio$GDPRatio[i] = GDPRatio[[as.character(year)]][i] / GDPRatio[[as.character(year)]][which(GDPRatio$LineCode == GDPRatio$LineCodeSec[i])]
    }
  }
  # drop na, which is the row for sector
  GDPRatio = na.omit(GDPRatio[,c('LineCode', 'LineCodeSec', 'GDPRatio')])
  return(GDPRatio)
}






#' EstimateCountySectorGDP
#' 
#' Make estimation of blank rows from what GetCountyOriginalSectorGDP returned by c
#' ounty-state establishment ratio
#' 
#' 
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
#' @export GACounty_SectorGDP_xxxx.csv
EstimateCountySectorGDP = function(year) {
  # CrossWalk to BEA sector
  cw = readr::read_csv('../data/extdata/CrossWalk_NAICS2ToLineCode.csv')
  filename = paste0("../data/GACounty_estabs_", paste0(year,'.csv'))
  CountyEstabCount = readr::read_csv(filename) %>% 
    right_join(., cw, by = 'NAICS2') %>% 
    relocate(LineCode,.after = NAICS2) %>% 
    group_by(LineCode) %>%
    summarise_if(is.numeric, sum) %>% select(-1)
  
  # Calculate GDP difference
  RawGDP = GetCountyOriginalSectorGDP(year, 'all', 0) %>% select(-1)
  RawGDP[is.na(RawGDP)] = 0
  GDPRowDifference = RawGDP$Georgia - rowSums(RawGDP[,2:ncol(RawGDP)])
  
  filename2 = '../data/extdata/BEA_County/CAGDP2_GA_2001_2018.csv'
  SectorLevelLineCode = c(3,6,10,11,12,34,35,36,45,50,59,68,75,82,83) # sector level and total 
  t_cs = readr::read_csv(filename2) %>% 
    filter(!is.na(LineCode)) %>% 
    filter(LineCode == 1, GeoName != 'Georgia') %>% 
    arrange(GeoName) %>% select(year - (2001-9))
  colnames(t_cs)[1] = 'countyGDP'
  t_cs = as.numeric(t_cs$countyGDP) * 1000
  GDPColDifference = t_cs - colSums(RawGDP[,2:ncol(RawGDP)])
  
  # Replace NA by Estimated GDP
  # 1. estimate by county/state raio for each subsector
  CountyGDP = GetCountyOriginalSectorGDP(year, 'all', 0) %>% select(-1,-2)
  matrixKEY = is.na(CountyGDP)
  for (row in 1:(nrow(CountyGDP))) {
    key = which(is.na(CountyGDP[row,]))
    if (length(key) != 0 && sum(CountyEstabCount[row,key]) != 0) {
      ratio = CountyEstabCount[row,key] / sum(CountyEstabCount[row,key])
      CountyGDP[row,key] = ratio * GDPRowDifference[row]
    } else if (length(key) != 0 && sum(CountyEstabCount[row,key]) == 0) {
      CountyGDP[row,key] = GDPRowDifference[row] / length(key)
    }
  }

  # 2. RAS for data reconciliation
  M0 = CountyGDP
  for (row in (1:nrow(M0))) {
    for (col in (1:ncol(M0))) {
      if (matrixKEY[row,col] == TRUE) {
        M0[row,col] = M0[row,col]
      } else if (matrixKEY[row,col] == FALSE){
        M0[row,col] = 0
      }
    }
  }
  M1 = applyRAS(as.matrix(M0), GDPRowDifference, GDPColDifference, relative_diff = NULL, absolute_diff = 0, max_itr = 1000)
  
  for (row in 1:(nrow(CountyGDP))) {
    for (col in (1:ncol(CountyGDP))) {
      if (matrixKEY[row,col] == TRUE) {
        CountyGDP[row,col] = M1[row,col]
      } else if (matrixKEY[row,col] == FALSE) {
        next
      }
    }
  }

  # Add back original Column to the table
  CountyGDP = cbind(GetCountyOriginalSectorGDP(year, 'all', 0) %>% select(1), CountyGDP)
  return(CountyGDP)
}
#for (year in seq(2015,2018,1)) {
  #filename = paste0("../data/County_SectorGDP_", paste0(year,'.csv'))
  #gdp = EstimateCountySectorGDP(year)
  #write_csv(gdp, filename)
#}



#' EstimateCountySummaryGDP
#' 
#' Break down sector-level GDP into summary-level GDP by state ratio and RAS
#' 
#' 
#' @param year Integer, A numeric value between 2015-2017 specifying the year of interest
#' @param ite Integer, times of iteration for RAS data reconciliation, 10000 as default
#' @return two data frames containing data asked for at a specific year: Column Error, Row Error
EstimateCountySummaryGDP = function(year, iteration = 1000) {
  
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






#####################################################################################
################## DEPRECATED FUNCTIONS, PLEASE DO NOT USE THEM  ####################
#####################################################################################                                  


#' GetCountyOriginalSectorGDP (This function has been deprecated. New function is in /data-raw/BEAData.R)
#' 
#' It returns the original county GDP at BEA-sector level with NAs. 
#' 
#' 
#' @param year A numeric value between 2007 and 2018 specifying the year of interest.
#' @param county A string character specifying the county of interest, or 'all' for all data
#' @param axis A numeric value, 0,1. if 0, each geographical unit will be a col, if 1, row
#' @return A data frame contains selected county GDP by BEA sector industries at a specific year.
GetCountyOriginalSectorGDP = function(year, county, axis) {
  filename = '../data/extdata/BEA_County/CAGDP2_GA_2001_2018.csv'
  SectorLevelLineCode = c(3,6,10,11,12,34,35,36,45,50,59,68,75,82,83) # sector level and total 
  total = readr::read_csv(filename) %>% filter(!is.na(LineCode))
  colnum = which(colnames(total) == paste0('gdp',as.character(year)))
  
  total = total %>% 
    select(2,5, which(colnames(total) == paste0('gdp',as.character(year)))) %>% 
    filter(LineCode %in% SectorLevelLineCode) # filter by sepecific year
  
  colnames(total)[ncol(total)] = 'GDP'
  if (county == 'all'){
    total = total %>%  # retain only sector-level lines
      mutate(GDP = as.numeric(GDP) * 1000) %>% arrange(GeoName)# NA if not available
    totalCol = total %>% spread(GeoName, GDP) %>% relocate(Georgia, .after = LineCode) # transpose the table and put total to the front
    if (axis == 0){return(totalCol)} else if (axis ==1) {return(total)}
    
  } else {
    geoname = paste0(county,', GA')
    total = total %>%  # retain only sector-level lines
      mutate(GDP = as.numeric(GDP) * 1000) %>% # NA if not available
      filter(GeoName == geoname)
    totalCol = total %>% spread(GeoName, GDP) # transpose the table and put total to the front
    if (axis == 0){return(totalCol)} else if (axis ==1) {return(total)}
  }
}


