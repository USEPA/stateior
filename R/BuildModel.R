#' Build a state supply model for all 52 states/regions (including DC and Overseas)
#' for a given year
#' @description Build a state supply model for all 52 states/regions
#' (including DC and Overseas) for a given year.
#' @param year A numeric value between 2007 and 2017.
#' @return A list of state supply model components: Make, commodity and industry output.
#' @export
buildStateSupplyModel <- function(year) {
  logging::loginfo("Loading RAS-balanced state-to-US value added (VA) ratios ...")
  StateUS_VA_Ratio <- get(paste0("StateUS_VA_Ratio_", year),
                          as.environment("package:stateior"))
  states <- unique(StateUS_VA_Ratio$GeoName)
  
  logging::loginfo("Estimating state Make table and commodity output ...")
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
    VA_ratio <- StateUS_VA_Ratio[StateUS_VA_Ratio$GeoName==state, ]
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
  
  logging::loginfo("Loading state commodity output ratios from alternative data ...")
  AlternativeStateCOR <- get(paste0("AlternativeStateCommodityOutputRatio_", year),
                             as.environment("package:stateior"))
  
  logging::loginfo("Adjusting state Make table ...")
  # Adjust estimated state commodity output and calculate state commodity adjustment ratio
  # Based on reported state commodity output from alternative sources.
  for (state in states) {
    # Adjust estimated state commodity output
    # Calculate state/US commodity output ratio * US Summary Comm Output
    AdjustedStateCommOutput <- merge(US_CommodityOutput,
                                     AlternativeStateCOR[AlternativeStateCOR$State==state, ],
                                     by.x = 0, by.y = "BEA_2012_Summary_Code")
    AdjustedStateCommOutput$Output <- AdjustedStateCommOutput$x*AdjustedStateCommOutput$Ratio
    # Replace commodity output value in State_CommodityOutput_ls
    commodities <- AdjustedStateCommOutput$Row.names
    output <- AdjustedStateCommOutput[AdjustedStateCommOutput$Row.names%in%commodities, "Output"]
    State_CommodityOutput_ls[[state]][commodities, ] <- output
    
    # Calculate state commodity adjustment ratio
    # Divide current state commodity output ratio by alternative state COR.
    # Merge two sets of state-US commodity output ratio
    COR_df <- merge(State_CommodityOutputRatio_ls[[state]],
                    AlternativeStateCOR[AlternativeStateCOR$State==state, ],
                    by.x = 0, by.y = "BEA_2012_Summary_Code", all.x = TRUE)
    # Replace NA in Ratio with values in OutputRatio
    COR_df[is.na(COR_df$Ratio), "Ratio"] <- COR_df[is.na(COR_df$Ratio), "OutputRatio"]
    rownames(COR_df) <- COR_df$Row.names
    COR_df <- COR_df[colnames(State_Make_ls[[state]]), ]
    # Adjust state Make based on adjusted commodity ratios
    CORAdjustmentRatio <- COR_df$Ratio/COR_df$OutputRatio
    AdjustedStateMake <- State_Make_ls[[state]]%*%diag(CORAdjustmentRatio)
    colnames(AdjustedStateMake) <- rownames(COR_df)
    State_Make_ls[[state]] <- AdjustedStateMake
  }
  
  logging::loginfo("Preparing state Make table for RAS balancing ...")
  # Vertically stack all state Make trascation tables.
  State_Make <- do.call(rbind, State_Make_ls)
  rownames(State_Make) <- paste(rep(names(State_Make_ls),
                                    each = nrow(State_Make_ls[[1]])),
                                rep(rownames(State_Make_ls[[1]]),
                                    time = length(names(State_Make_ls))),
                                sep = ".")
  colnames(State_Make) <- colnames(US_Make)
  
  logging::loginfo("Performing RAS balancing on state Make table ...")
  # Separate the state Make trascation table by industry (row) into 71 matrices.
  # Each matrix, m0, has dimensions of 52x73 (states x commodities)
  # Apply RAS till m0 is balanced subject to t_r and t_c and becomes m1.
  m1_ls <- list()
  for (industry in rownames(US_Make)) {
    m0 <- State_Make[gsub(".*\\.", "", rownames(State_Make))==industry, ]
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
  
  logging::loginfo("Finalizing state Make table, industry and commodity output...")
  model <- list()
  for (state in states) {
    Make <- State_Make_balanced[gsub("\\..*", "",
                                     rownames(State_Make_balanced))==state, ]
    model[["Make"]][[state]] <- Make
    State_IndustryOutput_ls[[state]] <- as.data.frame(rowSums(Make))
    colnames(State_IndustryOutput_ls[[state]]) <- "Output"
    State_CommodityOutput_ls[[state]] <- as.data.frame(colSums(Make))
    colnames(State_CommodityOutput_ls[[state]]) <- "Output"
  }
  model[["IndustryOutput"]] <- State_IndustryOutput_ls
  model[["CommodityOutput"]] <- State_CommodityOutput_ls
  
  logging::loginfo("Model build complete.")
  return(model)
}

#' Build a state demand model for all 52 states/regions
#' (including DC and Overseas) for a given year
#' @description Build a state demand model for all 52 states/regions
#' (including DC and Overseas) for a given year.
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
  State_IndustryOutput_ls <- get(paste0("State_IndustryOutput_", year),
                                 as.environment("package:stateior"))
  states <- names(State_IndustryOutput_ls)
  # US industry output
  US_Make <- getNationalMake("Summary", year)
  US_IndustryOutput <- rowSums(US_Make)
  
  logging::loginfo("Loading US Use table ...")
  # Load US Summary Use table for given year
  US_Use <- getNationalUse("Summary", year)
  # Generate US Summary Use Transaction
  US_Use_Intermediate <- US_Use[commodities, industries]
  
  logging::loginfo("Calculating state-to-US industry output ratios ...")
  logging::loginfo("Estimating state intermediate consumption ...")
  # For each state and industry, calculate state_US_IndustryOutput_ratio
  # Multiply US_Use_Intermediate by state_US_IndustryOutput_ratio 
  State_Use_Intermediate_ls <- list()
  for (state in states) {
    IOR <- State_IndustryOutput_ls[[state]][, 1]/US_IndustryOutput
    State_Use_Intermediate <- as.matrix(US_Use_Intermediate) %*% diag(IOR)
    colnames(State_Use_Intermediate) <- colnames(US_Use_Intermediate)
    State_Use_Intermediate_ls[[state]] <- State_Use_Intermediate
  }
  
  logging::loginfo("Estimating state personal consumption expenditure ...")
  # Apply RAS to PCE
  State_PCE <- estimateStateHouseholdDemand(year)
  State_PCE[, "BEA_2012_Summary_Code"] <- gsub(".*\\.", "", rownames(State_PCE))
  State_PCE[, "State"] <- gsub("\\..*", "", rownames(State_PCE))
  State_PCE <- reshape2::dcast(State_PCE, BEA_2012_Summary_Code ~ State,
                               value.var = "F010")
  rownames(State_PCE) <- State_PCE$BEA_2012_Summary_Code
  # Set m0, t_r and t_c
  m0 <- as.matrix(State_PCE[rownames(US_Use_Intermediate), -1])
  t_r <- US_Use[rownames(US_Use_Intermediate), "F010"]
  t_c <- as.numeric(calculateStateTotalPCE(year)[colnames(m0), ])
  # Apply RAS, RAS converged after 1000001 iterations.
  State_PCE_balanced <- as.data.frame(applyRAS(m0, t_r, t_c, relative_diff = NULL,
                                               absolute_diff = 10, max_itr = 1E6))
  colnames(State_PCE_balanced) <- colnames(m0)
  # Convert State_PCE_balanced from a commodity x state matrix to a long df
  State_PCE_balanced$BEA_2012_Summary_Code <- rownames(State_PCE_balanced)
  State_PCE_balanced <- reshape2::melt(State_PCE_balanced,
                                       id.vars = "BEA_2012_Summary_Code")
  rownames(State_PCE_balanced) <- paste(State_PCE_balanced$variable,
                                        State_PCE_balanced$BEA_2012_Summary_Code,
                                        sep = ".")
  State_PCE_balanced <- State_PCE_balanced[, "value", drop = FALSE]
  colnames(State_PCE_balanced) <- "F010"
  
  logging::loginfo("Estimating state final demand ...")
  # Assemble final demand columns
  # Create a temporary State_Import as placeholder
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
  DomesticUse_ratios <- calculateUSDomesticUseRatioMatrix("Summary", year)
  logging::loginfo("Appending value added to state Use tables ...")
  StateGVA <- get(paste0("State_GrossValueAdded_", year),
                  as.environment("package:stateior"))
  model <- list()
  for (state in states) {
    # Assemble state Use table
    State_Use <- cbind(State_Use_Intermediate_ls[[state]],
                       StateFinalDemand[gsub("\\..*", "",
                                             rownames(StateFinalDemand))==state,
                                        FinalDemand_columns])
    # Calculate state domestic Use table
    State_DomesticUse <- State_Use*DomesticUse_ratios
    # Update Import in state Use table
    State_Use$F050 <- rowSums(State_DomesticUse) - rowSums(State_Use)
    # Append value added rows to state Use tables
    GVA <- StateGVA[gsub("\\..*", "", rownames(StateGVA))==state, ]
    rownames(GVA) <- gsub(".*\\.", "", rownames(GVA))
    State_Use[rownames(GVA), industries] <- GVA
    State_DomesticUse[rownames(GVA), industries] <- GVA
    # Replace NA with zero
    State_Use[is.na(State_Use)] <- 0
    State_DomesticUse[is.na(State_DomesticUse)] <- 0
    # Add to model
    model[["Use"]][[state]] <- State_Use
    model[["DomesticUse"]][[state]] <- State_DomesticUse
  }
  
  logging::loginfo("Model build complete.")
  return(model)
}

#' Build a two-region demand model
#' @description Generate two-region (SoI and RoUS) demand tables
#' with interregional exports and imports.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A list of domestic two-region demand tables.
#' @export
buildTwoRegionDemandModel <- function(state, year, ioschema, iolevel) {
  # 0 - Define commodities and desired columns
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  FD_cols <- getFinalDemandCodes(iolevel)
  # All tradable sectors
  tradable_cols <- c(unlist(sapply(list("Industry", "HouseholdDemand"),
                                   getVectorOfCodes, iolevel = iolevel)),
                     FD_cols[substr(FD_cols, nchar(FD_cols),
                                    nchar(FD_cols))%in%c("C", "E")])
  # All sectors except international imports
  import_col <- getVectorOfCodes(iolevel, "Import")
  nonimport_cols <- c(getVectorOfCodes(iolevel, "Industry"),
                      FD_cols[-which(FD_cols%in%import_col)])
  
  # 1 - Load state domestic Use for the specified year
  logging::loginfo("Loading state Domestic Use table ...")
  SoI_DomesticUse <- get(paste0("State_", iolevel, "_DomesticUse_", year),
                         as.environment("package:stateior"))[[state]][commodities, ]
  
  # 2 - Generate 2-region ICFs
  logging::loginfo("Generating two-region interregional commodity flow (ICF) ratios ...")
  ICF <- get(paste0("TwoRegion_", iolevel, "_ICF_Ratios_", year),
             as.environment("package:stateior"))[[state]]
  # Only allocate "error" to rows (commodities) that does not have ICF of 1 or 0
  commodities_notrade <- ICF[ICF$SoI2SoI==1&ICF$SoI2RoUS==0 &
                               ICF$RoUS2RoUS==1&ICF$RoUS2SoI==0, 1]
  rows_allocation <- commodities[-which(commodities%in%commodities_notrade)]
     
  # 3 - Generate SoI2SoI domestic Use
  logging::loginfo("Generating SoI2SoI Use table ...")
  SoI2SoI_Use <- SoI_DomesticUse
  SoI2SoI_Use[, tradable_cols] <- SoI_DomesticUse[, tradable_cols] * ICF$SoI2SoI
  # Load state commodity output
  logging::loginfo("Loading state commodity output ...")
  SoI_CommodityOutput <- get(paste0("State_", iolevel, "_CommodityOutput_", year),
                              as.environment("package:stateior"))[[state]]
  # Calculate Interregional Imports, Exports, and Net Exports
  logging::loginfo("Calculating SoI2SoI interregional imports and exports and net exports ...")
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_DomesticUse[, tradable_cols]) - rowSums(SoI2SoI_Use[, tradable_cols])
  SoI2SoI_Use$InterregionalExports <- SoI_CommodityOutput$Output - rowSums(SoI2SoI_Use[, nonimport_cols])
  
  # 4 - Generate RoUS domestic Use and commodity output
  # Generate RoUS domestic Use
  logging::loginfo("Generating RoUS Domestic Use table ...")
  US_DomesticUse <- estimateUSDomesticUse(iolevel, year)
  RoUS_DomesticUse <- US_DomesticUse - SoI_DomesticUse
  # Calculate RoUS Commodity Output
  logging::loginfo("Generating RoUS commodity output ...")
  US_Make <- getNationalMake(iolevel, year)
  US_CommodityOutput <- colSums(US_Make)
  RoUS_CommodityOutput <- US_CommodityOutput - SoI_CommodityOutput
  colnames(RoUS_CommodityOutput) <- "Output"
  # Adjust RoUS_CommodityOutput
  MakeUseDiff <- US_CommodityOutput - rowSums(US_DomesticUse[, nonimport_cols])
  RoUS_CommodityOutput$Output <- RoUS_CommodityOutput$Output - MakeUseDiff
  
  # 5 - Generate RoUS2RoUS domestic Use
  logging::loginfo("Generating RoUS2RoUS Use table ...")
  RoUS2RoUS_Use <- RoUS_DomesticUse
  RoUS2RoUS_Use[, tradable_cols] <- RoUS_DomesticUse[, tradable_cols] * ICF$RoUS2RoUS
  # Calculate Interregional Imports, Exports, and Net Exports
  logging::loginfo("Calculating RoUS2RoUS interregional imports and exports and net exports ...")
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_DomesticUse[, tradable_cols]) - rowSums(RoUS2RoUS_Use[, tradable_cols])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_CommodityOutput$Output - rowSums(RoUS2RoUS_Use[, nonimport_cols])
  
  # 6 - Allocate negative InterregionalExports across columns in SoI2SoI Use and RoUS2RoUS Use
  logging::loginfo("Allocating negative interregional exports in SoI2SoI Use and RoUS2RoUS Use ...")
  for (i in rows_allocation) {
    # SoI2SoI
    if (SoI2SoI_Use[i, "InterregionalExports"]<0) {
      value <- SoI2SoI_Use[i, "InterregionalExports"]
      weight <- SoI2SoI_Use[i, tradable_cols]
      SoI2SoI_Use[i, tradable_cols] <- weight + value*(weight/sum(weight))
    }
    # RoUS2RoUS
    if (RoUS2RoUS_Use[i, "InterregionalExports"]<0) {
      value <- RoUS2RoUS_Use[i, "InterregionalExports"]
      weight <- RoUS2RoUS_Use[i, tradable_cols]
      RoUS2RoUS_Use[i, tradable_cols] <- weight + value*(weight/sum(weight))
    }
  }
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_DomesticUse[, tradable_cols]) - rowSums(SoI2SoI_Use[, tradable_cols])
  SoI2SoI_Use$InterregionalExports <- SoI_CommodityOutput$Output - rowSums(SoI2SoI_Use[, nonimport_cols])
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_DomesticUse[, tradable_cols]) - rowSums(RoUS2RoUS_Use[, tradable_cols])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_CommodityOutput$Output - rowSums(RoUS2RoUS_Use[, nonimport_cols])
  
  # 7 - Calculate errors for SoI and RoUS
  logging::loginfo("Allocating difference between interregional imports and exports in SoI2SoI Use and RoUS2RoUS Use ...")
  error <- SoI2SoI_Use$InterregionalImports - RoUS2RoUS_Use$InterregionalExports
  SoIerror <- error*(SoI_CommodityOutput$Output/US_CommodityOutput)
  RoUSerror <- error - SoIerror
  SoIerror_1 <- SoIerror_2 <- SoIerror
  names(error) <- names(SoIerror_1)
  
  # 8 - Allocate the errors across columns in SoI2SoI Use and RoUS2RoUS Use
  for (i in rows_allocation) {
    SoIweight <- SoI2SoI_Use[i, tradable_cols]
    RoUSweight <- RoUS2RoUS_Use[i, tradable_cols]
    SoIerror_1[i] <- ifelse(abs(SoIerror[i])<sum(SoIweight), SoIerror[i],
                            ifelse(SoIerror[i]<0, sum(SoIweight)*-1, sum(SoIweight)))
    SoIerror_2[i] <- ifelse(SoIerror_1[i]!=SoIerror[i], SoIerror_1[i]/2, SoIerror[i])
    RoUSerror[i] <- error[i] - SoIerror_2[i]
    # If sum of SoI and RoUS weight != 0, allocate the error to each cell
    if (sum(SoIweight)!=0) {
      SoI2SoI_Use[i, tradable_cols] <- SoIweight + SoIerror_2[i]*(SoIweight/sum(SoIweight))
    }
    if (sum(RoUSweight)!=0) {
      RoUS2RoUS_Use[i, tradable_cols] <- RoUSweight - RoUSerror[i]*(RoUSweight/sum(RoUSweight))
    }
  }
  
  # 9 - Re-calculate InterregionalImports, InterregionalExports and NetExports
  logging::loginfo("Adjusting interregional imports and exports and net exports in SoI2SoI and RoUS2RoUS ...")
  # SoI2SoI
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_DomesticUse[, tradable_cols]) - rowSums(SoI2SoI_Use[, tradable_cols])
  SoI2SoI_Use$InterregionalExports <- SoI_CommodityOutput$Output - rowSums(SoI2SoI_Use[, nonimport_cols])
  SoI2SoI_Use$NetExports <- SoI2SoI_Use$InterregionalExports - SoI2SoI_Use$InterregionalImports
  # RoUS2RoUS
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_DomesticUse[, tradable_cols]) - rowSums(RoUS2RoUS_Use[, tradable_cols])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_CommodityOutput$Output - rowSums(RoUS2RoUS_Use[, nonimport_cols])
  RoUS2RoUS_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports
 
  # 10 - Generate SoI2RoUS and RoUS2SoI Use
  logging::loginfo("Generating SoI2RoUS and RoUS2SoI Use ...")
  # SoI2RoUS
  SoI2RoUS_Use <- RoUS_DomesticUse - RoUS2RoUS_Use[rownames(RoUS_DomesticUse), colnames(RoUS_DomesticUse)]
  SoI2RoUS_Use$InterregionalImports <- rowSums(RoUS_DomesticUse[, tradable_cols]) - rowSums(SoI2RoUS_Use[, tradable_cols])
  SoI2RoUS_Use$InterregionalExports <- RoUS_CommodityOutput$Output - rowSums(SoI2RoUS_Use[, nonimport_cols])
  SoI2RoUS_Use$NetExports <- SoI2RoUS_Use$InterregionalExports - SoI2RoUS_Use$InterregionalImports
  # RoUS2SoI
  RoUS2SoI_Use <- SoI_DomesticUse - SoI2SoI_Use[rownames(SoI_DomesticUse), colnames(SoI_DomesticUse)]
  RoUS2SoI_Use$InterregionalImports <- rowSums(SoI_DomesticUse[, tradable_cols]) - rowSums(RoUS2SoI_Use[, tradable_cols])
  RoUS2SoI_Use$InterregionalExports <- SoI_CommodityOutput$Output - rowSums(RoUS2SoI_Use[, nonimport_cols])
  RoUS2SoI_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2SoI_Use$InterregionalImports
  
  # 11 - For commodities that have SoI2SoI ICF ratio == 1,
  # replace InterregionalExports and NetExports with 0
  # and assign the values to ExportResidual
  logging::loginfo("Replace interregional exports of non-traded commodities with 0 ...")
  # SoI2SoI
  SoI2SoI_Use[commodities_notrade, "ExportResidual"] <- SoI2SoI_Use[commodities_notrade, "InterregionalExports"]
  SoI2SoI_Use[commodities_notrade, c("InterregionalExports", "NetExports")] <- 0
  SoI2SoI_Use[is.na(SoI2SoI_Use$ExportResidual), "ExportResidual"] <- 0
  # RoUS2RoUS
  RoUS2RoUS_Use[commodities_notrade, "ExportResidual"] <- RoUS2RoUS_Use[commodities_notrade, "InterregionalExports"]
  RoUS2RoUS_Use[commodities_notrade, c("InterregionalExports", "NetExports")] <- 0
  RoUS2RoUS_Use[is.na(RoUS2RoUS_Use$ExportResidual), "ExportResidual"] <- 0
  
  # 12 - Create validation
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
  
  # 13 - Assemble SoI2SoI Use, RoUS2RoUS Use
  Domestic2RegionUse <- list("SoI2SoI"    = SoI2SoI_Use,
                             "SoI2RoUS"   = SoI2RoUS_Use,
                             "RoUS2SoI"   = RoUS2SoI_Use,
                             "RoUS2RoUS"  = RoUS2RoUS_Use,
                             "Validation" = validation)
  logging::loginfo("Domestic two-region Use complete ...")
  return(Domestic2RegionUse)
}

#' Assemble two-region make, use, domestic use, and demand tables as well as commodity and industry outputs.
#' @description Assemble two-region make and use tables as well as commodity and industry outputs.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A list of two-region make, use, domestic use, and demand tables
#' as well as commodity and industry outputs by state.
#' @export
assembleTwoRegionIO <- function(year, iolevel) {
  # Define industries, commodities, valueadded and finaldemand
  industries <- getVectorOfCodes(iolevel, "Industry")
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  VA_rows <- getVectorOfCodes(iolevel, "ValueAdded")
  FD_cols <- getFinalDemandCodes(iolevel)
  # Load US Make table
  US_Make <- getNationalMake(iolevel, year)
  US_DomesticUse <- estimateUSDomesticUse(iolevel, year)
  # Load state Make, industry and commodity output
  State_Make_ls <- get(paste0("State_", iolevel, "_Make_", year),
                       as.environment("package:stateior"))
  State_Use_ls <- get(paste0("State_", iolevel, "_Use_", year),
                      as.environment("package:stateior"))
  State_DomesticUse_ls <- get(paste0("State_", iolevel, "_DomesticUse_", year),
                              as.environment("package:stateior"))
  State_IndustryOutput_ls <- get(paste0("State_", iolevel, "_IndustryOutput_", year),
                                 as.environment("package:stateior"))
  State_CommodityOutput_ls <- get(paste0("State_", iolevel, "_CommodityOutput_", year),
                                  as.environment("package:stateior"))
  # Assemble two-region IO tables
  TwoRegionIO <- list()
  for (state in sort(c(state.name, "District of Columbia"))) {
    state_abb <- getStateAbbreviation(state)
    # Two-region Make
    SoI_Make <- State_Make_ls[[state]]
    rownames(SoI_Make) <- apply(cbind(industries, paste0("US-", state_abb)), 1,
                                FUN = joinStringswithSlashes)
    colnames(SoI_Make) <- apply(cbind(commodities, paste0("US-", state_abb)), 1,
                                FUN = joinStringswithSlashes)
    RoUS_Make <- US_Make - SoI_Make
    rownames(RoUS_Make) <- apply(cbind(industries, "RoUS"), 1,
                                 FUN = joinStringswithSlashes)
    colnames(RoUS_Make) <- apply(cbind(commodities, "RoUS"), 1,
                                 FUN = joinStringswithSlashes)
    TwoRegionMake <- SoI_Make
    TwoRegionMake[rownames(RoUS_Make), colnames(RoUS_Make)] <- RoUS_Make
    TwoRegionIO[["Make"]][[state]] <- TwoRegionMake
    
    # Two-region Use
    SoI_Use <- State_Use_ls[[state]]
    rownames(SoI_Use) <- apply(cbind(c(commodities, VA_rows),
                                     paste0("US-", state_abb)),
                               1, FUN = joinStringswithSlashes)
    colnames(SoI_Use) <- apply(cbind(c(industries, FD_cols),
                                     paste0("US-", state_abb)),
                               1, FUN = joinStringswithSlashes)
    RoUS_Use <- Reduce("+", State_Use_ls) - SoI_Use
    rownames(RoUS_Use) <- apply(cbind(c(commodities, VA_rows), "RoUS"), 1,
                                FUN = joinStringswithSlashes)
    colnames(RoUS_Use) <- apply(cbind(c(industries, FD_cols), "RoUS"), 1,
                                FUN = joinStringswithSlashes)
    TwoRegionUse <- SoI_Use
    TwoRegionUse[rownames(RoUS_Use), colnames(RoUS_Use)] <- RoUS_Use
    TwoRegionIO[["Use"]][[state]] <- TwoRegionUse
    
    # Two-region DomesticUse
    SoI_DomesticUse <- State_DomesticUse_ls[[state]]
    rownames(SoI_DomesticUse) <- apply(cbind(c(commodities, VA_rows),
                                             paste0("US-", state_abb)),
                                       1, FUN = joinStringswithSlashes)
    colnames(SoI_DomesticUse) <- apply(cbind(c(industries, FD_cols),
                                             paste0("US-", state_abb)),
                                       1, FUN = joinStringswithSlashes)
    RoUS_DomesticUse <- Reduce("+", State_DomesticUse_ls) - SoI_DomesticUse
    rownames(RoUS_DomesticUse) <- apply(cbind(c(commodities, VA_rows), "RoUS"),
                                        1, FUN = joinStringswithSlashes)
    colnames(RoUS_DomesticUse) <- apply(cbind(c(industries, FD_cols), "RoUS"),
                                        1, FUN = joinStringswithSlashes)
    TwoRegionDomesticUse <- SoI_DomesticUse
    TwoRegionDomesticUse[rownames(RoUS_DomesticUse), colnames(RoUS_DomesticUse)] <- RoUS_DomesticUse
    TwoRegionIO[["DomesticUse"]][[state]] <- TwoRegionDomesticUse
    
    # Two-region Demand table
    TwoRegionDemandModel <- buildTwoRegionDemandModel(state, year, ioschema = 2012, iolevel = iolevel)
    TwoRegionDemand <- cbind(rbind(TwoRegionDemandModel[["SoI2SoI"]][commodities, c(industries, FD_cols)],
                                   TwoRegionDemandModel[["RoUS2SoI"]][commodities, c(industries, FD_cols)]),
                             rbind(TwoRegionDemandModel[["SoI2RoUS"]][commodities, c(industries, FD_cols)],
                                   TwoRegionDemandModel[["RoUS2RoUS"]][commodities, c(industries, FD_cols)]))
    rownames(TwoRegionDemand) <- apply(cbind(commodities,
                                             rep(c(paste0("US-", state_abb), "RoUS"),
                                                 each = length(commodities))),
                                       1, FUN = joinStringswithSlashes)
    colnames(TwoRegionDemand) <- apply(cbind(c(industries, FD_cols),
                                             rep(c(paste0("US-", state_abb), "RoUS"),
                                                 each = length(c(industries, FD_cols)))),
                                       1, FUN = joinStringswithSlashes)
    TwoRegionIO[["Demand"]][[state]] <- TwoRegionDemand
    
    # Two-region Demand table with exports and imports
    TwoRegionIO[["CompleteDemand"]][[state]] <- TwoRegionDemandModel[1:4]
    
    # Two-region Industry Output
    TwoRegionIndustryOutput <- cbind(State_IndustryOutput_ls[[state]],
                                     rowSums(US_Make) - State_IndustryOutput_ls[[state]])
    rownames(TwoRegionIndustryOutput) <- gsub(".*\\.", "", rownames(TwoRegionIndustryOutput))
    colnames(TwoRegionIndustryOutput) <- c(paste0("US-", state_abb), "RoUS")
    TwoRegionIO[["IndustryOutput"]][[state]] <- TwoRegionIndustryOutput
    
    # Two-region Commodity Output
    SoI_CommodityOutput <- State_CommodityOutput_ls[[state]]
    RoUS_CommodityOutput <- colSums(US_Make) - SoI_CommodityOutput
    columns <- colnames(US_DomesticUse)[!colnames(US_DomesticUse)%in%c("F040", "F050")]
    MakeUseDiff <- colSums(US_Make) - rowSums(US_DomesticUse[, c(columns, "F040")])
    RoUS_CommodityOutput$Output <- RoUS_CommodityOutput$Output - MakeUseDiff
    TwoRegionCommodityOutput <- cbind(SoI_CommodityOutput, RoUS_CommodityOutput)
    rownames(TwoRegionCommodityOutput) <- rownames(TwoRegionCommodityOutput)
    colnames(TwoRegionCommodityOutput) <- c(paste0("US-", state_abb), "RoUS")
    TwoRegionIO[["CommodityOutput"]][[state]] <- TwoRegionCommodityOutput
    print(state)
  }
  return(TwoRegionIO)
}

#' Build a full two-region IO table for specified state and rest of US for a given year.
#' @description Build a full two-region IO table for specified state and rest of US for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A full two-region IO table for specified state and rest of US for a given year.
#' @export
buildFullTwoRegionIOTable <- function(state, year, ioschema, iolevel) {
  # Define industries and commodities
  industries <- getVectorOfCodes(iolevel, "Industry")
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  
  logging::loginfo("Generating SoI Make table ...")
  # SoI Make
  SoI_Make <- get(paste0("State_", iolevel, "_Make_", year),
                  as.environment("package:stateior"))[[state]]
  rownames(SoI_Make) <- paste(state, industries, "Industry", sep = ".")
  colnames(SoI_Make) <- paste(state, commodities, "Commodity", sep = ".")
  # SoI commodity output
  SoI_CommodityOutput <- get(paste0("State_", iolevel, "_CommodityOutput_", year),
                             as.environment("package:stateior"))[[state]]
  
  logging::loginfo("Generating RoUS Make table ...")
  # RoUS Make
  US_Make <- getNationalMake(iolevel, year)
  RoUS_Make <- US_Make - SoI_Make
  rownames(RoUS_Make) <- paste("RoUS", industries, "Industry", sep = ".")
  colnames(RoUS_Make) <- paste("RoUS", commodities, "Commodity", sep = ".")
  # RoUS domestic Use
  SoI_DomesticUse <- get(paste0("State_", iolevel, "_DomesticUse_", year),
                         as.environment("package:stateior"))[[state]]
  columns <- colnames(SoI_DomesticUse)[!colnames(SoI_DomesticUse)%in%c("F040", "F050")]
  US_DomesticUse <- estimateUSDomesticUse(iolevel, year)
  RoUS_DomesticUse <- US_DomesticUse - SoI_DomesticUse[commodities, ]
  # RoUS commodity output
  US_CommodityOutput <- colSums(US_Make)
  RoUS_CommodityOutput <- US_CommodityOutput - SoI_CommodityOutput
  colnames(RoUS_CommodityOutput) <- "Output"
  # Adjust RoUS_CommodityOutput
  MakeUseDiff <- US_CommodityOutput - rowSums(US_DomesticUse[, c(columns, "F040")])
  RoUS_CommodityOutput$Output <- RoUS_CommodityOutput$Output - MakeUseDiff
  
  logging::loginfo("Generating two-region Domestic Use tables ...")
  # Two-region Use table
  TwoRegionDemandModel <- buildTwoRegionDemandModel(state, year, ioschema, iolevel)
  TwoRegionUse <- cbind(rbind(TwoRegionDemandModel[["SoI2SoI"]][commodities, industries],
                              TwoRegionDemandModel[["RoUS2SoI"]][commodities, industries]),
                        rbind(TwoRegionDemandModel[["SoI2RoUS"]][commodities, industries],
                              TwoRegionDemandModel[["RoUS2RoUS"]][commodities, industries]))
  rownames(TwoRegionUse) <- paste(rep(c(state, "RoUS"), each = length(commodities)),
                                  commodities, rep("Commodity", each = length(commodities)),
                                  sep = ".")
  colnames(TwoRegionUse) <- paste(rep(c(state, "RoUS"), each = length(industries)),
                                  industries, rep("Industry", each = length(industries)),
                                  sep = ".")
  
  logging::loginfo("Generating two-region final demand tables ...")
  # Final demand
  FD_columns <- getFinalDemandCodes(iolevel)
  TwoRegionFinalDemand <- cbind(rbind(TwoRegionDemandModel[["SoI2SoI"]][commodities, FD_columns],
                                      TwoRegionDemandModel[["RoUS2SoI"]][commodities, FD_columns]),
                                rbind(TwoRegionDemandModel[["SoI2RoUS"]][commodities, FD_columns],
                                      TwoRegionDemandModel[["RoUS2RoUS"]][commodities, FD_columns]))
  rownames(TwoRegionFinalDemand) <- rownames(TwoRegionUse)
  colnames(TwoRegionFinalDemand) <- paste(rep(c(state, "RoUS"), each = length(FD_columns)),
                                          FD_columns, sep = ".")
  
  logging::loginfo("Calculating SoI and RoUS international imports by industry ...")
  # International imports by industry
  SoI_Use <- get(paste0("State_", iolevel, "_Use_", year),
                 as.environment("package:stateior"))[[state]][commodities, ]
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
  
  logging::loginfo("Calculating SoI and RoUS gross value added by industry ...")
  # GVA
  GVA_rows <- getVectorOfCodes(iolevel, "ValueAdded")
  SoI_GVA <- get(paste0("State_", iolevel, "_Use_", year),
                 as.environment("package:stateior"))[[state]][GVA_rows, ]
  RoUS_GVA <- Reduce("+", get(paste0("State_", iolevel, "_Use_", year),
                              as.environment("package:stateior")))[GVA_rows, ] - SoI_GVA
  TwoRegionGVA <- cbind(SoI_GVA, RoUS_GVA)
  colnames(TwoRegionGVA) <- colnames(InternationalImports)
  
  logging::loginfo("Calculating SoI and RoUS international transport margins by industry ...")
  # International Transport Margins
  IntlTransportMarginsRatio <- calculateUSInternationalTransportMarginsRatioMatrix(iolevel, year)
  IntlTransportMargins <- as.data.frame(t(c(colSums(SoI_Use * IntlTransportMarginsRatio),
                                            colSums(RoUS_Use * IntlTransportMarginsRatio))))
  colnames(IntlTransportMargins) <- paste0(paste(rep(c(state, "RoUS"), each = ncol(IntlTransportMargins)/2),
                                                 colnames(IntlTransportMargins),
                                                 sep = "."),
                                           rep(c(rep(".Industry", each = length(industries)),
                                                 rep("", each = length(FD_columns))), 2))
  
  logging::loginfo("Assembling full two-region make and use table ...")
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

