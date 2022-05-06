#' Get US Make table of specified iolevel and year.
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param year A numeric value specifying the year of interest.
#' @return The US make table of specified iolevel and year.
getNationalMake <- function(iolevel, year) {
  # Load pre-saved US Make table
  dataset <- paste(iolevel, "Make", year, "BeforeRedef", sep = "_")
  Make <- loadDatafromUSEEIOR(dataset)*1E6
  # Keep industry and commodity
  Make <- Make[getVectorOfCodes(iolevel, "Industry"),
               getVectorOfCodes(iolevel, "Commodity")]
  return(Make)
}

#' Get industry-level GVA for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state GVA for all states at a specific year.
getStateGVA <- function(year) {
  # Load pre-saved state GVA data
  StateGVA <- loadStateIODataFile(paste0("State_GVA_", year))
  StateGVA <- StateGVA[, c("GeoName", "LineCode", as.character(year))]
  return(StateGVA)
}

#' Map state table to BEA Summary, mark sectors that need allocation
#' @param statetablename Name of pre-saved state table,
#' can be GVA, Tax, Employment Compensation, and GOS.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state value for all states with row names being BEA sector code.
mapStateTabletoBEASummary <- function(statetablename, year) {
  # Load and adjust State tables
  StateTable <- adjustGVAComponent(year, statetablename)
  # Load State GVA to BEA Summary sector-mapping table
  GVAtoBEAmapping <- loadBEAStateDatatoBEASummaryMapping("GVA")
  # Merge state table with BEA Summary sector code and name
  StateTableBEA <- merge(StateTable, GVAtoBEAmapping, by = "LineCode")
  return(StateTableBEA)
}

#' Calculate allocation factors based on state-level data, such as employment
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param allocationweightsource A string specifying the source being used
#' as the weight in the allocation.
#' @return A data frame contains allocation factors
#' for all states with row names being BEA sector code.
calculateStatetoBEASummaryAllocationFactor <- function(year, allocationweightsource) {
  # Define BEA_col and year_col
  BEA_col <- "BEA_2012_Summary_Code"
  year_col <- as.character(year)
  # Load State GVA to BEA Summary sector-mapping table
  GVAtoBEAmapping <- loadBEAStateDatatoBEASummaryMapping("GVA")
  # Determine BEA sectors that need allocation
  allocation_sectors <- GVAtoBEAmapping[duplicated(GVAtoBEAmapping$LineCode) |
                                          duplicated(GVAtoBEAmapping$LineCode,
                                                     fromLast = TRUE), ]
  allocation_codes <- allocation_sectors[, BEA_col]
  # Generate a mapping table only for allocation_codes based on MasterCrosswalk2012
  crosswalk <- useeior::MasterCrosswalk2012[useeior::MasterCrosswalk2012[, BEA_col]%in%allocation_codes, ]
  # Generate allocation_weight df based on pre-saved data
  if (allocationweightsource=="Employment") {
    # Load BEA State Emp to BEA Summary mapping
    EmptoBEAmapping <- loadBEAStateDatatoBEASummaryMapping("Employment")
    sectors <- unique(crosswalk[crosswalk$BEA_2012_Sector_Code%in%c("44RT", "FIRE", "G"), BEA_col])
    EmptoBEAmapping <- EmptoBEAmapping[EmptoBEAmapping[, BEA_col]%in%sectors, ]
    # For real estate (FIRE) and gov (G) sectors, calculate allocation factors using US GVA by industry
    allocation_factors <- merge(EmptoBEAmapping,
                                useeior::Summary_ValueAdded_IO[, year_col, drop = FALSE],
                                by.x = BEA_col, by.y = 0)
    for (linecode in unique(allocation_factors$LineCode)) {
      weight_vector <- allocation_factors[allocation_factors$LineCode==linecode, year_col]
      allocation_factors[allocation_factors$LineCode==linecode, "factor"] <- weight_vector/sum(weight_vector)
    }
    # Load BEA state Emp
    BEAStateEmp <- loadStateIODataFile("State_Employment_2009_2018")[, c("GeoName", "LineCode", year_col)]
    # Map BEA state Emp (from LineCode) to BEA Summary
    BEAStateEmp <- merge(BEAStateEmp[BEAStateEmp$GeoName %in% c(state.name, "District of Columbia"), ],
                         allocation_factors[, c(BEA_col, "LineCode", "factor")],
                         by = "LineCode")
    # Adjust BEA state Emp value based on allocation factor
    BEAStateEmp[, year_col] <- BEAStateEmp[, year_col]*BEAStateEmp$factor
    allocation_weight <- stats::aggregate(BEAStateEmp[, year_col],
                                          by = list(BEAStateEmp$GeoName,
                                                    BEAStateEmp[, BEA_col]),
                                          sum)
    colnames(allocation_weight) <- c("GeoName", BEA_col, "Weight")
  }
  # Add US allocation weight (Summary Gross Output)
  US_GrossOutput <- cbind.data.frame("United States *",
                                     rownames(useeior::Summary_GrossOutput_IO),
                                     useeior::Summary_GrossOutput_IO[, year_col, drop = FALSE])
  colnames(US_GrossOutput) <- colnames(allocation_weight)
  # Calculate allocation factor
  df <- merge(rbind(allocation_weight, US_GrossOutput), allocation_sectors, by = BEA_col)
  for (state in unique(df$GeoName)) {
    for (linecode in unique(df$LineCode)) {
      weight_vector <- df[df$GeoName==state&df$LineCode==linecode, "Weight"]
      factor <- weight_vector/sum(weight_vector)
      df[df$GeoName==state& df$LineCode==linecode, "AllocationFactor"] <- factor
    }
  }
  # Check if allocation factors add up to 1 (±1E-10)
  df_agg <- stats::aggregate(df$AllocationFactor,
                             by = list(df$GeoName, df$LineCode),
                             sum)
  colnames(df_agg) <- c("GeoName", "LineCode", "Value")
  check_condition <- abs(df_agg$Value - 1) > 1E-10
  if (any(check_condition)) {
    geoname <- df_agg[check_condition, "GeoName"]
    linecode <- df_agg[check_condition, "LineCode"]
    logging::logwarn(glue::glue("In {geoname}, allocation factors from {linecode}",
                                "to BEA industries do not add up to 1."))
    stop("Allocation factors do not add up to 1.")
  }
  return(df)
}

#' Allocate state table (GVA, Tax, Employment Compensation, and GOS)
#' to BEA Summary based on specified weight
#' @param statetablename Name of pre-saved state table,
#' can be GVA, Tax, Employment Compensation, and GOS.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param allocationweightsource Source of allocation weight, can be "Employment".
#' @return A data frame contains allocated state value
#' for all states with row names being BEA sector code.
allocateStateTabletoBEASummary <- function(statetablename, year, allocationweightsource) {
  # Define BEA_col and year_col
  BEA_col <- "BEA_2012_Summary_Code"
  year_col <- as.character(year)
  # Generate StateTableBEA
  StateTableBEA <- mapStateTabletoBEASummary(statetablename, year)
  # Generate allocation factor
  allocation_df <- calculateStatetoBEASummaryAllocationFactor(year, allocationweightsource)
  total_before_allocation <- unique(StateTableBEA[StateTableBEA$LineCode %in% allocation_df$LineCode,
                                                   c("GeoName", "LineCode", year_col)])
  # Merge StateTableBEA with allocation_df
  StateTableBEA_allocation <- merge(StateTableBEA, allocation_df,
                                    by = c("LineCode", "GeoName", BEA_col))
  # Modify value in StateTableBEA_allocation
  value <- StateTableBEA_allocation[, year_col]*StateTableBEA_allocation$AllocationFactor
  StateTableBEA_allocation[, year_col] <- value
  # Check if allocated amount add up to total (±1E-3) before proceeding to next step
  check_df <- stats::aggregate(StateTableBEA_allocation[, year_col],
                               by = list(StateTableBEA_allocation$GeoName,
                                         StateTableBEA_allocation$LineCode),
                               sum)
  colnames(check_df) <- c("GeoName", "LineCode", "Value")
  check_df <- merge(check_df, total_before_allocation,
                    by = c("GeoName", "LineCode"))
  check_condition <- abs(check_df$Value - check_df[, year_col]) > 1E-3
  if (any(check_condition)) {
    geoname <- check_df[check_condition, "GeoName"]
    linecode <- check_df[check_condition, "LineCode"]
    logging::logwarn(glue::glue("In {geoname}, allocated amount from {linecode}",
                                "to BEA industries do not add up to the total before allocation."))
    stop("Allocated amount do not add up to the total before allocation.")
  }
  # Append StateTableBEA_allocation to un-allocated StateTableBEA
  StateTableBEA <- rbind(StateTableBEA_allocation[, c("GeoName", BEA_col, year_col)],
                         StateTableBEA[!StateTableBEA$LineCode%in%StateTableBEA_allocation$LineCode,
                                       c("GeoName", BEA_col, year_col)])
  # Sort StateTableBEA
  StateTableBEA <- StateTableBEA[order(StateTableBEA$GeoName, StateTableBEA[, BEA_col]), ]
  # Re-number rownames
  rownames(StateTableBEA) <- NULL
  return(StateTableBEA)
}

#' Calculate state-US GVA (value added) ratios at BEA Summary level.
#' There are two prerequisite steps embedded in thus function.
#' Prerequisite #1: state_GVA is calculated from the SAGDP state GVA data,
#' via getStateGVA(year), which is originally by LineCode then mapped to
#' BEA industries using mapStateTabletoBEASummary("GVA", year).
#' Prerequisite #2: where GVA must be allocated from one LineCode to multiple
#' BEA industries, including sectors of retail, real estate, fed gov non-defense,
#' and state & local gov, allocation factors are calculated using
#' calculateStatetoBEASummaryAllocationFactor(year, "Employment")).
#' When using state employment (from BEA) as source for allocation,
#' introduce national GVA to disaggregate state employment
#' in real estate and gov industries from LineCode to BEA Summary.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains ratios of state/US GVA (value added)
#' for all states at a specific year at BEA Summary level.
calculateStateUSValueAddedRatio <- function(year) {
  # Define BEA_col and year_col
  BEA_col <- "BEA_2012_Summary_Code"
  year_col <- as.character(year)
  # Generate state GVA (value added) table
  StateValueAdded <- allocateStateTabletoBEASummary("GVA", year, "Employment")
  # Extract US value added
  US_VA <- StateValueAdded[StateValueAdded$GeoName=="United States *", ]
  # Extract state value added
  StateVA <- StateValueAdded[StateValueAdded$GeoName!="United States *", ]
  # Generate sum of state GVA (value added)
  StateVA_sum <- stats::aggregate(StateVA[, year_col], by = list(StateVA[, BEA_col]), sum)
  colnames(StateVA_sum) <- c(BEA_col, "StateVA_sum")
  
  # Merge sum of state GVA with US VA to get VA of Overseas region
  OverseasVA <- merge(StateVA_sum, US_VA, by = BEA_col)
  OverseasVA[, paste0(year, ".x")] <- OverseasVA[, year_col] - OverseasVA$StateVA_sum
  OverseasVA[, paste0(year, ".y")] <- OverseasVA[, year_col]
  OverseasVA$GeoName <- "Overseas"
  # Merge state GVA and US value added tables
  VA_Ratio_df <- merge(StateVA, US_VA[, -1], by = BEA_col)
  # Append Overseas value added to VA_Ratio_df
  VA_Ratio_df <- rbind(VA_Ratio_df, OverseasVA[, colnames(VA_Ratio_df)])
  # Calculate the state-US GVA (value added) ratios
  VA_Ratio_df$Ratio <- VA_Ratio_df[, paste0(year, ".x")]/VA_Ratio_df[, paste0(year, ".y")]
  VA_Ratio_df <- VA_Ratio_df[order(VA_Ratio_df$GeoName, VA_Ratio_df[, BEA_col]),
                             c(BEA_col, "GeoName", "Ratio")]
  rownames(VA_Ratio_df) <- NULL
  return(VA_Ratio_df)
}

#' Calculate state-US GVA (value added) ratios by BEA State LineCode.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains ratios of state/US GVA (value added)
#' for all states at a specific year by BEA State LineCode.
calculateStateUSVARatiobyLineCode <- function(year) {
  # Define BEA_col and year_col
  BEA_col <- "BEA_2012_Summary_Code"
  year_col <- as.character(year)
  # Load LineCode-coded State ValueAdded
  ValueAdded <- getStateGVA(year)
  # Extract US value added
  US_VA <- ValueAdded[ValueAdded$GeoName=="United States *", ]
  # Generate sum of State ValueAdded table
  StateVA <- ValueAdded[ValueAdded$GeoName!="United States *", ]
  StateVA_sum <- stats::aggregate(StateVA[, year_col], by = list(StateVA$LineCode),
                                  sum, na.rm = TRUE)
  colnames(StateVA_sum) <- c("LineCode", year_col)
  # Merge sum of state GVA with US VA to get VA of Overseas region
  OverseasVA <- merge(StateVA_sum, US_VA, by = "LineCode")
  value <- OverseasVA[, paste0(year, ".y")] - OverseasVA[, paste0(year, ".x")]
  OverseasVA[, paste0(year, ".x")] <- value
  OverseasVA$GeoName <- "Overseas"
  # Merge state and US ValueAdded by LineCode
  VA_Ratio_df <- merge(StateVA, US_VA[, -1], by = "LineCode")
  # Append Overseas VA to StateVA
  VA_Ratio_df <- rbind(VA_Ratio_df, OverseasVA[, colnames(VA_Ratio_df)])
  # Calculate the state-US ValueAdded ratios by LineCode
  VA_Ratio_df$Ratio <- VA_Ratio_df[, paste0(year, ".x")]/VA_Ratio_df[, paste0(year, ".y")]
  VA_Ratio_df <- VA_Ratio_df[order(VA_Ratio_df$LineCode, VA_Ratio_df$GeoName),
                             c("LineCode", "GeoName", "Ratio")]
  return(VA_Ratio_df)
}

#' Calculate state industry output by BEA State LineCode
#' by multiplying state_US_VA_ratio_LineCode by USGrossOutput_LineCode.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state industry output by BEA State LineCode.
calculateStateIndustryOutputbyLineCode <- function(year) {
  # Define BEA_col and year_col
  BEA_col <- "BEA_2012_Summary_Code"
  year_col <- as.character(year)
  # Generate state_US_VA_ratio_LineCode
  state_US_VA_ratio_LineCode <- calculateStateUSVARatiobyLineCode(year)
  # Get US Industry Output from US Make table
  US_Summary_Make <- getNationalMake("Summary", year)
  # Sum US_Summary_Make by row to get US_Summary_IndustryOutput
  USGrossOutput <- as.data.frame(rowSums(US_Summary_Make))
  colnames(USGrossOutput) <- year_col
  # Load State GVA to BEA Summary sector-mapping table
  GVAtoBEAmapping <- loadBEAStateDatatoBEASummaryMapping("GVA")
  # Generate LineCode-coded US Gross Output
  USGrossOutput <- merge(USGrossOutput, GVAtoBEAmapping, by.x = 0, by.y = BEA_col)
  USGrossOutput <- stats::aggregate(USGrossOutput[, year_col],
                                    by = list(USGrossOutput$LineCode), sum)
  colnames(USGrossOutput) <- c("LineCode", year_col)
  # Calculate state industry output by LineCode
  StateGrossOutput <- merge(state_US_VA_ratio_LineCode, USGrossOutput, by = "LineCode")
  StateGrossOutput[, year_col] <- StateGrossOutput[, year_col]*StateGrossOutput$Ratio
  # Re-order
  StateGrossOutput <- StateGrossOutput[order(StateGrossOutput$LineCode,
                                             StateGrossOutput$GeoName),
                                       c("LineCode", "GeoName", year_col)]
  return(StateGrossOutput)
}

#' Estimate state commodity output from alternative sources, calculate ratios.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state commodity output
#' for specified state with row names being BEA sector code.
getStateCommodityOutputRatioEstimates <- function(year) {
  # Generate Ag, Fishery, Forestry commodity output
  AgFisheryForestry <- getAgFisheryForestryCommodityOutput(year)
  # Generate FAF commodity output
  FAF <- getFAFCommodityOutput(year)
  # Combine all commodity output
  StateCommodityOutputRatio <- rbind(AgFisheryForestry, FAF)
  return(StateCommodityOutputRatio)
}

#' Load BEA and BLS QCEW State Employment data from pre-saved .rds files and FLOWSA.
#' Map to BEA Summary sectors.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains State Emp by BEA Summary.
getStateEmploymentbyBEASummary <- function(year) {
  # BEA State Emp
  BEAStateEmp <- loadStateIODataFile("State_Employment_2009_2018")[, c("GeoName",
                                                                       "LineCode",
                                                                       as.character(year))]
  EmptoBEAmapping <- loadBEAStateDatatoBEASummaryMapping("Employment")
  BEAStateEmp <- merge(BEAStateEmp, EmptoBEAmapping, by = "LineCode")
  # Aggregate StateEmployment by BEA
  BEAStateEmp <- stats::aggregate(BEAStateEmp[, as.character(year)],
                                  by = list(BEAStateEmp$BEA_2012_Summary_Code,
                                            BEAStateEmp$GeoName), sum)
  colnames(BEAStateEmp) <- c("BEA_2012_Summary_Code", "State", "Emp")
  # BLS QCEW Emp
  BLS_QCEW <- getFlowsaData("Employment", year)
  BLS_QCEW <- mapBLSQCEWtoBEA(BLS_QCEW, year, "Summary")
  BLS_QCEW$State <- mapFIPS5toLocationNames(BLS_QCEW$FIPS, "FIPS")
  # Prioritize BEAStateEmp, replace NAs in Emp with values from BLS_QCEW
  StateEmp <- merge(BEAStateEmp[BEAStateEmp$State%in%BLS_QCEW$State, ],
                    BLS_QCEW, by = c("State", "BEA_2012_Summary_Code"), all = TRUE)
  StateEmp[is.na(StateEmp$Emp), "Emp"] <- StateEmp[is.na(StateEmp$Emp), "FlowAmount"]
  # Replace the remaining NAs in Emp with zero
  StateEmp[is.na(StateEmp$Emp), "Emp"] <- 0
  # Drop unwanted columns
  StateEmp <- StateEmp[, colnames(BEAStateEmp)]
  return(StateEmp)
}

#' Estimate state Ag, Fishery and Forestry commodity output ratios
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state Ag, Fishery and Forestry commodity output
#' for specified state with row names being BEA sector code.
getAgFisheryForestryCommodityOutput <- function(year) {
  # Load state FIPS
  FIPS_STATE <- readCSV(system.file("extdata", "StateFIPS.csv", package = "stateior"))
  # Load USDA_ERS_FIWS data from flowsa
  USDA_ERS_FIWS <- getFlowsaData("USDA_ERS_FIWS", year)
  # Select All Commodities as Ag products
  Ag <- USDA_ERS_FIWS[USDA_ERS_FIWS$ActivityProducedBy=="All Commodities", ]
  # Convert State_FIPS to numeric values
  Ag$State_FIPS <- as.numeric(substr(Ag$Location, 1, 2))
  # Map to state names
  Ag <- merge(Ag, FIPS_STATE, by = "State_FIPS")
  # Calculate Commodity Output Ratio
  Ag$Ratio <- Ag$FlowAmount/sum(Ag$FlowAmount)
  # Assign BEA Code
  Ag$BEA_2012_Summary_Code <- "111CA"
  Ag$Value <- Ag$FlowAmount
  # Re-order columns and drop unwanted columns
  Ag <- Ag[, c("BEA_2012_Summary_Code", "State", "Value", "Ratio")]
  
  # Load Fishery Landings and Forestry CutValue data from flowsa
  Fishery <- getFlowsaData("NOAA_FisheryLandings", year)
  FisheryForestry <- rbind(Fishery,
                           USDA_ERS_FIWS[USDA_ERS_FIWS$ActivityProducedBy=="All Species", ])
  # Convert State_FIPS to numeric values
  FisheryForestry$State_FIPS <- as.numeric(substr(FisheryForestry$Location, 1, 2))
  # Map to state names
  FisheryForestry <- merge(FisheryForestry[, c("State_FIPS", "FlowAmount")],
                           FIPS_STATE, by = "State_FIPS")
  FisheryForestry <- stats::aggregate(FisheryForestry$FlowAmount,
                                      by = list(FisheryForestry$State), sum)
  colnames(FisheryForestry) <- c("State", "Value")
  # Calculate Commodity Output Ratio
  FisheryForestry$Ratio <- FisheryForestry$Value/sum(FisheryForestry$Value)
  # Assign BEA Code
  FisheryForestry$BEA_2012_Summary_Code <- "113FF"
  # Re-order columns and drop unwanted columns
  FisheryForestry <- FisheryForestry[, colnames(Ag)]
  
  # Combine Ag and FisheryForestry
  AgFisheryForestry <- rbind(Ag, FisheryForestry)
  return(AgFisheryForestry)
}

#' Estimate state FAF commodity output ratios
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state FAF commodity output
#' for specified state with row names being BEA sector code.
getFAFCommodityOutput <- function(year) {
  # Define BEA_col
  BEA_col <- "BEA_2012_Summary_Code"
  # Load state FIPS
  FIPS_STATE <- readCSV(system.file("extdata", "StateFIPS.csv",
                                    package = "stateior"))
  # Load pre-saved FAF4 commodity flow data
  FAF <- loadStateIODataFile(paste("FAF", year, sep = "_"))
  # Keep domestic and export trade, keep useful columns, then rename
  FAF <- FAF[FAF$trade_type%in%c(1, 3),
             c("dms_origst", "sctg2", paste0("value_", year))]
  colnames(FAF) <- c("State_FIPS", "SCTG", "Value")
  # Calculate state commodity output by SCTG
  FAF <- merge(FAF, FIPS_STATE, by = "State_FIPS", all.x = TRUE)
  FAF <- stats::aggregate(FAF$Value, by = list(FAF$SCTG, FAF$State), sum)
  colnames(FAF) <- c("SCTG", "State", "Value")
  # Map FAF from SCTG to BEA Summary commodities
  # Load SCTGtoBEA mapping table
  SCTGtoBEA <- unique(readCSV(system.file("extdata", "Crosswalk_SCTGtoBEA.csv",
                                          package = "stateior")))[, c("SCTG", BEA_col)]
  FAF <- merge(FAF, SCTGtoBEA, by = "SCTG")
  # Determine BEA sectors that need allocation
  allocation_sectors <- SCTGtoBEA[duplicated(SCTGtoBEA$SCTG) |
                                    duplicated(SCTGtoBEA$SCTG, fromLast = TRUE), ]
  allocation_sectors <- allocation_sectors[!allocation_sectors[, BEA_col]
                                           %in%c("111CA", "113FF", "311FT"), ]
  # Use State Emp to allocate
  StateEmp <- getStateEmploymentbyBEASummary(year)
  # Merge StateEmp with allocation_sectors
  StateEmp <- merge(StateEmp, allocation_sectors, by = BEA_col)
  # Process FAF for each state
  # Generate AFF
  AgFisheryForestry <- getAgFisheryForestryCommodityOutput(year)
  FAF_state_ls <- list()
  for (state in unique(FAF$State)) {
    FAF_state <- FAF[FAF$State==state, ]
    # Step 1. Calculate foods (311FT) as
    # 311FT = (111CA + 113FF + 311FT) - (Ag + ForestryandFishery)
    FAF_total <- sum(FAF[FAF[, BEA_col]%in%c("111CA", "113FF", "311FT"), "Value"])
    AFF_total <- sum(AgFisheryForestry[AgFisheryForestry$State==state, "Value"])
    FAF_state[FAF_state$BEA=="331FT", "Value"] <- FAF_total - AFF_total
    # Drop "111CA" and "113FF" from FAF
    FAF_state <- FAF_state[! FAF_state[, BEA_col]%in%c("111CA", "113FF"), ]
    # Step 2. Separate FAF_state to
    # FAF_state_1 (does not need allocation)
    # FAF_state_2 (needs allocation)
    FAF_state_1 <- FAF_state[!FAF_state$SCTG%in%allocation_sectors$SCTG, ]
    FAF_state_2 <- FAF_state[FAF_state$SCTG%in%allocation_sectors$SCTG, ]
    # Step 2.1. Aggregate FAF_state_1 by BEA industries
    FAF_state_1 <- stats::aggregate(FAF_state_1$Value,
                                    by = list(FAF_state_1$State,
                                              FAF_state_1[, BEA_col]),
                                    sum)
    colnames(FAF_state_1) <- c("State", BEA_col, "Value")
    # Step 2.2. Allocate FAF_state_2 from SCTG to BEA using BEA state employment
    Emp <- StateEmp[StateEmp$State==state, ]
    # Merge with FAF_state_2
    FAF_state_2 <- merge(FAF_state_2, Emp, by = c("State", "SCTG", BEA_col))
    for (sctg in unique(FAF_state_2$SCTG)) {
      # Calculate allocation factor
      weight_vector <- FAF_state_2[FAF_state_2$SCTG==sctg, "Emp"]
      allocation_factor <- weight_vector/sum(weight_vector, na.rm = TRUE)
      # Allocate Value
      value <- FAF_state_2[FAF_state_2$SCTG==sctg, "Value"]*allocation_factor
      FAF_state_2[FAF_state_2$SCTG==sctg, "Value"] <- value
      # Aggregate by BEA
      FAF_state_2 <- stats::aggregate(FAF_state_2$Value,
                                      by = list(FAF_state_2$State,
                                                FAF_state_2[, BEA_col]),
                                      sum, na.rm = TRUE)
      colnames(FAF_state_2) <- c("State", BEA_col, "Value")
    }
    # Combine FAF_state_1 and FAF_state_2
    FAF_state_new <- rbind(FAF_state_1, FAF_state_2)
    # Aggregate by BEA
    FAF_state_new <- aggregate(FAF_state_new$Value,
                               by = list(FAF_state_new$State,
                                         FAF_state_new[, BEA_col]),
                               sum)
    colnames(FAF_state_new) <- colnames(FAF_state_1)
    FAF_state_ls[[state]] <- FAF_state_new
  }
  FAF <- do.call(rbind, FAF_state_ls)
  # Calculate total commodity output ratio
  for (commodity in unique(FAF[, BEA_col])) {
    commodity_total <- sum(FAF[FAF[, BEA_col]==commodity, "Value"])
    ratio <- FAF[FAF[, BEA_col]==commodity, "Value"]/commodity_total
    FAF[FAF[, BEA_col]==commodity, "Ratio"] <- ratio
  }
  # Drop rows where Ratio==0
  FAF <- FAF[FAF$Ratio>0, ]
  return(FAF)
}
