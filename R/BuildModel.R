#' Build a state supply model for all 52 states/regions (including DC and Overseas) for a given year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @export
#' @return A list of state supply model components: Make table, commodity and industry output.
buildStateSupplyModel <- function(year) {
  logging::loginfo("Loading RAS-balanced state-to-US GDP ratios ...")
  load(paste0("data/StateUS_VAratio_", year, ".rda"))
  
  logging::loginfo("Estimating state Make table and commodity output ...")
  # Apply the adjusted VA_ratio to calculate State Summary MakeTransaction, IndustryOutput, and CommodityOutput
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
    State_Summary_Make_Transaction <- diag(VA_ratio$Ratio, names = TRUE) %*% as.matrix(US_Summary_MakeTransaction)
    rownames(State_Summary_Make_Transaction) <- rownames(US_Summary_MakeTransaction)
    State_Summary_MakeTransaction_list[[state]] <- State_Summary_Make_Transaction
    # Calculate State_Summary_IndustryOutput by multiplying US_Summary_IndustryOutput with VA_ratio
    State_Summary_IndustryOutput_list[[state]] <- US_Summary_IndustryOutput*VA_ratio$Ratio
    # Calculate State_Summary_CommodityOutput by colSumming State_Summary_MakeTransaction
    State_Summary_CommodityOutput_list[[state]] <- as.data.frame(colSums(State_Summary_Make_Transaction))
    # Calculate State_Summary_CommodityOutputRatio_list
    State_Summary_CommodityOutputRatio_list[[state]] <- as.data.frame(colSums(State_Summary_Make_Transaction)/US_Summary_CommodityOutput)
    colnames(State_Summary_CommodityOutputRatio_list[[state]]) <- "OutputRatio"
  }
  
  logging::loginfo("Loading state commodity output ratios from alternative data ...")
  load(paste0("data/AlternativeStateCommodityOutputRatio_", year, ".rda"))
  
  logging::loginfo("Adjusting state Make table ...")
  # Adjust estimated state commodity output and calculcate state commodity adjustment ratio
  # Based on reported state commodity output from alternative sources.
  for (state in states) {
    # Adjust estimated state commodity output
    # Calculate state/US commodit output ratio * US Summary Comm Output
    AdjustedStateCommodityOutput <- merge(US_Summary_CommodityOutput,
                                          AlternativeStateCommodityOutputRatio[AlternativeStateCommodityOutputRatio$State==state, ],
                                          by.x = 0, by.y = "BEA_2012_Summary_Code")
    AdjustedStateCommodityOutput$Output <- AdjustedStateCommodityOutput$x*AdjustedStateCommodityOutput$Ratio
    # Replace commodity output value in State_Summary_CommodityOutput_list
    commodities <- AdjustedStateCommodityOutput$Row.names
    State_Summary_CommodityOutput_list[[state]][commodities, ] <- AdjustedStateCommodityOutput[AdjustedStateCommodityOutput$Row.names%in%commodities, "Output"]
    
    # Calculate state commodity adjustment ratio
    # Divide current state commodity output ratio by state commodity output ratio from alternative sources.
    # Merge two sets of state-US commodity output ratio
    CommodityOutputRatios_df <- merge(State_Summary_CommodityOutputRatio_list[[state]],
                                      AlternativeStateCommodityOutputRatio[AlternativeStateCommodityOutputRatio$State==state, ],
                                      by.x = 0, by.y = "BEA_2012_Summary_Code", all.x = TRUE)
    # Replace NA in Ratio with values in OutputRatio
    CommodityOutputRatios_df[is.na(CommodityOutputRatios_df$Ratio), "Ratio"] <- CommodityOutputRatios_df[is.na(CommodityOutputRatios_df$Ratio), "OutputRatio"]
    rownames(CommodityOutputRatios_df) <- CommodityOutputRatios_df$Row.names
    CommodityOutputRatios_df <- CommodityOutputRatios_df[colnames(State_Summary_MakeTransaction_list[[state]]), ]
    # Adjust state Make transactions based on adjusted commodity ratios
    CommodityAdjustmentRatio <- CommodityOutputRatios_df$Ratio/CommodityOutputRatios_df$OutputRatio
    State_Summary_MakeTransaction_list[[state]] <- State_Summary_MakeTransaction_list[[state]]%*%diag(CommodityAdjustmentRatio)
    colnames(State_Summary_MakeTransaction_list[[state]]) <- rownames(CommodityOutputRatios_df)
  }
  
  logging::loginfo("Preparing state Make table for RAS balancing ...")
  # Vertically stack all state Make trascation tables.
  State_Summary_MakeTransaction <- do.call(rbind, State_Summary_MakeTransaction_list)
  rownames(State_Summary_MakeTransaction) <- paste(rep(names(State_Summary_MakeTransaction_list),
                                                       each = nrow(State_Summary_MakeTransaction_list[[1]])),
                                                   rep(rownames(State_Summary_MakeTransaction_list[[1]]),
                                                       time = length(names(State_Summary_MakeTransaction_list))),
                                                   sep = ".")
  colnames(State_Summary_MakeTransaction) <- colnames(US_Summary_MakeTransaction)
  
  logging::loginfo("Performing RAS balancing on state Make table ...")
  # Separate the state Make trascation table by industry (row) into 71 matrices.
  # Each matrix, m0, has dimensions of 52x73.
  # The rows are individual industry in all states, while the columns are all commodities.
  # Apply RAS till m0 is balanced subject to t_r and t_c and becomes m1.
  m1_list <- list()
  for (industry in rownames(US_Summary_MakeTransaction)) {
    m0 <- State_Summary_MakeTransaction[gsub(".*\\.", "", rownames(State_Summary_MakeTransaction))==industry, ]
    t_r <- as.numeric(do.call(cbind, State_Summary_IndustryOutput_list)[industry, ])
    t_c <- as.numeric(US_Summary_MakeTransaction[industry, ])
    print(industry)
    m1 <- applyRAS(m0, t_r, t_c, relative_diff = NULL, absolute_diff = 1E4, max_itr = 1E6)
    m1_list[[industry]] <- m1
  }
  # Vertically stack all m1 matrices to form a balanced state Make transaction table
  names(m1_list) <- NULL
  State_Summary_MakeTransaction_balanced <- do.call(rbind.data.frame, m1_list)
  State_Summary_MakeTransaction_balanced <- State_Summary_MakeTransaction_balanced[rownames(State_Summary_MakeTransaction), ]
  
  logging::loginfo("Finalizing state Make table, industry and commodity output...")
  model <- list()
  for (state in states) {
    Make <- State_Summary_MakeTransaction_balanced[gsub("\\..*", "", rownames(State_Summary_MakeTransaction_balanced))==state, ]
    model[["Make"]][[state]] <- Make
    State_Summary_IndustryOutput_list[[state]] <- as.data.frame(rowSums(Make))
    colnames(State_Summary_IndustryOutput_list[[state]]) <- "Output"
    State_Summary_CommodityOutput_list[[state]] <- as.data.frame(colSums(Make))
    colnames(State_Summary_CommodityOutput_list[[state]]) <- "Output"
  }
  model[["IndustryOutput"]] <- State_Summary_IndustryOutput_list
  model[["CommodityOutput"]] <- State_Summary_CommodityOutput_list
  
  logging::loginfo("Model build complete.")
  return(model)
}

#' Build a state demand model for all 52 states/regions (including DC and Overseas) for a given year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @export
#' @return A list of state demand model components: Use table and Domestic Use table.
buildStateDemandModel <- function(year) {
  logging::loginfo("Loading state and US industry output ...")
  # State industry output
  load(paste0("data/State_Summary_IndustryOutput_", year, ".rda"))
  states <- names(State_Summary_IndustryOutput_list)
  # US industry output
  US_Summary_MakeTransaction <- getNationalMake("Summary", year)
  US_Summary_IndustryOutput <- rowSums(US_Summary_MakeTransaction)
  
  logging::loginfo("Loading US Use table ...")
  # Load US Summary Use table for given year
  US_Summary_Use <- getNationalUse("Summary", year)
  # Generate US Summary Use Transaction
  US_Summary_Use_Intermediate <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity"),
                                                getVectorOfCodes("Summary", "Industry")]
  # Define final demand columns
  FinalDemand_columns <- getFinalDemandCodes("Summary")
  
  logging::loginfo("Calculating state-to-US industry output ratios ...")
  logging::loginfo("Estimating state intermediate consumption ...")
  # For each state and industry, calculate state_US_IndustryOutput_ratio
  # Multiply US_Summary_Use_Intermediate by state_US_IndustryOutput_ratio 
  State_Summary_Use_Intermediate_list <- list()
  for (state in states) {
    IndustryOutputRatio <- State_Summary_IndustryOutput_list[[state]][, 1]/US_Summary_IndustryOutput
    State_Summary_Use_Intermediate_list[[state]] <- as.matrix(US_Summary_Use_Intermediate) %*% diag(IndustryOutputRatio)
    colnames(State_Summary_Use_Intermediate_list[[state]]) <- colnames(US_Summary_Use_Intermediate)
  }
  
  logging::loginfo("Estimating state personal consumption expenditure ...")
  # Apply RAS to PCE
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
  # Convert State_PCE_balanced from a commodity x state matrix to a long df
  State_PCE_balanced$BEA_2012_Summary_Code <- rownames(State_PCE_balanced)
  State_PCE_balanced <- reshape2::melt(State_PCE_balanced, id.vars = "BEA_2012_Summary_Code")
  rownames(State_PCE_balanced) <- paste(State_PCE_balanced$variable,
                                        State_PCE_balanced$BEA_2012_Summary_Code, sep = ".")
  State_PCE_balanced <- State_PCE_balanced[, "value", drop = FALSE]
  colnames(State_PCE_balanced) <- "F010"
  
  logging::loginfo("Estimating state final demand ...")
  # Assemble final demand columns
  # Create a placeholding State_Import
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
  
  logging::loginfo("Assembling state use table (intermediate consumption + final demand) ...")
  logging::loginfo("Estimating state domestic use table ...")
  Domestic_Use_ratios <- calculateUSDomesticUseRatioMatrix("Summary", year)
  model <- list()
  for (state in states) {
    State_Summary_Use <- cbind(State_Summary_Use_Intermediate_list[[state]],
                               StateFinalDemand[gsub("\\..*", "", rownames(StateFinalDemand))==state,
                                                FinalDemand_columns])
    State_Summary_DomesticUse <- State_Summary_Use*Domestic_Use_ratios
    State_Summary_Use$F050 <- rowSums(State_Summary_DomesticUse) - rowSums(State_Summary_Use)
    model[["Use"]][[state]] <- State_Summary_Use
    model[["DomesticUse"]][[state]] <- State_Summary_DomesticUse
  }
  
  logging::loginfo("Model build complete.")
  return(model)
}
