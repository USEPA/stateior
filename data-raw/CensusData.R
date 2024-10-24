#10/07/24 updates: updated the getStateLocalExpenditure() function to grab 2021 data

#' Get US import/export table from usatrade.census.gov, and convert it to Census
#' import/export table format.
#' @param year A numeric value specifying year of interest.
#' @param flow_ratio_type Type of commodity flow, can be "export" or "import".
#' @return A data frame contains US import/export data for the specified year.
getCensusUSATradebyNAICS <- function(year, flow_ratio_type) {
  # Load the downloaded table from usatrade.census.gov
  FileName <- paste0("Census_USATrade",
                     capitalize(flow_ratio_type), "_", year, ".csv")
  FullFileName <- system.file("extdata", FileName, package = "stateior")
  date_last_modified <- as.character(as.Date(file.mtime(FullFileName)))
  table <- utils::read.table(FullFileName, sep = ",", header = FALSE,
                             stringsAsFactors = FALSE, check.names = FALSE,
                             skip = 4, col.names = c("Commodity", "State",
                                                     "Country", "Year", "Value"))
  # Keep rows for the specified year and drop "All Commodities"
  table <- table[table$Year == year & !table$Commodity == "All Commodities", ]
  # Change state name from "Dist of Columbia" to "District of Columbia"
  table[table$State == "Dist of Columbia", "State"] <- "District of Columbia"
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
  data_name <- paste(sub(".csv", "", FileName),
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = table,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = year,
                                source = "US Census Bureau",
                                url = "usatrade.census.gov",
                                date_last_modified = date_last_modified,
                                date_accessed = date_last_modified)
}
# Download, save and document 2012 state trade data (from Census USA Trade Export and Import)
if (year == 2012) {
  getCensusUSATradebyNAICS(2012, "export")
  getCensusUSATradebyNAICS(2012, "import")
}

#' Get Census export by NAICS data for a specific year.
#' Find guide at https://www.census.gov/foreign-trade/reference/guides/Guide%20to%20International%20Trade%20Datasets.pdf
#' @param year A numeric value larger than 2012 specifying year of interest.
#' of interest.
#' @return A data frame contains state export by NAICS data for the specified year.
getCensusStateExportbyNAICS <- function(year) {
  # Create URL
  # Use "CTY_NAME" instead of "CTY_CODE" to pull "TOTAL FOR ALL COUNTRIES" only
  # Use "MONTH=12" to pull Year-to-Date import values
  base_url <- "https://api.census.gov/data/timeseries/intltrade/exports/statenaics"
  url <- paste0(base_url,
                "?get=NAICS,CTY_NAME,STATE,ALL_VAL_YR&YEAR=",
                year,
                "&MONTH=12")
  # Get date_last_modified
  date_last_modified <- jsonlite::fromJSON(base_url)$dataset$modified
  # Download table and convert to dataframe
  tryCatch(
    exp = {
      default_options <- options()
      export <- as.data.frame(jsonlite::fromJSON(url),
                              stringsAsFactors = FALSE)[-1, -6]
      options(default_options)
      # Add column names
      colnames(export) <- c("NAICS", "CountryName", "State", "Value", "Year")
      # Convert specific columns to numeric format
      export[, c("Value", "Year")] <- sapply(export[, c("Value", "Year")], as.numeric)
      # Keep export by state (!STATE=="") and convert state abbreviation to state name
      export_states <- export[!export$NAICS == "" & export$State %in% c(state.abb, "DC"), ]
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
                                    url = url,
                                    date_last_modified = date_last_modified,
                                    date_accessed = as.character(Sys.Date()))
    },
    error = function(e) {
      stop(paste(year, "state export data is not avaliable from Census.",
                 "Nothing is returned."))
    }
  )
}
# Download, save and document Census state export data for specified year
if (year >= 2013) {
  getCensusStateExportbyNAICS(year)
}

#' Get Census import by NAICS data for a specific year.
#' Find guide at https://www.census.gov/foreign-trade/reference/guides/Guide%20to%20International%20Trade%20Datasets.pdf
#' @param year A numeric value larger than 2012 specifying year of interest.
#' @return A data frame contains state import by NAICS data for the specified year.
getCensusStateImportbyNAICS <- function(year) {
  # Create URL
  # Use "CTY_NAME" instead of "CTY_CODE" to pull "TOTAL FOR ALL COUNTRIES" only
  # Use "MONTH=12" to pull Year-to-Date import values
  base_url <- "https://api.census.gov/data/timeseries/intltrade/imports/statenaics"
  url <- paste0(base_url,
                "?get=NAICS,CTY_NAME,STATE,GEN_VAL_YR&YEAR=",
                year,
                "&MONTH=12")
  # Get date_last_modified
  date_last_modified <- jsonlite::fromJSON(base_url)$dataset$modified
  tryCatch(
    exp = {
      # Download table and convert to dataframe
      default_options <- options()
      import <- as.data.frame(jsonlite::fromJSON(url),
                              stringsAsFactors = FALSE)[-1, -6]
      options(default_options)
      # Add column names
      colnames(import) <- c("NAICS", "CountryName", "State", "Value", "Year")
      # Convert specific columns to numeric format
      import[, c("Value", "Year")] <- sapply(import[, c("Value", "Year")], as.numeric)
      # Keep import by state (!STATE=="") and convert state abbreviation to state name
      import_states <- import[!import$NAICS == "" & import$State %in% c(state.abb, "DC"), ]
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
                                    url = url,
                                    date_last_modified = date_last_modified,
                                    date_accessed = as.character(Sys.Date()))
    },
    error = function(e) {
      stop(paste(year, "state import data is not avaliable from Census.",
                 "Nothing is returned."))
    }
  )
}
# Download, save and document Census state import data for specified year
if (year >= 2013) {
  getCensusStateImportbyNAICS(year)
}

#' Download Census state and local gov expenditure for a specific year.
#' @param year A numeric value specifying year of interest.
#' @return A data frame containing Census state and local gov expenditure for
#' the specified year.
getStateLocalGovExpenditure <- function(year) {
  # Create base_url
  base_url <- "https://www2.census.gov/programs-surveys/gov-finances/tables/"
  df_ls <- list()
  date_last_modified_ls <- list()
  # Specify table to download
  if (year <2018){
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
      directory <- "inst/extdata/StateLocalGovFinances"
      tryCatch(
        exp = {
          if (!file.exists(directory)) {
            dir.create(directory, recursive = TRUE)
          }
          FullFileName <- file.path(directory, TableName)
          # Download file
          if (!file.exists(FullFileName)) {
            suppressWarnings(utils::download.file(url, FullFileName, mode = "wb"))
          }
          date_accessed <- as.character(as.Date(file.mtime(FullFileName)))
          # Specify rows to skip based on year
          if (year %in% c(2012, 2017)) {
            skip_rows <- 7
          } else if (year %in% c(2009:2011)) {
            skip_rows <- 8
          }
          # Load table
          df_i <- as.data.frame(readxl::read_excel(FullFileName, sheet = 1,
                                                   col_names = TRUE, skip = skip_rows))
          # Save date_last_modified
          date_last_modified_i <- sub("Revision date: ",
                                      "",
                                      df_i[grep("Revision date: ",
                                                df_i$Description), "Description"])
          date_last_modified_ls[[table]] <- date_last_modified_i
          # Keep Expenditures only
          df_i <- df_i[which(df_i$Description == "Expenditure1"):nrow(df_i), ]
          if (year > 2011) {
            Line <- as.integer(df_i[complete.cases(df_i), 1])
          }
          df_i <- df_i[, colnames(df_i) %in% c("Description", "United States Total",
                                               state.name, "District of Columbia")]
          df_ls[[table]] <- df_i[complete.cases(df_i), ]
        },
        error = function(e) {
          stop(paste(year, "state and local government expenditure data",
                     "is not avaliable from Census. Nothing is returned."))
        }
      )
    }
    
  } else {
    # Specify table to download
    FileType <- ".xlsx"
    url <- paste0(base_url, year, "/", substr(year, 3, 4),
                  "slsstab1", FileType)
    
    TableName <- paste0(substr(year, 3, 4), "slsstab1", FileType)
    directory <- "inst/extdata/StateLocalGovFinances"
    
    tryCatch(
      exp = {
        if (!file.exists(directory)) {
          dir.create(directory, recursive = TRUE)
        }
        FullFileName <- file.path(directory, TableName)
        # Download file
        if (!file.exists(FullFileName)) {
          suppressWarnings(utils::download.file(url, FullFileName, mode = "wb"))
        }
        date_accessed <- as.character(as.Date(file.mtime(FullFileName)))
  
        # Specify rows to skip 
        skip_rows <- 10
        
        # Load table
        df_i <- as.data.frame(readxl::read_excel(FullFileName, sheet = 1,
                                                 col_names = TRUE, skip = skip_rows))
        # Save date_last_modified
        date_last_modified_i <- sub("Revision date: ",
                                    "",
                                    df_i[grep("Revision date: ",
                                              df_i$Description), "Description"])
        date_last_modified_ls[[table]] <- date_last_modified_i
        # Keep Expenditures only
        df_i <- df_i[which(df_i$Description == "Expenditure1"):nrow(df_i), ]
        if (year > 2011) {
          Line <- as.integer(df_i[complete.cases(df_i), 1])
        }
        df_i <- df_i[, colnames(df_i) %in% c("Description", "United States Total",
                                             state.name, "District of Columbia")]
        df_ls[[table]] <- df_i[complete.cases(df_i), ]
      },
      error = function(e) {
        stop(paste(year, "state and local government expenditure data",
                   "is not avaliable from Census. Nothing is returned."))
      }
    )
  }
  if (length(df_ls) > 1) {
    df_ls[["b"]][, "Description"] <- NULL
    df <- cbind(Line, df_ls[["a"]], df_ls[["b"]])
  }else{
    df <- df_ls
  }
    
    # Convert values to numeric and $
    df[, 3:ncol(df)] <- sapply(df[, 3:ncol(df)], as.numeric)*1E3
    date_last_modified <- unique(unlist(date_last_modified_ls))
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
                                  url = base_url,
                                  date_last_modified = date_last_modified,
                                  date_accessed = date_accessed)
}

# Download, save and document Census state local government expenditure data
# for specified year
getStateLocalGovExpenditure(year)
