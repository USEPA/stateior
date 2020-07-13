#' Get BEA state data from 2007-2018.
#' @param dataname A text indicating what state data to get.
#' Can be GDP, employee compensation, taxes, and gross operating surplus.
#' @return A data frame of BEA state data from 2007-2018.
getBEAStateData <- function (dataname) {
  # Create the placeholder file
  StateGDPzip <- "inst/extdata/SAGDP.zip"
  # Download all BEA IO tables into the placeholder file
  if(!file.exists(StateGDPzip)) {
    download.file("https://apps.bea.gov/regional/zip/SAGDP.zip", StateGDPzip, mode = "wb")
    # Get the name of all files in the zip archive
    fname <- unzip(StateGDPzip, list = TRUE)[unzip(StateGDPzip, list = TRUE)$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(StateGDPzip, files = fname, exdir = "inst/extdata/SAGDP", overwrite = TRUE)
  }
  # Determine data filename
  if (dataname=="GDP") {
    FileName <- "inst/extdata/SAGDP/SAGDP2N__ALL_AREAS_1997_2019.csv"
  } else if (dataname=="Tax") {
    FileName <- "inst/extdata/SAGDP/SAGDP3N__ALL_AREAS_1997_2017.csv"
  } else if (dataname=="Compensation") {
    FileName <- "inst/extdata/SAGDP/SAGDP4N__ALL_AREAS_1997_2017.csv"
  } else if (dataname=="GOS") {
    FileName <- "inst/extdata/SAGDP/SAGDP7N__ALL_AREAS_1997_2017.csv"
  }
  endyear <- substr(FileName, nchar(FileName) - 7, nchar(FileName)-4)
  year_range <- c(2007:endyear)
  # Load state data
  StateData <- utils::read.table(FileName, sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE)
  StateData <- StateData[!is.na(StateData$LineCode), ]
  # Convert values to numeric
  StateData[, as.character(year_range)] <- sapply(StateData[, as.character(year_range)], as.numeric)
  # Convert values to current US $
  if (unique(StateData$Unit)=="Millions of current dollars") {
    StateData[, as.character(year_range)] <- StateData[, as.character(year_range)]*1E6
  } else if (unique(StateData$Unit)=="Thousands of dollars") {
    StateData[, as.character(year_range)] <- StateData[, as.character(year_range)]*1E3
  }
  # Keep state-level data
  StateData <- StateData[StateData$GeoName %in% c(state.name, "District of Columbia", "United States *"),
                         c("GeoName", "LineCode", "Description", as.character(year_range))]
  return(StateData)
}
State_GDP_2007_2019 <- getBEAStateData("GDP")
usethis::use_data(State_GDP_2007_2019, overwrite = TRUE)
State_Tax_2007_2017 <- getBEAStateData("Tax")
usethis::use_data(State_Tax_2007_2017, overwrite = TRUE)
State_Compensation_2007_2017 <- getBEAStateData("Compensation")
usethis::use_data(State_Compensation_2007_2017, overwrite = TRUE)
State_GOS_2007_2017 <- getBEAStateData("GOS")
usethis::use_data(State_GOS_2007_2017, overwrite = TRUE)

#' Get BEA state employment (full-time and part-time) data from 2009-2018
#' @return A data frame of BEA state employment data from 2009-2018.
getBEAStateEmployment <- function () {
  APIkey <- readLines(rappdirs::user_data_dir("BEA_API_KEY.txt"), warn = FALSE)
  linecodes <- jsonlite::fromJSON(paste0("https://apps.bea.gov/api/data/?&UserID=", APIkey,
                                         "&method=GetParameterValuesFiltered",
                                         "&datasetname=Regional",
                                         "&TargetParameter=LineCode",
                                         "&TableName=SAEMP25N",
                                         "&ResultFormat=json"))
  StateEmployment <- data.frame()
  for (linecode in linecodes$BEAAPI$Results$ParamValue$Key) {
    StateEmployment_linecode <- jsonlite::fromJSON(paste0("https://apps.bea.gov/api/data/?&UserID=", APIkey,
                                                          "&method=GetData",
                                                          "&datasetname=Regional",
                                                          "&TableName=SAEMP25N",
                                                          "&LineCode=", linecode,
                                                          "&GeoFIPS=STATE",
                                                          "&Year=Last10",
                                                          "&ResultFormat=json"))
    StateEmployment_linecode <- StateEmployment_linecode$BEAAPI$Results$Data
    if (is.null(StateEmployment_linecode$NoteRef)) {
      StateEmployment_linecode$NoteRef <- ""
    }
    StateEmployment_linecode$LineCode <- linecode
    StateEmployment_linecode$DataValue <- as.numeric(gsub(",", "", StateEmployment_linecode$DataValue))
    StateEmployment <- rbind(StateEmployment, StateEmployment_linecode)
    print(linecode)
  }
  # Reshape to wide table
  StateEmployment <- reshape2::dcast(StateEmployment, GeoFips + GeoName + LineCode ~ TimePeriod, value.var = "DataValue")
  return(StateEmployment)
}
State_Employment_2009_2018 <- getBEAStateEmployment()
usethis::use_data(State_Employment_2009_2018, overwrite = TRUE)

#' Get BEA state PCE (personal consumption expenditures) data from 2007-2018
#' @return A data frame of BEA state PCE data from 2007-2018.
getBEAStatePCE <- function () {
  # Create the placeholder file
  StatePCEzip <- "inst/extdata/SAEXP.zip"
  # Download all BEA IO tables into the placeholder file
  if(!file.exists(StatePCEzip)) {
    download.file("https://apps.bea.gov/regional/zip/SAEXP.zip", StatePCEzip, mode = "wb")
    # Get the name of all files in the zip archive
    fname <- unzip(StatePCEzip, list = TRUE)[unzip(StatePCEzip, list = TRUE)$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(StatePCEzip, files = fname, exdir = "inst/extdata/SAEXP", overwrite = TRUE)
  }
  # Load state PCE data
  StatePCE <- utils::read.table("inst/extdata/SAEXP/SAEXP1__ALL_AREAS_1997_2018.csv",
                                sep = ",", header = TRUE, stringsAsFactors = FALSE,
                                check.names = FALSE, fill = TRUE)
  StatePCE <- StatePCE[!is.na(StatePCE$Line), ]
  # Replace NA with zero
  StatePCE[is.na(StatePCE)] <- 0
  # Convert values to current US $
  StatePCE[, as.character(2007:2018)] <- StatePCE[, as.character(2007:2018)]*1E6
  # Keep state-level data
  StatePCE <- StatePCE[StatePCE$GeoName %in% c(state.name, "District of Columbia"),
                       c("GeoName", "Line", "Description", as.character(2007:2018))]
  return(StatePCE)
}
State_PCE_2007_2018 <- getBEAStatePCE()
usethis::use_data(State_PCE_2007_2018, overwrite = TRUE)

#' Download BEA US Gov Expenditure data (NIPA table) from 2007-2019.
#' @return A data frame of BEA US Gov Expenditure data (NIPA table) from 2007-2019.
getBEAGovExpenditure <- function() {
  TableName <- "Section3All_xls.xlsx"
  FileName <- paste0("inst/extdata/StateLocalGovFinances/", TableName)
  url <- "https://apps.bea.gov/national/Release/XLS/Survey/Section3All_xls.xlsx"
  # Download NIPA table file
  if(!file.exists(FileName)) {
    utils::download.file(url, FileName, mode = "wb")
  }
}

#' Get US Gov Investment data (Table 3.9.5 annual) from 2007-2019.
#' @return A data frame of BEA US Gov Investment data from 2007-2019.
getBEAGovInvestment <- function() {
  # Download US Gov Expenditure (NIPA table) from BEA
  getBEAGovExpenditure()
  # Load Gov Investment table
  TableName <- "Section3All_xls.xlsx"
  FileName <- paste0("inst/extdata/StateLocalGovFinances/", TableName)
  GovInvestment <- as.data.frame(readxl::read_excel(FileName, sheet = "T30905-A",
                                                    col_names = TRUE, skip = 7))
  # Assign column name to the description column
  colnames(GovInvestment)[2] <- "Description"
  # Keep wanted columns
  GovInvestment <- GovInvestment[complete.cases(GovInvestment),
                                 c("Line", "Description", as.character(c(2007:2019)))]
  # Convert values from million $ to $
  GovInvestment[, as.character(c(2007:2019))] <- GovInvestment[, as.character(c(2007:2019))]*1E6
  return(GovInvestment)
}
GovInvestment_2007_2019 <- getBEAGovInvestment()
usethis::use_data(GovInvestment_2007_2019, overwrite = TRUE)

#' Get US Gov Consumption data (Table 3.10.5 annual) from 2007-2019.
#' @return A data frame of BEA US Gov Consumption data from 2007-2019.
getBEAGovConsumption <- function() {
  # Download US Gov Expenditure (NIPA table) from BEA
  getBEAGovExpenditure()
  # Load Gov Consumption table
  TableName <- "Section3All_xls.xlsx"
  FileName <- paste0("inst/extdata/StateLocalGovFinances/", TableName)
  GovConsumption <- as.data.frame(readxl::read_excel(FileName, sheet = "T31005-A",
                                                     col_names = TRUE, skip = 7))
  # Assign column name to the description column
  colnames(GovConsumption)[2] <- "Description"
  # Keep wanted columns
  GovConsumption <- GovConsumption[complete.cases(GovConsumption),
                                   c("Line", "Description", as.character(c(2007:2019)))]
  # Convert values from million $ to $
  GovConsumption[, as.character(c(2007:2019))] <- GovConsumption[, as.character(c(2007:2019))]*1E6
  return(GovConsumption)
}
GovConsumption_2007_2019 <- getBEAGovConsumption()
usethis::use_data(GovConsumption_2007_2019, overwrite = TRUE)

