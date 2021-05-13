#' Load data from useeior using flexible dataset name
#' @param dataset A string specifying name of the data to load
#' @return The data loaded from useeior
loadDatafromUSEEIOR <- function(dataset) {
  data(package = "useeior", list = dataset)
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
                          stringsAsFactors = FALSE, check.names = FALSE, fill = fill)
  return(df)
}

#' Load BEA State data (GVA and Employment) to BEA Summary mapping table
#' @param dataname A string specifying name of the BEA state data
#' @return The mapping table
loadBEAStateDatatoBEASummaryMapping <- function(dataname) {
  filename <- paste0("Crosswalk_State", dataname, "toBEASummaryIO2012Schema.csv")
  mapping <- readCSV(system.file("extdata", filename, package = "stateior"))
  return(mapping)
}

#' Calculate tolerance for RAS. Takes a target row sum vector and target colsum vector.
#' Specify either relative difference or absolute difference.
#' @param t_r A vector setting the target row sums of the matrix.
#' @param t_c A vector setting the target column sums of the matrix.
#' @param relative_diff A numeric value setting the relative difference of the two numerical vectors.
#' @param absolute_diff A numeric value setting the mean absolute difference of the two numerical vectors.
#' @return A numeric value of relative difference of t_r and t_c.
setToleranceforRAS <- function(t_r, t_c, relative_diff = NULL, absolute_diff = NULL) {
  if (!is.null(relative_diff)) {
    t <- relative_diff
  } else if (!is.null(absolute_diff)) {
    t <- absolute_diff/max(abs(t_c), abs(t_r))
  } else {
    stop("Set relative_diff or absolute_diff first.")
  }
  return(t)
}

#' Generalized RAS procedure. Takes an initial matrix, a target row sum vector
#' and target colsum vector. Iterates until all row sums of matrix equal to target row sum vector
#' and colsums of matrix equal target col sum vector, within a tolerance.
#' @param m0 A matrix object.
#' @param t_r A vector setting the target row sums of the matrix.
#' @param t_c A vector setting the target column sums of the matrix.
#' @param t A numeric value setting the tolerance of RAS.
#' @param max_itr A numeric value setting the maximum number of iterations to try for convergence.
#' Defualt: 1000000.
#' @return A RAS balanced matrix.
RAS <- function(m0, t_r, t_c, t, max_itr = 1E6) {
  m <- m0
  c_r <- as.vector(rowSums(m0))
  c_c <- as.vector(colSums(m0))
  # Check row and column conditions
  row_condition <- all.equal(t_r, c_r, tolerance = t)
  col_condition <- all.equal(t_c, c_c, tolerance = t)
  i <- 0
  while(!isTRUE(row_condition) | !isTRUE(col_condition)) {
    if(i>max_itr){
      break
    }
    # Adjust rowwise
    c_r <- as.vector(rowSums(m))
    # Replace 0 with 1 in c_r
    c_r[c_r==0] <- 1
    r_ratio <- t_r/c_r
    m <- diag(r_ratio) %*% m
    # Adjust colwise
    c_c <- as.vector(colSums(m))
    # Replace 0 with 1 in c_c
    c_c[c_c==0] <- 1
    c_ratio <- t_c/c_c
    m <- m %*% diag(c_ratio)
    # Check row and column conditions
    row_condition <- all.equal(t_r, c_r, tolerance = t)
    col_condition <- all.equal(t_c, c_c, tolerance = t)
    i <- i + 1
  }
  dimnames(m) <- dimnames(m0)
  print(paste("RAS converged after", i, "iterations."))
  return(m)
}

#' Integrate pre-adjustment of t_r, t_c and t (tolerance level) with RAS function.
#' @param m0 A matrix object.
#' @param t_r A vector setting the target row sums of the matrix.
#' @param t_c A vector setting the target column sums of the matrix.
#' @param relative_diff A numeric value setting the relative difference of the two numerical vectors.
#' @param absolute_diff A numeric value setting the mean absolute difference of the two numerical vectors.
#' @param max_itr A numeric value setting the maximum number of iterations to try for convergence.
#' Defualt: 1000000.
#' @return A RAS balanced matrix.
applyRAS <- function(m0, t_r, t_c, relative_diff, absolute_diff, max_itr) {
  # Adjust t_c/t_r, make sum(t_c)==sum(t_r)
  if (sum(t_c) > sum(t_r)) {
    t_r <- (t_r/sum(t_r))*sum(t_c)
  } else {
    t_c <- (t_c/sum(t_c))*sum(t_r)
  }
  # Generate t for RAS
  t <- setToleranceforRAS(t_r, t_c, relative_diff, absolute_diff)
  # Apply RAS
  m <- RAS(m0, t_r, t_c, t, max_itr)
  return(m)
}

#' Estimate US domestic Use table by adjusting US Use table based on Import matrix.
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param year A numeric value specifying the year of interest.
#' @return A US Domestic Use table.
estimateUSDomesticUse <- function(iolevel, year) {
  # Load Use table and Import matrix
  Use <- getNationalUse(iolevel, year)
  Import <- loadDatafromUSEEIOR(paste(iolevel, "Import", year, "BeforeRedef", sep = "_"))*1E6
  # Sort rows and columns in Import to match those in Use
  Import <- Import[rownames(Use), colnames(Use)]
  # Define Export and Import codes
  ExportCode <- getVectorOfCodes(iolevel, "Export")
  ImportCode <- getVectorOfCodes(iolevel, "Import")
  # Calculate ImportCost.
  # The imports column in the Import matrix is in foreign port value.
  # But in the Use table it is in domestic port value.
  # domestic port value = foreign port value + value of all transportation and insurance services to import + customs duties
  # See documentation of the Import matrix (https://apps.bea.gov/industry/xls/io-annual/ImportMatrices_Before_Redefinitions_SUM_1997-2019.xlsx)
  # So, ImportCost <- Use$Imports - Import$Imports
  ImportCost <- Use[, ImportCode] - Import[, ImportCode]
  # Estimate DomesticUse
  DomesticUse <- Use
  # Calculate row_sum of Use, except for Export and Import, for allocating ImportCost
  row_sum <- rowSums(Use) - (Use[, ExportCode] + Use[, ImportCode])
  # Calculate allocation ratios
  ratio <- sweep(Use, 1, FUN = "/", row_sum)
  ratio[is.na(ratio)] <- 0
  # Subtract Import from Use, then allocate ImportCost to each Industry (column), except for Export and Import
  DomesticUse <- Use - Import + sweep(ratio, 1, FUN = "*", ImportCost)
  # Adjust Export and Import columns
  DomesticUse[, ExportCode] <- Use[, ExportCode]
  DomesticUse[, ImportCode] <- 0
  return(DomesticUse)
}

#' Calculate US Domestic Use Ratio (matrix).
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains US Domestic Use Ratio (matrix) at a specific year at BEA Summary level.
calculateUSDomesticUseRatioMatrix <- function(iolevel, year) {
  # Load US Use table
  Use <- getNationalUse(iolevel, year)
  # Load US domestic Use table
  Domestic_Use <- estimateUSDomesticUse(iolevel, year)
  # Calculate state Domestic Use ratios
  Ratio <- Domestic_Use/Use[rownames(Domestic_Use), colnames(Domestic_Use)]
  Ratio[is.na(Ratio)] <- 0
  Ratio$F050 <- 0
  return(Ratio)
}

#' Calculate US International Transport Margins Ratio (matrix).
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains US International Transport Margins Ratio (matrix) at a specific year at BEA Summary level.
calculateUSInternationalTransportMarginsRatioMatrix <- function(iolevel, year) {
  # Load US Use and Import tables
  US_Use <- getNationalUse(iolevel, year)
  US_Import <- loadDatafromUSEEIOR(paste(iolevel, "Import", year, "BeforeRedef", sep = "_"))*1E6
  # Calculate US Domestic Use ratios (w/ International Transport Margins)
  DomesticUseWithIntlTransportMarginsRatio <- (US_Use - US_Import[rownames(US_Use), colnames(US_Use)])/US_Use
  DomesticUseWithIntlTransportMarginsRatio[is.na(DomesticUseWithIntlTransportMarginsRatio)] <- 0
  # Calculate InternationalTransportMargins (vector)
  InternationalTransportMargins <- US_Use[, "F050"] - US_Import[, "F050"]
  # Allocate InternationalMargins to get InternationalMarginsMatrix
  DistributionRatio <- sweep(US_Use, 1, FUN = "/", rowSums(US_Use) - (US_Use[, "F040"] + US_Use[, "F050"]))
  DistributionRatio[is.na(DistributionRatio)] <- 0
  InternationalTransportMarginsMatrix <- sweep(DistributionRatio, 1, FUN = "*", InternationalTransportMargins)
  # Calculate InternationalTransportMarginsRatio
  InternationalTransportMarginsRatio <- InternationalTransportMarginsMatrix/US_Use
  InternationalTransportMarginsRatio[is.na(InternationalTransportMarginsRatio)] <- 0
  return(InternationalTransportMarginsRatio)
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

#' Join strings with slashes
#'
#' @param ... text string
joinStringswithSlashes <- function(...) {
  items <- list(...)
  str <- sapply(items, paste, collapse = '/')
  return(str)
}


#' getStateAbbreviation (MODIFIED)
#' 
#' This function is to return the two-character abbreviation of a US state. For example, 'GA'
#' 
#' @param state A string character specifying the full name of a US state , 'Georgia'
#' @return two-character abbreviation of a US state
getStateAbbreviation = function(state) {
  stateCode = readr::read_csv('inst/extdata/StateAbbreviation.csv')
  state = stateCode[which(stateCode$State == state),]$Code
  return(state)
}



#' getCountyFIPS (MODIFIED)
#' 
#' This function is to return a dataframe containing name and fips of each county in 
#' selected state in support of later data wrangling operations
#' 
#' @param state A string character specifying the state of interest 'Georgia' 
#' @return A data frame contains all 159 names and FIPS for all counties in specified state
getCountyFIPS = function(state) {
  CountyCodes = readr::read_csv('inst/extdata/CountyFIPS.csv') %>% 
    filter(State == getStateAbbreviation(state)) %>% 
    select(fips, Name) %>% stats::na.omit() %>% 
    arrange(Name)
  return(CountyCodes)
} 



#' getCrossWalk (MODIFIED)
#' 
#' This function is to return a dataframe containing the crosswalk of two different industry
#' classification system ('bea_sector', 'bea_summary', 'bea_detail', 'naics2007', 'naics2012', 'naics2017')
#' 
#' @param start A string character specifying the start point 
#' @param end A string character specifying the end point 
#' @return A data frame contains the croswalk table
getCrossWalk = function(start, end) {
  CW = useeior::MasterCrosswalk2012
  start_switch = switch (start,
                         'bea_sector' = 1,
                         'bea_summary' = 2,
                         'bea_detail' = 3,
                         'naics2012' = 4,
                         'naics2007' = 5,
                         'naics2017' = 6
  )
  end_switch = switch (end,
                       'bea_sector' = 1,
                       'bea_summary' = 2,
                       'bea_detail' = 3,
                       'naics2012' = 4,
                       'naics2007' = 5,
                       'naics2017' = 6
  )
  
  CW = unique(CW[, c(start_switch, end_switch)])
  return(CW)
}



#' calculateRowColumnDiffernce (MODIFIED)
#' 
#' This function is to return a list containing row difference and column difference of a 
#' matrix with NA
#' 
#' @param matrix Matrix, matrix to be processed
#' @param t_cs Vector, true column sum
#' @param t_rs Vector, true row sum
#' @return a list containing row difference and column difference
calculateRowColumnDiffernce = function(matrix, t_cs, t_rs) {
  matrix[is.na(matrix)] = 0
  row_difference = t_rs - rowSums(matrix)
  column_difference = t_cs - colSums(matrix)
  return(list(rowdiff = row_difference, coldiff = column_difference))
}



#' fillNAwithRatioMatrix (MODIFIED)
#' 
#' This function is to fill a matrix with NAs by another ratio matrix to neutralize
#' row difference
#' 
#' @param matrix_to_fill Matrix, matrix to be processed
#' @param ratio_matrix Matrix, ratio matrix
#' @param row_difference Vector, row difference
#' @return a matrix whose row sums equal trus row sum
fillNAwithRatioMatrix = function(matrix_to_fill, ratio_matrix, row_difference) {
  matrixKEY = is.na(matrix_to_fill)
  for (row in (1:nrow(matrix_to_fill))) {
    key = which(is.na(matrix_to_fill[row,]))
    if (length(key) != 0 && sum(ratio_matrix[row,key]) != 0) {
      ratio = ratio_matrix[row,key] / sum(ratio_matrix[row,key])
      matrix_to_fill[row,key] = ratio * row_difference[row]
    } else if (length(key) != 0 && sum(ratio_matrix[row,key]) == 0) {
      matrix_to_fill[row,key] = row_difference[row] / length(key)
    }
  }
  return(matrix_to_fill)
}



#' createMatrixForRASM0 (MODIFIED)
#' 
#' This function is to create a matrix that with 0 value at positions with all known value
#' and retains estimated value at positions with NA (M0 for RAS method)
#' 
#' @param matrix Matrix, matrix to be processed
#' @param matrixKEY Matrix, a boolean matrix = is.na(matrix)
#' @return a matrix M0 for RAS
createMatrixForRASM0 = function(matrixKEY, matrix) {
  for (row in (1:nrow(matrix))) {
    for (col in (1:ncol(matrix))) {
      if (matrixKEY[row,col] == TRUE) {
        matrix[row,col] = matrix[row,col]
      } else if (matrixKEY[row,col] == FALSE){
        matrix[row,col] = 0
      }
    }
  }
  return(matrix)
}


#' Generate two-region data filename with .rda as suffix.
#' @description Generate two-region data filename with .rda as suffix.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse", "CommodityOutput, and "IndustryOutput".
#' @return A string of two-region data filename with .rda as suffix.
getTwoRegionDataFileName <- function(year, iolevel, dataname) {
  filename <- paste("TwoRegion", iolevel, dataname, year, sep = "_")
  return(filename)
}

#' Get a datetime object for desired data file on the DataCommons server.
#' @description Get a datetime object for desired data file on the DataCommons server.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse", "CommodityOutput, and "IndustryOutput".
#' @return A datetime object for desired data file on the DataCommons server.
getFileUpdateTimefromDataCommons <- function(year, iolevel, dataname) {
  datafile <- getTwoRegionDataFileName(year, iolevel, dataname)
  base_url <- "https://xri9ebky5b.execute-api.us-east-1.amazonaws.com/api/?"
  url <- paste0(base_url, "searchvalue=", datafile, "&place=&searchfields=filename")
  date_str <- jsonlite::fromJSON(url)[, "LastModified"]
  file_upload_datetime <- as.POSIXct(date_str)
  return(file_upload_datetime)
}


#' Get a datetime object for desired data file from local folder.
#' @description Get a datetime object for desired data file from local folder.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse", "CommodityOutput, and "IndustryOutput".
#' @param path User-defined local path.
#' @return A datetime object for desired data file from local folder.
getFileUpdateTimefromLocal <- function(year, iolevel, dataname, path) {
  datafile <- getTwoRegionDataFileName(year, iolevel, dataname)
  meta <- read_datafile_meta(datafile, path)
  file_upload_datetime <- dt.datetime.strptime(meta["LastUpdated"], '%Y-%m-%d %H:%M:%S%z')
  return(file_upload_datetime)
}

#' Write a datetime object for desired data file to local folder.
#' @description Get a datetime object for desired data file to local folder.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse", "CommodityOutput, and "IndustryOutput".
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
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse", "CommodityOutput, and "IndustryOutput".
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
