#' getQCEWCountyEmployment
#' 
#' It returns county-level employment data of one specified state
#' level. Establishment count is 100% clean while employment count and compensation are not.
#' 
#' @param year A numeric value between 2007 and 2019 specifying the year of interest. If 0 ,return a dataframe with data from all years available
#' @param state A string character specifying the state of interest, default 'Georgia' 
#' @param type A string character specifying emp data types, 'establishment', 'compensation', 'employment' or 'all' , default 'establishment'
#' @return A data frame contains selected county GDP by BEA sector industries at a specific year.
getQCEWCountyEmployment = function(year, state = 'Georgia', type = 'establishment') {
  # Create the placeholder file
  CountyEmpFolder = "inst/extdata/QCEW_annual"
  # Download all BEA IO tables into the placeholder file (It may take long to run)
  if(!file.exists(CountyEmpFolder)) {
    # QCEW data is available on a yearly basis, although not ideal
    for (yr in seq(2007,2019,1)) {
      zipName = paste0(yr,'_annual_by_area.zip')
      fileName = paste0(yr,'.annual.by.area.csv')
      url = paste0('https://data.bls.gov/cew/data/files/', paste0(yr, paste0('/csv/', paste0(yr,'_annual_by_area.zip') )))
      download.file(url, paste0("inst/extdata/QCEW_annual/", zipName), mode = "wb")
      # Unzip the file to the designated directory
      unzip(paste0("inst/extdata/QCEW_annual/", zipName), files = fileName, exdir = CountyEmpFolder, overwrite = TRUE)
    }
  }
  # filter for specified year
  folderName = paste0('inst/extdata/QCEW_annual/', paste0(year,'.annual.by_area'))
  # filter for specified state
  fileList = list.files(folderName)
  countyEmp = data.frame()
  # loop through all counties in the folder, only choose those in our specified state, store them into one single table
  for (f in fileList) {
    if (grepl('Georgia', f, fixed = TRUE) && !grepl('Unknown', f, fixed = TRUE)) {
      tempDF = utils::read.table(paste0(folderName, paste0('/',f)), 
                                 sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE)
      countyEmp = rbind(countyEmp, tempDF)
    }
  }
  #filter for specified type
  type_switch = switch(type, 'establishment' = 'annual_avg_estabs_count', 'compensation' = 'total_annual_wages', 'employment' = 'annual_avg_emplvl', 'all' = c('annual_avg_estabs_count', 'annual_avg_emplvl', 'total_annual_wages'))
  # drop unnecessary columns
  countyEmp = countyEmp[countyEmp$own_code != 0, c('area_fips', 'own_code', 'industry_code', 'year', type_switch)]
  
  return(countyEmp)
}


CountyGA_QCEWEmployment_2007_2019 = data.frame()
for (yr in seq(2007,2019,1)) {
  temp = getQCEWCountyEmployment(yr, state = 'Georgia', type = 'all')
  CountyGA_QCEWEmployment_2007_2019 = rbind(CountyGA_QCEWEmployment_2007_2019, temp)
  # print('AHA!')
}
usethis::use_data(CountyGA_QCEWEmployment_2007_2019, overwrite = TRUE)