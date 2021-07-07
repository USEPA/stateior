#' Get EPA RCRAInfo Biennial Report data.
#' @param year A numeric value specifying the year of interest,
#' can be odd numbers like 2013.
#' @return A data frame of EPA RCRAInfo Biennial Report data.
getRCRAInfoBR <- function (year) {
  # Create the placeholder file
  dataset <- paste0("BR_REPORTING_", year)
  RCRAInfoBRzip <- paste0("inst/extdata/", dataset, ".zip")
  # Download EPA RCRAInfo Biennial Report data into the placeholder file
  if(!file.exists(RCRAInfoBRzip)) {
    base_url <- "https://s3.amazonaws.com/rcrainfo-ftp/Production/CSV-2021-06-28T03-00-00-0400/Biennial%20Report/"
    download.file(paste0(base_url, gsub("inst/extdata", dataset, RCRAInfoBRzip)),
                  RCRAInfoBRzip, mode = "wb")
    # Get the name of all files in the zip archive
    tmp <- unzip(RCRAInfoBRzip, list = TRUE)
    fname <- tmp[tmp$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(RCRAInfoBRzip, files = fname,
          exdir = paste0("inst/extdata/BR_REPORTING_", year), overwrite = TRUE)
  }
  # Load all EPA RCRAInfo Biennial Report data
  location_cols <- c("STATE NAME", "RECEIVER STATE NAME", "SHIPPER STATE NAME")
  value_cols <- c("GENERATION TONS", "MANAGED TONS", "SHIPPED TONS", "RECEIVED TONS")
  file_ls <- list()
  for (file in list.files(paste0("inst/extdata/", dataset))) {
    filename <- paste("inst/extdata", dataset, file, sep = "/")
    file_ls[[file]] <- as.data.frame(data.table::fread(filename,
                                                       select = c(location_cols, value_cols),
                                                       stringsAsFactors = FALSE))
  }
  # Rbind to a large data.frame
  df <- do.call(rbind, file_ls)
  # Assign "UNKNOWN" to blank RECEIVER/SHIPPER STATE NAME
  df[df[, "RECEIVER STATE NAME"]=="", "RECEIVER STATE NAME"] <- "UNKNOWN"
  df[df[, "SHIPPER STATE NAME"]=="", "SHIPPER STATE NAME"] <- "UNKNOWN"
  # Aggregate value_cols by location_cols
  df_agg <- stats::aggregate(df[, value_cols],
                             by = list(df[, "STATE NAME"],
                                       df[, "RECEIVER STATE NAME"],
                                       df[, "SHIPPER STATE NAME"]),
                             sum)
  colnames(df_agg)[1:3] <- location_cols
  return(df_agg)
}

RCRAInfoBR_2013 <- getRCRAInfoBR(2013)
usethis::use_data(RCRAInfoBR_2013, overwrite = TRUE)
RCRAInfoBR_2015 <- getRCRAInfoBR(2015)
usethis::use_data(RCRAInfoBR_2015, overwrite = TRUE)
RCRAInfoBR_2017 <- getRCRAInfoBR(2017)
usethis::use_data(RCRAInfoBR_2017, overwrite = TRUE)
