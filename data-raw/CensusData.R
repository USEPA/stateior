#' Get US import/export table from usatrade.census.gov, and convert it to Census import/export table format.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @param flow_ratio_type Type of commodity flow, can be "export" or "import".
#' @return A data frame contains US import/export data from 2012-2017.
getCensusUSATradebyNAICS <- function (year, flow_ratio_type) {
  # Load the downloaded table from usatrade.census.gov
  filename <- paste0("Census_USATrade",
                     Hmisc::capitalize(flow_ratio_type), "_", year, ".csv")
  table <- utils::read.table(system.file("extdata", filename, package = "stateior"),
                             sep = ",", header = FALSE, stringsAsFactors = FALSE,
                             check.names = FALSE, skip = 4,
                             col.names = c("Commodity", "State", "Country",
                                           "Year", "Value"))
  # Keep rows for the specified year and drop "All Commodities"
  table <- table[table$Year==year & !table$Commodity=="All Commodities", ]
  # Change state name from "Dist of Columbia" to "District of Columbia"
  table[table$State=="Dist of Columbia", "State"] <- "District of Columbia"
  # Drop "All States" and non-state rows
  table <- table[table$State %in% c(state.name, "District of Columbia"), ]
  # Create NAICS
  table$NAICS <- as.integer(do.call(rbind,
                                    strsplit(table$Commodity, "\\ "))[, 1])
  # Convert trade value to numeric
  table$Value <- as.numeric(gsub(",", "", table$Value))
  # Re-order columns
  table <- table[, c("State", "Year", "NAICS", "Value")]
  # Write data to .rds
  data_name <- paste(sub(".csv", "", filename),
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = table,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = year,
                                source = "US Census Bureau",
                                url = NULL)
}
# Download, save and document 2012 state trade data (from Census USA Trade Export and Import)
Census_USATradeExport_2012 <- getCensusUSATradebyNAICS(2012, "export")
Census_USATradeImport_2012 <- getCensusUSATradebyNAICS(2012, "import")

#' Get Census export data for specified year by NAICS
#' Find guide at https://www.census.gov/foreign-trade/reference/guides/Guide%20to%20International%20Trade%20Datasets.pdf
#' @param year A numeric value between 2013 and 2017 specifying the year of interest.
#' @return A data frame contains state export data by NAICS for the specified year.
getCensusStateExportbyNAICS <- function(year) {
  # Create URL
  # Use "CTY_NAME" instead of "CTY_CODE" to pull "TOTAL FOR ALL COUNTRIES" only
  # Use "MONTH=12" to pull Year-to-Date import values
  base_url <- paste0("https://api.census.gov/data/timeseries/intltrade/exports/statenaics?get=NAICS,CTY_NAME,STATE,ALL_VAL_YR&YEAR=", year, "&MONTH=12")
  # Download table and convert to dataframe
  export <- as.data.frame(jsonlite::fromJSON(base_url),
                          stringsAsFactors = FALSE)[-1, -6]
  # Add column names
  colnames(export) <- c("NAICS", "CountryName", "State", "Value", "Year")
  # Convert specific columns to numeric format
  export[, c("Value", "Year")] <- sapply(export[, c("Value", "Year")], as.numeric)
  # Keep export by state (!STATE=="") and convert state abbreviation to state name
  export_states <- export[!export$NAICS=="" & export$State %in% c(state.abb, "DC"), ]
  state_names <- c(state.name, "District of Columbia")
  export_states$State <- state_names[match(export_states$State, c(state.abb, "DC"))]
  # Write data to .rds
  data_name <- paste("Census_StateExport", year,
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = export_states,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = year,
                                source = "US Census Bureau",
                                url = base_url)
}
# Download, save and document 2013-2018 state export data (from Census)
for (year in 2013:2018) {
  getCensusStateExportbyNAICS(year)
}

#' Get Census import data for specified year by NAICS
#' Find guide at https://www.census.gov/foreign-trade/reference/guides/Guide%20to%20International%20Trade%20Datasets.pdf
#' @param year A numeric value between 2013 and 2018 specifying the year of interest.
#' @return A data frame contains state import data by NAICS for the specified year.
getCensusStateImportbyNAICS <- function (year) {
  # Create URL
  # Use "CTY_NAME" instead of "CTY_CODE" to pull "TOTAL FOR ALL COUNTRIES" only
  # Use "MONTH=12" to pull Year-to-Date import values
  base_url <- paste0("https://api.census.gov/data/timeseries/intltrade/imports/statenaics?get=NAICS,CTY_NAME,STATE,GEN_VAL_YR&YEAR=", year, "&MONTH=12")
  # Download table and convert to dataframe
  import <- as.data.frame(jsonlite::fromJSON(base_url),
                          stringsAsFactors = FALSE)[-1, -6]
  # Add column names
  colnames(import) <- c("NAICS", "CountryName", "State", "Value", "Year")
  # Convert specific columns to numeric format
  import[, c("Value", "Year")] <- sapply(import[, c("Value", "Year")], as.numeric)
  # Keep import by state (!STATE=="") and convert state abbreviation to state name
  import_states <- import[!import$NAICS=="" & import$State %in% c(state.abb, "DC"), ]
  state_names <- c(state.name, "District of Columbia")
  import_states$State <- state_names[match(import_states$State, c(state.abb, "DC"))]
  # Write data to .rds
  data_name <- paste("Census_StateImport", year,
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = import_states,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = year,
                                source = "US Census Bureau",
                                url = base_url)
}
# Download, save and document 2013-2018 state import data (from Census)
for (year in 2013:2018) {
  getCensusStateImportbyNAICS(year)
}

#' Download Census state and local gov expenditure between 2012 and 2017
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @return A data frame containing Census state and local gov expenditure between 2012 and 2017.
getStateLocalGovExpenditure <- function (year) {
  # Create base_url
  base_url <- "https://www2.census.gov/programs-surveys/gov-finances/tables/"
  df_ls <- list()
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
    directory <- "inst/extdata/StateLocalGovFinances/"
    if (!file.exists(directory)) {
      dir.create(directory, recursive = TRUE)
    }
    FileName <- file.path(directory, TableName)
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
    df_i <- as.data.frame(readxl::read_excel(FileName, sheet = 1,
                                             col_names = TRUE, skip = skip_rows))
    # Keep Expenditures only
    df_i <- df_i[which(df_i$Description == "Expenditure1"):nrow(df_i), ]
    if (year>2011) {
      Line <- as.integer(df_i[complete.cases(df_i), 1])
    }
    df_i <- df_i[, colnames(df_i)%in%c("Description", "United States Total",
                                       state.name, "District of Columbia")]
    df_ls[[table]] <- df_i[complete.cases(df_i), ]
  }
  df_ls[["b"]][, "Description"] <- NULL
  df <- cbind(Line, df_ls[["a"]], df_ls[["b"]])
  # Convert values to numeric and $
  df[, 3:ncol(df)] <- sapply(df[, 3:ncol(df)], as.numeric)*1E3
  # Write data to .rds
  data_name <- paste("Census_StateLocalGovExpenditure", year,
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = df,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = year,
                                source = "US Census Bureau",
                                url = base_url)
}
# Download, save and document 2013-2017 state local government expenditure (from Census)
for (year in 2012:2017) {
  getStateLocalGovExpenditure(year)
}
