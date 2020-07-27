
if (!require(tidyverse)) { install.packages(tidyverse) }
library(useeior)
library(tidyverse)

#' GetCountyPCERatio
#' 
#' Get county Personal Expenditure Ratio by using county personal income data
#' 
#' 
#' @param year A numeric value between 2001 and 2018 specifying the year of interest.
#' @return A data frame contains county Personal Expenditure Ratio at a specific year.
GetCountyPCERatio = function(year) {
  PC = readr::read_csv('../data/extdata/BEA_County/CAINC5N_GA_2001_2018.csv') %>%
    select(1:5, year-1994)
  colnames(PC)[ncol(PC)] = 'PCI'
  PCERatio = PC %>% 
    filter(LineCode == 10, GeoName != 'Georgia') %>% 
    mutate(PCI = as.numeric(PCI) * 1000, PCERatio = PCI / sum(PCI)) %>%
    select(1,2,6,7) %>% arrange(GeoName)
  return(PCERatio)
}

CalculateCountyPCEbyCommodity = function(year) {
  ## TODO: use PCERatio data to calculate county PCE Row as a component of final demand when state IO table is ready
}

