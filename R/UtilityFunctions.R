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

#' Adjust US Use table by Import matrix.
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param year A numeric value specifying the year of interest.
#' @return A adjusted US Use table.
adjustUseTablebyImportMatrix <- function(iolevel, year) {
  # Load Use table and Import matrix
  Use <- get(paste(iolevel, "Use", year, "PRO_BeforeRedef", sep = "_"))*1E6
  Import <- get(paste(iolevel, "Import", year, "BeforeRedef", sep = "_"))*1E6
  # Load BEA schema_info based on model BEA
  SchemaInfo <- utils::read.table(system.file("extdata",
                                              paste0("2012_", iolevel, "_Schema_Info.csv"),
                                              package = "useeior"),
                                  sep = ",", header = TRUE,
                                  stringsAsFactors = FALSE, check.names = FALSE)
  # Specify rows and columns to use
  getVectorOfCodes <- function(colName) {
    return(as.vector(stats::na.omit(SchemaInfo[, c("Code", colName)])[, "Code"]))
  }
  Commodities <- getVectorOfCodes("Commodity")
  Industries <- getVectorOfCodes("Industry")
  FinalDemand_columns <- c(getVectorOfCodes("HouseholdDemand"),
                           getVectorOfCodes("InvestmentDemand"),
                           getVectorOfCodes("ChangeInventories"),
                           getVectorOfCodes("Export"),
                           getVectorOfCodes("Import"),
                           getVectorOfCodes("GovernmentDemand"))
  ExportCodes <- getVectorOfCodes("Export")
  ImportCodes <- getVectorOfCodes("Import")
  # Subset Use
  Use <- Use[Commodities, c(Industries, FinalDemand_columns)]
  # Sort rows and columns in Import to match those in Use
  Import <- Import[rownames(Use), colnames(Use)]
  # Calculate F050A
  F050A <- Use[, ImportCodes] - Import[, ImportCodes]
  # Allocate F050A to each Industry (column) in Use table, except for Export and Import
  Use_adjusted <- Use
  for (i in 1:nrow(Use)) {
    row_sum <- rowSums(Use[i, ]) - (Use[i, ExportCodes] + Use[i, ImportCodes])
    Use_adjusted[i, ] <- Use[i, ] + F050A[i] * (Use[i, ]/row_sum)
  }
  # Adjust Export and Import columns
  Use_adjusted[, ExportCodes] <- Use[, ExportCodes]
  Use_adjusted[, ImportCodes] <- 0
  return(Use_adjusted)
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
    select(fips, Name) %>% na.omit() %>% 
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


