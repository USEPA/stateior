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

#' Calculate regional purchase coefficient for specified state and year
#' @param SoI2SoIUse A data.frame of SoI2SoIUse table.
#' @param RoUS2SoIUse A data.frame of RoUS2SoIUse table.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame contains by-commodity RPC and overall RPC
calculateRegionalPurchaseCoefficient <- function(SoI2SoIUse, RoUS2SoIUse, iolevel) {
  import_export_cols <- unlist(sapply(list("Export", "Import"),
                                      getVectorOfCodes, iolevel = iolevel))
  LocallyProducedConsumption <- rowSums(SoI2SoIUse) - rowSums(SoI2SoIUse[, import_export_cols])
  ImportedConsumption <- rowSums(RoUS2SoIUse) - rowSums(RoUS2SoIUse[, import_export_cols])
  TotalConsumption <- LocallyProducedConsumption + ImportedConsumption
  rpc <- cbind.data.frame(LocallyProducedConsumption/TotalConsumption,
                          sum(LocallyProducedConsumption)/sum(TotalConsumption))
  colnames(rpc) <- c("RPC", "OverallRPC")
  rpc[is.na(rpc)] <- 1
  return(rpc)
}

