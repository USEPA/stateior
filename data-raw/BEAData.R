#' Get BEA state GDP data (including GVA, Employment Compensation, Tax, and GOS)
#' from 2010 to the latest year available.
#' @param dataname A text indicating what state data to get.
#' Can be GVA, employee compensation, taxes, and gross operating surplus.
#' @return A data frame of BEA state data from 2010 to the latest year available.
getBEAStateGDPData <- function(dataname) {
  # Create the placeholder file
  StateGVAzip <- "inst/extdata/SAGDP.zip"
  dir <- "inst/extdata/SAGDP"
  # Download all BEA IO tables into the placeholder file
  if (!file.exists(StateGVAzip)) {
    utils::download.file("https://apps.bea.gov/regional/zip/SAGDP.zip",
                         StateGVAzip, mode = "wb")
    # Get the name of all files in the zip archive
    tmp <- unzip(StateGVAzip, list = TRUE)
    fname <- tmp[tmp$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(StateGVAzip, files = fname, exdir = dir, overwrite = TRUE)
  }
  # Determine data filename
  if (dataname == "GVA") {
    FileName <- list.files(dir, pattern = "SAGDP2N__ALL_AREAS.*\\.csv")
  } else if (dataname == "Tax") {
    FileName <- list.files(dir, pattern = "SAGDP3N__ALL_AREAS.*\\.csv")
  } else if (dataname == "Compensation") {
    FileName <- list.files(dir, pattern = "SAGDP4N__ALL_AREAS.*\\.csv")
  } else if (dataname == "GOS") {
    FileName <- list.files(dir, pattern = "SAGDP7N__ALL_AREAS.*\\.csv")
  }
  FullFileName <- file.path(dir, FileName)
  # Get date_accessed and date_last_modified
  date_accessed <- as.character(as.Date(file.mtime(StateGVAzip)))
  date_last_modified <- as.character(as.Date(file.mtime(FullFileName)))
  # Find latest data year
  file_split <- unlist(stringr::str_split(FileName, pattern = "_"))
  end_year <- sub(".csv", "", file_split[length(file_split)])
  # Create year_cols
  year_cols <- as.character(2010:end_year)
  
  # Load state data
  StateData <- utils::read.table(FullFileName, sep = ",",
                                 header = TRUE, stringsAsFactors = FALSE,
                                 check.names = FALSE, fill = TRUE)
  StateData <- StateData[!is.na(StateData$LineCode), ]
  # Assign NaN to (L) Less than $50,000.
  StateData[StateData == "(L)"] <- NaN
  # Assign NA to (D) Not shown to avoid disclosure of confidential information;
  # estimates are included in higher-level totals.
  StateData[StateData == "(D)"] <- NA
  # Replace (NA) with NA
  StateData[StateData == "(NA)"] <- NA
  # Convert all the other values to numeric
  StateData[, year_cols] <- sapply(StateData[, year_cols], as.numeric)
  # Convert values to current US $
  if (unique(StateData$Unit) == "Millions of current dollars") {
    StateData[, year_cols] <- StateData[, year_cols]*1E6
  } else if (unique(StateData$Unit) == "Thousands of dollars") {
    StateData[, year_cols] <- StateData[, year_cols]*1E3
  }
  # Keep state-level data
  geo_names <- c(state.name, "District of Columbia", "United States *")
  # Save data
  for (year in year_cols) {
    df <- StateData[StateData$GeoName %in% geo_names,
                    c("GeoName", "LineCode", "Description", year)]
    # Write data to .rds
    data_name <- paste("State", dataname, year,
                       utils::packageDescription("stateior", fields = "Version"),
                       sep = "_")
    saveRDS(object = df,
            file = paste0(file.path("data", data_name), ".rds"))
    # Write metadata to JSON
    useeior:::writeMetadatatoJSON(package = "stateior",
                                  name = data_name,
                                  year = year,
                                  source = "US Bureau of Economic Analysis",
                                  url = "https://apps.bea.gov/regional/zip/SAGDP.zip",
                                  date_last_modified = date_last_modified,
                                  date_accessed = date_accessed)
  }
}
# Download, save and document BEA state economic data
# from 2010 to the latest year available
for (dataname in c("GVA", "Tax", "Compensation", "GOS")) {
  getBEAStateGDPData(dataname)
}

#' Get BEA state PCE (personal consumption expenditures) data from 2010 to the
#' latest year available.
#' @return A data frame of BEA state PCE data from 2010 to the latest year
#' available.
getBEAStatePCE <- function() {
  # Create the placeholder file
  StatePCEzip <- "inst/extdata/SAPCE.zip"
  dir <- "inst/extdata/SAPCE"
  # Download all BEA IO tables into the placeholder file
  if (!file.exists(StatePCEzip)) {
    utils::download.file("https://apps.bea.gov/regional/zip/SAPCE.zip",
                         StatePCEzip, mode = "wb")
    # Get the name of all files in the zip archive
    tmp <- unzip(StatePCEzip, list = TRUE)
    fname <- tmp[tmp$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(StatePCEzip, files = fname, exdir = dir, overwrite = TRUE)
  }
  # Define FileName and FullFileName
  FileName <- list.files(dir, pattern = "SAPCE1__ALL_AREAS")
  FullFileName <- file.path(dir, FileName)
  # Get date_accessed and date_last_modified
  date_accessed <- as.character(as.Date(file.mtime(StatePCEzip)))
  date_last_modified <- as.character(as.Date(file.mtime(FullFileName)))
  # Find latest data year
  file_split <- unlist(stringr::str_split(FileName, pattern = "_"))
  end_year <- sub(".csv", "", file_split[length(file_split)])
  # Create year_cols
  year_cols <- as.character(2010:end_year)
  
  # Load state PCE data
  StatePCE <- utils::read.table(FullFileName, sep = ",",
                                header = TRUE, stringsAsFactors = FALSE,
                                check.names = FALSE, fill = TRUE)
  StatePCE <- StatePCE[!is.na(StatePCE$Line), ]
  # Replace NA with zero
  StatePCE[is.na(StatePCE)] <- 0
  # Convert values to current US $
  StatePCE[, year_cols] <- StatePCE[, year_cols]*1E6
  # Keep state-level data
  geo_names <- c(state.name, "District of Columbia", "United States *")
  # Save data
  for (year in year_cols) {
    df <- StatePCE[StatePCE$GeoName %in% geo_names,
                   c("GeoName", "LineCode", "Description", year_cols)]
    # Write data to .rds
    data_name <- paste("State_PCE", year,
                       utils::packageDescription("stateior", fields = "Version"),
                       sep = "_")
    saveRDS(object = df,
            file = paste0(file.path("data", data_name), ".rds"))
    # Write metadata to JSON
    useeior:::writeMetadatatoJSON(package = "stateior",
                                  name = data_name,
                                  year = year,
                                  source = "US Bureau of Economic Analysis",
                                  url = "https://apps.bea.gov/regional/zip/SAPCE.zip",
                                  date_last_modified = date_last_modified,
                                  date_accessed = date_accessed)
  }
}
# Download, save and document BEA state PCE from 2010 to the latest year available.
getBEAStatePCE()

#' Download BEA US Gov Expenditure data (NIPA table) from 2007-2019.
#' @return A data frame of BEA US Gov Expenditure data (NIPA table) from 2007-2019.
downloadBEAGovExpenditure <- function() {
  TableName <- "Section3All_xls.xlsx"
  dir <- "inst/extdata/StateLocalGovFinances"
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
  FullFileName <- file.path(dir, TableName)
  url <- "https://apps.bea.gov/national/Release/XLS/Survey/Section3All_xls.xlsx"
  # Download NIPA table file
  if (!file.exists(FullFileName)) {
    utils::download.file(url, FullFileName, mode = "wb")
  }
  # Create output
  ls <- list("url" = url,
             "date_accessed" = as.character(as.Date(file.mtime(FullFileName))))
  return(ls)
}

#' Get BEA US Gov Investment data by state (Table 3.9.5 annual) from 2010 to the
#' latest year available.
#' @return A data frame of BEA US Gov Investment data from 2010 to the latest
#' year available.
getBEAGovInvestment <- function() {
  # Download US Gov Expenditure (NIPA table) from BEA
  url <- downloadBEAGovExpenditure()[["url"]]
  date_accessed <- downloadBEAGovExpenditure()[["date_accessed"]]
  # Load Gov Investment table
  TableName <- "Section3All_xls.xlsx"
  FullFileName <- file.path("inst/extdata/StateLocalGovFinances", TableName)
  # Get date_last_modified
  date_last_modified <- as.character(as.Date(file.mtime(FullFileName)))
  
  # Load data
  GovInvestment <- as.data.frame(readxl::read_excel(FullFileName,
                                                    sheet = "T30905-A",
                                                    col_names = TRUE,
                                                    skip = 7))
  # Assign column name to the description column
  colnames(GovInvestment)[2] <- "Description"
  # Find latest data year
  end_year <- colnames(GovInvestment)[ncol(GovInvestment)]
  # Create year_cols
  year_cols <- as.character(2010:end_year)
  # Save data
  for (year in year_cols) {
    df <- GovInvestment[complete.cases(GovInvestment),
                        c("Line", "Description", year)]
    # Convert values from million $ to $
    df[, year] <- df[, year]*1E6
    # Write data to .rds
    data_name <- paste("GovInvestment", year,
                       utils::packageDescription("stateior", fields = "Version"),
                       sep = "_")
    saveRDS(object = df,
            file = paste0(file.path("data", data_name), ".rds"))
    # Write metadata to JSON
    useeior:::writeMetadatatoJSON(package = "stateior",
                                  name = data_name,
                                  year = year,
                                  source = "US Bureau of Economic Analysis",
                                  url = url,
                                  date_last_modified = date_last_modified,
                                  date_accessed = date_accessed)
  }
}
# Download, save and document BEA US government investment by state data from
# 2010 to the latest year available.
getBEAGovInvestment()

#' Get BEA US Gov Consumption data by state (Table 3.10.5 annual) from 2010
#' to the latest year available.
#' @return A data frame of BEA US Gov Consumption by state data from 2010
#' to the latest year available.
getBEAGovConsumption <- function() {
  # Download US Gov Expenditure (NIPA table) from BEA
  url <- downloadBEAGovExpenditure()[["url"]]
  date_accessed <- downloadBEAGovExpenditure()[["date_accessed"]]
  # Load Gov Consumption table
  TableName <- "Section3All_xls.xlsx"
  FullFileName <- paste0("inst/extdata/StateLocalGovFinances/", TableName)
  # Get date_last_modified
  date_last_modified <- as.character(as.Date(file.mtime(FullFileName)))
  
  # Load data
  GovConsumption <- as.data.frame(readxl::read_excel(FullFileName,
                                                     sheet = "T31005-A",
                                                     col_names = TRUE,
                                                     skip = 7))
  # Assign column name to the description column
  colnames(GovConsumption)[2] <- "Description"
  # Find latest data year
  end_year <- colnames(GovConsumption)[ncol(GovConsumption)]
  # Create year_cols
  year_cols <- as.character(2010:end_year)
  # Save data
  for (year in year_cols) {
    df <- GovConsumption[complete.cases(GovConsumption),
                         c("Line", "Description", year)]
    # Convert values from million $ to $
    GovConsumption[, year_cols] <- GovConsumption[, year]*1E6
    # Write data to .rds
    data_name <- paste("GovConsumption", year,
                       utils::packageDescription("stateior", fields = "Version"),
                       sep = "_")
    saveRDS(object = df,
            file = paste0(file.path("data", data_name), ".rds"))
    # Write metadata to JSON
    useeior:::writeMetadatatoJSON(package = "stateior",
                                  name = data_name,
                                  year = year,
                                  source = "US Bureau of Economic Analysis",
                                  url = url,
                                  date_last_modified = date_last_modified,
                                  date_accessed = date_accessed)
  }
}
# Download, save and document BEA US government consumption by state data from
# 2010 to the latest year available.
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

# CountyGA_BEASectorGDP_2001_2018 = getBEACountySectorGDP(year = 0, state = 'Georgia', axis = 1)
# usethis::use_data(CountyGA_BEASectorGDP_2001_2018, overwrite = TRUE)
