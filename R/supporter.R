library(tidyverse)
source('R/CountyEmployment.R')
#' getCountyFIPS (MODIFIED)
#' 
#' This function is to return a dataframe containing name and fips of each county in 
#' selected state in support of later data wrangling operations
#' 
#' @param state A string character specifying the state of interest, default 'GA' 
#' @return A data frame contains all 159 names and FIPS for all counties in specified state
getCountyFIPS = function(state = 'GA') {
  CountyFIPS = readr::read_csv('inst/extdata/CountyFIPS.csv')
  CountyCodes = CountyFIPS[CountyFIPS$State == state, c('fips', 'Name')] %>% arrange(Name)
  return(CountyCodes)
} 


#' getIndustryCodes
#' 
#' This function is to return a list of containing industry codes of selected classification 
#' system.
#' 
#' 
#' @param type Character, types of classification system. 'naics', 'bea'
#' @param level character, resolution level naics: 2,3,4,5,6 ; bea: sector, summary, detail
#' 
#' @return A data frame contains all 159 names and FIPS for all counties in Georgia
getIndustryCodes = function(type, level) {
  Indcode = readr::read_csv('../data/extdata/Crosswalk_MasterCrosswalk.csv')
  if (type == 'naics') {
    n_switch = switch(level, '2' = 10, '3' = 100, '4' = 1000, '5' = 10000, '6' = 100000)
    filter = between(Indcode$'2012_NAICS_Code', n_switch, n_switch * 10-0.000001)
    naicsCode = na.omit(unique(Indcode$'2012_NAICS_Code'[filter]))
    
    return(naicsCode)
  }
  if (type == 'bea') {
    b_switch = switch(level, 'sector' = 'BEA_15_Code', 'summary' = 'BEA_71_Code', 'detail' = 'BEA_389_Code')
    filter = which(colnames(Indcode) == b_switch)
    beaCode = na.omit(unique(Indcode[, b_switch]))
    
    return(beaCode)
  }
}



#' getCrossWalk (MODIFIED)
#' 
#' This function is to return a dataframe containing the crosswalk of two different industry
#' classification system ('bea_sector', 'bea_summary', 'bea_detail', 'naics2007', 'naics2012', 'naics2017')
#' 
#' @param start A string character specifying the start point 
#' @param end A string character specifying the end point 
#' @return A data frame contains the croswalk table
getCrossWalk = function(start, end) {
  CW = useeior::MasterCrosswalk2012
  start_switch = switch (start,
                         'bea_sector' = 1,
                         'bea_summary' = 2,
                         'bea_detail' = 3,
                         'naics2012' = 4,
                         'naics2007' = 5,
                         'naics2017' = 6
  )
  end_switch = switch (end,
                       'bea_sector' = 1,
                       'bea_summary' = 2,
                       'bea_detail' = 3,
                       'naics2012' = 4,
                       'naics2007' = 5,
                       'naics2017' = 6
  )
  
  CW = unique(CW[, c(start_switch, end_switch)])
  return(CW)
}



#' mapEstablishmentCountFromNAICStoBEA (MODIFIED)
#' 
#' This function is to return a dataframe containing establishment count data at BEA-summary level.
#' 
#' @param state A string character specifying the state of interest, default 'Georgia'
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @param scope A string character specifying output type. 'state' to return state data and 'county' to return county data
#' @return A data frame contains the croswalk table
mapEstablishmentCountFromNAICStoBEA = function(state = 'Georgia', year, scope) {
  # load crosswalk map
  CW_BtN = getCrossWalk('bea_summary','naics2012') %>% 
    mutate(NAICS_2012_Code = as.numeric(NAICS_2012_Code)) %>%
    na.omit() %>%
    filter(NAICS_2012_Code >= 1e+4, NAICS_2012_Code < 1e+5)
  CW_LtB = utils::read.table('inst/extdata/Crosswalk_StateGDPtoBEASummaryIO2012Schema.csv', 
                             sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE)[, c('LineCode', 'BEA_2012_Summary_Code')]
  # map NAICS6 to BEA Summary
  ### BE CAREFUL. BLS DATA CONTAINS 6-DIGIT NAICS THAT NOT INCLUDED IN OFFICIAL NAICS. 
  ### OUR SOLUTION IS TO COERCE 6-DIGIT INTO 5-DIGIT TO AVOID DISCREPANCY.
  if (scope == 'county') {
    countyCount = getCountyEstablishmentCount(state, year)
    countyCount_BEA = countyCount %>%
      mutate(industry_code = floor(industry_code / 10)) %>% 
      left_join(., CW_BtN, by = c('industry_code' = 'NAICS_2012_Code')) %>%
      group_by(area_fips, BEA_2012_Summary_Code) %>%
      summarise(estabs_count = sum(estabs_count)) %>%
      na.omit()
    return(countyCount_BEA)
  } else {
    stateCount = getStateEstablishmentCount(state, year)
    stateCount_BEA = stateCount %>% 
      mutate(industry_code = floor(industry_code / 10)) %>% 
      left_join(., CW_BtN, by = c('industry_code' = 'NAICS_2012_Code')) %>%
      group_by(BEA_2012_Summary_Code) %>%
      summarise(estabs_count = sum(estabs_count)) %>%
      na.omit() 
    return(stateCount_BEA)
  }
}
