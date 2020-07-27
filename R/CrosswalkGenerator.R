if (!require(tidyverse)) { install.packages(tidyverse) }
library(tidyverse)


getCrosswalk = function(start, end) {
  start_switch = switch (start,
                         'bea_sector' = c(1,2),
                         'bea_summary' = c(3,4),
                         'bea_detail' = c(5,6),
                         'useeio1' = c(7,8,9),
                         'useeio2' = c(10,11,12),
                         'naics' = c(13,14)
  )
  end_switch = switch (end,
                         'bea_sector' = c(1,2),
                         'bea_summary' = c(3,4),
                         'bea_detail' = c(5,6),
                         'useeio1' = c(7,8,9),
                         'useeio2' = c(10,11,12),
                         'naics' = c(13,14)
  )
  
  raw = readr::read_csv('../data/extdata/Crosswalk_MasterCrosswalk.csv') %>% 
    select(start_switch, end_switch) 
  CW = unique(na.omit(raw))
  return(CW)
}

