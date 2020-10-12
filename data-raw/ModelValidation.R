### State Supply Model
# Load US make
year <- 2012
US_Summary_Make <- get(paste("Summary_Make", year, "BeforeRedef", sep = "_"), as.environment("package:useeior"))*1E6
US_Summary_MakeTransaction <- US_Summary_Make[-which(rownames(US_Summary_Make)=="Total Commodity Output"),
                                              -which(colnames(US_Summary_Make)=="Total Industry Output")]
# Load state Make, industry and commodity output
load(paste0("data/State_Summary_Make_", year, ".rda"))
load(paste0("data/State_Summary_IndustryOutput_", year, ".rda"))
load(paste0("data/State_Summary_CommodityOutput_", year, ".rda"))
states <- names(State_Summary_IndustryOutput_list)
# Load state total Use and domestic Use
load(paste0("data/State_Summary_Use_", year, ".rda"))
load(paste0("data/State_Summary_Domestic_Use_", year, ".rda"))

# Create a function to extract validation passes or failures
extractValidationResult <- function(confrontation, failure = TRUE) {
  confrontation <- validate::as.data.frame(confrontation)
  confrontation$rownames <- rownames(confrontation)
  df <- reshape2::melt(confrontation, id.vars = c("rownames", "name", "expression"))
  if (failure) {
    result <- df[df$value==FALSE, c("rownames", "variable")]
  } else {
    result <- df[df$value==TRUE, c("rownames", "variable")]
  }
  result <- as.data.frame(lapply(result, function(x) gsub(".*\\.", "", x)))
  return(result)
}

#' 1. Sum of each cell across all state Make tables must almost equal (tolerance is 1E-3)
#' the same cell in US Make table
# Aggregate state Make to US level
StateMake_list <- list()
for (state in states) {
  row_names <- paste(state, rownames(US_Summary_MakeTransaction), sep = ".")
  column_names <- colnames(US_Summary_MakeTransaction)
  StateMake_list[[state]] <- State_Summary_MakeTransaction_balanced[row_names, column_names]
}
df1 <- Reduce("+", StateMake_list)
rownames(df1) <- gsub(".*\\.", "", rownames(df1))
# Validate aggregated state Make against US Make
rules <- validate::validator(abs(df1 - df0) < 1E-3)
confrontation <- validate::confront(df1, rules, ref = list(df0 = US_Summary_MakeTransaction))
validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rules))
rownames(validation) <- rownames(validate::as.data.frame(confrontation))
validation$name <- NULL
# Extract failures
failures <- extractValidationResult(confrontation, failure = TRUE)
colnames(failures) <- c("Industry", "Commodity")

#' 2. There should not be any negative values in state Make table
#' Only exception being Overseas, which isn’t used for further calculations)
# Validate Make table and extract failures for each state
failure_list <- list()
for (state in states) {
  rules <- validate::validator(df1 >= 0)
  df1 <- as.data.frame(StateMake_list[[state]])
  confrontation <- validate::confront(df1, rules)
  failures <- extractValidationResult(confrontation, failure = TRUE)
  colnames(failures) <- c("Industry", "Commodity")
  failure_list[[state]] <- failures
}

#' 3. Sum of each industry’s output across all states must almost equal (tolerance is 1E-3)
#' industry output in US Make Table.
# Validate aggregated state industry output against US industry output
rules <- validate::validator(abs(df1 - df0) < 1E-3)
df1 <- Reduce("+", State_Summary_IndustryOutput_list)
rownames(df1) <- gsub(".*\\.", "", rownames(df1))
confrontation <- validate::confront(df1, rules, ref = list(df0 = rowSums(US_Summary_MakeTransaction)))
validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rules))
rownames(validation) <- rownames(validate::as.data.frame(confrontation))
# Extract failures
failures <- extractValidationResult(confrontation, failure = TRUE)
colnames(failures) <- c("Industry", "Commodity")

#' 4. Sum of each commodity’s output across all states must almost equal (tolerance is 1E-3)
#' commodity output in US Make Table.
# Validate aggregated state commodity output against US commodity output
rules <- validate::validator(abs(df1 - df0) < 1E-3)
df1 <- Reduce("+", State_Summary_CommodityOutput_list)
rownames(df1) <- gsub(".*\\.", "", rownames(df1))
confrontation <- validate::confront(df1, rules, ref = list(df0 = colSums(US_Summary_MakeTransaction)))
validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rules))
rownames(validation) <- rownames(validate::as.data.frame(confrontation))
# Extract failures
failures <- extractValidationResult(confrontation, failure = TRUE)
colnames(failures) <- c("Industry", "Commodity")

#' 5. Sum of each commodity’s output across all states must almost equal (tolerance is 1E7, or $10 million by commodity)
#' commodity output in US Use Table minus International Imports (commodity specific).
#' Even if the threshold is met, track the difference for each commodity as a type of quality control check.
# Prepare US domestic Use table
US_DomesticUse <- estimateUSDomesticUse("Summary", year)
# Validate aggregated state commodity output against row sum of US domestic Use
rules <- validate::validator(abs(df1 - df0) <= 1E7)
df1 <- Reduce("+", State_Summary_CommodityOutput_list)
rownames(df1) <- gsub(".*\\.", "", rownames(df1))
confrontation <- validate::confront(df1, rules, ref = list(df0 = rowSums(US_DomesticUse)))
validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rules))
rownames(validation) <- rownames(validate::as.data.frame(confrontation))
# Calcualte difference between df0 and df1
Difference <- df1 - rowSums(US_DomesticUse)
colnames(Difference) <- "df1-df0"
validation <- merge(validation, Difference, by = 0)

#' 6. All cells that are zero in the US Make table must remain zero in state Make tables.
rules <- validate::validator(US_Summary_MakeTransaction == 0)
confrontation <- validate::confront(US_Summary_MakeTransaction, rules)
baseline <- extractValidationResult(confrontation, failure = FALSE)
# Validate the position of zero values in state Make tables
failure_list <- list()
for (state in states) {
  rules <- validate::validator(StateMake_list[[state]] == 0)
  confrontation <- validate::confront(StateMake_list[[state]], rules)
  passes <- extractValidationResult(confrontation, failure = FALSE)
  failures <- setdiff(paste(baseline$rownames, baseline$variable),
                      paste(passes$rownames, passes$variable))
  failures <- do.call(rbind.data.frame, strsplit(failures, " "))
  if (nrow(failures) > 0) {
    colnames(failures) <- c("Industry", "Commodity")
  }
  failure_list[[state]] <- failures
}

#' 7. Sum of each cell across all state Use tables must almost equal (tolerance is 1E-2)
#' the same cell in US Use table.
#' Create a function to implement the validation
validateStateUseAgainstNationlUse <- function(domestic = FALSE) {
  if (domestic) {
    Use <- State_Summary_Domestic_Use
    df0 <- estimateUSDomesticUse("Summary", year)
  } else {
    Use <- State_Summary_Use
    df0 <- getNationalUse("Summary", year)
  }
  StateUse_list <- list()
  for (state in states) {
    row_names <- paste(state, rownames(df0), sep = ".")
    column_names <- colnames(df0)
    StateUse_list[[state]] <- Use[row_names, column_names]
  }
  df1 <- Reduce("+", StateUse_list)
  rownames(df1) <- gsub(".*\\.", "", rownames(df1))
  # Validate aggregated state Make against US Make
  rules <- validate::validator(abs(df1 - df0) < 1E-2)
  confrontation <- validate::confront(df1, rules, ref = list(df0 = df0))
  validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rules))
  rownames(validation) <- rownames(validate::as.data.frame(confrontation))
  validation$name <- NULL
  # Extract failures
  failures <- extractValidationResult(confrontation, failure = TRUE)
  colnames(failures) <- c("Commodity", "Industry")
  return(list(Validation = validation, Failures = failures))
}
StateUseValidation <- validateStateUseAgainstNationlUse(domestic = FALSE)
StateDomesticUseValidation <- validateStateUseAgainstNationlUse(domestic = TRUE)

