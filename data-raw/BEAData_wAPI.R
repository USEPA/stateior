#' Get BEA state employment (full-time and part-time) data for a specified year.
#' Use BEA API guide https://apps.bea.gov/API/docs/index.htm.
#' @param year A numeric value specifying year of interest.
#' @return A data frame of BEA state employment data for the specified year.
getBEAStateEmployment <- function(year) {
  APIkey <- readLines(rappdirs::user_data_dir("BEA_API_KEY.txt"), warn = FALSE)
  linecodes_txt <- paste0("https://apps.bea.gov/api/data/?&UserID=",
                          APIkey,
                          "&method=GetParameterValuesFiltered",
                          "&datasetname=Regional",
                          "&TargetParameter=LineCode",
                          "&TableName=SAEMP25N",
                          "&ResultFormat=json")
  linecodes <- jsonlite::fromJSON(linecodes_txt)
  keys <- as.numeric(linecodes$BEAAPI$Results$ParamValue$Key)
  geo_names <- c(state.name, "District of Columbia", "United States")
  # Download data
  StateEmp <- data.frame()
  DateLastModified <- data.frame()
  for (linecode in keys) {
    StateEmp_linecode_txt <- paste0("https://apps.bea.gov/api/data/?&UserID=",
                                    APIkey,
                                    "&method=GetData",
                                    "&datasetname=Regional",
                                    "&TableName=SAEMP25N",
                                    "&LineCode=", linecode,
                                    "&GeoFIPS=STATE",
                                    "&Year=LAST10", # can be "ALL" to incl. 1998-
                                    "&ResultFormat=json")
    response <- jsonlite::fromJSON(StateEmp_linecode_txt)
    # Get employment data by linecode
    StateEmp_linecode <- response$BEAAPI$Results$Data
    if (is.null(StateEmp_linecode$NoteRef)) {
      StateEmp_linecode$NoteRef <- ""
    }
    StateEmp_linecode$LineCode <- linecode
    # Keep US and states only
    StateEmp_linecode <- StateEmp_linecode[StateEmp_linecode$GeoName %in% geo_names, ]
    # Convert data value to numeric
    StateEmp_linecode$DataValue <- as.numeric(gsub(",", "",
                                                   StateEmp_linecode$DataValue))
    StateEmp <- rbind(StateEmp, StateEmp_linecode)
    # Get date_last_modified by linecode
    notes <- unlist(response$BEAAPI$Results$Notes)
    DateLastModified_linecode <- stringr::str_match(toString(notes),
                                                    "Last updated: (.*?)--")[2]
    DateLastModified <- rbind(DateLastModified, DateLastModified_linecode)
    Sys.sleep(3)
  }
  
  # Save data
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
# Download, save and document BEA state employment data
for (year in 2012:2020) {
  getBEAStateEmployment(year)
  print(year)
}
