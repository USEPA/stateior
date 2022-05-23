#' Build a state supply model for all 52 states/regions (including DC and Overseas)
#' for a given year
#' @description Build a state supply model for all 52 states/regions
#' (including DC and Overseas) for a given year.
#' @param year A numeric value between 2007 and 2017.
#' @return A list of state supply model components: Make, commodity and industry output.
#' @export
buildStateSupplyModel <- function(year) {
  startLogging()
  logging::loginfo("Calculate state/US Gross Value Added (GVA) ratios...")
  StateUS_VA_Ratio <- calculateStateUSValueAddedRatio(year)
  states <- unique(StateUS_VA_Ratio$GeoName)
  
  logging::loginfo("Estimating state Make table and commodity output...")
  # Apply the adjusted VA_ratio to calculate
  # State Summary Make, IndustryOutput, and CommodityOutput
  State_Make_ls <- list()
  State_IndustryOutput_ls <- list()
  State_CommodityOutput_ls <- list()
  State_CommodityOutputRatio_ls <- list()
  US_Make <- getNationalMake("Summary", year)
  US_IndustryOutput <- rowSums(US_Make)
  US_CommodityOutput <- colSums(US_Make)
  for (state in states) {
    # Subset the StateUS_VA_Ratio for specified state
    VA_ratio <- StateUS_VA_Ratio[StateUS_VA_Ratio$GeoName == state, ]
    # Replace NA with zero
    VA_ratio[is.na(VA_ratio$Ratio), "Ratio"] <- 0
    # Re-order StateUS_VA_Ratio
    rownames(VA_ratio) <- VA_ratio$BEA_2012_Summary_Code
    VA_ratio <- VA_ratio[rownames(US_Make), ]
    # Calculate State_Make by multiplying US_Make with VA_ratio
    State_Make <- diag(VA_ratio$Ratio, names = TRUE) %*% as.matrix(US_Make)
    rownames(State_Make) <- rownames(US_Make)
    State_Make_ls[[state]] <- State_Make
    # Calculate State_IndustryOutput by multiplying US_IndustryOutput with VA_ratio
    State_IndustryOutput_ls[[state]] <- US_IndustryOutput*VA_ratio$Ratio
    # Calculate State_CommodityOutput by colSumming State_Make
    State_CommodityOutput_ls[[state]] <- as.data.frame(colSums(State_Make))
    # Calculate State_CommodityOutputRatio_ls
    StateCOR <- as.data.frame(colSums(State_Make)/US_CommodityOutput)
    State_CommodityOutputRatio_ls[[state]] <- StateCOR
    colnames(State_CommodityOutputRatio_ls[[state]]) <- "OutputRatio"
  }
  
  logging::loginfo("Estimating state/US commodity output ratios using data from alternative data...")
  AlternativeStateCOR <- estimateStateCommodityOutputRatiofromAlternativeSources(year)
  
  logging::loginfo("Adjusting state Make table...")
  # Adjust estimated state commodity output and calculate state commodity adjustment ratio
  # Based on reported state commodity output from alternative sources.
  for (state in setdiff(states, "Overseas")) {
    # Adjust estimated state commodity output
    # Calculate state/US commodity output ratio * US Summary Comm Output
    AdjustedStateCommOutput <- merge(US_CommodityOutput,
                                     AlternativeStateCOR[AlternativeStateCOR$State == state, ],
                                     by.x = 0, by.y = "BEA_2012_Summary_Code")
    AdjustedStateCommOutput$Output <- AdjustedStateCommOutput$x*AdjustedStateCommOutput$Ratio
    # Replace commodity output value in State_CommodityOutput_ls
    commodities <- AdjustedStateCommOutput$Row.names
    output <- AdjustedStateCommOutput[AdjustedStateCommOutput$Row.names %in% commodities, "Output"]
    State_CommodityOutput_ls[[state]][commodities, ] <- output
    
    # Calculate state commodity adjustment ratio
    # Divide current state commodity output ratio by alternative state COR.
    # Merge two sets of state-US commodity output ratio
    COR_df <- merge(State_CommodityOutputRatio_ls[[state]],
                    AlternativeStateCOR[AlternativeStateCOR$State == state, ],
                    by.x = 0, by.y = "BEA_2012_Summary_Code", all.x = TRUE)
    # Replace NA in Ratio with values in OutputRatio
    COR_df[is.na(COR_df$Ratio), "Ratio"] <- COR_df[is.na(COR_df$Ratio), "OutputRatio"]
    rownames(COR_df) <- COR_df$Row.names
    COR_df <- COR_df[colnames(State_Make_ls[[state]]), ]
    # Adjust state Make based on adjusted commodity ratios
    CORAdjustmentRatio <- COR_df$Ratio/COR_df$OutputRatio
    AdjustedStateMake <- State_Make_ls[[state]] %*% diag(CORAdjustmentRatio)
    colnames(AdjustedStateMake) <- rownames(COR_df)
    State_Make_ls[[state]] <- AdjustedStateMake
  }
  
  logging::loginfo("Preparing state Make table for RAS balancing...")
  # Vertically stack all state Make transaction tables.
  State_Make <- do.call(rbind, State_Make_ls)
  rownames(State_Make) <- paste(rep(names(State_Make_ls),
                                    each = nrow(State_Make_ls[[1]])),
                                rep(rownames(State_Make_ls[[1]]),
                                    time = length(names(State_Make_ls))),
                                sep = ".")
  colnames(State_Make) <- colnames(US_Make)
  
  logging::loginfo("Performing RAS balancing on state Make table...")
  # Separate the state Make transaction table by industry (row) into 71 matrices.
  # Each matrix, m0, has dimensions of 52x73 (states x commodities)
  # Apply RAS till m0 is balanced subject to t_r and t_c and becomes m1.
  m1_ls <- list()
  for (industry in rownames(US_Make)) {
    m0 <- State_Make[gsub(".*\\.", "", rownames(State_Make)) == industry, ]
    t_r <- as.numeric(do.call(cbind, State_IndustryOutput_ls)[industry, ])
    t_c <- as.numeric(US_Make[industry, ])
    print(industry)
    m1 <- applyRAS(m0, t_r, t_c, relative_diff = NULL, absolute_diff = 1E4,
                   max_itr = 1E6)
    m1_ls[[industry]] <- m1
  }
  # Vertically stack all m1 matrices to form a balanced state Make
  names(m1_ls) <- NULL
  State_Make_balanced <- do.call(rbind.data.frame, m1_ls)
  State_Make_balanced <- State_Make_balanced[rownames(State_Make), ]
  
  logging::loginfo("Finalizing state Make table...")
  model <- list()
  for (state in states) {
    Make <- State_Make_balanced[gsub("\\..*", "",
                                     rownames(State_Make_balanced)) == state, ]
    model[["Make"]][[state]] <- Make
  }
  logging::loginfo("State Supply model build complete.")
  return(model)
}

#' Build a state use use for all 52 states/regions
#' (including DC and Overseas) for a given year
#' @description Build a state Use model for all 52 states/regions
#' (including DC and Overseas) for a given year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A list of state use model components: Use table and Domestic Use table.
#' @export
buildStateUseModel <- function(year) {
  startLogging()
  # Define industries, commodities and # Define final demand columns
  industries <- getVectorOfCodes("Summary", "Industry")
  commodities <- getVectorOfCodes("Summary", "Commodity")
  FD_cols <- getFinalDemandCodes("Summary")
  VA_rows <- getVectorOfCodes("Summary", "ValueAdded")
  # Prepare State Intermediate Consumption tables
  logging::loginfo("Estimating state intermediate consumption...")
  State_Use_Intermediate_ls <- estimateStateIntermediateConsumption(year)
  states <- names(State_Use_Intermediate_ls)
  # Prepare State Final Demand
  logging::loginfo("Estimating state personal consumption expenditure...")
  State_PCE <- estimateStateHouseholdDemand(year)
  logging::loginfo("Estimating state final demand...")
  # Assemble final demand columns and create a temporary State_Import as placeholder
  State_Import <- State_PCE
  colnames(State_Import) <- "F050"
  State_Import$F050 <- 0
  row_names <- rownames(State_PCE)
  StateFinalDemand <- cbind(State_PCE,
                            estimateStatePrivateInvestment(year)[row_names, ],
                            estimateStateExport(year)[row_names, , drop = FALSE],
                            State_Import[row_names, , drop = FALSE],
                            estimateStateFedGovExpenditure(year)[row_names, ],
                            estimateStateSLGovExpenditure(year)[row_names, ])
  StateFinalDemand$State <- gsub("\\..*", "", rownames(StateFinalDemand))
  StateFinalDemand$Commodity <- gsub(".*\\.", "", rownames(StateFinalDemand))
  
  logging::loginfo("Assembling state Use table (intermediate consumption + final demand)...")
  logging::loginfo("Estimating state domestic Use table...")
  logging::loginfo("Estimating state value added, appending it to state Use table...")
  StateGVA <- assembleStateSummaryGrossValueAdded(year)
  StateMake_ls <- loadStateIODataFile(paste0("State_Summary_Make_", year))
  # Derive a commodity_import_ratio matrix from US Import matrix
  US_Import <- loadDatafromUSEEIOR(paste("Summary_Import", year, "BeforeRedef",
                                         sep = "_"))[commodities, c(industries, FD_cols)]*1E6
  US_Import_wo_F050 <- US_Import
  US_Import_wo_F050$F050 <- 0
  commodity_import_ratio <- US_Import_wo_F050/rowSums(US_Import_wo_F050)
  # Replace NaN with 1/(71 + 20 - 1): industries + final demand except imports
  for (i in 1:nrow(commodity_import_ratio)) {
    if (all(commodity_import_ratio[i, ] == "NaN")) {
      commodity_import_ratio[i, ] <- 1/(71 + 20 - 1)
    }
  }
  
  model <- list()
  for (state in states) {
    # Assemble state Use table
    State_Use <- cbind(State_Use_Intermediate_ls[[state]],
                       StateFinalDemand[StateFinalDemand$State == state, FD_cols])
    # Update Import in state Use table
    State_Use$F050 <- colSums(StateMake_ls[[state]]) - rowSums(State_Use)
    State_Use[is.na(State_Use)] <- 0
    # Validation - interrupt if commodity output (q) from Make != q from Use by 1E-5
    q_make <- colSums(StateMake_ls[[state]])
    q_use <- rowSums(State_Use)
    rel_diff <- (q_use - q_make)/q_make
    if (max(abs(rel_diff), na.rm = TRUE) > 1E-5 && state != "Overseas") {
      stop(paste0(state, "'s Make and Use tables are not balanced ",
                  "in terms of commodity output."))
    }
    # Generate state domestic Use table
    US_Import_wo_F050 <- US_Import
    US_Import_wo_F050$F050 <- 0
    State_Import_m <- State_Use$F050 * commodity_import_ratio
    State_DomesticUse <- State_Use + State_Import_m
    State_DomesticUse$F050 <- 0
    State_DomesticUse[is.na(State_DomesticUse)] <- 0
    # Validation - interrupt if commodity output (q) from Make != q from Domestic Use by 1E-5
    q_domuse <- rowSums(State_DomesticUse)
    rel_diff <- (q_domuse - q_make)/q_make
    if (max(abs(rel_diff), na.rm = TRUE) > 1E-5 && state != "Overseas") {
      stop(paste0(state, "'s Make and Domestic Use tables are not balanced ",
                  "in terms of commodity output."))
    }
    # Append value added rows to state Use tables
    GVA <- StateGVA[gsub("\\..*", "", rownames(StateGVA)) == state, ]
    rownames(GVA) <- gsub(".*\\.", "", rownames(GVA))
    State_Use[rownames(GVA), industries] <- GVA
    State_DomesticUse[rownames(GVA), industries] <- GVA
    # Add to model
    model[["Use"]][[state]] <- State_Use
    model[["DomesticUse"]][[state]] <- State_DomesticUse
  }
  
  logging::loginfo("Estimating state international trade adjustment...")
  # Append international trade adjustment to state Use and DomesticUse tables
  # !This step has to be executed after 'model' is complete in order to derive 'ratio'.
  State_Import_sum <- Reduce("+", model[["Use"]])[commodities, "F050"]
  names(State_Import_sum) <- commodities
  # Generate US international trade adjustment
  US_ITA <- generateInternationalTradeAdjustmentVector("Summary", year)
  # Load US Summary Use table for given year
  US_Use <- getNationalUse("Summary", year)
  logging::loginfo("Finalizing state Use table, industry and commodity output...")
  ratio_ls <- list()
  comm_ls <- list()
  for (state in states) {
    ratio <- model[["Use"]][[state]][commodities, "F050"]/State_Import_sum
    names(ratio) <- commodities
    ratio_ls[[state]] <- ratio
    # Find commodities meet any condition below:
    # 1. Its state/US import ratio == NA,
    # 2. It has state/US import ratio that is negative or larger than 1,
    # 3. It has non-zero national ITA but zero in state/US import ratio.
    comm_ls[[state]] <- unique(c(names(ratio[is.na(ratio)]),
                                 names(ratio[which(ratio < 0 | ratio > 1)]),
                                 intersect(names(US_ITA[US_ITA != 0]),
                                           names(ratio[ratio == 0]))))
  }
  comms <- unique(unlist(comm_ls))
  for (state in states) {
    ratio <- ratio_ls[[state]]
    # For each commodity in the comm_ls, replace its state/US import ratio
    # with total consumption (rowSums of Use excluding Imports) ratio.
    for (comm in comms) {
      state_total_cons <- sum(model[["Use"]][[state]][comm, setdiff(c(industries, FD_cols), "F050")])
      US_total_cons <- sum(US_Use[comm, setdiff(c(industries, FD_cols), "F050")])
      ratio[comm] <- state_total_cons/US_total_cons
    }
    # Add F051 to Use and DomesticUse
    model[["Use"]][[state]][commodities, "F051"] <- US_ITA*ratio
    model[["DomesticUse"]][[state]][commodities, "F051"] <- US_ITA*ratio
    # Calculate industry and commodity output based on Use
    x <- as.data.frame(colSums(model[["Use"]][[state]][c(commodities, VA_rows), industries]))
    q <- as.data.frame(rowSums(model[["Use"]][[state]][commodities, c(industries, FD_cols)]))
    colnames(x) <- colnames(q) <- "Output"
    model[["IndustryOutput"]][[state]] <- x
    model[["CommodityOutput"]][[state]] <- q
  }
  logging::loginfo("State Use model build complete.")
  return(model)
}

#' Build a two-region Use model
#' @description Generate two-region (SoI and RoUS) Use tables
#' with interregional exports and imports.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @param ICF_sensitivity_analysis A logical value indicating whether to conduct
#' sensitivity analysis on ICF, default is FALSE.
#' @param adjust_by A numeric value between 0 and 1 indicating the manual adjustment
#' to ICF if a sensitivity analysis is conducted, default is 0 due to no SA.
#' @param domestic A logical value indicating whether to use Domestic Use tables,
#' default is TRUE.
#' @return A list of domestic two-region Use tables.
#' @export
buildTwoRegionUseModel <- function(state, year, ioschema, iolevel,
                                   ICF_sensitivity_analysis = FALSE,
                                   adjust_by = 0, domestic = TRUE) {
  startLogging()
  # 0 - Define commodities, industries, final demand columns, import column, and
  # international trade adjustment column
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  industries <- getVectorOfCodes(iolevel, "Industry")
  FD_cols <- getFinalDemandCodes(iolevel)
  import_col <- getVectorOfCodes(iolevel, "Import")
  ITA_col <- ifelse(iolevel == "Detail", "F05100", "F051")
  # All tradable sectors
  tradable_cols <- c(unlist(sapply(list("Industry", "HouseholdDemand"),
                                   getVectorOfCodes, iolevel = iolevel)),
                     FD_cols[substr(FD_cols, nchar(FD_cols),
                                    nchar(FD_cols)) %in% c("C", "E", "R", "N")])
  # All sectors except international imports
  nonimport_cols <- c(industries, FD_cols[-which(FD_cols %in% import_col)])
  
  # 1 - Load state domestic Use for the specified year
  logging::loginfo("Loading state Domestic Use table...")
  SoI_DomesticUse <- loadStateIODataFile(paste0("State_",
                                                iolevel,
                                                "_DomesticUse_",
                                                year))[[state]][commodities, ]
  
  # 2 - Generate 2-region ICFs
  logging::loginfo("Generating two-region interregional commodity flow (ICF) ratios...")
  ICF <- generateDomestic2RegionICFs(state, year, ioschema, iolevel,
                                     ICF_sensitivity_analysis, adjust_by)
  # Only allocate "error" to rows (commodities) that does not have ICF of 1 or 0
  commodities_notrade <- ICF[ICF$SoI2SoI == 1 & ICF$SoI2RoUS == 0 &
                               ICF$RoUS2RoUS == 1 & ICF$RoUS2SoI == 0, 1]
  rows_allocation <- setdiff(commodities, commodities_notrade)
  
  # 3 - Generate SoI2SoI domestic Use
  logging::loginfo("Generating SoI2SoI Use table...")
  SoI2SoI_Use <- SoI_DomesticUse
  SoI2SoI_Use[, tradable_cols] <- SoI_DomesticUse[, tradable_cols] * ICF$SoI2SoI
  # Load state commodity output
  logging::loginfo("Loading state commodity output...")
  SoI_CommodityOutput <- loadStateIODataFile(paste0("State_",
                                                    iolevel,
                                                    "_CommodityOutput_",
                                                    year))[[state]]
  # Calculate Interregional Imports, Exports, and Net Exports
  logging::loginfo("Calculating SoI2SoI interregional imports and exports and net exports...")
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_DomesticUse[, tradable_cols]) - rowSums(SoI2SoI_Use[, tradable_cols])
  SoI2SoI_Use$InterregionalExports <- SoI_CommodityOutput$Output - rowSums(SoI2SoI_Use[, c(nonimport_cols, ITA_col)])
  
  # 4 - Generate RoUS domestic Use and commodity output
  # Generate RoUS domestic Use
  logging::loginfo("Generating RoUS Domestic Use table...")
  US_DomesticUse <- generateUSDomesticUse(iolevel, year)
  RoUS_DomesticUse <- US_DomesticUse - SoI_DomesticUse
  # Calculate RoUS Commodity Output
  logging::loginfo("Generating RoUS commodity output...")
  US_Make <- getNationalMake(iolevel, year)
  US_CommodityOutput <- colSums(US_Make)
  RoUS_CommodityOutput <- US_CommodityOutput - SoI_CommodityOutput
  colnames(RoUS_CommodityOutput) <- "Output"
  # Adjust RoUS_CommodityOutput
  MakeUseDiff <- US_CommodityOutput - rowSums(US_DomesticUse[, c(nonimport_cols, ITA_col)])
  RoUS_CommodityOutput$Output <- RoUS_CommodityOutput$Output - MakeUseDiff
  
  # 5 - Generate RoUS2RoUS domestic Use
  logging::loginfo("Generating RoUS2RoUS Use table...")
  RoUS2RoUS_Use <- RoUS_DomesticUse
  RoUS2RoUS_Use[, tradable_cols] <- RoUS_DomesticUse[, tradable_cols] * ICF$RoUS2RoUS
  # Calculate Interregional Imports, Exports, and Net Exports
  logging::loginfo("Calculating RoUS2RoUS interregional imports and exports and net exports...")
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_DomesticUse[, tradable_cols]) - rowSums(RoUS2RoUS_Use[, tradable_cols])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_CommodityOutput$Output - rowSums(RoUS2RoUS_Use[, c(nonimport_cols, ITA_col)])
  
  # 6 - Allocate negative InterregionalExports across columns in SoI2SoI Use and RoUS2RoUS Use
  logging::loginfo("Allocating negative interregional exports in SoI2SoI Use and RoUS2RoUS Use...")
  for (i in rows_allocation) {
    # SoI2SoI
    if (SoI2SoI_Use[i, "InterregionalExports"] < 0) {
      value <- SoI2SoI_Use[i, "InterregionalExports"]
      weight <- SoI2SoI_Use[i, tradable_cols]
      if (sum(weight) == 0) {
        SoI2SoI_Use[i, tradable_cols] <- value*(1/length(weight))
      } else {
        SoI2SoI_Use[i, tradable_cols] <- weight + value*(weight/sum(weight))
      }
    }
    # RoUS2RoUS
    if (RoUS2RoUS_Use[i, "InterregionalExports"] < 0) {
      value <- RoUS2RoUS_Use[i, "InterregionalExports"]
      weight <- RoUS2RoUS_Use[i, tradable_cols]
      if (sum(weight) == 0) {
        RoUS2RoUS_Use[i, tradable_cols] <- value*(1/length(weight))
      } else {
        RoUS2RoUS_Use[i, tradable_cols] <- weight + value*(weight/sum(weight))
      }
    }
  }
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_DomesticUse[, tradable_cols]) - rowSums(SoI2SoI_Use[, tradable_cols])
  SoI2SoI_Use$InterregionalExports <- SoI_CommodityOutput$Output - rowSums(SoI2SoI_Use[, c(nonimport_cols, ITA_col)])
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_DomesticUse[, tradable_cols]) - rowSums(RoUS2RoUS_Use[, tradable_cols])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_CommodityOutput$Output - rowSums(RoUS2RoUS_Use[, c(nonimport_cols, ITA_col)])
  
  # 7 - Calculate residual for SoI and RoUS
  logging::loginfo("Allocating the difference between interregional imports and exports (i.e. residual) in SoI2SoI Use and RoUS2RoUS Use...")
  residual <- SoI2SoI_Use$InterregionalImports - RoUS2RoUS_Use$InterregionalExports
  SoI_residual <- residual*(SoI_CommodityOutput$Output/US_CommodityOutput)
  RoUS_residual <- residual - SoI_residual
  SoI_residual_1 <- SoI_residual_2 <- SoI_residual
  names(residual) <- names(SoI_residual_1)
  residual_df <- cbind.data.frame(residual, SoI_residual, RoUS_residual,
                                  SoI_CommodityOutput, US_CommodityOutput)
  
  # 8 - Allocate residual across columns in SoI2SoI Use and RoUS2RoUS Use
  for (i in rows_allocation) {
    SoIweight <- SoI2SoI_Use[i, tradable_cols]
    RoUSweight <- RoUS2RoUS_Use[i, tradable_cols]
    SoI_residual_1[i] <- ifelse(abs(SoI_residual[i]) < sum(SoIweight), SoI_residual[i],
                                ifelse(SoI_residual[i] < 0,
                                       sum(SoIweight)*-1, sum(SoIweight)))
    SoI_residual_2[i] <- ifelse(SoI_residual_1[i] != SoI_residual[i], SoI_residual_1[i]/2, SoI_residual[i])
    RoUS_residual[i] <- residual[i] - SoI_residual_2[i]
    # If sum of SoI and RoUS weight != 0, allocate residual to each cell
    if (sum(SoIweight) != 0) {
      SoI2SoI_Use[i, tradable_cols] <- SoIweight + SoI_residual_2[i]*(SoIweight/sum(SoIweight))
    }
    if (sum(RoUSweight) != 0) {
      RoUS2RoUS_Use[i, tradable_cols] <- RoUSweight - RoUS_residual[i]*(RoUSweight/sum(RoUSweight))
    }
  }
  
  # 9 - Re-calculate InterregionalImports, InterregionalExports and NetExports
  logging::loginfo("Adjusting interregional imports and exports and net exports in SoI2SoI and RoUS2RoUS...")
  # SoI2SoI
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_DomesticUse[, tradable_cols]) - rowSums(SoI2SoI_Use[, tradable_cols])
  SoI2SoI_Use$InterregionalExports <- SoI_CommodityOutput$Output - rowSums(SoI2SoI_Use[, c(nonimport_cols, ITA_col)])
  SoI2SoI_Use$NetExports <- SoI2SoI_Use$InterregionalExports - SoI2SoI_Use$InterregionalImports
  # RoUS2RoUS
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_DomesticUse[, tradable_cols]) - rowSums(RoUS2RoUS_Use[, tradable_cols])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_CommodityOutput$Output - rowSums(RoUS2RoUS_Use[, c(nonimport_cols, ITA_col)])
  RoUS2RoUS_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports
  
  # 10 - Generate SoI2RoUS and RoUS2SoI Use
  logging::loginfo("Generating SoI2RoUS and RoUS2SoI Use...")
  # SoI2RoUS
  SoI2RoUS_Use <- RoUS_DomesticUse - RoUS2RoUS_Use[rownames(RoUS_DomesticUse), colnames(RoUS_DomesticUse)]
  SoI2RoUS_Use$InterregionalImports <- rowSums(RoUS_DomesticUse[, tradable_cols]) - rowSums(SoI2RoUS_Use[, tradable_cols])
  SoI2RoUS_Use$InterregionalExports <- RoUS_CommodityOutput$Output - rowSums(SoI2RoUS_Use[, c(nonimport_cols, ITA_col)])
  SoI2RoUS_Use$NetExports <- SoI2RoUS_Use$InterregionalExports - SoI2RoUS_Use$InterregionalImports
  # RoUS2SoI
  RoUS2SoI_Use <- SoI_DomesticUse - SoI2SoI_Use[rownames(SoI_DomesticUse), colnames(SoI_DomesticUse)]
  RoUS2SoI_Use$InterregionalImports <- rowSums(SoI_DomesticUse[, tradable_cols]) - rowSums(RoUS2SoI_Use[, tradable_cols])
  RoUS2SoI_Use$InterregionalExports <- SoI_CommodityOutput$Output - rowSums(RoUS2SoI_Use[, c(nonimport_cols, ITA_col)])
  RoUS2SoI_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2SoI_Use$InterregionalImports
  
  # 11 - For commodities that have SoI2SoI ICF ratio == 1,
  # replace InterregionalExports and NetExports with 0
  # and assign the values to ExportResidual
  logging::loginfo("Replace interregional exports of non-traded commodities with 0...")
  # SoI2SoI
  SoI2SoI_Use[commodities_notrade, "ExportResidual"] <- SoI2SoI_Use[commodities_notrade, "InterregionalExports"]
  SoI2SoI_Use[commodities_notrade, c("InterregionalExports", "NetExports")] <- 0
  SoI2SoI_Use[is.na(SoI2SoI_Use$ExportResidual), "ExportResidual"] <- 0
  # RoUS2RoUS
  RoUS2RoUS_Use[commodities_notrade, "ExportResidual"] <- RoUS2RoUS_Use[commodities_notrade, "InterregionalExports"]
  RoUS2RoUS_Use[commodities_notrade, c("InterregionalExports", "NetExports")] <- 0
  RoUS2RoUS_Use[is.na(RoUS2RoUS_Use$ExportResidual), "ExportResidual"] <- 0
  
  # 12 - Create validation
  logging::loginfo("Creating validation on two-region domestic Use table...")
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
  validation_check <- validation[, c("SoI2SoI$InterregionalImports - RoUS2RoUS$InterregionalExports",
                                     "SoI2SoI$InterregionalExports - RoUS2RoUS$InterregionalImports",
                                     "SoI2SoI$NetExports + RoUS2RoUS$NetExports")]
  if (max(abs(validation_check)) > 1E-3) {
    stop("Two-region domestic Use table did not pass validation.")
  }
  
  # 13 - If domestic == FALSE, two-region total Use table is generated.
  # The first step is to create SoI and RoUS import matrix by subtracting SoI
  # DomesticUse from SoI Use and subtracting RoUS DomesticUse from RoUS Use.
  # Because we assumed international import is not for trade between SoI and RoUS,
  # SoI_Import and RoUS_Import are only added to SoI2SoI_Use and RoUS2RoUS_Use,
  # respectively, while leaving SoI2RoUS_Use and RoUS2SoI_Use unchanged,
  # to form two-region total Use table.
  if (!domestic) {
    # Load US and SoI Use, calcuate RoUS_Use
    # US_Use <- getNationalUse("Summary", year)
    SoI_Use <- loadStateIODataFile(paste0("State_", iolevel, "_Use_", year))[[state]]
    # RoUS_Use <- US_Use - SoI_Use[commodities, c(industries, FD_cols)]
    # Calculate SoI_Import and RoUS_Import
    SoI_Import <- SoI_Use[commodities, c(industries, FD_cols)] - SoI_DomesticUse[commodities, c(industries, FD_cols)]
    # RoUS_Import <- RoUS_Use[commodities, c(industries, FD_cols)] - RoUS_DomesticUse[commodities, c(industries, FD_cols)]
    US_Import <- loadDatafromUSEEIOR(paste("Summary_Import", year, "BeforeRedef",
                                           sep = "_"))[commodities, c(industries, FD_cols)]*1E6
    RoUS_Import <- US_Import - SoI_Import
    # Add SoI and RoUS Import to the two-region Domestic Use
    logging::loginfo("Generating two-region Use with imports...")
    SoI2SoI_Use <- cbind(SoI2SoI_Use[, colnames(SoI_Import)] + SoI_Import,
                         SoI2SoI_Use[, setdiff(colnames(SoI2SoI_Use), colnames(SoI_Import))])
    RoUS2RoUS_Use <- cbind(RoUS2RoUS_Use[, colnames(RoUS_Import)] + RoUS_Import,
                           RoUS2RoUS_Use[, setdiff(colnames(RoUS2RoUS_Use), colnames(RoUS_Import))])
    # Note: F051 - ITA has been carried over from SoI_Use and RoUS_Use to
    # SoI2SoI_Use and RoUS2RoUS_Use, respectively.
  }
  
  # 14 - Check if commodity output from two-region table equals to single-region
  # commodity output vector
  # SoI
  q_SoI <- SoI_CommodityOutput$Output
  q_SoI_use <- rowSums(SoI2SoI_Use[, c(industries, FD_cols, ITA_col, "ExportResidual")]) + rowSums(SoI2RoUS_Use[, c(industries, FD_cols, ITA_col)])
  if (max(abs((q_SoI - q_SoI_use)/q_SoI_use)) > 1E-2) {
    if (domestic) {
      stop(paste0(state, "'s commodity output summed from two-region Domestic Use table, ",
                  "doesn't equal to, ", state, "'s commodity output."))
    } else {
      stop(paste0(state, "'s commodity output summed from two-region (total) Use table, ",
                  "doesn't equal to, ", state, "'s commodity output."))
    }
  }
  # RoUS
  q_RoUS <- RoUS_CommodityOutput$Output
  q_RoUS_use <- rowSums(RoUS2RoUS_Use[, c(industries, FD_cols, ITA_col, "ExportResidual")]) + rowSums(RoUS2SoI_Use[, c(industries, FD_cols, ITA_col)])
  if (max(abs((q_RoUS - q_RoUS_use)/q_RoUS_use)) > 1E-2) {
    if (domestic) {
      stop(paste0("RoUS (of ", state, ")'s commodity output summed from two-region Domestic Use table, ",
                  "doesn't equal to RoUS's commodity output."))
    } else {
      stop(paste0("RoUS (of ", state, ")'s commodity output summed from two-region (total) Use table, ",
                  "doesn't equal to RoUS's commodity output."))
    }
  }
  
  # 15 - Assemble SoI2SoI and RoUS2RoUS total or domestic Use
  TwoRegionUse <- list("SoI2SoI"    = SoI2SoI_Use,
                       "SoI2RoUS"   = SoI2RoUS_Use,
                       "RoUS2SoI"   = RoUS2SoI_Use,
                       "RoUS2RoUS"  = RoUS2RoUS_Use,
                       "Validation" = validation,
                       "Residual"   = residual_df)
  logging::loginfo(paste("Two-region", ifelse(domestic, "Domestic", "Total"), "Use model build complete..."))
  return(TwoRegionUse)
}

#' Assemble two-region make, use, domestic use, and Use tables as well as commodity and industry outputs.
#' @description Assemble two-region make and use tables as well as commodity and industry outputs.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A list of two-region make, use, domestic use, and Use tables
#' as well as commodity and industry outputs by state.
#' @export
assembleTwoRegionIO <- function(year, iolevel) {
  startLogging()
  # Define industries, commodities, value added rows, final demand columns,
  # international trade adjustment column, and non-import columns
  industries <- getVectorOfCodes(iolevel, "Industry")
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  VA_rows <- getVectorOfCodes(iolevel, "ValueAdded")
  FD_cols <- getFinalDemandCodes(iolevel)
  ITA_col <- ifelse(iolevel == "Detail", "F05100", "F051")
  import_col <- getVectorOfCodes(iolevel, "Import")
  nonimport_cols <- c(industries, FD_cols[-which(FD_cols %in% import_col)])
  # Load US Make table
  US_Make <- getNationalMake(iolevel, year)
  US_DomesticUse <- generateUSDomesticUse(iolevel, year)
  # Load state Make, industry and commodity output
  State_Make_ls <- loadStateIODataFile(paste0("State_", iolevel, "_Make_", year))
  State_Use_ls <- loadStateIODataFile(paste0("State_", iolevel, "_Use_", year))
  State_IndustryOutput_ls <- loadStateIODataFile(paste0("State_",
                                                        iolevel,
                                                        "_IndustryOutput_",
                                                        year))
  State_CommodityOutput_ls <- loadStateIODataFile(paste0("State_",
                                                         iolevel,
                                                         "_CommodityOutput_",
                                                         year))
  # Assemble two-region IO tables
  TwoRegionIO <- list()
  for (state in sort(c(state.name, "District of Columbia"))) {
    ## Two-region Make
    SoI_Make <- State_Make_ls[[state]]
    rownames(SoI_Make) <- getBEASectorCodeLocation("Industry", state, iolevel)
    colnames(SoI_Make) <- getBEASectorCodeLocation("Commodity", state, iolevel)
    RoUS_Make <- US_Make - SoI_Make
    rownames(RoUS_Make) <- getBEASectorCodeLocation("Industry", "RoUS", iolevel)
    colnames(RoUS_Make) <- getBEASectorCodeLocation("Commodity", "RoUS", iolevel)
    # Form two-region Make
    TwoRegionMake <- SoI_Make
    TwoRegionMake[rownames(RoUS_Make), colnames(RoUS_Make)] <- RoUS_Make
    # Replace NA with 0 in two-region Make
    TwoRegionMake[is.na(TwoRegionMake)] <- 0
    TwoRegionIO[["Make"]][[state]] <- TwoRegionMake
    
    ## Two-region Use and Domestic Use table
    TwoRegionUseModel <- buildTwoRegionUseModel(state, year, ioschema = 2012,
                                                iolevel = iolevel, domestic = FALSE)
    TwoRegionUse <- cbind(rbind(TwoRegionUseModel[["SoI2SoI"]][commodities, c(industries, FD_cols)],
                                TwoRegionUseModel[["RoUS2SoI"]][commodities, c(industries, FD_cols)]),
                          rbind(TwoRegionUseModel[["SoI2RoUS"]][commodities, c(industries, FD_cols)],
                                TwoRegionUseModel[["RoUS2RoUS"]][commodities, c(industries, FD_cols)]))
    TwoRegionDomesticUseModel <- buildTwoRegionUseModel(state, year, ioschema = 2012,
                                                        iolevel = iolevel, domestic = TRUE)
    TwoRegionDomesticUse <- cbind(rbind(TwoRegionDomesticUseModel[["SoI2SoI"]][commodities, c(industries, FD_cols)],
                                        TwoRegionDomesticUseModel[["RoUS2SoI"]][commodities, c(industries, FD_cols)]),
                                  rbind(TwoRegionDomesticUseModel[["SoI2RoUS"]][commodities, c(industries, FD_cols)],
                                        TwoRegionDomesticUseModel[["RoUS2RoUS"]][commodities, c(industries, FD_cols)]))
    rownames(TwoRegionUse) <- c(getBEASectorCodeLocation("Commodity", state, iolevel),
                                getBEASectorCodeLocation("Commodity", "RoUS", iolevel))
    rownames(TwoRegionDomesticUse) <- rownames(TwoRegionUse)
    colnames(TwoRegionUse) <- c(getBEASectorCodeLocation("Industry", state, iolevel),
                                getBEASectorCodeLocation("FinalDemand", state, iolevel),
                                getBEASectorCodeLocation("Industry", "RoUS", iolevel),
                                getBEASectorCodeLocation("FinalDemand", "RoUS", iolevel))
    colnames(TwoRegionDomesticUse) <- colnames(TwoRegionUse)
    TwoRegionIO[["Use"]][[state]] <- TwoRegionUse
    TwoRegionIO[["DomesticUse"]][[state]] <- TwoRegionDomesticUse
    
    ## Two-region Value Added
    SoI_VA <- State_Use_ls[[state]][VA_rows, industries]
    rownames(SoI_VA) <- getBEASectorCodeLocation("ValueAdded", state, iolevel)
    colnames(SoI_VA) <- getBEASectorCodeLocation("Industry", state, iolevel)
    RoUS_VA <- (Reduce("+", State_Use_ls) - State_Use_ls[[state]])[VA_rows, industries]
    rownames(RoUS_VA) <- apply(cbind(VA_rows, "RoUS"), 1, joinStringswithSlashes)
    colnames(RoUS_VA) <- apply(cbind(industries, "RoUS"), 1, joinStringswithSlashes)
    TwoRegionVA <- SoI_VA
    TwoRegionVA[rownames(RoUS_VA), colnames(RoUS_VA)] <- RoUS_VA
    # Replace NA with 0 in two-region Make
    TwoRegionVA[is.na(TwoRegionVA)] <- 0
    TwoRegionIO[["ValueAdded"]][[state]] <- TwoRegionVA
    
    ## Two-region Domestic Use table with interregional exports and imports
    TwoRegionIO[["DomesticUsewithTrade"]][[state]] <- TwoRegionDomesticUseModel[1:4]
    
    ## Two-region Commodity Output
    SoI_CommodityOutput <- State_CommodityOutput_ls[[state]]
    RoUS_CommodityOutput <- colSums(US_Make) - SoI_CommodityOutput
    MakeUseDiff <- colSums(US_Make) - rowSums(US_DomesticUse[, c(nonimport_cols, ITA_col)])
    RoUS_CommodityOutput$Output <- RoUS_CommodityOutput$Output - MakeUseDiff
    TwoRegionCommodityOutput <- c(SoI_CommodityOutput$Output, RoUS_CommodityOutput$Output)
    names(TwoRegionCommodityOutput) <- c(getBEASectorCodeLocation("Commodity", state, iolevel),
                                         getBEASectorCodeLocation("Commodity", "RoUS", iolevel))
    TwoRegionIO[["CommodityOutput"]][[state]] <- TwoRegionCommodityOutput
    
    ## Two-region Industry Output
    TwoRegionIndustryOutput <- c(State_IndustryOutput_ls[[state]][, "Output"],
                                 rowSums(US_Make) - State_IndustryOutput_ls[[state]][, "Output"])
    names(TwoRegionIndustryOutput) <- c(getBEASectorCodeLocation("Industry", state, iolevel),
                                        getBEASectorCodeLocation("Industry", "RoUS", iolevel))
    TwoRegionIO[["IndustryOutput"]][[state]] <- TwoRegionIndustryOutput
    
    ## Two-region International Trade Adjustment
    SoI_ITA <- State_Use_ls[[state]][commodities, ITA_col]
    names(SoI_ITA) <- getBEASectorCodeLocation("Commodity", state, iolevel)
    RoUS_ITA <- Reduce("+", State_Use_ls)[commodities, ITA_col] - SoI_ITA
    names(RoUS_ITA) <- getBEASectorCodeLocation("Commodity", "RoUS", iolevel)
    TwoRegionIO[["InternationalTradeAdjustment"]][[state]] <- c(SoI_ITA, RoUS_ITA)
    
    print(state)
  }
  return(TwoRegionIO)
}

#' Build a full two-region IO table for specified state and rest of US for a given year.
#' @description Build a full two-region IO table for specified state and rest of US for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A full two-region IO table for specified state and rest of US for a given year.
#' @export
buildFullTwoRegionIOTable <- function(state, year, ioschema, iolevel) {
  startLogging()
  # Define industries, commodities, final demand columns, and non-import columns
  industries <- getVectorOfCodes(iolevel, "Industry")
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  FD_cols <- getFinalDemandCodes(iolevel)
  import_col <- getVectorOfCodes(iolevel, "Import")
  nonimport_cols <- c(industries, FD_cols[-which(FD_cols %in% import_col)])
  
  logging::loginfo("Generating SoI Make table...")
  # SoI Make
  SoI_Make <- loadStateIODataFile(paste0("State_",iolevel,
                                         "_Make_", year))[[state]]
  rownames(SoI_Make) <- paste(state, industries, "Industry", sep = ".")
  colnames(SoI_Make) <- paste(state, commodities, "Commodity", sep = ".")
  # SoI commodity output
  SoI_CommodityOutput <- loadStateIODataFile(paste0("State_",
                                                    iolevel,
                                                    "_CommodityOutput_",
                                                    year))[[state]]
  
  logging::loginfo("Generating RoUS Make table...")
  # RoUS Make
  US_Make <- getNationalMake(iolevel, year)
  RoUS_Make <- US_Make - SoI_Make
  rownames(RoUS_Make) <- paste("RoUS", industries, "Industry", sep = ".")
  colnames(RoUS_Make) <- paste("RoUS", commodities, "Commodity", sep = ".")
  # RoUS domestic Use
  SoI_DomesticUse <- loadStateIODataFile(paste0("State_", iolevel,
                                                "_DomesticUse_", year))[[state]]
  US_DomesticUse <- generateUSDomesticUse(iolevel, year)
  RoUS_DomesticUse <- US_DomesticUse - SoI_DomesticUse[commodities, ]
  # RoUS commodity output
  US_CommodityOutput <- colSums(US_Make)
  RoUS_CommodityOutput <- US_CommodityOutput - SoI_CommodityOutput
  colnames(RoUS_CommodityOutput) <- "Output"
  # Adjust RoUS_CommodityOutput
  MakeUseDiff <- US_CommodityOutput - rowSums(US_DomesticUse[, nonimport_cols])
  RoUS_CommodityOutput$Output <- RoUS_CommodityOutput$Output - MakeUseDiff
  
  logging::loginfo("Generating two-region Domestic Use tables...")
  # Two-region Use table
  TwoRegionUseModel <- buildTwoRegionUseModel(state, year, ioschema, iolevel)
  TwoRegionUse <- cbind(rbind(TwoRegionUseModel[["SoI2SoI"]][commodities, industries],
                              TwoRegionUseModel[["RoUS2SoI"]][commodities, industries]),
                        rbind(TwoRegionUseModel[["SoI2RoUS"]][commodities, industries],
                              TwoRegionUseModel[["RoUS2RoUS"]][commodities, industries]))
  rownames(TwoRegionUse) <- paste(rep(c(state, "RoUS"), each = length(commodities)),
                                  commodities, rep("Commodity", each = length(commodities)),
                                  sep = ".")
  colnames(TwoRegionUse) <- paste(rep(c(state, "RoUS"), each = length(industries)),
                                  industries, rep("Industry", each = length(industries)),
                                  sep = ".")
  
  logging::loginfo("Generating two-region final demand tables...")
  # Final demand
  FD_columns <- getFinalDemandCodes(iolevel)
  TwoRegionFinalDemand <- cbind(rbind(TwoRegionUseModel[["SoI2SoI"]][commodities, FD_columns],
                                      TwoRegionUseModel[["RoUS2SoI"]][commodities, FD_columns]),
                                rbind(TwoRegionUseModel[["SoI2RoUS"]][commodities, FD_columns],
                                      TwoRegionUseModel[["RoUS2RoUS"]][commodities, FD_columns]))
  rownames(TwoRegionFinalDemand) <- rownames(TwoRegionUse)
  colnames(TwoRegionFinalDemand) <- paste(rep(c(state, "RoUS"), each = length(FD_columns)),
                                          FD_columns, sep = ".")
  
  logging::loginfo("Calculating SoI and RoUS international imports by industry...")
  # International imports by industry
  SoI_Use <- loadStateIODataFile(paste0("State_", iolevel, "_Use_", year))[[state]][commodities, ]
  US_Use <- getNationalUse(iolevel, year)
  US_Import <- loadDatafromUSEEIOR(paste(iolevel, "Import", year, "BeforeRedef", sep = "_"))*1E6
  US_ImportRatios <- US_Import[rownames(US_Use), colnames(US_Use)]/US_Use
  US_ImportRatios[is.na(US_ImportRatios)] <- 0
  RoUS_Use <- US_Use - SoI_Use
  IntlImports <- as.data.frame(t(c(colSums(SoI_Use * US_ImportRatios),
                                   colSums(RoUS_Use * US_ImportRatios))))
  colnames(IntlImports) <- paste0(paste(rep(c(state, "RoUS"), each = ncol(IntlImports)/2),
                                        colnames(IntlImports),
                                        sep = "."),
                                  rep(c(rep(".Industry", each = length(industries)),
                                        rep("", each = length(FD_columns))), 2))
  
  logging::loginfo("Calculating SoI and RoUS gross value added by industry...")
  # GVA
  GVA_rows <- getVectorOfCodes(iolevel, "ValueAdded")
  SoI_GVA <- loadStateIODataFile(paste0("State_", iolevel, "_Use_", year))[[state]][GVA_rows, ]
  RoUS_GVA <- Reduce("+", loadStateIODataFile(paste0("State_", iolevel, "_Use_", year)))[GVA_rows, ] - SoI_GVA
  TwoRegionGVA <- cbind(SoI_GVA, RoUS_GVA)
  colnames(TwoRegionGVA) <- colnames(InternationalImports)
  
  logging::loginfo("Calculating SoI and RoUS international transport margins by industry...")
  # International Transport Margins
  IntlTransportMarginsRatio <- calculateUSInternationalTransportMarginsRatioMatrix(iolevel, year)
  IntlTransportMargins <- as.data.frame(t(c(colSums(SoI_Use * IntlTransportMarginsRatio),
                                            colSums(RoUS_Use * IntlTransportMarginsRatio))))
  colnames(IntlTransportMargins) <- paste0(paste(rep(c(state, "RoUS"), each = ncol(IntlTransportMargins)/2),
                                                 colnames(IntlTransportMargins),
                                                 sep = "."),
                                           rep(c(rep(".Industry", each = length(industries)),
                                                 rep("", each = length(FD_columns))), 2))
  
  logging::loginfo("Assembling full two-region make and use table...")
  # Start with SoI_Make
  FullTwoRegionTable <- SoI_Make
  # Append RoUS_Make
  FullTwoRegionTable[rownames(RoUS_Make), colnames(RoUS_Make)] <- RoUS_Make
  # Append TwoRegionUse
  FullTwoRegionTable[rownames(TwoRegionUse), colnames(TwoRegionUse)] <- TwoRegionUse
  # Append TwoRegionFinalDemand
  FullTwoRegionTable[rownames(TwoRegionUse), colnames(TwoRegionFinalDemand)] <- TwoRegionFinalDemand
  # Adjust row and column order
  FullTwoRegionTable <- FullTwoRegionTable[c(rownames(TwoRegionUse),
                                             rownames(SoI_Make), rownames(RoUS_Make)),
                                           c(colnames(SoI_Make),colnames(RoUS_Make),
                                             colnames(TwoRegionUse), colnames(TwoRegionFinalDemand))]
  
  # Append final demand table
  FullTwoRegionTable[1:nrow(TwoRegionFinalDemand), colnames(TwoRegionFinalDemand)] <- TwoRegionFinalDemand
  # Append international imports
  FullTwoRegionTable["InternationalImports", colnames(InternationalImports)] <- InternationalImports
  # Append total intermediate consumption
  FullTwoRegionTable["TotalIntermediateConsumption", colnames(TwoRegionUse)] <- colSums(FullTwoRegionTable[, colnames(TwoRegionUse)])
  # Append gross value added
  FullTwoRegionTable[GVA_rows, colnames(TwoRegionGVA)] <- TwoRegionGVA
  # Append value added at basic price or Gross Value Added
  FullTwoRegionTable["GrossValueAdded", colnames(TwoRegionGVA)] <- colSums(FullTwoRegionTable[GVA_rows, colnames(TwoRegionGVA)])
  # Append direct purchases abroad by residents
  # TBD
  # Append purchases on the domestic territory by non-residents
  # TBD
  # Append international transportation margins
  FullTwoRegionTable["InternationalTransportMargins", colnames(InternationalTransportMargins)] <- InternationalTransportMargins
  
  return(FullTwoRegionTable)
}
