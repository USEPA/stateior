### State Supply Model
# Load US make
year <- 2012
US_Summary_Make <- get(paste("Summary_Make", year, "BeforeRedef", sep = "_"), as.environment("package:useeior"))*1E6
US_Summary_MakeTransaction <- US_Summary_Make[-which(rownames(US_Summary_Make)=="Total Commodity Output"),
                                              -which(colnames(US_Summary_Make)=="Total Industry Output")]
# Load state make, industry and commodity output
load(paste0("data/State_Summary_Make_", year, ".rda"))
load(paste0("data/State_Summary_IndustryOutput_", year, ".rda"))
load(paste0("data/State_Summary_CommodityOutput_", year, ".rda"))
states <- names(State_Summary_IndustryOutput_list)

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
StateMake_agg <- Reduce("+", StateMake_list)
rownames(StateMake_agg) <- gsub(".*\\.", "", rownames(StateMake_agg))
# Validate aggregated state Make against US Make
rules <- validate::validator(abs(df1 - df0) < 1E-3)
df1 <- as.data.frame(StateMake_agg)
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

#' 5. Sum of each commodity’s output across all states must almost equal (tolerance is 1E-3)
#' commodity output in US Use Table minus International Imports (commodity specific).
rules <- validate::validator(abs(df1 - df0) <= 1E7)
df1 <- Reduce("+", State_Summary_CommodityOutput_list)
rownames(df1) <- gsub(".*\\.", "", rownames(df1))
# Prepare US domestic Use table
US_DomesticUse <- estimateUSDomesticUse("Summary", year)
confrontation <- validate::confront(df1, rules, ref = list(df0 = rowSums(US_DomesticUse)))
validation <- merge(validate::as.data.frame(confrontation), validate::as.data.frame(rules))

#' 6. All cells that are zero in the US Make Table must remain zero in state Make tables.
rules <- validate::validator(US_Summary_MakeTransaction == 0)
confrontation <- validate::confront(US_Summary_MakeTransaction, rules)
baseline <- extractValidationResult(confrontation, failure = FALSE)

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
