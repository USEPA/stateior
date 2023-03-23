#' Validate result based on specified tolerance
#' @param result A data object to be validated
#' @param abs_diff A logical value indicating whether to validate absolute values
#' @param tolerance A numeric value setting tolerance of the comparison
#' @return A list contains confrontation details and validation results
validateResult <- function(result, abs_diff = TRUE, tolerance) {
  result[is.na(result)] <- 0
  # Validate result
  if (abs_diff) {
    validation <- as.data.frame(abs(result) < tolerance)
  } else {
    validation <- as.data.frame(result < tolerance)
  }
  if (!is.null(rownames(result))) {
    validation$rownames <- rownames(result)
  } else if (!is.null(names(result))) {
    validation$rownames <- names(result)
  } else {
    validation$rownames <- rownames(validation)
  }
  if (ncol(validation) <= 3) {
    if (class(result) == "data.frame") {
      result <- result[, 1]
    }
    validation$result <- round(result, abs(log10(tolerance)))
    validation <- reshape2::melt(validation,
                                 id.vars = c("rownames", "result"),
                                 variable.name = "check")
  } else {
    validation_self <- validation
    validation_result <- round(result, abs(log10(tolerance)))
    validation_result$rownames <- rownames(validation_result)
    validation_self <- reshape2::melt(validation_self,
                                      id.vars = "rownames")
    validation_self$variable <- as.character(validation_self$variable)
    validation_result <- reshape2::melt(validation_result,
                                        id.vars = "rownames",
                                        value.name = "result")
    validation_result$variable <- as.character(validation_result$variable)
    validation <- merge(validation_self, validation_result,
                        by = c("rownames", "variable"))
    validation$check <- "abs(result) < tolerance"
  }
  return(validation)
}

#' Extract validation passes or failures
#' @param validation A data.frame contains validation details
#' @param failure A logical value indicating whether to report failure or not
#' @return A data.frame contains validation results
extractValidationResult <- function(validation, failure = TRUE) {
  if (failure) {
    val_result <- validation[validation$value == FALSE,
                             setdiff(colnames(validation), "value")]
  } else {
    val_result <- validation[validation$value == TRUE,
                             setdiff(colnames(validation), "value")]
  }
  val_result$check <- as.character(val_result$check)
  return(val_result)
}

#' Format validation result
#' @param result Validation result to be formatted
#' @param abs_diff A logical value indicating whether to validate absolute values
#' @param tolerance A numeric value setting tolerance of the comparison
#' @return A list contains formatted validation results
formatValidationResult <- function(result, abs_diff = TRUE, tolerance) {
  # Validate result
  validation <- validateResult(result, abs_diff, tolerance)
  # Extract passes and failures
  passes <- extractValidationResult(validation, failure = FALSE)
  failures <- extractValidationResult(validation, failure = TRUE)
  N_passes <- nrow(passes)
  N_failures <- nrow(failures)
  return(list("Result" = as.data.frame(result),
              "Pass" = passes, "N_Pass" = N_passes,
              "Failure" = failures, "N_Failure" = N_failures))
}

#' Check order of names (n1 and n2). Stop function execution if n1 != n2.
#' @param n1 Name vector #1
#' @param n2 Name vector #2
#' @param note Note about n1 and n2
checkNamesandOrdering <- function(n1, n2, note) {
  if (!identical(n1, n2)) {
    stop(paste(note, "not the same or not in the same order."))
  }
}

#' Report failures from validation in printed messages
#' @param failures A data frame or a vector of failures
reportValidationResult <- function(failures) {
  if (any(nrow(failures) == 0, length(failures) == 0)) {
    cat("There are no failures.\n\n")
  } else {
    cat("There are", nrow(failures), "failures, and they are")
    knitr::kable(failures, "simple")
  }
}

#' Validate state Use against US Use, cell-by-cell
#' @param domestic A logical value indicating whether to compare Domestic Use or not
#' @param rel_diff A logical value indicating whether to validate relative difference or not
#' @return A data.frame or vector contains failures
validateStateUseAgainstNationlUse <- function(domestic = FALSE, rel_diff = FALSE) {
  if (domestic) {
    Use_ls <- State_Summary_DomesticUse_ls
    df0 <- US_Summary_DomesticUse
  } else {
    Use_ls <- State_Summary_Use_ls
    df0 <- US_Summary_Use
  }
  df1 <- Reduce("+", Use_ls)
  rownames(df1) <- gsub(".*\\.", "", rownames(df1))
  df1 <- df1[rownames(df0), colnames(df0)]
  # Compare aggregated state Use table against US Use table
  if (rel_diff) {
    failures <- formatValidationResult((df1 - df0)/df0, abs_diff = TRUE, tolerance = 1E-3)[["Failure"]]
    rownames(failures) <- NULL
    colnames(failures) <- c("Commodity", "Industry/Final Demand", "Relative Diff", "Validation")
    # Provide values in df0 and df1 for failures
    if (nrow(failures) > 0) {
      failures[, c("US", "StateSum")] <- 0
      for (i in 1:nrow(failures)) {
        row <- failures[i, "Commodity"]
        col <- failures[i, "Industry/Final Demand"]
        failures[i, "US"] <- df0[row, col]
        failures[i, "StateSum"] <- df1[row, col]
      }
    }
  } else {
    failures <- formatValidationResult(df1 - df0, abs_diff = TRUE, tolerance = 5E6)[["Failure"]]
    rownames(failures) <- NULL
    colnames(failures) <- c("Commodity", "Industry/Final Demand", "Absolute Diff", "Validation")
    # Compare failures to US values
    if (nrow(failures) > 0) {
      failures[, "AbsDiffPortioninNationalTotals"] <- 0
      for (i in 1:nrow(failures)) {
        row <- failures[i, "Commodity"]
        col <- failures[i, "Industry/Final Demand"]
        failures[i, "AbsDiffPortioninNationalTotals"] <- failures[i, "Absolute Diff"]/df0[row, col]
      }
    }
  }
  
  return(failures)
}

#' Validate Leontief matrix (L) of two-region model and final demand against
#' SoI and RoUS output.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A list of validation components and result.
validateTwoRegionLagainstOutput <- function(state, year, ioschema, iolevel) {
  startLogging()
  # Define industries and commodities
  industries <- getVectorOfCodes(iolevel, "Industry")
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  ita_column <- ifelse(iolevel == "Detail", "F05100", "F051")
  # Define state abbreviation
  state_abb <- state.abb[which(state.name == state)]
  logging::loginfo("Generating A matrix of SoI Make table ...")
  # SoI Make
  TwoRegionMake <- TwoRegionMake_ls[[state]]
  SoI_Make <- TwoRegionMake[endsWith(rownames(TwoRegionMake), state_abb),
                            endsWith(colnames(TwoRegionMake), state_abb)]
  # SoI commodity output
  # SoI_Commodity_Output <- State_Summary_CommodityOutput_ls[[state]]
  TwoRegionCommodityOutput <- TwoRegionCommodityOutput_ls[[state]]
  SoI_Commodity_Output <- TwoRegionCommodityOutput[endsWith(names(TwoRegionCommodityOutput),
                                                            state_abb)]
  # SoI A matrix
  SoI_A <- useeior:::normalizeIOTransactions(SoI_Make, SoI_Commodity_Output)
  # Check column sums of SoI_A
  if (all(abs(colSums(SoI_A) - 1) < 1E-3)) {
    logging::loginfo("FACT CHECK: column sums of A matrix of SoI Make table == 1.")
  } else {
    logging::logwarn("Column sums of A matrix of SoI Make table != 1")
  }
  
  logging::loginfo("Generating A matrix of RoUS Make table ...")
  # RoUS Make
  RoUS_Make <- TwoRegionMake[endsWith(rownames(TwoRegionMake), "RoUS"),
                             endsWith(colnames(TwoRegionMake), "RoUS")]
  # RoUS commodity output
  RoUS_Commodity_Output <- TwoRegionCommodityOutput[endsWith(names(TwoRegionCommodityOutput),
                                                             "RoUS")]
  
  # RoUS A matrix
  RoUS_A <- useeior:::normalizeIOTransactions(RoUS_Make, RoUS_Commodity_Output)
  # Check column sums of RoUS_A
  if (all(abs(colSums(RoUS_A) - 1) < 1E-3)) {
    logging::loginfo("FACT CHECK: column sums of A matrix of RoUS Make table == 1.")
  } else {
    logging::logerror("Column sums of A matrix of RoUS Make table != 1")
  }
  
  # Two-region A matrix
  #                       Commodity                Commodity                  Industry                     Industry
  #                          SoI                     RoUS                        SoI                         RoUS
  #               +-----------------------+-------------------------+---------------------------+----------------------------+
  # Commodity SoI |           0           |            0            |norm(SoI2SoI_Use,  SoI_TIO)|norm(SoI2RoUS_Use, RoUS_TIO)|
  #               +-----------------------+-------------------------+---------------------------+----------------------------+
  # Commodity RoUS|           0           |            0            |norm(RoUS2SoI_Use, SoI_TIO)|norm(RoUS2RoUS_Use,RoUS_TIO)|
  #               +-----------------------+-------------------------+---------------------------+----------------------------+
  # Industry  SoI |norm(SoI_Make, SoI_TCO)|            0            |             0             |             0              |
  #               +-----------------------+-------------------------+---------------------------+----------------------------+
  # Industry  RoUS|           0           |norm(RoUS_Make, RoUS_TCO)|             0             |             0              |
  #               +-----------------------+-------------------------+---------------------------+----------------------------+
  #                           Total column sum must equal 1                 Total column sum can but shouldn't equal 1
  
  logging::loginfo("Generating two-region Domestic Use tables ...")
  ls <- TwoRegionDomesticUsewithTrade_ls[[state]]
  TwoRegionIndustryOutput <- TwoRegionIndustryOutput_ls[[state]]
  SoI_Industry_Output <- TwoRegionIndustryOutput[endsWith(names(TwoRegionIndustryOutput),
                                                          state_abb)]
  RoUS_Industry_Output <- TwoRegionIndustryOutput[endsWith(names(TwoRegionIndustryOutput),
                                                           "RoUS")]
  # If industry/comm output == 0, it's not viable to generate A matrix, hence set it to 1.
  SoI_Industry_Output[SoI_Industry_Output == 0] <- 1
  
  logging::loginfo("Generating A matrix of SoI2SoI Domestic Use table ...")
  SoI2SoI_A <- useeior:::normalizeIOTransactions(ls[["SoI2SoI"]][, industries],
                                                 SoI_Industry_Output)
  
  logging::loginfo("Generating A matrix of RoUS2SoI Domestic Use table ...")
  RoUS2SoI_A <- useeior:::normalizeIOTransactions(ls[["RoUS2SoI"]][, industries],
                                                  SoI_Industry_Output)
  
  logging::loginfo("Generating A matrix of SoI2RoUS Domestic Use table ...")
  SoI2RoUS_A <- useeior:::normalizeIOTransactions(ls[["SoI2RoUS"]][, industries],
                                                  RoUS_Industry_Output)
  
  logging::loginfo("Generating A matrix of RoUS2RoUS Domestic Use table ...")
  RoUS2RoUS_A <- useeior:::normalizeIOTransactions(ls[["RoUS2RoUS"]][, industries],
                                                   RoUS_Industry_Output)
  
  logging::loginfo("Assembling the complete A matrix ...")
  # Assemble A matrix
  A_top <- cbind(diag(rep(0, length(commodities)*2)),
                 cbind(rbind(SoI2SoI_A, RoUS2SoI_A),
                       rbind(SoI2RoUS_A, RoUS2RoUS_A)))
  colnames(A_top) <- c(1:ncol(A_top))
  A_btm <- cbind(as.matrix(Matrix::bdiag(list(as.matrix(SoI_A),
                                              as.matrix(RoUS_A)))),
                 diag(rep(0, length(industries)*2)))
  A <- as.matrix(rbind(A_top, setNames(A_btm, colnames(A_top))))
  rownames(A) <- paste(c(rep(c(state, "RoUS"), each = length(commodities)),
                         rep(c(state, "RoUS"), each = length(industries))),
                       c(rep(commodities, 2), rep(industries, 2)),
                       c(rep("Commodity", length(commodities)*2),
                         rep("Industry", length(industries)*2)),
                       sep = ".")
  colnames(A) <- rownames(A)
  
  logging::loginfo("Generating the L matrix ...")
  # Calculate L matrix
  I <- diag(nrow(A))
  L <- solve(I - A, tol = 1E-20)
  
  logging::loginfo("Calculating y (Final Demand totals) of SoI and RoUS ...")
  # Calculate Final Demand (y)
  FD_columns  <- getFinalDemandCodes("Summary")
  ita_column <- ifelse(iolevel == "Detail", "F05100", "F051")
  SoI2SoI_y   <- rowSums(ls[["SoI2SoI"]][, c(FD_columns, ita_column, "ExportResidual")])
  SoI2RoUS_y  <- rowSums(ls[["SoI2RoUS"]][, c(FD_columns, ita_column)])
  RoUS2SoI_y  <- rowSums(ls[["RoUS2SoI"]][, c(FD_columns, ita_column)])
  RoUS2RoUS_y <- rowSums(ls[["RoUS2RoUS"]][, c(FD_columns, ita_column, "ExportResidual")])
  y <- c(SoI2SoI_y + SoI2RoUS_y, RoUS2SoI_y + RoUS2RoUS_y, rep(0, length(industries)*2))
  names(y) <- rownames(L)
  
  logging::loginfo("Validating L*y == commodity and industry output ...")
  # Validate L * y == Output
  # Output = c(SoI_TCO, RoUS_TCO, SoI_TIO, RoUS_TIO)
  output <- c(SoI_Commodity_Output, RoUS_Commodity_Output,
              SoI_Industry_Output, RoUS_Industry_Output)
  validation <- as.data.frame(L %*% y - output)
  colnames(validation) <- "L*y-output"
  
  validation$rel_diff <- validation$`L*y-output`/output
  validation$Ly <- as.numeric(L %*% y)
  validation$output <- output
  validation[validation$output == 1, "rel_diff"] <- 0
  
  logging::loginfo("Validation complete.")
  return(list(A = A, L = L, y = y, Validation = validation))
}
