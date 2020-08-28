setwd("~/Documents/GitHub/USEEIOStateMethod/USAspending_API")
library(tidyverse)

CW = readr::read_csv('data/Crosswalk_MasterCrosswalk.csv') %>% select(5:6, 13:14)
colnames(CW) = c('BEA_CODE','BEA_IND','naics','n_ind')

data = readr::read_csv('data/GAawards.csv')

cw = CW  %>% na.omit() %>% filter(naics >= 100000) %>% unique()

data_combined = data %>% left_join(., cw, by = 'naics') %>% unique()