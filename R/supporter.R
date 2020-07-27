library(tidyverse)
#' getGACountyFIPS
#' 
#' This function is to return a dataframe containing name and fips of each county in 
#' Georgia in support of later data wrangling operations
#' 
#' 
#' @return A data frame contains all 159 names and FIPS for all counties in Georgia
getGACountyFIPS = function() {
  CountyCodes = readr::read_csv('../data/extdata/GA_County_FIPS.csv')
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
