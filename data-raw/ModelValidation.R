### State Supply Model
# Define year
year <- 2012
# Load US Make and Use
US_Summary_Make <- getNationalMake("Summary", year)
US_Summary_Use <- getNationalUse("Summary", year)
US_Summary_DomesticUse <- estimateUSDomesticUse("Summary", year)
# Load state Make, industry and commodity output
load(paste0("data/State_Summary_Make_", year, ".rda"))
load(paste0("data/State_Summary_IndustryOutput_", year, ".rda"))
load(paste0("data/State_Summary_CommodityOutput_", year, ".rda"))
states <- names(State_Summary_Make_list)
# Load state total Use and domestic Use
load(paste0("data/State_Summary_Use_", year, ".rda"))
load(paste0("data/State_Summary_DomesticUse_", year, ".rda"))

# Validate df1 against df0 based on specified conditions
compareModelResult <- function(df0, df1, abs_diff = TRUE, tolerance) {
  # Define comparison rule
  if (abs_diff) {
    rule <- validate::validator(abs(df1 - df0) <= tolerance)
  } else {
    rule <- validate::validator(df1 - df0 <= tolerance)
  }
  # Compare df1 against df0
  confrontation <- validate::confront(df1, rule, ref = list(df0 = df0))
  confrontation <- validate::as.data.frame(confrontation)
  validation <- merge(confrontation, validate::as.data.frame(rule))
  rownames(validation) <- confrontation$rownames <- rownames(confrontation)
  validation$name <- NULL
  return(list("confrontation" = confrontation, "validation" = validation))
}

# Extract validation passes or failures
extractValidationResult <- function(confrontation, failure = TRUE) {
  df <- reshape2::melt(confrontation, id.vars = c("rownames", "name", "expression"))
  if (failure) {
    result <- df[df$value==FALSE, c("rownames", "variable")]
  } else {
    result <- df[df$value==TRUE, c("rownames", "variable")]
  }
  result <- as.data.frame(lapply(result, function(x) gsub("value.", "", x)))
  result[] <- sapply(result, as.character)
  return(result)
}

#' 1. Sum of each cell across all state Make tables must almost equal
#' (tolerance is 1E-3) the same cell in US Make table.
df0 <- US_Summary_Make
df1 <- Reduce("+", State_Summary_Make_list)
rownames(df1) <- gsub(".*\\.", "", rownames(df1))
# Compare aggregated state Make against US Make
comparison <- compareModelResult(df0, df1, abs_diff = TRUE, tolerance = 1E-3)
# Extract failures
failures <- extractValidationResult(comparison$confrontation, failure = TRUE)
colnames(failures) <- c("Industry", "Commodity")

#' 2. There should not be any negative values in state Make table.
#' Only exception being Overseas, which isn’t used for further calculations).
# Validate Make table and extract failures for each state
failure_list <- list()
for (state in states) {
  df <- as.data.frame(State_Summary_Make_list[[state]])
  # Check if there is zero in state Make table
  comparison <- compareModelResult(0, df, abs_diff = FALSE, tolerance = 0)
  # Extract failures
  failures <- extractValidationResult(confrontation, failure = TRUE)
  colnames(failures) <- c("Industry", "Commodity")
  failure_list[[state]] <- failures
}

#' 3. Sum of each industry’s output across all states must almost equal
#' (tolerance is 1E-3) industry output in US Make Table.
df0 <- rowSums(US_Summary_Make)
df1 <- Reduce("+", State_Summary_IndustryOutput_list)
rownames(df1) <- gsub(".*\\.", "", rownames(df1))
# Compare aggregated state industry output against US industry output
comparison <- compareModelResult(df0, df1, abs_diff = TRUE, tolerance = 1E-3)
# Extract failures
failures <- extractValidationResult(comparison$confrontation, failure = TRUE)
colnames(failures) <- c("Industry", "Commodity")

#' 4. Sum of each commodity’s output across all states must almost equal
#' (tolerance is 1E-3) commodity output in US Make Table.
df0 <- colSums(US_Summary_Make)
df1 <- Reduce("+", State_Summary_CommodityOutput_list)
rownames(df1) <- gsub(".*\\.", "", rownames(df1))
# Compare aggregated state commodity output against US commodity output
comparison <- compareModelResult(df0, df1, abs_diff = TRUE, tolerance = 1E-3)
# Extract failures
failures <- extractValidationResult(comparison$confrontation, failure = TRUE)
colnames(failures) <- c("Industry", "Commodity")

#' 5. Sum of each commodity’s output across all states must almost equal
#' (tolerance is 1E7, or $10 million by commodity) commodity output
#' in US Use Table minus International Imports (commodity specific).
#' Even if the threshold is met, track the difference for each commodity
#' Save result as a type of quality control check.
df0 <- rowSums(US_Summary_DomesticUse)
df1 <- Reduce("+", State_Summary_CommodityOutput_list)
rownames(df1) <- gsub(".*\\.", "", rownames(df1))
# Compare aggregated state commodity output against row sum of US domestic Use
comparison <- compareModelResult(df0, df1, abs_diff = TRUE, tolerance = 1E7)
# Calcualte difference between df0 and df1
Difference <- df1 - df0
colnames(Difference) <- "df1-df0"
comparison$validation <- merge(comparison$validation, Difference, by = 0)
# Extract failures
failures <- extractValidationResult(comparison$confrontation, failure = TRUE)

#' 6. All cells that are zero in US Make table must remain zero in state Make tables.
rule <- validate::validator(US_Summary_Make == 0)
confrontation <- validate::confront(US_Summary_Make, rule)
baseline <- extractValidationResult(confrontation, failure = FALSE)
# Validate the position of zero values in state Make tables
failure_list <- list()
for (state in states) {
  rule <- validate::validator(State_Summary_Make_list[[state]] == 0)
  confrontation <- validate::confront(State_Summary_Make_list[[state]], rule)
  passes <- extractValidationResult(confrontation, failure = FALSE)
  failures <- setdiff(paste(baseline$rownames, baseline$variable),
                      paste(passes$rownames, passes$variable))
  failures <- do.call(rbind.data.frame, strsplit(failures, " "))
  if (nrow(failures) > 0) {
    colnames(failures) <- c("Industry", "Commodity")
  }
  failure_list[[state]] <- failures
}

#' 7. Sum of each cell across all state Use tables must almost equal
#' (tolerance is 1E-2) the same cell in US Use table.
#' This validates that Total state demand == Total national demand.
# Create a function to implement the validation
validateStateUseAgainstNationlUse <- function(domestic = FALSE) {
  if (domestic) {
    Use_list <- State_Summary_DomesticUse_list
    df0 <- US_Summary_DomesticUse
  } else {
    Use_list <- State_Summary_Use_list
    df0 <- US_Summary_Use
  }
  df1 <- Reduce("+", Use_list)
  rownames(df1) <- gsub(".*\\.", "", rownames(df1))
  # Compare aggregated state Make against US Make
  comparison <- compareModelResult(df0, df1, abs_diff = TRUE, tolerance = 1E-2)
  # Extract failures
  failures <- extractValidationResult(comparison$confrontation, failure = TRUE)
  colnames(failures) <- c("Commodity", "Industry")
  return(list(Validation = comparison$validation, Failures = failures))
}
StateUseValidation <- validateStateUseAgainstNationlUse(domestic = FALSE)
StateDomesticUseValidation <- validateStateUseAgainstNationlUse(domestic = TRUE)

#' 8. If SoI commodity == 0, SoI2SoI ICF ratio == 0
failure_list <- list()
for (state in states) {
  # Prepare SoI_CommodityOutputRatio
  SoI_CommodityOutput <- State_Summary_CommodityOutput_list[[state]]
  US_CommodityOutput <- Reduce("+", State_Summary_CommodityOutput_list)
  SoI_CommodityOutputRatio <- SoI_CommodityOutput/US_CommodityOutput
  rule <- validate::validator(SoI_CommodityOutputRatio == 0)
  confrontation <- validate::confront(SoI_CommodityOutputRatio, rule)
  baseline <- extractValidationResult(confrontation, failure = FALSE)
  # Prepare ICF
  ICF <- generateDomestic2RegionICFs(state, year, remove_scrap = FALSE,
                                     ioschema = 2012, iolevel = "Summary")
  df <- ICF[, "SoI2SoI", drop = FALSE]
  rule <- validate::validator(df == 0)
  confrontation <- validate::confront(d1, rule)
  passes <- extractValidationResult(confrontation, failure = FALSE)
  failures <- setdiff(paste(baseline$rownames, baseline$variable),
                      paste(passes$rownames, passes$variable))
  failures <- do.call(rbind.data.frame, strsplit(failures, " "))
  if (nrow(failures) > 0) {
    colnames(failures) <- "Commodity"
  }
  failure_list[[state]] <- failures
}

#' 9. SoI and RoUS interregional exports >= 0, interregional imports >= 0
failure_list <- list()
for (state in states) {
  # Prepare domestic 2-region Use tables
  ls <- generateTwoRegionDomesticUse(state, year = 2012, ioschema = 2012, "Summary")
  df <- cbind(ls[["SoI2SoI"]][, c("InterregionalImports", "InterregionalExports")],
              ls[["RoUS2RoUS"]][, c("InterregionalImports", "InterregionalExports")])
  df <- as.data.frame(sapply(df, round, 1))
  colnames(df) <- paste(rep(c("SoI2SoI", "RoUS2RoUS"), each = 2),
                        colnames(df), sep = "$")
  # Compare aggregated state Make against US Make
  comparison <- compareModelResult(0, df, abs_diff = TRUE, tolerance = 0)
  # Extract failures
  failures <- extractValidationResult(confrontation, failure = TRUE)
  failure_list[[state]] <- failures
}

#' 10. SoI net exports + RoUS net exports == 0
failure_list <- list()
for (state in states) {
  # Prepare domestic 2-region Use tables
  ls <- generateTwoRegionDomesticUse(state, year = 2012, ioschema = 2012, "Summary")
  df <- ls[["SoI2SoI"]][, "NetExports", drop = FALSE] + ls[["RoUS2RoUS"]][, "NetExports", drop = FALSE]
  df <- as.data.frame(sapply(df, round, 1))
  rule <- validate::validator(df == 0)
  confrontation <- validate::confront(df, rule)
  validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rule))
  rownames(validation) <- rownames(validate::as.data.frame(confrontation))
  failures <- extractValidationResult(confrontation, failure = TRUE)
  failure_list[[state]] <- failures
}

#' 11. Check row sum of SoI2SoI <= state commodity supply, or diff <= 1E-3
#' Row sum of RoUS2RoUS <= national commodity supply, or diff <= 1E-3
failure_list <- list()
for (state in states) {
  # Prepare domestic 2-region Use tables
  ls <- generateTwoRegionDomesticUse(state, year = 2012, ioschema = 2012, "Summary")
  columns <- c(getVectorOfCodes("Summary", "Industry"), getFinalDemandCodes("Summary"))
  df <- cbind.data.frame(rowSums(ls[["SoI2SoI"]][, columns]),
                         rowSums(ls[["RoUS2RoUS"]][, columns]))
  colnames(df) <- c("SoI", "RoUS")
  rule <- validate::validator(SoI - State_Summary_CommodityOutput_list[[state]][, "Output"] <= 1E-3,
                               RoUS - colSums(US_Summary_Make) <= 1E-3)
  confrontation <- validate::confront(df, rule)
  validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rule))
  rownames(validation) <- c(rownames(df), gsub(paste0(state, "."), "RoUS.", rownames(df)))
  # Calcualte difference between checked objects
  Difference <- as.data.frame(c(df$SoI - State_Summary_CommodityOutput_list[[state]][, "Output"],
                                df$RoUS - colSums(US_Summary_Make)))
  colnames(Difference) <- "Difference"
  validation <- cbind(validation, Difference)
  # Extract failures
  failures <- extractValidationResult(confrontation, failure = TRUE)
  # Add difference to failures
  rows <- cbind.data.frame(rownames(validate::as.data.frame(confrontation)),
                           rownames(validation))
  rows[] <- sapply(rows, as.character)
  failures[failures$rownames%in%rows[, 1], "rownames"] <- rows[rows[, 1]%in%failures$rownames, 2]
  failures[, "Difference"] <- validation[failures$rownames, "Difference"]
  failure_list[[state]] <- failures
}

#' 12. Value in SoI2SoI and RoUS2RoUS can be negative only when the same cell is negative in national Use table
rule <- validate::validator(US_Summary_DomesticUse < 0)
confrontation <- validate::confront(US_Summary_DomesticUse, rule)
baseline <- extractValidationResult(confrontation, failure = FALSE)
# Validate the position of zero values in state Make tables
failure_list <- list()
for (state in states) {
  # Prepare domestic 2-region Use tables
  ls <- generateTwoRegionDomesticUse(state, year = 2012, ioschema = 2012, "Summary")
  columns <- c(getVectorOfCodes("Summary", "Industry"), getFinalDemandCodes("Summary"))
  # SoI
  df_SoI <- ls[["SoI2SoI"]][, columns]
  rownames(df_SoI) <- gsub(".*\\.", "", rownames(df_SoI))
  rule_SoI <- validate::validator(df_SoI < 0)
  confrontation_SoI <- validate::confront(df_SoI, rule_SoI)
  passes_SoI <- extractValidationResult(confrontation_SoI, failure = FALSE)
  failures_SoI <- setdiff(paste(baseline$rownames, baseline$variable),
                          paste(passes_SoI$rownames, passes_SoI$variable))
  failures_SoI <- do.call(rbind.data.frame, strsplit(failures_SoI, " "))
  if (nrow(failures_SoI) > 0) {
    colnames(failures_SoI) <- c("Commodity", "Industry")
  }
  failure_list[[state]] <- failures_SoI
  # RoUS
  df_RoUS <- ls[["RoUS2RoUS"]][, columns]
  rownames(df_RoUS) <- gsub(".*\\.", "", rownames(df_RoUS))
  rule_RoUS <- validate::validator(df_RoUS < 0)
  confrontation_RoUS <- validate::confront(df_RoUS, rule_RoUS)
  passes_RoUS <- extractValidationResult(confrontation_RoUS, failure = FALSE)
  failures_RoUS <- setdiff(paste(baseline$rownames, baseline$variable),
                           paste(passes_RoUS$rownames, passes_RoUS$variable))
  failures_RoUS <- do.call(rbind.data.frame, strsplit(failures_RoUS, " "))
  if (nrow(failures_RoUS) > 0) {
    colnames(failures_RoUS) <- c("Commodity", "Industry")
  }
  failure_list[[paste("RoUS of", state)]] <- failures_RoUS
}

#' 13. SoI interregional imports == RoUS interregional exports, or difference <= 1E-3
failure_list <- list()
for (state in states) {
  # Prepare domestic 2-region Use tables
  ls <- generateTwoRegionDomesticUse(state, year = 2012, ioschema = 2012, "Summary")
  df0 <- ls[["SoI2SoI"]][, "InterregionalImports", drop = FALSE]
  df1 <- ls[["RoUS2RoUS"]][, "InterregionalExports", drop = FALSE]
  rule <- validate::validator(abs(df1-df0) <= 1E-3)
  confrontation <- validate::confront(df1, rule, ref = list(df0 = df0))
  validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rule))
  rownames(validation) <- rownames(validate::as.data.frame(confrontation))
  # Calcualte difference between checked objects
  Difference <- df0 - df1
  colnames(Difference) <- "df0-df1"
  validation <- cbind(validation, Difference)
  # Extract failures
  failures <- extractValidationResult(confrontation, failure = TRUE)
  # Add difference to failures
  failures[, "df0-df1"] <- validation[failures$rownames, "df0-df1"]
  failure_list[[state]] <- failures
}

#' 14. Total state commodity supply == state demand by intermediate consumption,
#' plus final demand (except imports) + Interregional Exports
failure_list <- list()
for (state in states) {
  # Prepare domestic 2-region Use tables
  ls <- generateTwoRegionDomesticUse(state, year = 2012, ioschema = 2012, "Summary")
  columns <- c(getVectorOfCodes("Summary", "Industry"),
               setdiff(getFinalDemandCodes("Summary"),
                       getVectorOfCodes("Summary", "Import")),
               "InterregionalExports")
  df0 <- State_Summary_CommodityOutput_list[[state]][, "Output"]
  df1 <- as.data.frame(rowSums(ls[["SoI2SoI"]][, columns]))
  rule <- validate::validator(abs(df1 - df0) <= 1E-3)
  confrontation <- validate::confront(df1, rule, ref = list(df0 = df0))
  validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rule))
  rownames(validation) <- rownames(validate::as.data.frame(confrontation))
  # Calcualte difference between checked objects
  Difference <- df0 - df1
  colnames(Difference) <- "df0-df1"
  validation <- cbind(validation, Difference)
  # Extract failures
  failures <- extractValidationResult(confrontation, failure = TRUE)
  # Add difference to failures
  failures[, "df0-df1"] <- validation[failures$rownames, "df0-df1"]
  failure_list[[state]] <- failures
}

#' 15. Number of negative cells in SoI2SoI, SoI2RoUS, RoUS2SoI and RoUS2RoUS <=
#' Number of negative cells in national Use table
rule <- validate::validator(US_Summary_DomesticUse < 0)
confrontation <- validate::confront(US_Summary_DomesticUse, rule)
baseline <- extractValidationResult(confrontation, failure = FALSE)
failure_list <- list()
for (state in states) {
  # Prepare domestic 2-region Use tables
  ls <- generateTwoRegionDomesticUse(state, year = 2012, ioschema = 2012, "Summary")
  columns <- c(getVectorOfCodes("Summary", "Industry"), getFinalDemandCodes("Summary"))
  for (table in names(ls)[1:4]) {
    df <- ls[[table]][, columns]
    rule <- validate::validator(df < 0)
    confrontation <- validate::confront(df, rule)
    # Extract failures
    failures <- extractValidationResult(confrontation, failure = FALSE)
    # Keep failures that are not in baseline
    failures <- failures[!paste(failures$rownames, failures$variable)%in%paste(baseline$rownames, baseline$variable), ]
    failure_list[[paste(state, table, sep = ".")]] <- failures
  }
}

#' 16. Non-square model verification

