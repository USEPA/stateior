#' Get industry-level GDP for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state GDP for all states at a specific year.
getStateGDP <- function(year) {
  # Load pre-saved state GDP 2007-2019
  StateGDP <- stateio::State_GDP_2007_2019
  StateGDP <- StateGDP[, c("GeoName", "LineCode", as.character(year))]
  return(StateGDP)
}

#' Map state table to BEA Summary, mark sectors that need allocation
#' @param statetablename Name of pre-saved state table, can be GDP, Tax, Employment Compensation, and GOS.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state value for all states with row names being BEA sector code.
mapStateTabletoBEASummary <- function(statetablename, year) {
  # Load and adjust State tables
  StateTable <- AdjustGDPComponent(year, statetablename)
  # Load State GDP to BEA Summary sector-mapping table
  BEAStateGDPtoBEASummary <- utils::read.table(system.file("extdata", "Crosswalk_StateGDPtoBEASummaryIO2012Schema.csv", package = "stateio"),
                                               sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  # Merge state table with BEA Summary sector code and name
  StateTableBEA <- merge(StateTable, BEAStateGDPtoBEASummary, by = "LineCode")
  return(StateTableBEA)
}

#' Calculate allocation factors based on state-level data, such as employment
#' @param statetablename Name of pre-saved state table, canbe GDP, Tax, Employment Compensation, and GOS.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains allocation factors for all states with row names being BEA sector code.
calculateStatetoBEASummaryAllocationFactor <- function(year, allocationweightsource) {
  # Load State GDP to BEA Summary sector-mapping table
  BEAStateGDPtoBEASummary <- utils::read.table(system.file("extdata", "Crosswalk_StateGDPtoBEASummaryIO2012Schema.csv", package = "stateio"),
                                               sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  # Determine BEA sectors that need allocation
  allocation_sectors <- BEAStateGDPtoBEASummary[duplicated(BEAStateGDPtoBEASummary$LineCode) | duplicated(BEAStateGDPtoBEASummary$LineCode, fromLast = TRUE), ]
  allocation_codes <- allocation_sectors$BEA_2012_Summary_Code
  # Generate a mapping table only for allocation_codes based on MasterCrosswalk2012
  crosswalk <- useeior::MasterCrosswalk2012[useeior::MasterCrosswalk2012$BEA_2012_Summary_Code%in%allocation_codes, ]
  # Generate allocation_weight df based on pre-saved data
  if (allocationweightsource=="Employment") {
    # Load BEA State Emp to BEA Summary mapping
    BEAStateEmptoBEAmapping <- utils::read.table(system.file("extdata", "Crosswalk_StateEmploymenttoBEASummaryIO2012Schema.csv", package = "stateio"),
                                                 sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
    BEAStateEmptoBEAmapping <- BEAStateEmptoBEAmapping[BEAStateEmptoBEAmapping$BEA_2012_Summary_Code%in%
                                                         crosswalk[crosswalk$BEA_2012_Sector_Code%in%c("44RT", "FIRE", "G"), "BEA_2012_Summary_Code"], ]
    # For real estate (FIRE) and gov (G) sectors, calculate allocation factors using US GDP by industry
    allocation_factors <- merge(BEAStateEmptoBEAmapping,
                                useeior::Summary_ValueAdded_IO[, as.character(year), drop = FALSE],
                                by.x = "BEA_2012_Summary_Code", by.y = 0)
    for (linecode in unique(allocation_factors$LineCode)) {
      weight_vector <- allocation_factors[allocation_factors$LineCode==linecode, as.character(year)]
      allocation_factors[allocation_factors$LineCode==linecode, "factor"] <- weight_vector/sum(weight_vector)
    }
    # Load BEA state Emp
    BEAStateEmployment <- stateio::State_Employment_2009_2018[, c("GeoName", "LineCode", as.character(year))]
    # Map BEA state Emp (from LineCode) to BEA Summary
    BEAStateEmployment <- merge(BEAStateEmployment[BEAStateEmployment$GeoName %in% c(state.name, "District of Columbia"), ],
                                allocation_factors[, c("BEA_2012_Summary_Code", "LineCode", "factor")],
                                by = "LineCode")
    # Adjust BEA state Emp value based on allocation factor
    BEAStateEmployment[, as.character(year)] <- BEAStateEmployment[, as.character(year)]*BEAStateEmployment$factor
    allocation_weight <- stats::aggregate(BEAStateEmployment[, as.character(year)],
                                          by = list(BEAStateEmployment$GeoName,
                                                    BEAStateEmployment$BEA_2012_Summary_Code),
                                          sum)
    colnames(allocation_weight) <- c("GeoName", "BEA_2012_Summary_Code", "Weight")
  }
  # Add US allocation weight (Summary Gross Output)
  US_GrossOutput <- cbind.data.frame("United States *", rownames(useeior::Summary_GrossOutput_IO),
                                     useeior::Summary_GrossOutput_IO[, as.character(year), drop = FALSE])
  colnames(US_GrossOutput) <- colnames(allocation_weight)
  # Calculate allocation factor
  allocation_df <- merge(rbind(allocation_weight, US_GrossOutput), allocation_sectors, by = "BEA_2012_Summary_Code")
  for (state in unique(allocation_df$GeoName)) {
    for (linecode in unique(allocation_df$LineCode)) {
      weight_vector <- allocation_df[allocation_df$GeoName==state&allocation_df$LineCode==linecode, "Weight"]
      allocation_df[allocation_df$GeoName==state&allocation_df$LineCode==linecode, "AllocationFactor"] <- weight_vector/sum(weight_vector)
    }
  }
  return(allocation_df)
}

#' Allocate state table (GDP, Tax, Employment Compensation, and GOS) to BEA Summary based on specified weight
#' @param statetablename Name of pre-saved state table, canbe GDP, Tax, Employment Compensation, and GOS.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param allocationweightsource Source of allocatino weight, can be "Employment".
#' @return A data frame contains allocated state value for all states with row names being BEA sector code.
allocateStateTabletoBEASummary <- function(statetablename, year, allocationweightsource) {
  # Generate StateTableBEA
  StateTableBEA <- mapStateTabletoBEASummary(statetablename, year)
  # Generate allocation factor
  allocation_df <- calculateStatetoBEASummaryAllocationFactor(year, allocationweightsource)
  # Merge StateTableBEA with allocation_df
  StateTableBEA_allocation <- merge(StateTableBEA, allocation_df, by = c("LineCode", "GeoName", "BEA_2012_Summary_Code"))
  # Modify value in StateTableBEA_allocation
  StateTableBEA_allocation[, as.character(year)] <- StateTableBEA_allocation[, as.character(year)]*StateTableBEA_allocation$AllocationFactor
  # Append StateTableBEA_allocation to un-allocated StateTableBEA
  StateTableBEA <- rbind(StateTableBEA_allocation[, c("GeoName", "BEA_2012_Summary_Code", as.character(year))],
                         StateTableBEA[!StateTableBEA$LineCode%in%StateTableBEA_allocation$LineCode,
                                       c("GeoName", "BEA_2012_Summary_Code", as.character(year))])
  # Sort StateTableBEA
  StateTableBEA <- StateTableBEA[order(StateTableBEA$GeoName, StateTableBEA$BEA_2012_Summary_Code), ]
  # Re-number rownames
  rownames(StateTableBEA) <- NULL
  return(StateTableBEA)
}

#' Calculate state-US GDP (value added) ratios at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains ratios of state/US GDP (value added) for all states at a specific year at BEA Summary level.
calculateStateUSValueAddedRatio <- function(year) {
  # Generate state GDP (value added) table
  StateValueAdded <- allocateStateTabletoBEASummary("GDP", year, "Employment")
  # Generate sum of state GDP (value added)
  StateValueAdded_sum <- stats::aggregate(StateValueAdded[StateValueAdded$GeoName!="United States *", as.character(year)],
                                          by = list(StateValueAdded[StateValueAdded$GeoName!="United States *", "BEA_2012_Summary_Code"]),
                                          sum)
  colnames(StateValueAdded_sum) <- c("BEA_2012_Summary_Code", "StateVA_sum")
  # Extract US value added
  USValueAdded <- StateValueAdded[StateValueAdded$GeoName=="United States *", ]
  # Merge sum of state GDP with US VA to get VA of Overseas region
  OverseasValueAdded <- merge(StateValueAdded_sum, USValueAdded, by = "BEA_2012_Summary_Code")
  OverseasValueAdded[, paste0(year, ".x")] <- OverseasValueAdded[, as.character(year)] - OverseasValueAdded$StateVA_sum
  OverseasValueAdded[, paste0(year, ".y")] <- OverseasValueAdded[, as.character(year)]
  OverseasValueAdded$GeoName <- "Overseas"
  # Merge state GDP and US value added tables
  StateUSValueAdded <- merge(StateValueAdded[StateValueAdded$GeoName!="United States *", ],
                             USValueAdded[, -1], by = "BEA_2012_Summary_Code")
  # Append Overseas VA to StateUSValueAdded
  StateUSValueAdded <- rbind(StateUSValueAdded, OverseasValueAdded[, colnames(StateUSValueAdded)])
  # Calculate the state-US GDP (value added) ratios
  StateUSValueAdded$Ratio <- StateUSValueAdded[, paste0(year, ".x")]/StateUSValueAdded[, paste0(year, ".y")]
  StateUSValueAdded <- StateUSValueAdded[order(StateUSValueAdded$GeoName, StateUSValueAdded$BEA_2012_Summary_Code),
                                         c("BEA_2012_Summary_Code", "GeoName", "Ratio")]
  rownames(StateUSValueAdded) <- NULL
  return(StateUSValueAdded)
}

#' Calculate state-US GDP (value added) ratios by BEA State LineCode.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains ratios of state/US GDP (value added) for all states at a specific year by BEA State LineCode.
calculateStateUSVARatiobyLineCode <- function(year) {
  # Load LineCode-coded State ValueAdded
  ValueAdded <- getStateGDP(year)
  # Extract US value added
  USValueAdded <- ValueAdded[ValueAdded$GeoName=="United States *", ]
  # Generate sum of State ValueAdded table
  StateValueAdded <- ValueAdded[ValueAdded$GeoName!="United States *", ]
  StateValueAdded_sum <- stats::aggregate(StateValueAdded[, as.character(year)],
                                          by = list(StateValueAdded$LineCode), sum)
  colnames(StateValueAdded_sum) <- c("LineCode", as.character(year))
  # Merge sum of state GDP with US VA to get VA of Overseas region
  OverseasValueAdded <- merge(StateValueAdded_sum, USValueAdded, by = "LineCode")
  OverseasValueAdded[, paste0(year, ".x")] <- OverseasValueAdded[, paste0(year, ".y")] - OverseasValueAdded[, paste0(year, ".x")]
  OverseasValueAdded$GeoName <- "Overseas"
  # Merge state and US ValueAdded by LineCode
  StateUSValueAdded <- merge(StateValueAdded, USValueAdded[, -1], by = "LineCode")
  # Append Overseas VA to StateValueAdded
  StateUSValueAdded <- rbind(StateUSValueAdded, OverseasValueAdded[, colnames(StateUSValueAdded)])
  # Calculate the state-US ValueAdded ratios by LineCode
  StateUSValueAdded$Ratio <- StateUSValueAdded[, paste0(year, ".x")]/StateUSValueAdded[, paste0(year, ".y")]
  StateUSValueAdded <- StateUSValueAdded[order(StateUSValueAdded$LineCode, StateUSValueAdded$GeoName),
                                         c("LineCode", "GeoName", "Ratio")]
  return(StateUSValueAdded)
}

#' Calculate state industry output by BEA State LineCode via multiplying state_US_VA_ratio_LineCode by USGrossOutput_LineCode.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state industry output by BEA State LineCode.
calculateStateIndustryOutputbyLineCode <- function(year) {
  # Generate state_US_VA_ratio_LineCode
  state_US_VA_ratio_LineCode <- calculateStateUSVARatiobyLineCode(year)
  # Get US Industry Output from US Make table
  US_Summary_Make <- get(paste("Summary_Make", year, "BeforeRedef", sep = "_"), as.environment("package:useeior"))*1E6
  US_Summary_MakeTrasaction <- US_Summary_Make[-which(rownames(US_Summary_Make)=="Total Commodity Output"),
                                               -which(colnames(US_Summary_Make)=="Total Industry Output")]
  # Sum US_Summary_MakeTrasaction by row to get US_Summary_IndustryOutput
  USGrossOutput <- as.data.frame(rowSums(US_Summary_MakeTrasaction))
  colnames(USGrossOutput) <- as.character(year)
  # Load State GDP to BEA Summary sector-mapping table
  BEAStateGDPtoBEASummary <- utils::read.table(system.file("extdata", "Crosswalk_StateGDPtoBEASummaryIO2012Schema.csv", package = "stateio"),
                                               sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  # Generate LineCode-coded US Gross Output
  USGrossOutput <- merge(USGrossOutput, BEAStateGDPtoBEASummary, by.x = 0, by.y = "BEA_2012_Summary_Code")
  USGrossOutput <- stats::aggregate(USGrossOutput[, as.character(year)], by = list(USGrossOutput$LineCode), sum)
  colnames(USGrossOutput) <- c("LineCode", as.character(year))
  # Calculate state industry output by LineCode
  StateGrossOutput <- merge(state_US_VA_ratio_LineCode, USGrossOutput, by = "LineCode")
  StateGrossOutput[, as.character(year)] <- StateGrossOutput[, as.character(year)]*StateGrossOutput$Ratio
  # Re-order
  StateGrossOutput <- StateGrossOutput[order(StateGrossOutput$LineCode, StateGrossOutput$GeoName),
                                       c("LineCode", "GeoName", as.character(year))]
  return(StateGrossOutput)
}

#' Estimate state commodity output from alternative sources, calculate ratios.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state commodity output for specified state with row names being BEA sector code.
getStateCommodityOutputRatioEstimates <- function(year) {
  # Generate Ag, Fishery, Forestry commodity output
  AgFisheryForestry <- getAgFisheryForestryCommodityOutput(year)
  # Generate FAF commodity output
  FAF <- getFAFCommodityOutput(year)
  # Combine all commodity output
  StateCommodityOutputRatio <- rbind(AgFisheryForestry, FAF)
  return(StateCommodityOutputRatio)
}

#' Load flowbyactivity data from FLOWSA
#' @param flowclass A character value specifying flow class, can be "Money".
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param datasource A character value specifying data source.
#' @return A data frame contains state Ag, Fishery and Forestry commodity output
#' for specified state with row names being BEA sector code.
loadDatafromFLOWSA <- function(flowclass, year, datasource) {
  # Import flowsa
  library(reticulate)
  flowsa <- import("flowsa")
  # Load data
  df <- flowsa$getFlowByActivity(list(flowclass), list(as.character(year)), datasource)
  return(df)
}

#' Load BEA and BLS QCEW State Employment data from pre-saved .rda files and FLOWSA.
#' Map to BEA Summary sectors.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains State Emp by BEA Summary.
getStateEmploymentbyBEASummary <- function(year) {
  # BEA State Emp
  BEAStateEmployment <- stateio::State_Employment_2009_2018[, c("GeoName", "LineCode", as.character(year))]
  BEAStateEmptoBEAmapping <- utils::read.table(system.file("extdata", "Crosswalk_StateEmploymenttoBEASummaryIO2012Schema.csv", package = "stateio"),
                                               sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  BEAStateEmployment <- merge(BEAStateEmployment, BEAStateEmptoBEAmapping, by = "LineCode")
  # Aggregate StateEmployment by BEA
  BEAStateEmployment <- stats::aggregate(BEAStateEmployment[, as.character(year)],
                                         by = list(BEAStateEmployment$BEA_2012_Summary_Code,
                                                   BEAStateEmployment$GeoName), sum)
  colnames(BEAStateEmployment) <- c("BEA_2012_Summary_Code", "State", "Emp")
  # BLS QCEW Emp
  BLS_QCEW <- loadDatafromFLOWSA("Employment", year, "BLS_QCEW")
  BLS_QCEW <- mapBLSQCEWtoBEA(BLS_QCEW, year, "Summary")
  BLS_QCEW$FIPS <- as.numeric(substr(BLS_QCEW$FIPS, 1, 2))
  FIPS_STATE <- utils::read.table(system.file("extdata", "StateFIPS.csv", package = "stateio"),
                                  sep = ",", header = TRUE, check.names = FALSE)
  BLS_QCEW <- merge(BLS_QCEW, FIPS_STATE, by.x = "FIPS", by.y = "State_FIPS")
  # Prioritize BEAStateEmployment, replace NAs in Emp with values from BLS_QCEW
  StateEmployment <- merge(BEAStateEmployment, BLS_QCEW, by = c("State", "BEA_2012_Summary_Code"))
  StateEmployment[is.na(StateEmployment$Emp), "Emp"] <- StateEmployment[is.na(StateEmployment$Emp), "FlowAmount"]
  # Drop unwanted columns
  StateEmployment <- StateEmployment[, colnames(BEAStateEmployment)]
  return(StateEmployment)
}

#' Estimate state Ag, Fishery and Forestry commodity output ratios
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state Ag, Fishery and Forestry commodity output
#' for specified state with row names being BEA sector code.
getAgFisheryForestryCommodityOutput <- function(year) {
  # Load state FIPS
  FIPS_STATE <- utils::read.table(system.file("extdata", "StateFIPS.csv", package = "stateio"),
                                  sep = ",", header = TRUE, check.names = FALSE)
  # Load USDA_ERS_FIWS data from flowsa
  USDA_ERS_FIWS <- loadDatafromFLOWSA("Money", year, "USDA_ERS_FIWS")
  # Select All Commodities as Ag products
  Ag <- USDA_ERS_FIWS[USDA_ERS_FIWS$ActivityProducedBy=="All Commodities", ]
  # Convert State_FIPS to numeric values
  Ag$State_FIPS <- as.numeric(Ag$Location)
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
  Fishery <- loadDatafromFLOWSA("Money", "2012-2018", "NOAA_FisheryLandings")
  FisheryForestry <- rbind(Fishery[Fishery$Year==year, ],
                           USDA_ERS_FIWS[USDA_ERS_FIWS$ActivityProducedBy=="Forest products", ])
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
  # Load state FIPS
  FIPS_STATE <- utils::read.table(system.file("extdata", "StateFIPS.csv", package = "stateio"),
                                  sep = ",", header = TRUE, check.names = FALSE)
  # Load pre-saved FAF4 commodity flow data
  FAF <- get(paste("FAF", year, sep = "_"))
  # Keep domestic and export trade, keep useful columns, then rename
  FAF <- FAF[FAF$trade_type%in%c(1, 3), c("dms_origst", "sctg2", paste0("value_", year))]
  colnames(FAF) <- c("State_FIPS", "SCTG", "Value")
  # Calculate state commodity output by SCTG
  FAF <- merge(FAF, FIPS_STATE, by = "State_FIPS", all.x = TRUE)
  FAF <- stats::aggregate(FAF$Value, by = list(FAF$SCTG, FAF$State), sum)
  colnames(FAF) <- c("SCTG", "State", "Value")
  # Map FAF from SCTG to BEA Summary commodities
  # Load SCTGtoBEA mapping table
  SCTGtoBEA <- utils::read.table(system.file("extdata", "Crosswalk_SCTGtoBEA.csv", package = "stateio"),
                                 sep = ",", header = TRUE, check.names = FALSE)
  SCTGtoBEASummary <- unique(SCTGtoBEA[, c("SCTG", "BEA_2012_Summary_Code")])
  FAF <- merge(FAF, SCTGtoBEASummary, by = "SCTG")
  # Determine BEA sectors that need allocation
  allocation_sectors <- SCTGtoBEASummary[duplicated(SCTGtoBEASummary$SCTG) |
                                           duplicated(SCTGtoBEASummary$SCTG, fromLast = TRUE), ]
  allocation_sectors <- allocation_sectors[!allocation_sectors$BEA_2012_Summary_Code%in%c("111CA", "113FF", "311FT"),]
  # Use State Emp to allocate
  StateEmp <- getStateEmploymentbyBEASummary(year)
  # Merge StateEmp with allocation_sectors
  StateEmp <- merge(StateEmp, allocation_sectors, by = "BEA_2012_Summary_Code")
  # Process FAF for each state
  # Generate AFF
  AgFisheryForestry <- getAgFisheryForestryCommodityOutput(year)
  FAF_state_list <- list()
  for (state in unique(FAF$State)) {
    FAF_state <- FAF[FAF$State==state, ]
    # Step 1. Calculate foods (311FT) as
    # 311FT = (111CA + 113FF + 311FT) - (Ag + ForestryandFishery)
    FAF_total <- sum(FAF[FAF$BEA_2012_Summary_Code%in%c("111CA", "113FF", "311FT"), "Value"])
    AFF_total <- sum(AgFisheryForestry[AgFisheryForestry$State==state, "Value"])
    FAF_state[FAF_state$BEA=="331FT", "Value"] <- FAF_total - AFF_total
    # Drop "111CA" and "113FF" from FAF
    FAF_state <- FAF_state[! FAF_state$BEA_2012_Summary_Code%in%c("111CA", "113FF"), ]
    # Step 2. Separate FAF_state to FAF_state_1 (does not need allocation)
    # And FAF_state_2 (needs allocation)
    FAF_state_1 <- FAF_state[!FAF_state$SCTG%in%allocation_sectors$SCTG, ]
    FAF_state_2 <- FAF_state[FAF_state$SCTG%in%allocation_sectors$SCTG, ]
    # Step 2.1. Aggregate FAF_state_1 by BEA industries
    FAF_state_1 <- stats::aggregate(FAF_state_1$Value,by = list(FAF_state_1$State,
                                                                FAF_state_1$BEA_2012_Summary_Code), sum)
    colnames(FAF_state_1) <- c("State", "BEA_2012_Summary_Code", "Value")
    # Step 2.2. Allocate FAF_state_2 from SCTG to BEA using BEA state employment
    Emp <- StateEmp[StateEmp$State==state, ]
    # Merge with FAF_state_2
    FAF_state_2 <- merge(FAF_state_2, Emp, by = c("State", "SCTG", "BEA_2012_Summary_Code"))
    for (sctg in unique(FAF_state_2$SCTG)) {
      # Calculate allocation factor
      weight_vector <- FAF_state_2[FAF_state_2$SCTG==sctg, "Emp"]
      allocation_factor <- weight_vector/sum(weight_vector, na.rm = TRUE)
      # Allocate Value
      FAF_state_2[FAF_state_2$SCTG==sctg, "Value"] <- FAF_state_2[FAF_state_2$SCTG==sctg, "Value"]*allocation_factor
      # Aggregate by BEA
      FAF_state_2 <- stats::aggregate(FAF_state_2$Value,
                                      by = list(FAF_state_2$State, FAF_state_2$BEA_2012_Summary_Code),
                                      sum, na.rm = TRUE)
      colnames(FAF_state_2) <- c("State", "BEA_2012_Summary_Code", "Value")
    }
    # Combine FAF_state_1 and FAF_state_2
    FAF_state_new <- rbind(FAF_state_1, FAF_state_2)
    # Aggregate by BEA
    FAF_state_new <- aggregate(FAF_state_new$Value, by = list(FAF_state_new$State,
                                                              FAF_state_new$BEA_2012_Summary_Code), sum)
    colnames(FAF_state_new) <- colnames(FAF_state_1)
    FAF_state_list[[state]] <- FAF_state_new
  }
  FAF <- do.call(rbind, FAF_state_list)
  # Calculate total commodity output ratio
  for (commodity in unique(FAF$BEA_2012_Summary_Code)) {
    commodity_total <- sum(FAF[FAF$BEA_2012_Summary_Code==commodity, "Value"])
    FAF[FAF$BEA_2012_Summary_Code==commodity, "Ratio"] <- FAF[FAF$BEA_2012_Summary_Code==commodity, "Value"]/commodity_total
  }
  # Drop rows where Ratio==0
  FAF <- FAF[FAF$Ratio>0, ]
  return(FAF)
}
