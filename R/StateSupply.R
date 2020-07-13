#'Creates Combined Supply Table (in Make Table form) for all 52 states (including DC and Overseas) for a given year
#'Stores table by year .rda files in useeior package

#' 1 - Load state GDP/value added (VA) by industry for the given year.
#' Map to BEA Summary level
year <- 2012
state_VA <- getStateGDP(year)
state_VA_BEA <- mapStateTabletoBEASummary("GDP", year)

#' 2 - Where VA must be allocated from a LineCode to BEA Summary industries,
#' calculate allocation factors using specified allocationweightsource.
#' When using state employment (from BEA) as source for allocation,
#' introduce national GDP to disaggregate state employment in real estate and gov industries
#' from LineCode to BEA Summary.
AllocationFactors <- calculateStatetoBEASummaryAllocationFactor(year, allocationweightsource = "Employment")
StateValueAdded <- allocateStateTabletoBEASummary("GDP", year, allocationweightsource = "Employment")

#' 3 - Load US Summary Make table for given year
#' Generate US Summary Make Transaction and Industry and Commodity Output
US_Summary_Make <- get(paste("Summary_Make", year, "BeforeRedef", sep = "_"), as.environment("package:useeior"))*1E6
US_Summary_MakeTransaction <- US_Summary_Make[-which(rownames(US_Summary_Make)=="Total Commodity Output"),
                                              -which(colnames(US_Summary_Make)=="Total Industry Output")]
US_Summary_IndustryOutput <- rowSums(US_Summary_MakeTransaction)
US_Summary_CommodityOutput <- colSums(US_Summary_MakeTransaction)

#' 4 - Calculate state_US_VA_ratio, for each state and each industry, divide state VA by US VA.
#' For each state, estimate industry output based on US industry output and state_US_VA_ratio.
#' For industries whose state_US_VA_ratio were calculated based on disaggregated state VA,
#' apply RAS balancing to adjust state industry output and state_US_VA_ratio.
#' Use the adjusted state_US_VA_ratio to calculate state make transaction, industry and commodity output.

# Calculate state_US_VA_ratio
state_US_VA_ratio <- calculateStateUSValueAddedRatio(year)
# Generate list of states
states <- unique(state_US_VA_ratio$GeoName)
State_Summary_IndustryOutput_list <- list()
for (state in c(states, "Overseas")) {
  # Subset the state_US_VA_ratio for specified state
  VA_ratio <- state_US_VA_ratio[state_US_VA_ratio$GeoName==state, ]
  # Replace NA with zero
  VA_ratio[is.na(VA_ratio$Ratio), "Ratio"] <- 0
  # Re-order state_US_VA_ratio
  rownames(VA_ratio) <- VA_ratio$BEA_2012_Summary_Code
  VA_ratio <- VA_ratio[rownames(US_Summary_MakeTransaction), ]
  # Calculate State_Summary_IndustryOutput by multiplying US_Summary_IndustryOutput with VA_ratio
  State_Summary_IndustryOutput_list[[state]] <- US_Summary_IndustryOutput*VA_ratio$Ratio
}

#' Apply RAS balancing method to adjust VA_ratio of the disaggregated sectors (retail, real estate, gov)
for (linecode in c("35", "57", "84", "86")) {
  # Determine BEA sectors that need allocation
  BEAStateGDPtoBEASummary <- utils::read.table(system.file("extdata", "Crosswalk_StateGDPtoBEASummaryIO2012Schema.csv", package = "useeior"),
                                               sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  allocation_sectors <- BEAStateGDPtoBEASummary[duplicated(BEAStateGDPtoBEASummary$LineCode) |
                                                  duplicated(BEAStateGDPtoBEASummary$LineCode, fromLast = TRUE), ]
  BEA_sectors <- allocation_sectors[allocation_sectors$LineCode==linecode, "BEA_2012_Summary_Code"]
  t_r <- as.data.frame(US_Summary_IndustryOutput)[BEA_sectors, ]
  # Generate industry output by LineCode by State, a vector/df of 1x52,
  # Calculated by state_US_VA_ratio_LineCode * sum(US industry output Linecode sectors)
  StateIndustryOutputbyLineCode <- calculateStateIndustryOutputbyLineCode(year)
  t_c <- StateIndustryOutputbyLineCode[StateIndustryOutputbyLineCode$LineCode==linecode, as.character(year)]
  # Generate another vector of US industry output for the LineCode by BEA Summary
  # Load State GDP to BEA Summary sector-mapping table
  BEAStateGDPtoBEASummary <- utils::read.table(system.file("extdata", "Crosswalk_StateGDPtoBEASummaryIO2012Schema.csv", package = "useeior"),
                                               sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  # Create m0
  EstimatedStateIndustryOutput <- do.call(cbind.data.frame, State_Summary_IndustryOutput_list)
  colnames(EstimatedStateIndustryOutput) <- names(State_Summary_IndustryOutput_list)
  m0 <- as.matrix(EstimatedStateIndustryOutput[BEA_sectors, ])
  # Apply RAS
  if (linecode=="35") {
    m <- applyRAS(m0, t_r, t_c, relative_diff = NULL, absolute_diff = 0, max_itr = 1E6)
  } else {
    m <- applyRAS(m0, t_r, t_c, relative_diff = NULL, absolute_diff = 1, max_itr = 1E6)
  }
  # Re-calculate state_US_VA_ratio for the disaggregated sectors
  state_US_VA_ratio_linecode <- m/rowSums(m)
  # Replace the ratio values in state_US_VA_ratio with the re-calculated ratio
  for (sector in rownames(state_US_VA_ratio_linecode)) {
    state_US_VA_ratio[state_US_VA_ratio$BEA_2012_Summary_Code==sector, "Ratio"] <- state_US_VA_ratio_linecode[sector, ]
  }
}

State_Summary_MakeTransaction_list <- list()
State_Summary_IndustryOutput_list <- list()
State_Summary_CommodityOutput_list <- list()
State_Summary_CommodityOutputRatio_list <- list()
for (state in states) {
  # Subset the state_US_VA_ratio for specified state
  VA_ratio <- state_US_VA_ratio[state_US_VA_ratio$GeoName==state, ]
  # Replace NA with zero
  VA_ratio[is.na(VA_ratio$Ratio), "Ratio"] <- 0
  # Re-order state_US_VA_ratio
  rownames(VA_ratio) <- VA_ratio$BEA_2012_Summary_Code
  VA_ratio <- VA_ratio[rownames(US_Summary_MakeTransaction), ]
  # Calculate State_Summary_MakeTransaction by multiplying US_Summary_MakeTransaction with VA_ratio
  State_Summary_MakeTransaction_list[[state]] <- diag(VA_ratio$Ratio, names = TRUE) %*% as.matrix(US_Summary_MakeTransaction)
  rownames(State_Summary_MakeTransaction_list[[state]]) <- rownames(US_Summary_MakeTransaction)
  # Calculate State_Summary_IndustryOutput by multiplying US_Summary_IndustryOutput with VA_ratio
  State_Summary_IndustryOutput_list[[state]] <- US_Summary_IndustryOutput*VA_ratio$Ratio
  # Calculate State_Summary_CommodityOutput by colSumming State_Summary_MakeTransaction
  State_Summary_CommodityOutput_list[[state]] <- as.data.frame(colSums(State_Summary_MakeTransaction_list[[state]]))
  # Calculate State_Summary_CommodityOutputRatio_list
  State_Summary_CommodityOutputRatio_list[[state]] <- as.data.frame(State_Summary_CommodityOutput_list[[state]]/US_Summary_CommodityOutput)
  colnames(State_Summary_CommodityOutputRatio_list[[state]]) <- "OutputRatio"
}

#' 5 - Load available state commodity output data from alternative sources for a given year.
#' Use these data to estimate state-US commodity output ratios.
StateCommodityOutputRatioAlternative <- getStateCommodityOutputRatioEstimates(year)

#' 6 - Adjust estimated state commodity output and calculcate state commodity adjustment ratio
#' Based on reported state commodity output from alternative sources.
for (state in states) {
  #' Adjust estimated state commodity output
  # Calculate state/US commodit output ratio * US Summary Comm Output
  AdjustedCommodityOutput <- merge(US_Summary_CommodityOutput,
                                   StateCommodityOutputRatioAlternative[StateCommodityOutputRatioAlternative$State==state, ],
                                   by.x = 0, by.y = "BEA_2012_Summary_Code")
  AdjustedCommodityOutput$Output <- AdjustedCommodityOutput$x*AdjustedCommodityOutput$Ratio
  # Replace commodity output value in State_Summary_CommodityOutput_list
  commodities <- AdjustedCommodityOutput$Row.names
  State_Summary_CommodityOutput_list[[state]][commodities, ] <- AdjustedCommodityOutput[AdjustedCommodityOutput$Row.names%in%commodities, "Output"]
  #' Calculate state commodity adjustment ratio.
  #' Divide current state commodity output ratio by state commodity output ratio from alternative sources.
  # Merge two sets of state-US commodity output ratio
  commodity_ratios <- merge(State_Summary_CommodityOutputRatio_list[[state]],
                            StateCommodityOutputRatioAlternative[StateCommodityOutputRatioAlternative$State==state, ],
                            by.x = 0, by.y = "BEA_2012_Summary_Code", all.x = TRUE)
  # Replace NA in Ratio with values in OutputRatio
  commodity_ratios[is.na(commodity_ratios$Ratio), "Ratio"] <- commodity_ratios[is.na(commodity_ratios$Ratio), "OutputRatio"]
  # Adjust state Make transactions based on commodity ratios
  State_Summary_MakeTransaction_list[[state]] <- State_Summary_MakeTransaction_list[[state]]%*%diag(commodity_ratios$Ratio/commodity_ratios$OutputRatio)
}

#' 7 - Vertically stack all state Make trascation tables.
State_Summary_MakeTransaction <- do.call(rbind, State_Summary_MakeTransaction_list)
rownames(State_Summary_MakeTransaction) <- paste(rep(names(State_Summary_MakeTransaction_list),
                                                     each = nrow(State_Summary_MakeTransaction_list[[1]])),
                                                 rep(rownames(State_Summary_MakeTransaction_list[[1]]),
                                                     time = length(names(State_Summary_MakeTransaction_list))),
                                                 sep = ".")
colnames(State_Summary_MakeTransaction) <- colnames(US_Summary_MakeTransaction)

#' 8 - Perform RAS until model is balanced
#' Apply RAS balancing to the entire Make table
m0 <- State_Summary_MakeTransaction
t_r <- as.numeric(unlist(State_Summary_IndustryOutput_list))
t_c <- as.numeric(colSums(US_Summary_MakeTransaction))
State_Summary_MakeTransaction_balanced <- applyRAS(m0, t_r, t_c, relative_diff = NULL, absolute_diff = 1E6, max_itr = 1E6)
colnames(State_Summary_MakeTransaction_balanced) <- colnames(m0)

#' 9 - Generae MarketShare matrix for US and each state
# US MS
US_Summary_MarketShare <- normalizeIOTransactions(US_Summary_MakeTransaction, US_Summary_CommodityOutput)
# State MS
State_Summary_MarketShare_list <- list()
for (state in states) {
  StateMS <- normalizeIOTransactions(State_Summary_MakeTransaction_list[[state]],
                                     State_Summary_CommodityOutput_list[[state]])
  # print(paste(state, max(StateMS)))
  # print(paste(state, min(StateMS)))
  State_Summary_MarketShare_list[[state]] <- cbind.data.frame(rownames(StateMS), StateMS)
  colnames(State_Summary_MarketShare_list[[state]])[1] <- ""
}

# Compare state MS to US MS
State_US_MS_Comparison_list <- list()
for (state in states) {
  State_US_MS_Comparison_list[[state]] <- compareMatrices(US_Summary_MarketShare,
                                                          State_Summary_MarketShare_list[[state]])
}

#' 10 - Save state industry output estimates and balanced Make table to .rda
save(State_Summary_MakeTransaction_balanced,
     file = paste0("data/State_Summary_Make_", year, ".rda"))
save(State_Summary_IndustryOutput_list,
     file = paste0("data/State_Summary_IndustryOutput_", year, ".rda"))
save(State_Summary_CommodityOutput_list,
     file = paste0("data/State_Summary_CommodityOutput_", year, ".rda"))
