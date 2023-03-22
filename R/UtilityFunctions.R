#' Start logging 
startLogging <- function() {
  #http://logging.r-forge.r-project.org/sample_session.php
  logging::basicConfig()
}

#' Load data from useeior using flexible dataset name
#' @param dataset A string specifying name of the data to load
#' @return The data loaded from useeior
loadDatafromUSEEIOR <- function(dataset) {
  utils::data(package = "useeior", list = dataset)
  df <- get(dataset)
  return(df)
}

#' Read csv files using read.table function from utils package
#' set header = TRUE, stringsAsFactors = FALSE, and check.names = FALSE
#' @param filename A string specifying name of the csv file
#' @param fill logical. If TRUE then in case the rows have unequal length,
#' blank fields are implicitly added.
#' @return The data read
readCSV <- function(filename, fill = FALSE) {
  df <- utils::read.table(filename, sep = ",", header = TRUE,
                          stringsAsFactors = FALSE, check.names = FALSE,
                          fill = fill, fileEncoding = "UTF-8-BOM")
  return(df)
}

#' Join strings with slashes
#'
#' @param ... text string
joinStringswithSlashes <- function(...) {
  items <- list(...)
  str <- sapply(items, paste, collapse = '/')
  return(str)
}

#' Extract desired columns from SchemaInfo, return vectors with strings of codes.
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param colName A text value specifying desired column name.
#' @return A vector of codes.
getVectorOfCodes <- function(iolevel, colName) {
  SchemaInfo <- readCSV(system.file("extdata",
                                    paste0("2012_", iolevel, "_Schema_Info.csv"),
                                    package = "stateior"))
  return(as.vector(stats::na.omit(SchemaInfo[, c("Code", colName)])[, "Code"]))
}

#' Get codes of final demand.
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @return A vector of final demand codes.
getFinalDemandCodes <- function(iolevel) {
  FinalDemandCodes <- unlist(sapply(list("HouseholdDemand", "InvestmentDemand",
                                         "ChangeInventories", "Export", "Import",
                                         "GovernmentDemand"),
                                    getVectorOfCodes, iolevel = iolevel))
  return(FinalDemandCodes)
}

#' This function converts US state name, for example "Alabama",
#' to a two-character state abbreviation "AL". Can take "District of Columbia".
#' @param state A string character specifying the full name of a US state.
#' @return two-character abbreviation of a US state.
getStateAbbreviation <- function(state) {
  state_abb <- ifelse(state == "District of Columbia", "DC",
                      state.abb[state.name == state])
  return(state_abb)
}

#' Maps a vector of 5-digit FIPS codes to location names
#' @param fipscodes A vector of 5 digit FIPS codes
#' @param fipssystem A text value specifying FIPS System, can be FIPS_2015
#' @return A vector of location names where matches are found
mapFIPS5toLocationNames <- function(fipscodes, fipssystem) {
  mapping_file <- "Crosswalk_FIPS.csv"
  mapping <- utils::read.table(system.file("extdata", mapping_file, package = "stateior"),
                               sep = ",", header = TRUE, stringsAsFactors = FALSE, 
                               check.names = FALSE, quote = "")
  # Add leading zeros to FIPS codes if necessary
  if (!fipssystem %in% colnames(mapping)) {
    fipssystem <- max(which(startsWith(colnames(mapping), "FIPS")))
  }
  mapping[, fipssystem] <- formatC(mapping[, fipssystem], width = 5, format = "d", flag = "0")
  mapping <- mapping[mapping[, fipssystem] %in% fipscodes, ]
  # Get locations based on fip scodes
  locations <- stringr::str_replace_all(string = fipscodes,
                                        pattern = setNames(as.vector(mapping$State),
                                                           mapping[, fipssystem]))
  return(locations)
}

#' Load BEA State data (GVA and Employment) to BEA Summary mapping table
#' @param dataname A string specifying name of the BEA state data
#' @return The mapping table
loadBEAStateDatatoBEASummaryMapping <- function(dataname) {
  filename <- paste0("Crosswalk_State", dataname, "toBEASummaryIO2012Schema.csv")
  mapping <- readCSV(system.file("extdata", filename, package = "stateior"))
  return(mapping)
}

#' Combine sector code and location to the form of code/location.
#' @param sector_type A text value specifying desired sector type,
#' can be "Commodity", "Industry", "FinalDemand", or "ValueAdded".
#' @param location A text value specifying desired location,
#' can be state name like "Georgia" or "RoUS" representing Rest of US.
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param disagg optional, disaggregation specs 
#' @return A text value in the format of code/location.
getBEASectorCodeLocation <- function(sector_type, location, iolevel, disagg=NULL) {
  # Get code
  if (sector_type != "FinalDemand") {
    if (sector_type == "InternationalTradeAdjustment") {
      code <- ifelse(iolevel == "Detail", "F05100", "F051")
    } else {
      code <- getVectorOfCodes(iolevel, sector_type)
      if (!is.null(disagg)) {
        code <- disaggregateStateSectorLists(code, disagg)
      }
    }
  } else {
    code <- getFinalDemandCodes(iolevel)
  }
  # Get code_loc
  if (location != "RoUS") {
    state_abb <- getStateAbbreviation(location)
    code_loc <- apply(cbind(code, paste0("US-", state_abb)), 1,
                      FUN = joinStringswithSlashes)
  } else {
    code_loc <- apply(cbind(code, "RoUS"), 1, FUN = joinStringswithSlashes)
  }
  return(code_loc)
}

#' Generate two-region data filename with .rds as suffix.
#' @description Generate two-region data filename with .rds as suffix.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse",
#' "CommodityOutput, and "IndustryOutput".
#' @return A string of two-region data filename with .rds as suffix.
getTwoRegionDataFileName <- function(year, iolevel, dataname) {
  filename <- paste("TwoRegion", iolevel, dataname, year, sep = "_")
  return(filename)
}

#' Load flowsa FlowByActivity or FlowBySector data from Data Commons
#' @param dataname A string specifying data name, can be "NOAA_FisheryLandings".
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state data from FLOWSA.
getFlowsaData <- function(dataname, year) {
  if (is.null(model_ver)) {
    model_ver <- "NULL"
  }
  # Load metadata
  if (dataname == "Employment") {
    meta <- configr::read.config(system.file("extdata/", "FlowBySector_metadata.yml",
                                             package = "stateior"))
    if ("Extension" %in% names(meta[[dataname]][[model_ver]])) {
      file_extesion <- meta[[dataname]][[model_ver]]
    } else {
      file_extesion <- meta[[dataname]][[model_ver]][[as.character(year)]]
    }
    filename <- paste(dataname, "state", year, file_extesion, sep = "_")
    subdirectory <- "flowsa/FlowBySector"
  } else {
    meta <- configr::read.config(system.file("extdata/", "FlowByActivity_metadata.yml",
                                             package = "stateior"))
    if ("Extension" %in% names(meta[[dataname]][[model_ver]])) {
      file_extesion <- meta[[dataname]][[model_ver]]
    } else {
      file_extesion <- meta[[dataname]][[model_ver]][[as.character(year)]]
    }
    filename <- paste(dataname, year, file_extesion, sep = "_")
    subdirectory <- "flowsa/FlowByActivity"
  }
  # Define file directory
  directory <- file.path(rappdirs::user_data_dir(), subdirectory)
  if (!file.exists(file.path(directory, filename))) {
    url <- paste0("https://edap-ord-data-commons.s3.amazonaws.com/", subdirectory)
    logging::loginfo(paste0("file not found, downloading from ", url))
    # Check for and create directory if necessary
    if (!file.exists(directory)) {
      dir.create(directory, recursive = TRUE)
    }
    # Download file
    utils::download.file(file.path(url, filename),
                         file.path(directory, filename), mode = "wb", quiet = TRUE)
  }
  # Load data
  df <- as.data.frame(arrow::read_parquet(file.path(directory, filename)))
  # Keep state-level data, including 50 states and D.C.
  df <- df[substr(df$Location, 1, 2) <= 56 & substr(df$Location, 3, 5) == "000", ]
  return(df)
}

#' Get data registry on Data Commons.
#' @param data_group A string specifying name of data group that is used as the
#' subdirectory in Data Commons, can be "stateio", "flowsa/FlowBySector", or
#' "flowsa/FlowByActivity".
#' @return A dataframe of StateIO data registry on Data Commons.
getRegistryonDataCommons <- function(data_group = "stateio") {
  registry_ls <- aws.s3::get_bucket(bucket = "edap-ord-data-commons",
                                    prefix = data_group)
  registry <- cbind.data.frame(basename(sapply(registry_ls, `[[`, "Key")),
                               sapply(registry_ls, `[[`, "LastModified"),
                               stringsAsFactors = FALSE)
  colnames(registry) <- c("Key", "LastModified")
  return(registry)
}

#' Find the latest StateIO data on Data Commons.
#' @param filename A string specifying filename, e.g. "State_Summary_Use_2017".
#' @return File name of the latest StateIO data on Data Commons.
findLatestStateIODataonDataCommons <- function(filename) {
  registry <- getRegistryonDataCommons(data_group = "stateio")
  f <- registry[startsWith(registry$Key, filename) &
                  endsWith(registry$Key, ".rds"), ]
  f <- basename(f[which.max(as.Date(f$LastModified)), "Key"])
  if (length(f) == 0) {
    stop(paste(filename, "not avaialble on Data Commons."))
  }
  return(f)
}

#' Check if file is available on Data Commons. Stop function execution if not.
#' @param file A string specifying file, e.g. "State_Summary_Use_2017_v0.1.0_rds".
checkFileonDataCommons <- function(file) {
  registry <- getRegistryonDataCommons(data_group = "stateio")
  f <- basename(registry[startsWith(registry$Key, file) &
                           endsWith(registry$Key, ".rds"),
                         "Key"])
  if (length(f) == 0) {
    stop(paste(file, "not avaialble on Data Commons."))
  }
}

#' Download StateIO data file from Data Commons and stores in a local data directory.
#' @param filename A string specifying filename, e.g. "State_Summary_Use_2017".
#' @param ver A string specifying version of the data, default is NULL, can be "v0.1.0".
#' @return An .rds data file downloaded from Data Commons and stored in local directory.
downloadStateIODatafromDataCommons <- function(filename, ver = NULL) {
  # Define local directory
  directory <- file.path(rappdirs::user_data_dir(), "stateio")
  if (!file.exists(directory)) {
    dir.create(directory, recursive = TRUE)
  }
  # Define file name
  if (is.null(ver)) {
    # Look for the latest file
    f <- findLatestStateIODataonDataCommons(filename)
  } else {
    # Look for file under specific version
    f <- paste0(paste(filename, ver, sep = "_"), ".rds")
  }
  # Download file
  url <- "https://edap-ord-data-commons.s3.amazonaws.com/stateio"
  utils::download.file(file.path(url, f),
                       file.path(directory, f), mode = "wb", quiet = TRUE)
}

#' Find the latest StateIO data in local data directory.
#' @param filename A string specifying filename, e.g. "State_Summary_Use_2017".
#' @return File name of the latest StateIO data in local data directory.
findLatestStateIODatainLocalDirectory <- function(filename) {
  files <- list.files(path = file.path(rappdirs::user_data_dir(), "stateio"),
                      pattern = paste0(filename, ".*\\.rds"),
                      full.names = TRUE)
  f <- basename(files[which.max(as.Date(file.mtime(files)))])
  if (length(f) == 0) {
    stop(paste(filename, "not avaialble in local data directory."))
  }
  return(f)
}

#' Load StateIO data file from Data Commons or local data directory.
#' @param filename A string specifying filename, e.g. "State_Summary_Use_2017".
#' @param ver A string specifying version of the data, default is NULL, can be "v0.1.0".
#' @return A StateIO data product (usually a list of dataframes).
#' @export
loadStateIODataFile <- function(filename, ver = NULL) {
  # Define file name
  if (is.null(ver)) {
    # Look for the latest file in Data Commons first.
    tryCatch(
      expr = {
        f <- findLatestStateIODataonDataCommons(filename)
      },
      error = function(e) {
        logging::logwarn(paste(filename, "not found on Data Commons.",
                               "Looking in local data directory now..."))
        # If filename not found in Data Commons, look for it in local data directory.
        tryCatch(
          expr = {
            f <<- findLatestStateIODatainLocalDirectory(filename)
          },
          error = function(e) {
            logging::logwarn(paste(filename,
                                   "not found in local data directory, either."))
            message("Please confirm ", filename, " is correctly spelled. ",
                    "You should be able to find the correctly spelled file on ",
                    "https://edap-ord-data-commons.s3.amazonaws.com/index.html?prefix=stateio/. ",
                    "If it's not found there, please open an issue at ",
                    "https://github.com/USEPA/stateior/issues/new ",
                    "and inform package maintainers.\n",
                    "Process terminated.")
            opt <- options(show.error.messages = FALSE)
            on.exit(options(opt))
            stop()
          }
        )
      }
    )
  } else {
    # Look for file under specific version
    f <- paste0(paste(filename, ver, sep = "_"), ".rds")
  }
  # Download file from Data Commons, or load file from local folder
  if (!file.exists(file.path(rappdirs::user_data_dir(), "stateio", f))) {
    logging::loginfo(paste(f, "not found in local folder, downloading from Data Commons..."))
    checkFileonDataCommons(f)
    downloadStateIODatafromDataCommons(filename, ver = ver)
  } else {
    logging::loginfo(paste("Loading", f, "from local folder..."))
  }
  df <- readRDS(file.path(rappdirs::user_data_dir(), "stateio", f))
  return(df)
}

#' Get a datetime object for desired data file on the DataCommons server.
#' @description Get a datetime object for desired data file on the DataCommons server.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse",
#' "CommodityOutput, and "IndustryOutput".
#' @return A datetime object for desired data file on the DataCommons server.
getFileUpdateTimefromDataCommons <- function(year, iolevel, dataname) {
  datafile <- getTwoRegionDataFileName(year, iolevel, dataname)
  base_url <- "https://xri9ebky5b.execute-api.us-east-1.amazonaws.com/api/?"
  url <- paste0(base_url, "searchvalue=", datafile, "&place=&searchfields=filename")
  date_str <- jsonlite::fromJSON(url)[, "LastModified"]
  file_upload_datetime <- as.POSIXct(date_str)
  return(file_upload_datetime)
}

#' Write a datetime object for desired data file to local folder.
#' @description Get a datetime object for desired data file to local folder.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse",
#' "CommodityOutput, and "IndustryOutput".
#' @param path User-defined local path.
#' @return A datetime object for desired data file to local folder. 
writeDatafileMeta <- function(year, iolevel, dataname, path) {
  datafile <- getTwoRegionDataFileName(year, iolevel, dataname)
  file_upload_dt <- getFileUpdateTimefromDataCommons(year, iolevel, dataname)
  write(jsonlite::toJSON(file_upload_dt), paste0(path, "/", datafile, "_metadata.json"))
}

#' Load a datetime object for desired data file from local folder.
#' @description Load a datetime object for desired data file from local folder.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse",
#' "CommodityOutput, and "IndustryOutput".
#' @param path User-defined local path.
#' @return A datetime object for desired data file from local folder.
readDatafileMeta <- function(year, iolevel, dataname, path) {
  datafile <- getTwoRegionDataFileName(year, iolevel, dataname)
  if (file.exists(datafile)) {
    metadata <- jsonlite::fromJSON(paste0(path, "/", datafile, "_metadata.json"))
  } else {
    logging::logerror(paste("Local metadata file for", datafile, "is missing."))
  }
  return(metadata)
}

#' Capitalize a string.
#' @param string A string
#' @return A capitalized string.
capitalize <- function(string) {
  substr(string, 1, 1) <- toupper(substr(string, 1, 1))
  return(string)
}


#' Gets a stored or user specified model configuration file
#' @param configname str, name of the configuration file
#' @param configtype str, configuration type, can be "model"
#' @param configpaths str vector, paths (including file name) of model configuration file
#' and optional agg/disagg configuration file(s). If NULL, built-in config files are used.
#' @return A list of model specifications.
getConfiguration <- function(configname, configtype, configpaths = NULL) {
  configfile <- paste0(configname, ".yml")
  if (is.null(configpaths)) {
    configpath <- system.file(paste0("extdata/", configtype, "specs/"), configfile, package = "stateior")
  } else {
    configpath <- configpaths[endsWith(configpaths, configfile)]
  }
  if (!file.exists(configpath)) {
    stop(paste(configfile, "must be available in ", dirname(configpath)),
         call. = FALSE)
  }
  config <- configr::read.config(configpath)
  return(config)
}


##############################################################
### All functions below are archived and need modification ###
##############################################################

#' #' getCountyFIPS (MODIFIED)
#' #' 
#' #' This function is to return a dataframe containing name and fips of each county in 
#' #' selected state in support of later data wrangling operations
#' #' 
#' #' @param state A string character specifying the state of interest 'Georgia' 
#' #' @return A data frame contains all 159 names and FIPS for all counties in specified state
#' getCountyFIPS = function(state) {
#'   CountyCodes = readr::read_csv('inst/extdata/CountyFIPS.csv') %>% 
#'     dplyr::filter(State == getStateAbbreviation(state)) %>% 
#'     dplyr::select(fips, Name) %>% stats::na.omit() %>% 
#'     dplyr::arrange(Name)
#'   return(CountyCodes)
#' } 
#' 
#' 
#' 
#' #' getCrossWalk (MODIFIED)
#' #' 
#' #' This function is to return a dataframe containing the crosswalk of two different industry
#' #' classification system ('bea_sector', 'bea_summary', 'bea_detail', 'naics2007', 'naics2012', 'naics2017')
#' #' 
#' #' @param start A string character specifying the start point 
#' #' @param end A string character specifying the end point 
#' #' @return A data frame contains the croswalk table
#' getCrossWalk = function(start, end) {
#'   CW = useeior::MasterCrosswalk2012
#'   start_switch = switch (start,
#'                          'bea_sector' = 1,
#'                          'bea_summary' = 2,
#'                          'bea_detail' = 3,
#'                          'naics2012' = 4,
#'                          'naics2007' = 5,
#'                          'naics2017' = 6
#'   )
#'   end_switch = switch (end,
#'                        'bea_sector' = 1,
#'                        'bea_summary' = 2,
#'                        'bea_detail' = 3,
#'                        'naics2012' = 4,
#'                        'naics2007' = 5,
#'                        'naics2017' = 6
#'   )
#'   
#'   CW = unique(CW[, c(start_switch, end_switch)])
#'   return(CW)
#' }
#' 
#' 
#' 
#' #' calculateRowColumnDiffernce (MODIFIED)
#' #' 
#' #' This function is to return a list containing row difference and column difference of a 
#' #' matrix with NA
#' #' 
#' #' @param matrix Matrix, matrix to be processed
#' #' @param t_cs Vector, true column sum
#' #' @param t_rs Vector, true row sum
#' #' @return a list containing row difference and column difference
#' calculateRowColumnDiffernce = function(matrix, t_cs, t_rs) {
#'   matrix[is.na(matrix)] = 0
#'   row_difference = t_rs - rowSums(matrix)
#'   column_difference = t_cs - colSums(matrix)
#'   return(list(rowdiff = row_difference, coldiff = column_difference))
#' }
#' 
#' 
#' 
#' #' fillNAwithRatioMatrix (MODIFIED)
#' #' 
#' #' This function is to fill a matrix with NAs by another ratio matrix to neutralize
#' #' row difference
#' #' 
#' #' @param matrix_to_fill Matrix, matrix to be processed
#' #' @param ratio_matrix Matrix, ratio matrix
#' #' @param row_difference Vector, row difference
#' #' @return a matrix whose row sums equal trus row sum
#' fillNAwithRatioMatrix = function(matrix_to_fill, ratio_matrix, row_difference) {
#'   matrixKEY = is.na(matrix_to_fill)
#'   for (row in (1:nrow(matrix_to_fill))) {
#'     key = which(is.na(matrix_to_fill[row,]))
#'     if (length(key) != 0 && sum(ratio_matrix[row,key]) != 0) {
#'       ratio = ratio_matrix[row,key] / sum(ratio_matrix[row,key])
#'       matrix_to_fill[row,key] = ratio * row_difference[row]
#'     } else if (length(key) != 0 && sum(ratio_matrix[row,key]) == 0) {
#'       matrix_to_fill[row,key] = row_difference[row] / length(key)
#'     }
#'   }
#'   return(matrix_to_fill)
#' }
#' 
#' 
#' 
#' #' createMatrixForRASM0 (MODIFIED)
#' #' 
#' #' This function is to create a matrix that with 0 value at positions with all known value
#' #' and retains estimated value at positions with NA (M0 for RAS method)
#' #' 
#' #' @param matrix Matrix, matrix to be processed
#' #' @param matrixKEY Matrix, a boolean matrix = is.na(matrix)
#' #' @return a matrix M0 for RAS
#' createMatrixForRASM0 = function(matrixKEY, matrix) {
#'   for (row in (1:nrow(matrix))) {
#'     for (col in (1:ncol(matrix))) {
#'       if (matrixKEY[row,col] == TRUE) {
#'         matrix[row,col] = matrix[row,col]
#'       } else if (matrixKEY[row,col] == FALSE){
#'         matrix[row,col] = 0
#'       }
#'     }
#'   }
#'   return(matrix)
#' }


