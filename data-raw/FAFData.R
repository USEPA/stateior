# Get Freight Analysis Framework (FAF) data from 2012-2018.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @return A data frame contains FAF data from 2012-2018.
getFAF <- function(year) {
  # Create the placeholder file
  if (year == 2012) {
    FAFzip <- "inst/extdata/FAF4.5.1_csv_State.zip"
  } else if (year %in% c(2013:2018)) {
    FAFzip <- "inst/extdata/FAF4.5.1_csv_State_2013-2018.zip"
  }
  # Download all FAF tables into the placeholder file
  if (!file.exists(FAFzip)) {
    utils::download.file(paste0("https://www.bts.gov/sites/bts.dot.gov/files/",
                                "legacy/AdditionalAttachmentFiles/",
                                gsub("inst/extdata/", "", FAFzip)),
                         FAFzip, mode = "wb")
    # Get the name of all files in the zip archive
    fname <- unzip(FAFzip, list = TRUE)[unzip(FAFzip, list = TRUE)$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(FAFzip, files = fname, exdir = paste0("inst/extdata"), overwrite = TRUE)
  }
  # Specify filename based on year
  if (year == 2012) {
    filename <- "inst/extdata/FAF4.5.1_State.csv"
  } else if (year %in% c(2013:2018)) {
    filename <- paste0("inst/extdata/FAF4.5.1_State_", year, ".csv")
  }
  date_accessed <- as.character(as.Date(file.mtime(filename)))
  # Load state data
  FAF <- utils::read.table(filename, sep = ",", header = TRUE,
                           stringsAsFactors = FALSE,
                           check.names = FALSE, fill = TRUE)
  # Keep columns for year
  FAF <- FAF[, c(colnames(FAF)[1:9],
                 paste(c("value", "tons", "tmiles"), year, sep = "_"))]
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
                                url = "https://www.bts.gov/faf/faf4",
                                date_last_modified = "unknown",
                                date_accessed = date_accessed)
}
# Download, save and document 2012-2018 state FAF data (from ORNL)
for (year in 2012:2018) {
  getFAF(year)
}
