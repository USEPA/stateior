#' Build a state supply model for all 52 states/regions (including DC and Overseas) for a given year
#' @description Build a state supply model for all 52 states/regions (including DC and Overseas) for a given year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A list of state supply model components: Make table, commodity and industry output.
#' @export
buildStateSupplyModel <- function(year) {
  logging::loginfo("Loading RAS-balanced state-to-US value added (VA) ratios ...")
  StateUS_VA_Ratio <- get(paste0("StateUS_VA_Ratio_", year), as.environment("package:stateior"))
  states <- unique(StateUS_VA_Ratio$GeoName)
  
  logging::loginfo("Estimating state Make table and commodity output ...")
  # Apply the adjusted VA_ratio to calculate State Summary MakeTransaction, IndustryOutput, and CommodityOutput
  State_Summary_MakeTransaction_list <- list()
  State_Summary_IndustryOutput_list <- list()
  State_Summary_CommodityOutput_list <- list()
  State_Summary_CommodityOutputRatio_list <- list()
  US_Summary_MakeTransaction <- getNationalMake("Summary", year)
  US_Summary_IndustryOutput <- rowSums(US_Summary_MakeTransaction)
  US_Summary_CommodityOutput <- colSums(US_Summary_MakeTransaction)
  for (state in states) {
    # Subset the StateUS_VA_Ratio for specified state
    VA_ratio <- StateUS_VA_Ratio[StateUS_VA_Ratio$GeoName==state, ]
    # Replace NA with zero
    VA_ratio[is.na(VA_ratio$Ratio), "Ratio"] <- 0
    # Re-order StateUS_VA_Ratio
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
  AlternativeStateCommodityOutputRatio <- get(paste("AlternativeStateCommodityOutputRatio_", year),
                                              as.environment("package:stateior"))
  
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

#' Build a state demand model for all 52 states/regions (including DC and Overseas) for a given year
#' @description Build a state demand model for all 52 states/regions (including DC and Overseas) for a given year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A list of state demand model components: Use table and Domestic Use table.
#' @export
buildStateDemandModel <- function(year) {
  # Define industries, commodities and # Define final demand columns
  industries <- getVectorOfCodes("Summary", "Industry")
  commodities <- getVectorOfCodes("Summary", "Commodity")
  FinalDemand_columns <- getFinalDemandCodes("Summary")
  
  logging::loginfo("Loading state and US industry output ...")
  # State industry output
  State_Summary_IndustryOutput_list <- get(paste0("State_Summary_IndustryOutput_", year),
                                           as.environment("package:stateior"))
  states <- names(State_Summary_IndustryOutput_list)
  # US industry output
  US_Summary_MakeTransaction <- getNationalMake("Summary", year)
  US_Summary_IndustryOutput <- rowSums(US_Summary_MakeTransaction)
  
  logging::loginfo("Loading US Use table ...")
  # Load US Summary Use table for given year
  US_Summary_Use <- getNationalUse("Summary", year)
  # Generate US Summary Use Transaction
  US_Summary_Use_Intermediate <- US_Summary_Use[commodities, industries]
  
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
  logging::loginfo("Appending value added to state Use tables ...")
  StateGVA <- get(paste0("State_GrossValueAdded_", year), as.environment("package:stateior"))
  model <- list()
  for (state in states) {
    # Assemble state Use table
    State_Summary_Use <- cbind(State_Summary_Use_Intermediate_list[[state]],
                               StateFinalDemand[gsub("\\..*", "", rownames(StateFinalDemand))==state,
                                                FinalDemand_columns])
    # Calculate state domestic Use table
    State_Summary_DomesticUse <- State_Summary_Use*Domestic_Use_ratios
    # Update Import in state Use table
    State_Summary_Use$F050 <- rowSums(State_Summary_DomesticUse) - rowSums(State_Summary_Use)
    # Append value added rows to state Use tables
    GVA <- StateGVA[gsub("\\..*", "", rownames(StateGVA))==state, ]
    rownames(GVA) <- gsub(".*\\.", "", rownames(GVA))
    State_Summary_Use[rownames(GVA), industries] <- GVA
    State_Summary_DomesticUse[rownames(GVA), industries] <- GVA
    model[["Use"]][[state]] <- State_Summary_Use
    model[["DomesticUse"]][[state]] <- State_Summary_DomesticUse
  }
  
  logging::loginfo("Model build complete.")
  return(model)
}

#' Build a two-region state demand model
#' @description Generate two-region (SoI and RoUS) domestic use tables.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A list of domestic 2-region use tables.
buildTwoRegionStateDemandModel <- function(state, year, ioschema, iolevel) {
  # 1 - Load state domestic Use for the specified year
  logging::loginfo("Loading state Domestic Use table ...")
  SoI_Domestic_Use <- get(paste0("State_", iolevel, "_DomesticUse_", year),
                          as.environment("package:stateior"))[[state]]
  # Define desired columns
  columns <- unlist(sapply(list("Industry", "HouseholdDemand", "InvestmentDemand",
                                "ChangeInventories", "GovernmentDemand"),
                           getVectorOfCodes, iolevel = iolevel))
  ExportCodes <- getVectorOfCodes(iolevel, "Export")
  
  # 2 - Generate 2-region ICFs
  logging::loginfo("Generating two-region interregional commodity flow (ICF) ratios ...")
  ICF <- generateDomestic2RegionICFs(state, year, remove_scrap = FALSE, ioschema = 2012, iolevel = iolevel)
  
  # 3 - Generate SoI2SoI domestic Use
  logging::loginfo("Generating SoI2SoI Use table ...")
  SoI2SoI_Use <- SoI_Domestic_Use
  SoI2SoI_Use[, columns] <- SoI_Domestic_Use[, columns] * ICF$SoI2SoI
  # Load state commodity output
  logging::loginfo("Loading state commodity output ...")
  SoI_Commodity_Output <- get(paste0("State_", iolevel, "_CommodityOutput_", year),
                              as.environment("package:stateior"))[[state]]
  # Calculate Interregional Imports, Exports, and Net Exports
  logging::loginfo("Calculating SoI2SoI interregional imports and exports and net exports ...")
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(SoI2SoI_Use[, columns])
  SoI2SoI_Use$InterregionalExports <- SoI_Commodity_Output$Output - rowSums(SoI2SoI_Use[, c(columns, ExportCodes)])
  SoI2SoI_Use$NetExports <- SoI2SoI_Use$InterregionalExports - SoI2SoI_Use$InterregionalImports
  
  # 4 - Generate RoUS domestic Use and commodity output
  # Generate RoUS domestic Use
  logging::loginfo("Generating RoUS Domestic Use table ...")
  US_Domestic_Use <- estimateUSDomesticUse(iolevel, year)
  RoUS_Domestic_Use <- US_Domestic_Use - SoI_Domestic_Use
  # Calculate RoUS Commodity Output
  logging::loginfo("Generating RoUS commodity output ...")
  US_Make <- getNationalMake(iolevel, year)
  US_Commodity_Output <- colSums(US_Make)
  RoUS_Commodity_Output <- US_Commodity_Output - SoI_Commodity_Output
  colnames(RoUS_Commodity_Output) <- "Output"
  # Adjust RoUS_Commodity_Output
  MakeUseDiff <- US_Commodity_Output - rowSums(US_Domestic_Use[, c(columns, ExportCodes)])
  RoUS_Commodity_Output$Output <- RoUS_Commodity_Output$Output - MakeUseDiff
  
  # 5 - Generate RoUS2RoUS domestic Use
  logging::loginfo("Generating RoUS2RoUS Use table ...")
  RoUS2RoUS_Use <- RoUS_Domestic_Use
  RoUS2RoUS_Use[, columns] <- RoUS_Domestic_Use[, columns] * ICF$RoUS2RoUS
  # Calculate Interregional Imports, Exports, and Net Exports
  logging::loginfo("Calculating RoUS2RoUS interregional imports and exports and net exports ...")
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Use[, columns])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(RoUS2RoUS_Use[, c(columns, ExportCodes)])
  RoUS2RoUS_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports
  
  # 6 - Allocate negative InterregionalExports across columns in SoI2SoI Use and RoUS2RoUS Use
  logging::loginfo("Allocating negative interregional exports in SoI2SoI Use and RoUS2RoUS Use ...")
  for (i in 1:nrow(SoI2SoI_Use)) {
    # SoI2SoI
    if (SoI2SoI_Use[i, "InterregionalExports"]<0) {
      value <- SoI2SoI_Use[i, "InterregionalExports"]
      weight <- SoI2SoI_Use[i, columns]
      SoI2SoI_Use[i, columns] <- weight + value*(weight/sum(weight))
    }
    # RoUS2RoUS
    if (RoUS2RoUS_Use[i, "InterregionalExports"]<0) {
      value <- RoUS2RoUS_Use[i, "InterregionalExports"]
      weight <- RoUS2RoUS_Use[i, columns]
      RoUS2RoUS_Use[i, columns] <- weight + value*(weight/sum(weight))
    }
  }
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(SoI2SoI_Use[, columns])
  SoI2SoI_Use$InterregionalExports <- SoI_Commodity_Output$Output - rowSums(SoI2SoI_Use[, c(columns, ExportCodes)])
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Use[, columns])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(RoUS2RoUS_Use[, c(columns, ExportCodes)])
  
  # 7 - Calculate errors for SoI and RoUS
  logging::loginfo("Allocating difference between interregional imports and exports in SoI2SoI Use and RoUS2RoUS Use ...")
  error <- SoI2SoI_Use$InterregionalImports - RoUS2RoUS_Use$InterregionalExports
  SoIerror <- error*(SoI_Commodity_Output$Output/US_Commodity_Output)
  RoUSerror <- error - SoIerror
  SoIerror_1 <- SoIerror_2 <- SoIerror
  
  # 8 - Allocate the errors across columns in SoI2SoI Use and RoUS2RoUS Use
  for (i in 1:nrow(SoI2SoI_Use)) {
    SoIweight <- SoI2SoI_Use[i, columns]
    RoUSweight <- RoUS2RoUS_Use[i, columns]
    SoIerror_1[i] <- ifelse(abs(SoIerror[i])<sum(SoIweight), SoIerror[i],
                            ifelse(SoIerror[i]<0, sum(SoIweight)*-1, sum(SoIweight)))
    SoIerror_2[i] <- ifelse(SoIerror_1[i]!=SoIerror[i], SoIerror_1[i]/2, SoIerror[i])
    RoUSerror[i] <- error[i] - SoIerror_2[i]
    SoI2SoI_Use[i, columns] <- SoIweight + SoIerror_2[i]*(SoIweight/sum(SoIweight))
    RoUS2RoUS_Use[i, columns] <- RoUSweight - RoUSerror[i]*(RoUSweight/sum(RoUSweight))
  }
  # Check if negative cells in SoI2SoI_Use and RoUS2RoUS_Use are also negative in US_Domestic_Use
  
  # 9 - Re-calculate InterregionalImports, InterregionalExports and NetExports
  logging::loginfo("Adjusting interregional imports and exports and net exports in SoI2SoI and RoUS2RoUS ...")
  # SoI2SoI
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(SoI2SoI_Use[, columns])
  SoI2SoI_Use$InterregionalExports <- SoI_Commodity_Output$Output - rowSums(SoI2SoI_Use[, c(columns, ExportCodes)])
  SoI2SoI_Use$NetExports <- SoI2SoI_Use$InterregionalExports - SoI2SoI_Use$InterregionalImports
  # RoUS2RoUS
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Use[, columns])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(RoUS2RoUS_Use[, c(columns, ExportCodes)])
  RoUS2RoUS_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports
  # Check if there are negative values in InterregionalImports, InterregionalExports and NetExports in SoI2SoI_Use and RoUS2RoUS_Use
  
  # 10 - Generate SoI2RoUS and RoUS2SoI Use
  logging::loginfo("Generating SoI2RoUS and RoUS2SoI Use ...")
  # SoI2RoUS
  SoI2RoUS_Use <- RoUS_Domestic_Use - RoUS2RoUS_Use[rownames(RoUS_Domestic_Use), colnames(RoUS_Domestic_Use)]
  SoI2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(SoI2RoUS_Use[, columns])
  SoI2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(SoI2RoUS_Use[, c(columns, ExportCodes)])
  SoI2RoUS_Use$NetExports <- SoI2RoUS_Use$InterregionalExports - SoI2RoUS_Use$InterregionalImports
  # RoUS2SoI
  RoUS2SoI_Use <- SoI_Domestic_Use - SoI2SoI_Use[rownames(SoI_Domestic_Use), colnames(SoI_Domestic_Use)]
  RoUS2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(RoUS2SoI_Use[, columns])
  RoUS2SoI_Use$InterregionalExports <- SoI_Commodity_Output$Output - rowSums(RoUS2SoI_Use[, c(columns, ExportCodes)])
  RoUS2SoI_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2SoI_Use$InterregionalImports
  
  # 11 - Create validation
  logging::loginfo("Creating validation ...")
  validation <- cbind.data.frame(SoI2SoI_Use$InterregionalImports - RoUS2RoUS_Use$InterregionalExports,
                                 SoI2SoI_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports,
                                 SoI2SoI_Use$NetExports + RoUS2RoUS_Use$NetExports,
                                 SoI2RoUS_Use$InterregionalImports - RoUS2SoI_Use$InterregionalExports,
                                 SoI2RoUS_Use$InterregionalExports - RoUS2SoI_Use$InterregionalImports,
                                 SoI2RoUS_Use$NetExports + RoUS2SoI_Use$NetExports)
  rownames(validation) <- rownames(RoUS2RoUS_Use)
  colnames(validation) <- c("SoI2SoI$InterregionalImports - RoUS2RoUS$InterregionalExports",
                            "SoI2SoI$InterregionalExports - RoUS2RoUS$InterregionalImports",
                            "SoI2SoI$NetExports + RoUS2RoUS$NetExports",
                            "SoI2RoUS$InterregionalImports - RoUS2SoI$InterregionalExports",
                            "SoI2RoUS$InterregionalExports - RoUS2SoI$InterregionalImports",
                            "SoI2RoUS$NetExports + RoUS2SoI$NetExports")
  
  # 12 - Assemble SoI2SoI Use, RoUS2RoUS Use
  Domestic2RegionUse <- list("SoI2SoI"    = SoI2SoI_Use,
                             "SoI2RoUS"   = SoI2RoUS_Use,
                             "RoUS2SoI"   = RoUS2SoI_Use,
                             "RoUS2RoUS"  = RoUS2RoUS_Use,
                             "Validation" = validation)
  logging::loginfo("Domestic two-region Use complete ...")
  return(Domestic2RegionUse)
}

