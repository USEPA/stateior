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
  keys <- as.numeric(linecodes$BEAAPI$Results$ParamValue$Key)
  for (linecode in keys) {
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
