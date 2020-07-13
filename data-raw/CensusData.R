#' Get US import/export table from usatrade.census.gov, and convert it to Census import/export table format.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @param flow_ratio_type Type of commodity flow, can be "export" or "import".
getCensusUSATradebyNAICS <- function (year, flow_ratio_type) {
  # Load the downloaded table from usatrade.census.gov
  filename <- paste0("Census_USATrade", Hmisc::capitalize(flow_ratio_type), "_", year, ".csv")
  table <- utils::read.table(system.file("extdata", filename, package = "stateio"),
                             sep = ",", header = FALSE, stringsAsFactors = FALSE, check.names = FALSE, skip = 4,
                             col.names = c("Commodity", "State", "Country", "Year", "Value"))
  # Keep rows for the specified year and drop "All Commodities"
  table <- table[table$Year==year & !table$Commodity=="All Commodities", ]
  # Change state name from "Dist of Columbia" to "Disctrict of Columbia"
  table[table$State=="Dist of Columbia", "State"] <- "Disctrict of Columbia"
  # Drop "All States" and non-state rows
  table <- table[table$State %in% c(state.name, "Disctrict of Columbia"), ]
  # Create NAICS
  table$NAICS <- as.integer(do.call(rbind, strsplit(table$Commodity, "\\ "))[, 1])
  # Convert trade value to numeric
  table$Value <- as.numeric(gsub(",", "", table$Value))
  # Re-order columns
  table <- table[, c("State", "Year", "NAICS", "Value")]
  return(table)
}

Census_USATradeExport_2012 <- getCensusUSATradebyNAICS(2012, "export")
usethis::use_data(Census_USATradeExport_2012, overwrite = TRUE)
Census_USATradeImport_2012 <- getCensusUSATradebyNAICS(2012, "import")
usethis::use_data(Census_USATradeImport_2012, overwrite = TRUE)

#' Get Census export data for specified year by NAICS
#' Find guide at https://www.census.gov/foreign-trade/reference/guides/Guide%20to%20International%20Trade%20Datasets.pdf
#' @param year A numeric value between 2013 and 2017 specifying the year of interest.
#' @return A data frame contains state export data by NAICS for the specified year.
getCensusStateExportbyNAICS <- function(year) {
  # Create URL
  # Use "CTY_NAME" instead of "CTY_CODE" to pull "TOTAL FOR ALL COUNTRIES" only
  # Use "MONTH=12" to pull Year-to-Date import values
  baseurl <- paste0("https://api.census.gov/data/timeseries/intltrade/exports/statenaics?get=NAICS,CTY_NAME,STATE,ALL_VAL_YR&YEAR=", year, "&MONTH=12")
  # Download table and convert to dataframe
  export <- as.data.frame(jsonlite::fromJSON(baseurl), stringsAsFactors = FALSE)[-1, -6]
  # Add column names
  colnames(export) <- c("NAICS", "CTY_NAME", "STATE", "ALL_VAL_YR", "YEAR")
  # Convert specific columns to numeric format
  export[, c("ALL_VAL_YR", "YEAR")] <- sapply(export[, c("ALL_VAL_YR", "YEAR")], as.numeric)
  # Keep export by state (!STATE=="")
  export_states <- export[!export$NAICS==""&!export$STATE=="", ]
  return (export_states)
}
Census_StateExport_2013 <- getCensusStateExportbyNAICS(2013)
usethis::use_data(Census_StateExport_2013, overwrite = TRUE)
Census_StateExport_2014 <- getCensusStateExportbyNAICS(2014)
usethis::use_data(Census_StateExport_2014, overwrite = TRUE)
Census_StateExport_2015 <- getCensusStateExportbyNAICS(2015)
usethis::use_data(Census_StateExport_2015, overwrite = TRUE)
Census_StateExport_2016 <- getCensusStateExportbyNAICS(2016)
usethis::use_data(Census_StateExport_2016, overwrite = TRUE)
Census_StateExport_2017 <- getCensusStateExportbyNAICS(2017)
usethis::use_data(Census_StateExport_2017, overwrite = TRUE)
Census_StateExport_2018 <- getCensusStateExportbyNAICS(2018)
usethis::use_data(Census_StateExport_2018, overwrite = TRUE)

#' Get Census import data for specified year by NAICS
#' Find guide at https://www.census.gov/foreign-trade/reference/guides/Guide%20to%20International%20Trade%20Datasets.pdf
#' @param year A numeric value between 2013 and 2017 specifying the year of interest.
#' @return A data frame contains state import data by NAICS for the specified year.
getCensusStateImportbyNAICS <- function (year) {
  # Create URL
  # Use "CTY_NAME" instead of "CTY_CODE" to pull "TOTAL FOR ALL COUNTRIES" only
  # Use "MONTH=12" to pull Year-to-Date import values
  baseurl <- paste0("https://api.census.gov/data/timeseries/intltrade/imports/statenaics?get=NAICS,CTY_NAME,STATE,GEN_VAL_YR&YEAR=", year, "&MONTH=12")
  # Download table and convert to dataframe
  import <- as.data.frame(jsonlite::fromJSON(baseurl), stringsAsFactors = FALSE)[-1, -6]
  # Add column names
  colnames(import) <- c("NAICS", "CTY_NAME", "STATE", "GEN_VAL_YR", "YEAR")
  # Convert specific columns to numeric format
  import[, c("GEN_VAL_YR", "YEAR")] <- sapply(import[, c("GEN_VAL_YR", "YEAR")], as.numeric)
  # Keep import by state (!STATE=="")
  import_states <- import[!import$NAICS==""&!import$STATE=="", ]
  return (import_states)
}
Census_StateImport_2013 <- getCensusStateImportbyNAICS(2013)
usethis::use_data(Census_StateImport_2013, overwrite = TRUE)
Census_StateImport_2014 <- getCensusStateImportbyNAICS(2014)
usethis::use_data(Census_StateImport_2014, overwrite = TRUE)
Census_StateImport_2015 <- getCensusStateImportbyNAICS(2015)
usethis::use_data(Census_StateImport_2015, overwrite = TRUE)
Census_StateImport_2016 <- getCensusStateImportbyNAICS(2016)
usethis::use_data(Census_StateImport_2016, overwrite = TRUE)
Census_StateImport_2017 <- getCensusStateImportbyNAICS(2017)
usethis::use_data(Census_StateImport_2017, overwrite = TRUE)
Census_StateImport_2018 <- getCensusStateImportbyNAICS(2018)
usethis::use_data(Census_StateImport_2018, overwrite = TRUE)

#' Download Census state and local gov expenditure 2007-2017
#' @return A list of data frames containing Census state and local gov expenditure 2007-2017.
getStateLocalGovExpenditure <- function () {
  StateLocalGovExp_list <- list()
  for (year in 2017:2007) {
    # Create base_url
    base_url <- "https://www2.census.gov/programs-surveys/gov-finances/tables/"
    df_list <- list()
    # Specify table to download
    for (table in c("a", "b")) {
      # Specify file format
      if (year < 2012) {
        FileType <- ".xls"
      } else {
        FileType <- ".xlsx"
      }
      # Create url
      url <- paste0(base_url, year, "/summary-tables/", substr(year, 3, 4),
                    "slsstab1", table, FileType)
      TableName <- paste0(substr(year, 3, 4), "slsstab1", table, FileType)
      FileName <- paste0("inst/extdata/StateLocalGovFinances/", TableName)
      # Download file
      if(!file.exists(FileName)) {
        utils::download.file(url, FileName, mode = "wb")
      }
      # Specify rows to skip based on year
      if (year%in%c(2008, 2013:2016)) {
        skip_rows <- 9
      } else if (year%in%c(2009:2011)) {
        skip_rows <- 8
      } else {
        skip_rows <- 7
      }
      # Load table
      df_i <- as.data.frame(readxl::read_excel(FileName, sheet = 1, col_names = TRUE, skip = skip_rows))
      # Keep Expenditures only
      df_i <- df_i[which(df_i$Description == "Expenditure1"):nrow(df_i), ]
      if (year>2011) {
        Line <- as.integer(df_i[complete.cases(df_i), 1])
      }
      df_i <- df_i[, colnames(df_i)%in%c("Description", "United States Total", state.name, "District of Columbia")]
      df_list[[table]] <- df_i[complete.cases(df_i), ]
    }
    df_list[["b"]][, "Description"] <- NULL
    df <- cbind(Line, df_list[["a"]], df_list[["b"]])
    # Convert values to numeric and $
    df[, 3:ncol(df)] <- sapply(df[, 3:ncol(df)], as.numeric)*1E3
    StateLocalGovExp_list[[as.character(year)]] <- df
  }
  return(StateLocalGovExp_list)
}
StateLocalGovExpenditure_2007_2017 <- getStateLocalGovExpenditure()
Census_StateLocalGovExpenditure_2007 <- StateLocalGovExpenditure_2007_2017[["2007"]]
usethis::use_data(Census_StateLocalGovExpenditure_2007, overwrite = TRUE)
Census_StateLocalGovExpenditure_2008 <- StateLocalGovExpenditure_2007_2017[["2008"]]
usethis::use_data(Census_StateLocalGovExpenditure_2008, overwrite = TRUE)
Census_StateLocalGovExpenditure_2009 <- StateLocalGovExpenditure_2007_2017[["2009"]]
usethis::use_data(Census_StateLocalGovExpenditure_2009, overwrite = TRUE)
Census_StateLocalGovExpenditure_2010 <- StateLocalGovExpenditure_2007_2017[["2010"]]
usethis::use_data(Census_StateLocalGovExpenditure_2010, overwrite = TRUE)
Census_StateLocalGovExpenditure_2011 <- StateLocalGovExpenditure_2007_2017[["2011"]]
usethis::use_data(Census_StateLocalGovExpenditure_2011, overwrite = TRUE)
Census_StateLocalGovExpenditure_2012 <- StateLocalGovExpenditure_2007_2017[["2012"]]
usethis::use_data(Census_StateLocalGovExpenditure_2012, overwrite = TRUE)
Census_StateLocalGovExpenditure_2013 <- StateLocalGovExpenditure_2007_2017[["2013"]]
usethis::use_data(Census_StateLocalGovExpenditure_2013, overwrite = TRUE)
Census_StateLocalGovExpenditure_2014 <- StateLocalGovExpenditure_2007_2017[["2014"]]
usethis::use_data(Census_StateLocalGovExpenditure_2014, overwrite = TRUE)
Census_StateLocalGovExpenditure_2015 <- StateLocalGovExpenditure_2007_2017[["2015"]]
usethis::use_data(Census_StateLocalGovExpenditure_2015, overwrite = TRUE)
Census_StateLocalGovExpenditure_2016 <- StateLocalGovExpenditure_2007_2017[["2016"]]
usethis::use_data(Census_StateLocalGovExpenditure_2016, overwrite = TRUE)
Census_StateLocalGovExpenditure_2017 <- StateLocalGovExpenditure_2007_2017[["2017"]]
usethis::use_data(Census_StateLocalGovExpenditure_2017, overwrite = TRUE)
