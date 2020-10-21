#'Creates Combined Demand Table (in Use Table form) for all 52 states (including DC and Overseas) for a given year
#'Stores table by year .rda files in stateior package

#' 1 - Load state industry output for the given year.
year <- 2012
load(paste0("data/State_Summary_IndustryOutput_", year, ".rda"))
states <- names(State_Summary_IndustryOutput_list)

#' 2 - Load US Summary Make table for given year
#' Generate US Summary Industry Output
US_Summary_MakeTransaction <- getNationalMake("Summary", year)
US_Summary_IndustryOutput <- rowSums(US_Summary_MakeTransaction)

#' 3 - Load US Summary Use table for given year
US_Summary_Use <- getNationalUse("Summary", year)
# Generate US Summary Use Transaction
US_Summary_Use_Intermediate <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity"),
                                              getVectorOfCodes("Summary", "Industry")]
FinalDemand_columns <- getFinalDemandCodes("Summary")

#' 4 - Calculate state_US_IndustryOutput_ratio, for each state and each industry,
#' Divide state IndustryOutput by US IndustryOutput.
#' Multiply US_Summary_Use_Intermediate by state_US_IndustryOutput_ratio 
State_Summary_Use_Intermediate_list <- list()
for (state in states) {
  IndustryOutputRatio <- State_Summary_IndustryOutput_list[[state]][, 1]/US_Summary_IndustryOutput
  State_Summary_Use_Intermediate_list[[state]] <- as.matrix(US_Summary_Use_Intermediate) %*% diag(IndustryOutputRatio)
  colnames(State_Summary_Use_Intermediate_list[[state]]) <- colnames(US_Summary_Use_Intermediate)
}

#' 5 - Vertically stack all state Use trascation tables.
State_Summary_Use_Intermediate <- do.call(rbind, State_Summary_Use_Intermediate_list)
rownames(State_Summary_Use_Intermediate) <- paste(rep(names(State_Summary_Use_Intermediate_list),
                                                      each = nrow(State_Summary_Use_Intermediate_list[[1]])),
                                                  rep(rownames(State_Summary_Use_Intermediate_list[[1]]),
                                                      time = length(names(State_Summary_Use_Intermediate_list))),
                                                  sep = ".")
colnames(State_Summary_Use_Intermediate) <- colnames(US_Summary_Use_Intermediate)

#' 6 - Apply RAS to PCE
State_PCE <- estimateStateHouseholdDemand(year)
State_PCE[, "BEA_2012_Summary_Code"] <- gsub(".*\\.", "", rownames(State_PCE))
State_PCE[, "State"] <- gsub("\\..*", "", rownames(State_PCE))
State_PCE <- reshape2::dcast(State_PCE, BEA_2012_Summary_Code ~ State, value.var = "F010")
rownames(State_PCE) <- State_PCE$BEA_2012_Summary_Code
# Set m0, t_r and t_c
m0 <- as.matrix(State_PCE[rownames(US_Summary_Use_Intermediate), -1])
t_r <- US_Summary_Use[rownames(US_Summary_Use_Intermediate), "F010"]
t_c <- as.numeric(calculateStateTotalPCE(year)[colnames(m0), ])
# Apply RAS, RAS converged after 1000001 iterations.
State_PCE_balanced <- as.data.frame(applyRAS(m0, t_r, t_c, relative_diff = NULL,
                                             absolute_diff = 10, max_itr = 1E6))
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
State_Summary_Use <- cbind(State_Summary_Use_Intermediate,
                           StateFinalDemand[rownames(State_Summary_Use_Intermediate), FinalDemand_columns])

#' 8 - Estimate state imports following these steps:
#' NationalDomesticUse (i.e. adjusted table) = NationalUse (i.e. original table) - NationalImportMatrix + the distribution of F050A
#' NationalDomesticUseRatios = NationalDomesticUse (i.e. adjusted table)/NationalUse (i.e. original table)
#' For each state, StateDomesticUse = StateUse * NationalDomesticUseRatios
#' StateImportColumn = rowSums(StateUse) - rowSums(StateDomesticUse)
#' Optional: StateImportMatrix = StateDomesticUse - StateUse
Domestic_Use_ratios <- calculateUSDomesticUseRatioMatrix("Summary", year)
Domestic_Use_ratios <- do.call("rbind", replicate(52, Domestic_Use_ratios, simplify = FALSE))
rownames(Domestic_Use_ratios) <- rownames(State_Summary_Use)
State_Summary_DomesticUse <- State_Summary_Use*Domestic_Use_ratios
State_Summary_Use$F050 <- rowSums(State_Summary_DomesticUse) - rowSums(State_Summary_Use)

# Save to .rda
State_Summary_Use_list <- list()
State_Summary_DomesticUse_list <- list()
State_Summary_FinalDemand_list <- list()
for (state in states) {
  # State Use
  State_Summary_Use_list[[state]] <- State_Summary_Use[gsub("\\..*", "", rownames(State_Summary_Use))==state, ]
  rownames(State_Summary_Use_list[[state]]) <- gsub(".*\\.", "", rownames(State_Summary_Use_list[[state]]))
  # State Domestic Use
  State_Summary_DomesticUse_list[[state]] <- State_Summary_DomesticUse[gsub("\\..*", "", rownames(State_Summary_DomesticUse))==state, ]
  rownames(State_Summary_DomesticUse_list[[state]]) <- gsub(".*\\.", "", rownames(State_Summary_DomesticUse_list[[state]]))
  # State Final Demand
  State_Summary_FinalDemand_list[[state]] <- StateFinalDemand[gsub("\\..*", "", rownames(StateFinalDemand))==state, ]
  rownames(State_Summary_FinalDemand_list[[state]]) <- gsub(".*\\.", "", rownames(State_Summary_FinalDemand_list[[state]]))
}
save(State_Summary_Use_list, file = paste0("data/State_Summary_Use_", year, ".rda"))
save(State_Summary_DomesticUse_list, file = paste0("data/State_Summary_DomesticUse_", year, ".rda"))
save(State_Summary_FinalDemand_list, file = paste0("data/State_Summary_FinalDemand_", year, ".rda"))

#' 9 - Calculate imports by industry
ImportByIndustry <- colSums(State_Summary_Use) - colSums(State_Summary_DomesticUse)

#' Last step - For each state, append detailed Value Added to the end of Use table
State_Value_Added <- assembleStateValueAdded(year)
State_Summary_Use <- rbind(State_Summary_Use, State_Value_Added)
State_Summary_Use <- State_Summary_Use[order(rownames(State_Summary_Use)), ]
