#' Get BEA state compensation data for a range of years.
#' @param years A range of years for which to create data objects.
#' @return A data frame of BEA state compensation data for the range of years.
getBEAStateCompensation <- function(years) {
  output <- processBEAAPIcall("SAINC6N")
  StateComp <- output$df
  DateLastModified <- output$DateLastModified
  # Save data
  for(year in years) {
    if (year <= max(StateComp$TimePeriod)) {
      # Reshape to wide table
      df <- reshape2::dcast(StateComp,
                            GeoFips + GeoName + LineCode ~ TimePeriod,
                            value.var = "DataValue")
      # Write data to .rds
      data_name <- paste("State_Compensation", year,
                         utils::packageDescription("stateior", fields = "Version"),
                         sep = "_")
      saveRDS(object = df,
              file = paste0(file.path("data", data_name), ".rds"))
      # Write metadata to JSON
      useeior:::writeMetadatatoJSON(package = "stateior",
                                    name = data_name,
                                    year = year,
                                    source = "US Bureau of Economic Analysis",
                                    url = "https://apps.bea.gov/api",
                                    date_last_modified = unique(DateLastModified[, 1]),
                                    date_accessed = as.character(Sys.Date()))
    } else {
      logging::logwarn(paste(year, "state compensation data is not avaliable from BEA.",
                             "Nothing is returned."))
    }
  }
}

#' Get BEA state wages and salaries data for a range of years.
#' @param years A range of years for which to create data objects.
#' @return A data frame of BEA state wages and salaries data for the range of years.
getBEAStateWages <- function(years) {
  output <- processBEAAPIcall("SAINC7N")
  StateWages <- output$df
  DateLastModified <- output$DateLastModified
  # Save data
  for(year in years) {
    if (year <= max(StateWages$TimePeriod)) {
      # Reshape to wide table
      df <- reshape2::dcast(StateWages,
                            GeoFips + GeoName + LineCode ~ TimePeriod,
                            value.var = "DataValue")
      # Write data to .rds
      data_name <- paste("State_Wages", year,
                         utils::packageDescription("stateior", fields = "Version"),
                         sep = "_")
      saveRDS(object = df,
              file = paste0(file.path("data", data_name), ".rds"))
      # Write metadata to JSON
      useeior:::writeMetadatatoJSON(package = "stateior",
                                    name = data_name,
                                    year = year,
                                    source = "US Bureau of Economic Analysis",
                                    url = "https://apps.bea.gov/api",
                                    date_last_modified = unique(DateLastModified[, 1]),
                                    date_accessed = as.character(Sys.Date()))
    } else {
      logging::logwarn(paste(year, "state wage and salaries data is not avaliable from BEA.",
                             "Nothing is returned."))
    }
  }
}

#' Get BEA state employment (full-time and part-time) data for a range of years.
#' This dataset has been deprecated by BEA and is no longer available.
#' @param years A range of years for which to create data objects.
#' @return A data frame of BEA state employment data for the range of years.
getBEAStateEmployment <- function(years) {
  output <- processBEAAPIcall("SAEMP25N")
  StateEmp <- output$df
  DateLastModified <- output$DateLastModified
  # Save data
  for(year in years) {
    if (year <= max(StateEmp$TimePeriod)) {
      # Reshape to wide table
      df <- reshape2::dcast(StateEmp,
                            GeoFips + GeoName + LineCode ~ TimePeriod,
                            value.var = "DataValue")
      # Write data to .rds
      data_name <- paste("State_Employment", year,
                         utils::packageDescription("stateior", fields = "Version"),
                         sep = "_")
      saveRDS(object = df,
              file = paste0(file.path("data", data_name), ".rds"))
      # Write metadata to JSON
      useeior:::writeMetadatatoJSON(package = "stateior",
                                    name = data_name,
                                    year = year,
                                    source = "US Bureau of Economic Analysis",
                                    url = "https://apps.bea.gov/api",
                                    date_last_modified = unique(DateLastModified[, 1]),
                                    date_accessed = as.character(Sys.Date()))
    } else {
      logging::logwarn(paste(year, "state employment data is not avaliable from BEA.",
                             "Nothing is returned."))
    }
  }
}

#' Calls BEA API for specific table
#' Use BEA API guide https://apps.bea.gov/API/docs/index.htm.
#' @param table A string indicating the table ID.
#' @return A data frame of BEA state data for all available years.
processBEAAPIcall <- function(table) {
  # Store API key in text file within local data dir (e.g. ../USER/AppData/Local/BEA_API_KEY.txt)
  APIkey <- readLines(file.path(rappdirs::user_data_dir(), "BEA_API_KEY.txt"), warn = FALSE)
  linecodes_txt <- paste0("https://apps.bea.gov/api/data/?&UserID=",
                          APIkey,
                          "&method=GetParameterValuesFiltered",
                          "&datasetname=Regional",
                          "&TargetParameter=LineCode",
                          "&TableName=", table,
                          "&ResultFormat=json")
  linecodes <- jsonlite::fromJSON(linecodes_txt)
  keys <- as.numeric(linecodes$BEAAPI$Results$ParamValue$Key)
  geo_names <- c(state.name, "District of Columbia", "United States")
  # Download data
  df <- data.frame()
  DateLastModified <- data.frame()
  for (linecode in keys) {
    linecode_txt <- paste0("https://apps.bea.gov/api/data/?&UserID=",
                                    APIkey,
                                    "&method=GetData",
                                    "&datasetname=Regional",
                                    "&TableName=", table,
                                    "&LineCode=", linecode,
                                    "&GeoFIPS=STATE",
                                    "&Year=ALL", # can be "ALL" to incl. 1998-
                                    "&ResultFormat=json")
    response <- jsonlite::fromJSON(linecode_txt)
    # Get data by linecode
    data_linecodes <- response$BEAAPI$Results$Data
    if (is.null(data_linecodes$NoteRef)) {
      data_linecodes$NoteRef <- ""
    }
    data_linecodes$LineCode <- linecode
    # Keep US and states only
    data_linecodes <- data_linecodes[data_linecodes$GeoName %in% geo_names, ]
    # Convert data value to numeric
    data_linecodes$DataValue <- as.numeric(gsub(",", "", data_linecodes$DataValue))
    df <- rbind(df, data_linecodes)
    # Get date_last_modified by linecode
    notes <- unlist(response$BEAAPI$Results$Notes)
    DateLastModified_linecode <- stringr::str_match(toString(notes),
                                                    "Last updated: (.*?)--")[2]
    DateLastModified <- rbind(DateLastModified, DateLastModified_linecode)
    Sys.sleep(3)
  }
  return(list(df = df, DateLastModified = DateLastModified))
}

# # Download, save and document BEA state data
# getBEAStateEmployment(seq(2012, 2023))
getBEAStateCompensation(seq(2012, 2023))
getBEAStateWages(seq(2012, 2023))
