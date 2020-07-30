library(tidyverse)
source('CrosswalkGenerator.R')
source('supporter.R')
source('../../stateio/R/UtilityFunctions.R')
source('data-raw/BEAData.R')
#' getGeorgiaEmploymentData
#' 
#' This function is to return dataframes containing establishment count data at 
#' NAICS 6-digit level from the year of 2007 to 2019, during which QCEW data is available. 
#' WARNING: 
#' 
#' @param state A string character specifying the state of interest, default 'Georgia' 
#' WARNING: only 'Georgia' is supported now, please do not attempt to give input other than that
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
getStateEstablishmentData = function(state = 'Georgia', year) {
  # load total data (now GA only)
  ####TODO: find a way to load total df without having too much time and memory cost
  CountyEmp = load('data/CountyGA_QCEWEmployment_2007_2019.rda')
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


#' GetCountyEmploymentData
#' 
#' This function is to return dataframes binding employement data of each county from
#' the year of 2007 to 2019, during which QCEW data is available, into one data frame. 
#' 
#' 
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
GetCountyEmploymentData = function(state = 'Georgia', year) {
  GAcountyFIPS = getGACountyFIPS() %>% arrange(Name) # county fips
  allcounty = data.frame() # blank data frame
  
  for (fips in unique(GAcountyFIPS$fips)) {
    filename = paste0(GAcountyFIPS[GAcountyFIPS$fips == fips,]$Name,paste0(year,'.csv'))
    url = paste0('../data/extdata/QCEW_County_Emp/', paste0(paste0(year,"/"), filename))
    countyraw = readr::read_csv(url) 
    countytotal = countyraw %>% filter(own_code == '0') %>% select(area_fips, own_code, industry_code, year, annual_avg_estabs, annual_avg_emplvl, total_annual_wages) 
    countydetail = countyraw %>% 
      select(area_fips, own_code, industry_code, year, annual_avg_estabs, annual_avg_emplvl, total_annual_wages) %>%
      filter(own_code %in% c("1","2","3","5"), industry_code %in% NAICS2) %>% rbind(., countytotal)
    allcounty = rbind(allcounty, countydetail)
  }
  ##filename = paste0('../data/GACounty_Emp_Raw_', paste0(year,'.csv'))
  ##readr::write_csv(allcounty, filename)
  return(allcounty)
}



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



#' ComputeEstabLocationQuotient
#' 
#' Compute Establishment count LQ for each industry of each county
#' 
#' 
#' @param year Integer, A numeric value between 2015-2018 specifying the year of interest
#' @return A data frame containing data asked for at a specific year.
#' @export GACounty_SummaryEstabsLQ_xxxx.csv
ComputeEstabLocationQuotient = function(year) {
  CW = getCrosswalk('bea_summary','naics')
  colnames(CW) = c('BEA','BEA_DES','NAICS','NAICS_DES')
  CW = CW %>% filter(NAICS >= 1e+5)
  CW2 = readr::read_csv('../data/extdata/Crosswalk_CountyGDPtoBEASummaryIO2012Schema.csv')
  GAcountyFIPS = getGACountyFIPS() 
  GAcountyName = sort(GAcountyFIPS$Name)
  
  for (name in GAcountyName) {
    filename = paste0(name,paste0(year,'.csv'))
    url = paste0('../data/extdata/QCEW_County_Emp/', paste0(paste0(year,"/"), filename))
    countyraw = readr::read_csv(url) 
    countydetail = countyraw %>% 
      select(area_fips, own_code, industry_code, year, annual_avg_estabs) %>%
      mutate(industry_code = as.numeric(industry_code)) %>%
      filter(own_code %in% c("1","2","3","5"), industry_code >= 1e+5) %>%
      group_by(industry_code) %>% summarise(estab = sum(annual_avg_estabs))
    colnames(countydetail)[2] = paste0(name, ', GA')
    CW = CW %>% left_join(., countydetail, by = c('NAICS' = 'industry_code'))
    CW[is.na(CW)] = 0
    
  }
  
  CountyEstab = CW %>% 
    group_by(BEA,BEA_DES) %>% 
    summarise_if(is.numeric, sum) %>% 
    select(-3) %>% 
    full_join(.,CW2, by = c('BEA'= 'BEA_2012_Summary_Code')) %>%
    relocate(LineCodeSec, DescriptionSec, LineCodeSum, DescriptionSum, BEA_2012_Summary_Name, .after = BEA_DES) %>%
    select(-2,-4,-7) %>% arrange(LineCodeSum) %>% mutate(LineCodeSec = as.character(LineCodeSec))
  CountyEstab = CountyEstab[!is.na(CountyEstab$LineCodeSec),]
  CountyEstab[is.na(CountyEstab)] = 0
  CountyEstab  = CountyEstab %>% group_by(LineCodeSum) %>% summarise_if(is.numeric, sum)
  
  CountyLQ = CountyEstab
  
  CountyTotal = colSums(CountyLQ[,2:ncol(CountyLQ)])
  GATotal = sum(CountyTotal)
  for (row in (1:nrow(CountyLQ))) {
    GAIndtotal = sum(CountyLQ[row,2:ncol(CountyLQ)])
    for (col in (2:ncol(CountyLQ))) {
      if (GAIndtotal ==0) {
        CountyLQ[row,col] = 0
      } else {
        CountyLQ[row,col] = (CountyLQ[row,col] / CountyTotal[col-1]) / (GAIndtotal / GATotal)
      }
    }
  }
    
  return(CountyLQ)
}


#for (year in seq(2016,2018,1)) {
#filename = paste0("../data/GACounty_SummaryEstabsLQ_", paste0(year,'.csv'))
#lq = ComputeEstabLocationQuotient(year)
#write_csv(lq, filename)
#}

