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
    validation$check <- ifelse(abs_diff,
                               "abs(result) < tolerance",
                               "result < tolerance")
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
