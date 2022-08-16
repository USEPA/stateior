#' Write StateIO data to specified format, .csv or .xlsx, to output folder.
#' The data are loaded from Data Commons or local data directory.
#' @param filename A string specifying filename, e.g. "State_Summary_Use_2017".
#' @param ver A string specifying version of the data, default is NULL, can be "v0.1.0".
#' @param state State name.
#' #' @param outputfolder A directory to write matrices out to.
#' @description Writes StateIO data as .csv or .xlsx files to output folder.
#' @export
writeStateIODatatoCSV <- function(filename, ver = NULL, state, outputfolder) {
  data <- loadStateIODataFile(filename, ver)[[state]]
  if (!dir.exists(outputfolder)) {
    dir.create(outputfolder, recursive = TRUE) 
  }
  utils::write.csv(data, file.path(outputfolder, "/", matrix, ".csv"),
                   na = "", row.names = TRUE, fileEncoding = "UTF-8")
  logging::loginfo(paste0(state, unlist(strsplit(filename, "_"))[4],
                          unlist(strsplit(filename, "_"))[3],
                          " written to ", outputfolder, "."))
}

