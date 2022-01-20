#' Get BEA state data from 2007-2017.
#' @param dataname A text indicating what state data to get.
#' Can be GVA, employee compensation, taxes, and gross operating surplus.
#' @return A data frame of BEA state data from 2007-2017.
getBEAStateData <- function (dataname) {
  # Create the placeholder file
  StateGVAzip <- "inst/extdata/SAGDP.zip"
  # Download all BEA IO tables into the placeholder file
  if(!file.exists(StateGVAzip)) {
    utils::download.file("https://apps.bea.gov/regional/zip/SAGDP.zip",
                         StateGVAzip, mode = "wb")
    # Get the name of all files in the zip archive
    tmp <- unzip(StateGVAzip, list = TRUE)
    fname <- tmp[tmp$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(StateGVAzip, files = fname, exdir = "inst/extdata/SAGDP",
          overwrite = TRUE)
  }
  # Determine data filename
  if (dataname=="GVA") {
    FileName <- "inst/extdata/SAGDP/SAGDP2N__ALL_AREAS_1997_2019.csv"
  } else if (dataname=="Tax") {
    FileName <- "inst/extdata/SAGDP/SAGDP3N__ALL_AREAS_1997_2017.csv"
  } else if (dataname=="Compensation") {
    FileName <- "inst/extdata/SAGDP/SAGDP4N__ALL_AREAS_1997_2017.csv"
  } else if (dataname=="GOS") {
    FileName <- "inst/extdata/SAGDP/SAGDP7N__ALL_AREAS_1997_2017.csv"
  }
  year_cols <- as.character(2007:2017)
  # Load state data
  StateData <- utils::read.table(FileName, sep = ",", header = TRUE,
                                 stringsAsFactors = FALSE, check.names = FALSE,
                                 fill = TRUE)
  StateData <- StateData[!is.na(StateData$LineCode), ]
  # Convert values to numeric
  StateData[, year_cols] <- sapply(StateData[, year_cols], as.numeric)
  # Convert values to current US $
  if (unique(StateData$Unit)=="Millions of current dollars") {
    StateData[, year_cols] <- StateData[, year_cols]*1E6
  } else if (unique(StateData$Unit)=="Thousands of dollars") {
    StateData[, year_cols] <- StateData[, year_cols]*1E3
  }
  # Keep state-level data
  geo_names <- c(state.name, "District of Columbia", "United States *")
  StateData <- StateData[StateData$GeoName %in%geo_names,
                         c("GeoName", "LineCode", "Description", year_cols)]
  # Write data to .rds
  data_name <- paste("State", dataname, "2007_2017",
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = StateData,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = "2007-2017",
                                source = "US Bureau of Economic Analysis",
                                url = "https://apps.bea.gov/regional/zip/SAGDP.zip")
}
# Download, save and document 2007-2017 state economic data (from BEA)
for (dataname in c("GVA", "Tax", "Compensation", "GOS")) {
  getBEAStateData(dataname)
}

#' Get BEA state employment (full-time and part-time) data from 2009-2018
#' @return A data frame of BEA state employment data from 2009-2018.
getBEAStateEmployment <- function () {
  APIkey <- readLines(rappdirs::user_data_dir("BEA_API_KEY.txt"), warn = FALSE)
  linecodes_txt <- paste0("https://apps.bea.gov/api/data/?&UserID=",
                          APIkey,
                          "&method=GetParameterValuesFiltered",
                          "&datasetname=Regional",
                          "&TargetParameter=LineCode",
                          "&TableName=SAEMP25N",
                          "&ResultFormat=json")
  linecodes <- jsonlite::fromJSON(linecodes_txt)
  StateEmployment <- data.frame()
  for (linecode in linecodes$BEAAPI$Results$ParamValue$Key) {
    StateEmployment_linecode_txt <- paste0("https://apps.bea.gov/api/data/?&UserID=",
                                           APIkey,
                                           "&method=GetData",
                                           "&datasetname=Regional",
                                           "&TableName=SAEMP25N",
                                           "&LineCode=", linecode,
                                           "&GeoFIPS=STATE",
                                           "&Year=Last10",
                                           "&ResultFormat=json")
    StateEmployment_linecode <- jsonlite::fromJSON(StateEmployment_linecode_txt)
    StateEmployment_linecode <- StateEmployment_linecode$BEAAPI$Results$Data
    if (is.null(StateEmployment_linecode$NoteRef)) {
      StateEmployment_linecode$NoteRef <- ""
    }
    StateEmployment_linecode$LineCode <- linecode
    datavalue_new <- as.numeric(gsub(",", "", StateEmployment_linecode$DataValue))
    StateEmployment_linecode$DataValue <- datavalue_new
    StateEmployment <- rbind(StateEmployment, StateEmployment_linecode)
    # print(linecode)
  }
  # Reshape to wide table
  StateEmployment <- reshape2::dcast(StateEmployment,
                                     GeoFips + GeoName + LineCode ~ TimePeriod,
                                     value.var = "DataValue")
  # Write data to .rds
  data_name <- paste("State_Employment_2009_2018",
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = StateEmployment,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = "2009-2018",
                                source = "US Bureau of Economic Analysis",
                                url = "https://apps.bea.gov/api")
}
# Download, save and document 2009-2018 state employment data (from BEA)
getBEAStateEmployment()

#' Get BEA state PCE (personal consumption expenditures) data from 2007-2018
#' @return A data frame of BEA state PCE data from 2007-2018.
getBEAStatePCE <- function () {
  # Create the placeholder file
  StatePCEzip <- "inst/extdata/SAPCE.zip"
  # Download all BEA IO tables into the placeholder file
  if(!file.exists(StatePCEzip)) {
    utils::download.file("https://apps.bea.gov/regional/zip/SAPCE.zip",
                         StatePCEzip, mode = "wb")
    # Get the name of all files in the zip archive
    tmp <- unzip(StatePCEzip, list = TRUE)
    fname <- tmp[tmp$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(StatePCEzip, files = fname, exdir = "inst/extdata/SAPCE",
          overwrite = TRUE)
  }
  # Load state PCE data
  StatePCE <- utils::read.table("inst/extdata/SAPCE/SAPCE1__ALL_AREAS_1997_2018.csv",
                                sep = ",", header = TRUE, stringsAsFactors = FALSE,
                                check.names = FALSE, fill = TRUE)
  StatePCE <- StatePCE[!is.na(StatePCE$Line), ]
  # Replace NA with zero
  StatePCE[is.na(StatePCE)] <- 0
  # Convert values to current US $
  year_cols <- as.character(2007:2018)
  StatePCE[, year_cols] <- StatePCE[, year_cols]*1E6
  # Keep state-level data
  StatePCE <- StatePCE[StatePCE$GeoName %in%
                         c(state.name, "District of Columbia", "United States"),
                       c("GeoName", "Line", "Description", year_cols)]
  # Write data to .rds
  data_name <- paste("State_PCE_2007_2018",
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = StatePCE,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = "2007-2018",
                                source = "US Bureau of Economic Analysis",
                                url = "https://apps.bea.gov/regional/zip/SAPCE.zip")
}
# Download, save and document 2007-2018 state PCE data (from BEA)
getBEAStatePCE()

#' Download BEA US Gov Expenditure data (NIPA table) from 2007-2019.
#' @return A data frame of BEA US Gov Expenditure data (NIPA table) from 2007-2019.
downloadBEAGovExpenditure <- function() {
  TableName <- "Section3All_xls.xlsx"
  FileName <- paste0("inst/extdata/StateLocalGovFinances/", TableName)
  url <- "https://apps.bea.gov/national/Release/XLS/Survey/Section3All_xls.xlsx"
  # Download NIPA table file
  if(!file.exists(FileName)) {
    utils::download.file(url, FileName, mode = "wb")
  }
  return(url)
}

#' Get US Gov Investment data (Table 3.9.5 annual) from 2007-2019.
#' @return A data frame of BEA US Gov Investment data from 2007-2019.
getBEAGovInvestment <- function() {
  # Download US Gov Expenditure (NIPA table) from BEA
  url <- downloadBEAGovExpenditure()
  # Load Gov Investment table
  TableName <- "Section3All_xls.xlsx"
  FileName <- paste0("inst/extdata/StateLocalGovFinances/", TableName)
  GovInvestment <- as.data.frame(readxl::read_excel(FileName, sheet = "T30905-A",
                                                    col_names = TRUE, skip = 7))
  # Assign column name to the description column
  colnames(GovInvestment)[2] <- "Description"
  # Keep wanted columns
  year_cols <- as.character(2007:2019)
  GovInvestment <- GovInvestment[complete.cases(GovInvestment),
                                 c("Line", "Description", year_cols)]
  # Convert values from million $ to $
  GovInvestment[, year_cols] <- GovInvestment[, year_cols]*1E6
  # Write data to .rds
  data_name <- paste("GovInvestment_2007_2019",
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = GovInvestment,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = "2007-2019",
                                source = "US Bureau of Economic Analysis",
                                url = url)
}
# Download, save and document 2007-2019 state government investment data (from BEA)
getBEAGovInvestment()

#' Get US Gov Consumption data (Table 3.10.5 annual) from 2007-2019.
#' @return A data frame of BEA US Gov Consumption data from 2007-2019.
getBEAGovConsumption <- function() {
  # Download US Gov Expenditure (NIPA table) from BEA
  url <- downloadBEAGovExpenditure()
  # Load Gov Consumption table
  TableName <- "Section3All_xls.xlsx"
  FileName <- paste0("inst/extdata/StateLocalGovFinances/", TableName)
  GovConsumption <- as.data.frame(readxl::read_excel(FileName, sheet = "T31005-A",
                                                     col_names = TRUE, skip = 7))
  # Assign column name to the description column
  colnames(GovConsumption)[2] <- "Description"
  # Keep wanted columns
  year_cols <- as.character(2007:2019)
  GovConsumption <- GovConsumption[complete.cases(GovConsumption),
                                   c("Line", "Description", year_cols)]
  # Convert values from million $ to $
  GovConsumption[, year_cols] <- GovConsumption[, year_cols]*1E6
  # Write data to .rds
  data_name <- paste("GovConsumption_2007_2019",
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = GovConsumption,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = "2007-2019",
                                source = "US Bureau of Economic Analysis",
                                url = url)
}
# Download, save and document 2007-2019 state government consumption data (from BEA)
getBEAGovConsumption()



#####################################################################################
################## BELOW ARE COUNTY MODEL DATA PROCESSING FUNCTIONS #################
#####################################################################################                                  

#' getBEACountySectorGDP
#' 
#' It returns the original county GDP of one specified state at BEA-sector(Line Code) 
#' level with NAs. 
#' 
#' @param year A numeric value between 2001 and 2018 specifying the year of interest. If 0 ,return a dataframe with data from all years available
#' @param state A string character specifying the state of interest, 'GA' 
#' @param axis A numeric value, 0,1. if 0, each county will be a col, if 1, row, default 0. This parameter only works when you specify one year
#' @return A data frame contains selected county GDP by BEA sector industries at a specific year.
getBEACountySectorGDP = function(year, state, axis = 0) {
  # Create the placeholder file
  CountyGDPzip = "inst/extdata/CAGDP2.zip"
  # Download all BEA IO tables into the placeholder file
  if(!file.exists(CountyGDPzip)) {
    utils::download.file("https://apps.bea.gov/regional/zip/CAGDP2.zip", CountyGDPzip, mode = "wb")
    # Get the name of all files in the zip archive
    fname = unzip(CountyGDPzip, list = TRUE)[unzip(CountyGDPzip, list = TRUE)$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(CountyGDPzip, files = fname, exdir = "inst/extdata/CAGDP2", overwrite = TRUE)
  }
  # filter for specified state
  fileName = paste0('inst/extdata/CAGDP2/CAGDP2_', paste0(getStateAbbreviation(state),'_2001_2018.csv'))
  # read data 
  countyData = utils::read.table(fileName, sep = ",", header = TRUE,
                                 stringsAsFactors = FALSE, check.names = FALSE,
                                 fill = TRUE)
  # drop last four rows (notes in original file)
  countyData = countyData[!is.na(countyData$Region), ]
  # select only BEA-sector-level rows
  sectorLevelLineCode = c(1,3,6,10,11,12,34,35,36,45,50,59,68,75,82,83)  #######TODO: have a crosswalk file in extdata and read from it, instead of hardcoding? 
  countyData = countyData[countyData$LineCode %in% sectorLevelLineCode, ]
  # convert data type (string to numeric) Note: NAs introduced by coercion, which is ok
  year_range = seq(2001,2018,1)
  countyData[, as.character(year_range)]  =  sapply(countyData[, as.character(year_range)], 
                                                    as.numeric)
  
  # Decision1: return all-year table or one-year table
  if (year == 0) {
    # retain all year columns
    countyDataAllYear = countyData[, c('GeoFIPS', 'GeoName', 'LineCode', as.character(year_range))]
    # convert unit
    for (yr in as.character(year_range)) {
      countyDataAllYear[[yr]] = 1000 * countyDataAllYear[[yr]]
    }
    
    return(countyDataAllYear)
  } else {
    # retain specified year only
    countyDataOneYear = countyData[, c('GeoName', 'LineCode', year)]
    countyDataOneYear[[as.character(year)]] = 1000 * countyDataOneYear[[as.character(year)]]
  }
  
  # Decision2: transpose the table? (county as column or as row)
  if (axis == 0) {
    countyDataOneYearColumn = countyDataOneYear
    colnames(countyDataOneYearColumn)[ncol(countyDataOneYearColumn)] = 'GDP'
    # drop State Total Rows (you can still find it in row table)
    dropStateFilter = sapply(attributes(countyDataOneYearColumn)$row.names, as.numeric) >= 36 # because state total always takes the first 35 rows(indices) of each table
    countyDataOneYearColumn = countyDataOneYearColumn[dropStateFilter, ]
    # WHY ARRANGE? It is because there is a discrepancy between rank by FIPS (default) and Name. 
    # We decide to stick with character string ranking (For instance: in Georgia, we arrange 'Macon' before 'McIntosh' while Macon in fact has a larger fips than McIntosh) 
    countyDataOneYearColumn = countyDataOneYearColumn %>% 
      dplyr::arrange(GeoName) %>%
      dplyr::spread(GeoName, GDP)
    
    return(countyDataOneYearColumn)
    
  } else {
    return(countyDataOneYear)
  }
}

CountyGA_BEASectorGDP_2001_2018 = getBEACountySectorGDP(year = 0, state = 'Georgia', axis = 1)
usethis::use_data(CountyGA_BEASectorGDP_2001_2018, overwrite = TRUE)
