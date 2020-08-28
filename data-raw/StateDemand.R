#'Creates Combined Demand Table (in Use Table form) for all 52 states (including DC and Overseas) for a given year
#'Stores table by year .rda files in stateior package

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

#' 3 - Load and adjust US Summary Use table for given year
US_Summary_Use <- adjustUseTablebyImportMatrix("Summary", year)
# Generate US Summary Use Transaction
US_Summary_UseTransaction <- US_Summary_Use[colnames(US_Summary_MakeTransaction),
                                            rownames(US_Summary_MakeTransaction)]
FinalDemand_columns <- colnames(US_Summary_Use)[72:91]

#' 4 - Calculate state_US_IndustryOutput_ratio, for each state and each industry,
#' Divide state IndustryOutput by US IndustryOutput.
#' Multiply US_Summary_UseTransaction by state_US_IndustryOutput_ratio 
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

#' 6 - Apply RAS to PCE
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
                                             absolute_diff = 0, max_itr = 1E6))
colnames(State_PCE_balanced) <- colnames(m0)
save(State_PCE_balanced, file = paste0("data/State_PCE_", year, "_afterRAS.rda"))

# Convert State_PCE_balanced from a commodity x state matrix to a long df
load(paste0("data/State_PCE_", year, "_afterRAS.rda"))
State_PCE_balanced$BEA_2012_Summary_Code <- rownames(State_PCE_balanced)
State_PCE_balanced <- reshape2::melt(State_PCE_balanced, id.vars = "BEA_2012_Summary_Code")
rownames(State_PCE_balanced) <- paste(State_PCE_balanced$variable,
                                      State_PCE_balanced$BEA_2012_Summary_Code, sep = ".")
State_PCE_balanced <- State_PCE_balanced[, "value", drop = FALSE]
colnames(State_PCE_balanced) <- "F010"

#' 7 - Assemble final demand columns
#' Create a placeholding State_Import
State_Import <- State_PCE_balanced
colnames(State_Import) <- "F050"
State_Import$F050 <- 0
row_names <- rownames(State_PCE_balanced)
StateFinalDemand <- cbind(State_PCE_balanced,
                          estimateStatePrivateInvestment(year)[row_names, ],
                          estimateStateExport(year)[row_names, , drop = FALSE],
                          State_Import[row_names, , drop = FALSE],
                          estimateStateFedGovExpenditure(year)[row_names, ],
                          estimateStateSLGovExpenditure(year))[row_names, ]
State_Summary_Use <- cbind(State_Summary_UseTransaction,
                           StateFinalDemand[rownames(State_Summary_UseTransaction), FinalDemand_columns])
save(StateFinalDemand, file = paste0("data/State_Summary_FinalDemand_", year, ".rda"))

#' 8 - Estimate state imports following these steps:
#' NationalDomesticUse = NationalUse - NationalImportMatrix
#' NationalDomesticUseRatios = NationalDomesticUse/NationalUse
#' For each state, StateDomesticUse = StateUse * NationalDomesticUseRatios
#' StateImportColumn  = rowSums(StateUse) - rowSums(StateDomesticUse)
#' Optional: StateImportMatrix = StateDomesticUse - StateUse
Domestic_Use_ratios <- calculateUSDomesticUseRatioMatrix(year)
Domestic_Use_ratios <- do.call("rbind", replicate(52, Domestic_Use_ratios, simplify = FALSE))
rownames(Domestic_Use_ratios) <- rownames(State_Summary_Use)
State_Summary_Domestic_Use <- State_Summary_Use*Domestic_Use_ratios
State_Summary_Use$F050 <- rowSums(State_Summary_Domestic_Use) - rowSums(State_Summary_Use)
save(State_Summary_Use, file = paste0("data/State_Summary_Use_", year, ".rda"))
save(State_Summary_Domestic_Use, file = paste0("data/State_Summary_Domestic_Use_", year, ".rda"))

#' 9 - Calculate imports by industry
ImportByIndustry <- colSums(State_Summary_Use) - colSums(State_Summary_Domestic_Use)

#' 10 - Aggregate state Use tables to national level and check if == US Use table
State_Summary_Use$BEA <- gsub(".*\\.", "", rownames(State_Summary_Use))
State_Summary_Use_agg <- stats::aggregate(State_Summary_Use[, colnames(State_Summary_Use)[1:91]],
                                          by = list(State_Summary_Use$BEA), sum)
rownames(State_Summary_Use_agg) <- State_Summary_Use_agg$Group.1
State_Summary_Use_agg$Group.1 <- NULL
test <- State_Summary_Use_agg - US_Summary_Use[rownames(State_Summary_Use_agg), colnames(State_Summary_Use_agg)]
View(test[, FinalDemand_columns])

#' 11 - Aggregate state Domestic Use tables to national level and check if == US Domestic Use table
State_Summary_Domestic_Use$BEA <- gsub(".*\\.", "", rownames(State_Summary_Domestic_Use))
State_Summary_Domestic_Use_agg <- stats::aggregate(State_Summary_Domestic_Use[, colnames(State_Summary_Domestic_Use)[1:91]],
                                                   by = list(State_Summary_Use$BEA), sum)
rownames(State_Summary_Domestic_Use_agg) <- State_Summary_Domestic_Use_agg$Group.1
State_Summary_Domestic_Use_agg$Group.1 <- NULL
US_Summary_Domestic_Use <- US_Summary_Use[1:73, colnames(State_Summary_Domestic_Use_agg)] * calculateUSDomesticUseRatioMatrix(year)
test <- State_Summary_Domestic_Use_agg - US_Summary_Domestic_Use[rownames(State_Summary_Domestic_Use_agg), colnames(State_Summary_Domestic_Use_agg)]
View(test[, FinalDemand_columns])

#' 12 - Validate total state demand == US demand
# Row sum
rowsum_validation <- rowSums(State_Summary_UseTransaction) - rowSums(US_Summary_UseTransaction)
# Column sum
State_CommInputTotal_list <- list()
for (industry in colnames(US_Summary_UseTransaction)) {
  State_CommInputTotal_list[[industry]] <- sum(State_Summary_UseTransaction[paste(states, industry, sep = "."), ])
}
colsum_validation <- unlist(State_CommInputTotal_list) - colSums(US_Summary_UseTransaction)

#' Last step - For each state, append detailed Value Added to the end of Use table
State_Value_Added <- assembleStateValueAdded(year)
State_Summary_Use <- rbind(State_Summary_Use, State_Value_Added)
State_Summary_Use <- State_Summary_Use[order(rownames(State_Summary_Use)), ]

