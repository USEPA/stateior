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

# Create a function to extract validation failures
extractFailtures <- function(confrontation) {
  confrontation <- validate::as.data.frame(confrontation)
  confrontation$rownames <- rownames(confrontation)
  df <- reshape2::melt(confrontation, id.vars = c("rownames", "name", "expression"))
  failures <- df[df$value==FALSE, c("rownames", "variable")]
  failures <- as.data.frame(lapply(failures, function(x) gsub(".*\\.", "", x)))
  return(failures)
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
failures <- extractFailtures(confrontation)
colnames(failures) <- c("Industry", "Commodity")

#' 2. There should not be any negative values in state Make table
#' Only exception being Overseas, which isn’t used for further calculations)
# Validate Make table and extract failures for each state
failure_list <- list()
for (state in states) {
  rules <- validate::validator(df1 >= 0)
  df1 <- as.data.frame(StateMake_list[[state]])
  confrontation <- validate::confront(df1, rules)
  failures <- extractFailtures(confrontation)
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
failures <- extractFailtures(confrontation)
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
failures <- extractFailtures(confrontation)
colnames(failures) <- c("Industry", "Commodity")

