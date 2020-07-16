# Get Freight Analysis Framework (FAF) data from 2013-2018.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @return A data frame contains FAF data from 2013-2018.
getFAF <- function (year) {
  # Create the placeholder file
  if (year == 2012) {
    FAFzip <- "inst/extdata/FAF4.5.1_State.zip"
  } else if (year %in% c(2013:2018)) {
    FAFzip <- "inst/extdata/FAF4.5.1_State_2013-2018.zip"
  }
  # Download all BLS QCEW tables into the placeholder file
  if(!file.exists(FAFzip)) {
    download.file(paste0("https://faf.ornl.gov/fafweb/Data/", gsub("inst/extdata/", "", FAFzip)),
                  FAFzip, mode = "wb")
    # Get the name of all files in the zip archive
    fname <- unzip(FAFzip, list = TRUE)[unzip(FAFzip, list = TRUE)$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(FAFzip, files = fname, exdir = paste0("inst/extdata"), overwrite = TRUE)
  }
  # Specify filename based on year
  if (year == 2012) {
    filename <- "inst/extdata/FAF4.5.1_State/FAF4.5.1_State.csv"
  } else if (year %in% c(2013:2018)) {
    filename <- paste0("inst/extdata/FAF4.5.1_State_2013-2018/FAF4.5.1_State_", year, ".csv")
  }
  # Load state data
  FAF <- utils::read.table(filename, sep = ",", header = TRUE,
                           stringsAsFactors = FALSE, check.names = FALSE, fill = TRUE)
  # Keep columns for year
  FAF <- FAF[, c(colnames(FAF)[1:9], paste0(c("value_", "tons_", "tmiles_"), year))]
  # Convert value from million $ to $
  FAF[, paste0("value_", year)] <- FAF[, paste0("value_", year)]*1E6
  # Convert weight from thousand tons to tons
  FAF[, paste0("tons_", year)] <- FAF[, paste0("tons_", year)]*1E3
  # Convert wright-distance from million ton-miles to ton-miles
  FAF[, paste0("tmiles_", year)] <- FAF[, paste0("tmiles_", year)]*1E6
  return(FAF)
}

FAF_2012 <- getFAF(2012)
usethis::use_data(FAF_2012, overwrite = TRUE)
FAF_2013 <- getFAF(2013)
usethis::use_data(FAF_2013, overwrite = TRUE)
FAF_2014 <- getFAF(2014)
usethis::use_data(FAF_2014, overwrite = TRUE)
FAF_2015 <- getFAF(2015)
usethis::use_data(FAF_2015, overwrite = TRUE)
FAF_2016 <- getFAF(2016)
usethis::use_data(FAF_2016, overwrite = TRUE)
FAF_2017 <- getFAF(2017)
usethis::use_data(FAF_2017, overwrite = TRUE)
FAF_2018 <- getFAF(2018)
usethis::use_data(FAF_2018, overwrite = TRUE)
