#'Creates Combined Demand Table (in Use Table form) for all 52 states (including DC and Overseas) for a given year
#'Stores table by year .rda files in useeior package

#' 1 - Load state industry output for the given year.
year <- 2012
load(paste0("data/State_Summary_IndustryOutput_", year, ".rda"))
states <- names(State_Summary_IndustryOutput_list)

#' 2 - Load US Summary Make table for given year
#' Generate US Summary Industry Output
US_Summary_Make <- get(paste("Summary_Make", year, "BeforeRedef", sep = "_"))*1E6
US_Summary_MakeTransaction <- US_Summary_Make[-which(rownames(US_Summary_Make)=="Total Commodity Output"),
                                              -which(colnames(US_Summary_Make)=="Total Industry Output")]
US_Summary_IndustryOutput <- rowSums(US_Summary_MakeTransaction)

#' 3 - Load US Summary Use table for given year
#' Generate US Summary Use Transaction
US_Summary_Use <- get(paste("Summary_Use", year, "PRO_BeforeRedef", sep = "_"))*1E6
US_Summary_UseTransaction <- US_Summary_Use[colnames(US_Summary_MakeTransaction),
                                            rownames(US_Summary_MakeTransaction)]

#' 4 - Calculate state_US_IndustryOutput_ratio, for each state and each industry,
#' Divide state IndustryOutput by US IndustryOutput.
State_Summary_UseTransaction_list <- list()
for (state in states) {
  IndustryOutputRatio <- State_Summary_IndustryOutput_list[[state]]/US_Summary_IndustryOutput
  State_Summary_UseTransaction_list[[state]] <- as.matrix(US_Summary_UseTransaction) %*% diag(IndustryOutputRatio)
  colnames(State_Summary_UseTransaction_list[[state]]) <- colnames(US_Summary_UseTransaction)
}

#' 5 - Vertically stack all state Use trascation tables.
State_Summary_UseTransaction <- do.call(rbind, State_Summary_UseTransaction_list)
rownames(State_Summary_UseTransaction) <- paste(rep(names(State_Summary_UseTransaction_list),
                                                    each = nrow(State_Summary_UseTransaction_list[[1]])),
                                                rep(rownames(State_Summary_UseTransaction_list[[1]]),
                                                    time = length(names(State_Summary_UseTransaction_list))),
                                                sep = ".")
colnames(State_Summary_UseTransaction) <- colnames(US_Summary_UseTransaction)

#' 6 - Validate if state totals == national total
# Row sum
rowsum_validation <- rowSums(State_Summary_UseTransaction) - rowSums(US_Summary_UseTransaction)
# Column sum
State_CommInputTotal_list <- list()
for (industry in colnames(US_Summary_UseTransaction)) {
  State_CommInputTotal_list[[industry]] <- sum(State_Summary_UseTransaction[paste(states, industry, sep = "."), ])
}
colsum_validation <- unlist(State_CommInputTotal_list) - colSums(US_Summary_UseTransaction)

#' 7 - Apply RAS to PCE
State_PCE <- estimateStateHouseholdDemand(year)
State_PCE[, "BEA_2012_Summary_Code"] <- gsub(".*\\.", "", rownames(State_PCE))
State_PCE[, "State"] <- gsub("\\..*", "", rownames(State_PCE))
State_PCE <- reshape2::dcast(State_PCE, BEA_2012_Summary_Code ~ State, value.var = "F010")
rownames(State_PCE) <- State_PCE$BEA_2012_Summary_Code
# Set m0, t_r and t_c
m0 <- as.matrix(State_PCE[rownames(US_Summary_UseTransaction), -1])
t_r <- US_Summary_Use[rownames(US_Summary_UseTransaction), "F010"]
t_c <- as.numeric(calculateStateTotalPCE(year)[colnames(m0), ])
# Apply RAS, RAS converged after 1000001 iterations.
State_PCE_balanced <- as.data.frame(applyRAS(m0, t_r, t_c, relative_diff = NULL,
                                             absolute_diff = 1E6, max_itr = 1E6))
colnames(State_PCE_balanced) <- colnames(m0)

# Convert State_PCE_balanced from a commodity x state matrix to a long df
State_PCE_balanced$BEA_2012_Summary_Code <- rownames(State_PCE_balanced)
State_PCE_balanced <- reshape2::melt(State_PCE_balanced, id.vars = "BEA_2012_Summary_Code")
rownames(State_PCE_balanced) <- paste(State_PCE_balanced$variable,
                                      State_PCE_balanced$BEA_2012_Summary_Code, sep = ".")
State_PCE_balanced <- State_PCE_balanced[, "value", drop = FALSE]
colnames(State_PCE_balanced) <- "F010"

#' 8 - Apply RAS to federal gov expenditure

#' 9 - Assemble final demand columns
StateFinalDemand <- cbind(State_PCE_balanced,
                          estimateStatePrivateInvestment(year),
                          estimateStateExport(year),
                          # state fed gov expenditure
                          estimateStateSLGovExpenditure(year))
State_Summary_Use <- cbind(State_Summary_UseTransaction, StateFinalDemand[rownames(State_Summary_Use), ])

#' 10 - Estimate state imports
State_Summary_Use_Domestic <- State_Summary_Use*(1 - calculateUSImportRatioMatrix(year))
StateImport <- rowSums(State_Summary_Use_Domestic) - rowSums(State_Summary_Use)

#' Last step - For each state, append detailed Value Added to the end of Use table
State_Value_Added <- assembleStateValueAdded(year)
State_Summary_Use <- rbind(State_Summary_Use, State_Value_Added)
State_Summary_Use <- State_Summary_Use[order(rownames(State_Summary_Use)), ]

