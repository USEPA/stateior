#' Get BEA state GDP data (including GVA, Employment Compensation, Tax, and GOS)
#' for a specified year.
#' @param dataname A text indicating what state data to get.
#' Can be GVA, employee compensation, taxes, and gross operating surplus.
#' @param year A numeric value specifying year of interest.
#' @return A data frame of BEA state data for the specified year.
getBEAStateGDPData <- function(dataname, year) {
  # Create the placeholder file
  StateGVAzip <- "inst/extdata/SAGDP.zip"
  dir <- "inst/extdata/SAGDP"
  # Download all BEA IO tables into the placeholder file
  if (!file.exists(StateGVAzip)) {
    utils::download.file("https://apps.bea.gov/regional/zip/SAGDP.zip",
                         StateGVAzip, mode = "wb",
                         timeout = max(1000, getOption("timeout")))
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
  # Get date_accessed
  date_accessed <- as.character(as.Date(file.mtime(StateGVAzip)))
  # Find latest data year
  file_split <- unlist(stringr::str_split(FileName, pattern = "_"))
  endyear <- sub(".csv", "", file_split[length(file_split)])
  
  # Load state data
  if (year <= endyear) {
    StateData <- utils::read.table(FullFileName, sep = ",",
                                   header = TRUE, stringsAsFactors = FALSE,
                                   check.names = FALSE, fill = TRUE)
    # Get date_last_modified
    date_last_modified <- stringr::str_match(StateData[grep("Last updated: ",
                                                            StateData$GeoFIPS),
                                                       "GeoFIPS"],
                                             "Last updated: (.*?)--")[2]
    StateData <- StateData[!is.na(StateData$LineCode), ]
    # Assign NaN to (L) Less than $50,000.
    StateData[StateData == "(L)"] <- NaN
    # Assign NA to (D) Not shown to avoid disclosure of confidential information;
    # estimates are included in higher-level totals.
    StateData[StateData == "(D)"] <- NA
    # Replace (NA) with NA
    StateData[StateData == "(NA)"] <- NA
    # Convert all the other values to numeric
    year_col <- as.character(year)
    StateData[, year_col] <- sapply(StateData[, year_col], as.numeric)
    # Convert values to current US $
    if (unique(StateData$Unit) == "Millions of current dollars") {
      StateData[, year_col] <- StateData[, year_col]*1E6
    } else if (unique(StateData$Unit) == "Thousands of dollars") {
      StateData[, year_col] <- StateData[, year_col]*1E3
    }
    # Keep state-level data
    geo_names <- c(state.name, "District of Columbia", "United States *")
    # Save data
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
  } else {
    logging::logwarn(paste(year, "state", dataname, "data is not avaliable from BEA.",
                           "Nothing is returned."))
  }
}
# Download, save and document BEA state economic data
for (dataname in c("GVA", "Tax", "Compensation", "GOS")) {
  getBEAStateGDPData(dataname, year)
}

#' Get BEA state PCE (personal consumption expenditures) data for a specified year.
#' @param year A numeric value specifying year of interest.
#' @return A data frame of BEA state PCE data for the specified year.
#' available.
getBEAStatePCE <- function(year) {
  # Create the placeholder file
  StatePCEzip <- "inst/extdata/SAPCE.zip"
  dir <- "inst/extdata/SAPCE"
  # Download all BEA IO tables into the placeholder file
  if (!file.exists(StatePCEzip)) {
    utils::download.file("https://apps.bea.gov/regional/zip/SAPCE.zip",
                         StatePCEzip, mode = "wb",
                         timeout = max(1000, getOption("timeout")))
    # Get the name of all files in the zip archive
    tmp <- unzip(StatePCEzip, list = TRUE)
    fname <- tmp[tmp$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(StatePCEzip, files = fname, exdir = dir, overwrite = TRUE)
  }
  # Define FileName and FullFileName
  FileName <- list.files(dir, pattern = "SAPCE1__ALL_AREAS")
  FullFileName <- file.path(dir, FileName)
  # Get date_accessed
  date_accessed <- as.character(as.Date(file.mtime(StatePCEzip)))
  # Find latest data year
  file_split <- unlist(stringr::str_split(FileName, pattern = "_"))
  endyear <- sub(".csv", "", file_split[length(file_split)])
  
  # Load state PCE data
  if (year <= endyear) {
    StatePCE <- utils::read.table(FullFileName, sep = ",",
                                  header = TRUE, stringsAsFactors = FALSE,
                                  check.names = FALSE, fill = TRUE)
    # Get date_last_modified
    date_last_modified <- stringr::str_match(StatePCE[grep("Last updated: ",
                                                           StatePCE$GeoFIPS),
                                                      "GeoFIPS"],
                                             "Last updated: (.*?)--")[2]
    StatePCE <- StatePCE[!is.na(StatePCE$Line), ]
    # Replace NA with zero
    StatePCE[is.na(StatePCE)] <- 0
    # Convert values to current US $
    year_col <- as.character(year)
    StatePCE[, year_col] <- StatePCE[, year_col]*1E6
    # Keep state-level data
    geo_names <- c(state.name, "District of Columbia", "United States")
    # Save data
    df <- StatePCE[StatePCE$GeoName %in% geo_names,
                   c("GeoName", "LineCode", "Description", year)]
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
  } else {
    logging::logwarn(paste(year, "state PCE data is not avaliable from BEA.",
                           "Nothing is returned."))
  }
}
# Download, save and document BEA state PCE from 2010 to the latest year available.
getBEAStatePCE(year)

#' Get BEA state foreign travel and expenditures by U.S. residents and
#' expenditures in the U.S. by nonresidents data from 2010 to the latest year
#' available.
#' @return A data frame of BEA state foreign travel and expenditures by U.S.
#' residents and expenditures in the U.S. by nonresidents data from 2010 to
#' the latest year available.
getBEAStateResidentAndNonresidentSpending <- function() {
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
  FileName <- list.files(dir, pattern = "SAPCE4__ALL_AREAS")
  FullFileName <- file.path(dir, FileName)
  # Get date_accessed
  date_accessed <- as.character(as.Date(file.mtime(StatePCEzip)))
  # Find latest data year
  file_split <- unlist(stringr::str_split(FileName, pattern = "_"))
  end_year <- sub(".csv", "", file_split[length(file_split)])
  # Create year_cols
  year_cols <- as.character(2010:end_year)
  
  # Load state PCE data
  StatePCE <- utils::read.table(FullFileName, sep = ",",
                                header = TRUE, stringsAsFactors = FALSE,
                                check.names = FALSE, fill = TRUE)
  # Get date_last_modified
  date_last_modified <- stringr::str_match(StatePCE[grep("Last updated: ",
                                                         StatePCE$GeoFIPS),
                                                    "GeoFIPS"],
                                           "Last updated: (.*?)--")[2]
  # Get resident and nonresident spending
  Spending <- StatePCE[StatePCE$LineCode %in% c(129, 130), ]
  # Replace NA with zero
  Spending[is.na(Spending)] <- 0
  # Convert values to current US $
  Spending[, year_cols] <- sapply(Spending[, year_cols], as.numeric)*1E6
  # Keep state-level data
  geo_names <- c(state.name, "District of Columbia", "United States")
  # Save data
  for (year in year_cols) {
    for (linecode in c(129:130)) {
      df <- Spending[Spending$GeoName %in% geo_names & Spending$LineCode == linecode,
                     c("GeoName", "LineCode", "Description", year)]
      # Write data to .rds
      data_name <- paste("State",
                         ifelse(linecode == 129,
                                "ForeignExpenditureByResident",
                                "DomesticExpenditureByNonresident"),
                         year,
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
}
# Download, save and document BEA state foreign travel and expenditures by U.S.
# residents and expenditures in the U.S. by nonresidents data from 2010 to
# the latest year available.
getBEAStateResidentAndNonresidentSpending()

#' Download BEA US Gov Expenditure data (NIPA table).
#' @return A data frame of BEA US Gov Expenditure data (NIPA table).
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
    utils::download.file(url, FullFileName, mode = "wb",
                         timeout = max(1000, getOption("timeout")))
  }
  # Create output
  ls <- list("url" = url,
             "date_accessed" = as.character(as.Date(file.mtime(FullFileName))))
  return(ls)
}

#' Get BEA US Gov Investment data by state (Table 3.9.5 annual) for a specified
#' year.
#' @param year A numeric value specifying year of interest.
#' @return A data frame of BEA US Gov Investment data for the specified year.
getBEAGovInvestment <- function(year) {
  # Download US Gov Expenditure (NIPA table) from BEA
  url <- downloadBEAGovExpenditure()[["url"]]
  date_accessed <- downloadBEAGovExpenditure()[["date_accessed"]]
  # Load Gov Investment table
  TableName <- "Section3All_xls.xlsx"
  FullFileName <- file.path("inst/extdata/StateLocalGovFinances", TableName)
  # Get date_last_modified
  notes <- as.data.frame(readxl::read_excel(FullFileName,
                                            sheet = "T30905-A",
                                            range = "A1:A7"))
  date_last_modified <- stringr::str_match(notes[grep("File created ",
                                                      notes[, 1]),
                                                 1],
                                           "File created (.*?)  ")[2]
  
  # Load data
  GovInvestment <- as.data.frame(readxl::read_excel(FullFileName,
                                                    sheet = "T30905-A",
                                                    col_names = TRUE,
                                                    skip = 7))
  # Assign column name to the description column
  colnames(GovInvestment)[2] <- "Description"
  # Create year_col
  year_col <- as.character(year)
  # Save data
  if (year %in% colnames(GovInvestment)) {
    df <- GovInvestment[complete.cases(GovInvestment),
                        c("Line", "Description", year)]
    # Convert values from million $ to $
    df[, year_col] <- df[, year_col]*1E6
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
  } else {
    logging::logwarn(paste(year, "state-level US government investment data is not",
                           "avaliable from BEA. Nothing is returned."))
  }
}
# Download, save and document BEA US government investment data.
getBEAGovInvestment(year)

#' Get BEA US Gov Consumption data by state (Table 3.10.5 annual) for a specified
#' year.
#' @param year A numeric value specifying year of interest.
#' @return A data frame of BEA US Gov Consumption by state data for the specified
#' year.
getBEAGovConsumption <- function(year) {
  # Download US Gov Expenditure (NIPA table) from BEA
  url <- downloadBEAGovExpenditure()[["url"]]
  date_accessed <- downloadBEAGovExpenditure()[["date_accessed"]]
  # Load Gov Consumption table
  TableName <- "Section3All_xls.xlsx"
  FullFileName <- paste0("inst/extdata/StateLocalGovFinances/", TableName)
  # Get date_last_modified
  notes <- as.data.frame(readxl::read_excel(FullFileName,
                                            sheet = "T31005-A",
                                            range = "A1:A7"))
  date_last_modified <- stringr::str_match(notes[grep("File created ",
                                                      notes[, 1]),
                                                 1],
                                           "File created (.*?)  ")[2]
  
  # Load data
  GovConsumption <- as.data.frame(readxl::read_excel(FullFileName,
                                                     sheet = "T31005-A",
                                                     col_names = TRUE,
                                                     skip = 7))
  # Assign column name to the description column
  colnames(GovConsumption)[2] <- "Description"
  # Create year_col
  year_col <- as.character(year)
  # Save data
  if (year %in% colnames(GovConsumption)) {
    df <- GovConsumption[complete.cases(GovConsumption),
                         c("Line", "Description", year)]
    # Convert values from million $ to $
    GovConsumption[, year_col] <- GovConsumption[, year_col]*1E6
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
  } else {
    logging::logwarn(paste(year, "state-level US government consumption data is not",
                           "avaliable from BEA. Nothing is returned."))
  }
}
# Download, save and document BEA US government consumption by state data
getBEAGovConsumption(year)



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
