# Get Freight Analysis Framework (FAF) data since 2012.
#' @param year A numeric value specifying year of interest.
#' @return A data frame contains FAF data since 2012.
getFAF <- function(year) {
  if (year <= 2018) {
    ### FAF 4.5.1 ###
    # Create placeholder for zip file and specify filename based on year
    if (year == 2012) {
      FAFzip <- "inst/extdata/FAF4.5.1_csv_State.zip"
      filename <- "inst/extdata/FAF4.5.1_State.csv"
    } else if (year %in% c(2013:2018)) {
      FAFzip <- "inst/extdata/FAF4.5.1_csv_State_2013-2018.zip"
      filename <- paste0("inst/extdata/FAF4.5.1_State_", year, ".csv")
    }
    file_baseurl <- paste0("https://www.bts.gov/sites/bts.dot.gov/files/",
                           "legacy/AdditionalAttachmentFiles/")
    # Use published date on www.bts.gov as the date last modified for FAF data
    url <- "https://www.bts.gov/faf/faf4"
    notes <- readLines(url)
    date_note <- notes[grep("About the Freight Analysis Framework", notes) - 4]
    date_last_modified <- stringr::str_match(date_note, "day, (.*?)</div>")[2]
  } else {
    ### FAF 5.3 ###
    # Create placeholder for zip file and specify filename based on year
    if (year == 2019) {
      FAFzip <- "inst/extdata/FAF5.3_2018-2019.zip"
      filename <- "inst/extdata/FAF5.3_2018-2019.csv"
    } else {
      # Use forecasts (mid-range estimates only)
      FAFzip <- "inst/extdata/FAF5.3_State.zip"
      filename <- "inst/extdata/FAF5.3_State.csv"
    }
    file_baseurl <- "https://faf.ornl.gov/faf5/data/download_files/"
    # Use last modified date on www.faf.ornl.gov
    url <- "https://faf.ornl.gov/faf5"
    notes <- readLines(url)
    date_note <- notes[grep("Last modified:", notes)]
    date_last_modified <- stringr::str_match(date_note,
                                             "Last modified: <br />(.*?)</small>")[2]
  }
  
  # Download all FAF tables into the placeholder file
  if (!file.exists(FAFzip)) {
    utils::download.file(paste0(file_baseurl, gsub("inst/extdata/", "", FAFzip)),
                         FAFzip, mode = "wb", timeout = max(1000, getOption("timeout")))
    # Get the name of all files in the zip archive
    fname <- unzip(FAFzip, list = TRUE)[unzip(FAFzip, list = TRUE)$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(FAFzip, files = fname, exdir = paste0("inst/extdata"), overwrite = TRUE)
  }
  # Find date accessed
  date_accessed <- as.character(as.Date(file.mtime(filename)))
  # Load state data
  FAF <- utils::read.table(filename, sep = ",", header = TRUE,
                           stringsAsFactors = FALSE,
                           check.names = FALSE, fill = TRUE)
  if (year %in% gsub(".*_", "", colnames(FAF))) {
    # Keep columns for year
    if (year == 2012) {
      FAF <- FAF[, c(colnames(FAF)[1:9],
                     paste(c("value", "tons", "tmiles"), year, sep = "_"))]
    } else if (year %in% c(2013:2018)) {
      FAF <- FAF[, c(colnames(FAF)[1:9],
                     paste(c("value", "curval", "tons", "tmiles"), year, sep = "_"))]
      # Convert current value from million $ to $
      FAF[, paste0("curval_", year)] <- FAF[, paste0("curval_", year)]*1E6
    }
    # Convert value from million $ to $
    FAF[, paste0("value_", year)] <- FAF[, paste0("value_", year)]*1E6
    # Convert weight from thousand tons to tons
    FAF[, paste0("tons_", year)] <- FAF[, paste0("tons_", year)]*1E3
    # Convert wright-distance from million ton-miles to ton-miles
    FAF[, paste0("tmiles_", year)] <- FAF[, paste0("tmiles_", year)]*1E6
    # Write data to .rds
    data_name <- paste("FAF", year,
                       utils::packageDescription("stateior", fields = "Version"),
                       sep = "_")
    saveRDS(object = FAF,
            file = paste0(file.path("data", data_name), ".rds"))
    # Write metadata to JSON
    useeior:::writeMetadatatoJSON(package = "stateior",
                                  name = data_name,
                                  year = year,
                                  source = "US Oak Ridge National Laboratory",
                                  url = url,
                                  date_last_modified = date_last_modified,
                                  date_accessed = date_accessed)
  } else {
    logging::logwarn(paste(year, "FAF data is not avaliable from ORNL.",
                           "Nothing is returned."))
  }
}

# Download, save and document state FAF data
getFAF(year)
