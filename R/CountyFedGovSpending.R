if (!require(tidyverse)) { install.packages(tidyverse) }
library(tidyverse)
library(readr)
source('CrosswalkGenerator.R')

#' GetFedGovSpendingData
#' 
#' This function is to return dataframes containing Federal Government Spending data pulled
#' from USASpending API. Time ranges from 2008-2018.
#' 
#' 
#' @param year Integer, A numeric value between 2008-2018 specifying the year of interest
#' @param scope String, 'GAcounty' or 'state'
#' @param column String, 'intermediate', 'equipment', 'ip', or 'structure'
#' @param type String, 'defense', 'nondefense'
#' @return A data frame containing data asked for at a specific year.

GetFedGovSpendingData = function(year, scope, column, type) {
  # column selection
  filename = paste0('../USAspending_API/output/fedspending_', paste0(column, "_0724.csv"))
  df = readr::read_csv(filename)
  df$StartDate = parse_date(df$`Start Date`, format = '%m/%d/%y')
  df$EndDate = parse_date(df$`End Date`, format = '%m/%d/%y')
  
  # scope and year selection
  if (scope == 'GAcounty') {
    
    df = df[df$`Place of Performance State Code`=='GA', ] %>% filter(StartDate >= as.Date(paste0(year, '-01-01')), StartDate <= as.Date(paste0(year, '-12-31'))) %>%
      select(6, 7, 10, 11, 14)
    colnames(df) = c('amount', 'agency', 'state', 'zip', 'NAICS')
    
  } else {

    df = df[df$`Place of Performance State Code`=='GA', ] %>% filter(StartDate >= as.Date(paste0(year, '-01-01')), StartDate <= as.Date(paste0(year, '-12-31'))) %>%
      select(6, 7, 10, 11, 14)  ##### NOT IN USE
    colnames(df) = c('amount', 'agency', 'state', 'zip', 'NAICS')  ##### NOT IN USE
    
  }
  
  # type selection
  if (type == 'defense') {df = df %>% filter(agency == 'Department of Defense') %>% group_by(zip, NAICS) %>% summarise(amount = sum(amount))} 
  else {df = df %>% filter(agency != 'Department of Defense') %>% group_by(zip, NAICS) %>% summarise(amount = sum(amount))}
  
  # mapping from zip to county 
  map = readr::read_csv('../data/extdata/Crosswalk_GAZipCodeToCounty.csv')
  output = full_join(map, df, by  = 'zip') %>% select(1,3,4,5)
  output$county = paste0(output$county, paste0('/',output$fips))
  output[is.na(output)] = 0
  
  # spread rows into columns
  output = output %>% group_by(county, NAICS) %>% summarise(amount = sum(amount)) %>% spread(county, amount) %>% filter(NAICS != 0)
  output[is.na(output)] = 0
  
  # mapping from NAICS6 to BEA summary using functions from crosswalkGenerator
  indmap = getCrosswalk('bea_summary', 'naics')
  indmap = indmap[indmap$`2012_NAICS_Code` >= 100000, ]
  output = indmap %>% left_join(., output, by = c('2012_NAICS_Code' = 'NAICS'))
  output[is.na(output)] = 0
  colnames(output)[1] = 'BEA'
  output = output %>% select(1,5:ncol(output)) %>% group_by(BEA) %>% summarise_if(is.numeric, sum)
  
  return(output)
}



#test = GetFedGovSpendingData(2015, 'GAcounty', 'structure', 'defense')