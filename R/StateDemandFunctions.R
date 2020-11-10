#' Get US Use table (intermediaete + final demand) of specified iolevel and year.
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param year A numeric value specifying the year of interest.
#' #' @return The US Use table (intermediaete + final demand) of specified iolevel and year.
getNationalUse <- function(iolevel, year) {
  # Load pre-saved US Use table
  Use <- get(paste(iolevel, "Use", year, "PRO_BeforeRedef", sep = "_"))*1E6
  # Keep intermediaete and final demand
  Use <- Use[getVectorOfCodes("Summary", "Commodity"),
             c(getVectorOfCodes("Summary", "Industry"), getFinalDemandCodes("Summary"))]
  return(Use)
}

#' Get industry-level Compensation for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state Compensation for all states at a specific year.
getStateEmpCompensation <- function(year) {
  # Load pre-saved state Compensation 2007-2017
  StateEmpCompensation <- stateior::State_Compensation_2007_2017
  StateEmpCompensation <- StateEmpCompensation[, c("GeoName", "LineCode", as.character(year))]
  return(StateEmpCompensation)
}

#' Get industry-level Tax for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state Tax for all states at a specific year.
getStateTax <- function(year) {
  # Load pre-saved state Tax 2007-2017
  StateTax <- stateior::State_Tax_2007_2017
  StateTax <- StateTax[, c("GeoName", "LineCode", as.character(year))]
  return(StateTax)
}

#' Get industry-level Gross Operating Surplus (GOS) for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state GOS for all states at a specific year.
getStateGOS <- function(year) {
  # Load pre-saved state GOS 2007-2017
  StateGOS <- stateior::State_GOS_2007_2017
  StateGOS <- StateGOS[, c("GeoName", "LineCode", as.character(year))]
  return(StateGOS)
}

#' Get commodity-level Personal Consumption Expenditure (PCE) for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state PCE for all states at a specific year.
getStatePCE <- function(year) {
  # Load pre-saved state PCE 2007-2018
  StatePCE <- stateior::State_PCE_2007_2018
  StatePCE <- StatePCE[, c("GeoName", "Line", as.character(year))]
  return(StatePCE)
}

#' Calculate state-US Commodity Output ratios at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state-US Commodity Output ratios at BEA Summary level.
calculateStateCommodityOutputRatio <- function(year) {
  # Load state Commodity output
  State_Summary_CommodityOutput_list <- get(paste0("State_", iolevel, "_CommodityOutput_", year),
                                            as.environment("package:stateior"))
  states <- names(State_Summary_CommodityOutput_list)
  # Load US Commodity output
  US_Summary_MakeTransaction <- getNationalMake("Summary", year)
  US_Summary_CommodityOutput <- colSums(US_Summary_MakeTransaction)
  # Calculate state Commodity output ratio
  State_CommodityOutputRatio <- data.frame()
  for (state in states) {
    CommodityOutputRatio <- cbind.data.frame(names(US_Summary_CommodityOutput), state,
                                             State_Summary_CommodityOutput_list[[state]]/US_Summary_CommodityOutput)
    colnames(CommodityOutputRatio) <- c("BEA_2012_Summary_Code", "State", "Ratio")
    CommodityOutputRatio[, c("BEA_2012_Summary_Code", "State")] <- sapply(CommodityOutputRatio[, c("BEA_2012_Summary_Code", "State")], as.character)
    rownames(CommodityOutputRatio) <- NULL
    State_CommodityOutputRatio <- rbind(State_CommodityOutputRatio, CommodityOutputRatio)
  }
  return(State_CommodityOutputRatio)
}

#' Adjust EmpComp, Tax, and GOS to fill NA and make them consistent with GVA
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param return A character string showing which attribute to return. 'comp', 'tax', 'gos'
#' @return A data frame contains adjusted EmpComp, Tax, GOS, and GVA
adjustGVAComponent <- function(year, return) {
  #load data
  gva <- getStateGVA(year)
  comp <- getStateEmpCompensation(year)
  tax <- getStateTax(year)
  gos <- getStateGOS(year)
  
  #join into one table
  compareTable <- gva %>% 
    dplyr::left_join(., comp, by=c('GeoName','LineCode')) %>% 
    dplyr::left_join(., tax, by=c('GeoName','LineCode')) %>%
    dplyr::left_join(., gos, by=c('GeoName','LineCode')) 
  colnames(compareTable)[3:6] <- c('GVA','EmpCompensation','Tax','GOS')
  
  #adjust NA in Tax (simple, add/subtract)
  compareTable[is.na(compareTable$Tax),]$Tax <- compareTable[is.na(compareTable$Tax),]$GVA - 
    compareTable[is.na(compareTable$Tax),]$EmpCompensation - 
    compareTable[is.na(compareTable$Tax),]$GOS
  
  #adjust NA in gva (simple, add/subtract)
  compareTable[is.na(compareTable$GVA),]$GVA <- compareTable[is.na(compareTable$GVA),]$Tax +
    compareTable[is.na(compareTable$GVA),]$EmpCompensation + 
    compareTable[is.na(compareTable$GVA),]$GOS
  
  #adjust NA in EmpComp and GOS 
  ## Step 1: calculate EmpComp-GVA ratio and GOS-GVA ratio for each LineCode
  ratioTable <- compareTable %>% na.omit() %>% 
    dplyr::mutate(compRatio = EmpCompensation / GVA, gosRatio = GOS / GVA) %>% na.omit() %>%
    dplyr::group_by(LineCode) %>%
    dplyr::summarise(avgCompRatio = mean(compRatio), avgGOSRatio = mean(gosRatio))
  ## Step 2: assign new EmpComp and GOS value to NAs
  position <- which(is.na(compareTable$EmpCompensation) == TRUE)
  for (i in position) {
    if (compareTable$GVA[i] != 0) {
      compareTable$EmpCompensation[i] <- compareTable$GVA[i] * ratioTable[ratioTable$LineCode == compareTable$LineCode[i],]$avgCompRatio
      compareTable$GOS[i] <- compareTable$GVA[i] * ratioTable[ratioTable$LineCode == compareTable$LineCode[i],]$avgGOSRatio
    } else if (compareTable$GVA[i] == 0) {
      compareTable$EmpCompensation[i] <- 0
      compareTable$GOS[i] <- 0
    }
  }
  ## Step 3: check row sum and apply adjustment factor to estiamted rows 
  compareTable <- compareTable %>% dplyr::mutate(dif = GVA - EmpCompensation - Tax - GOS, errorRate = abs(dif) / GVA)
  shrinkfactor <- 1.0 + compareTable$dif[position] / (compareTable$EmpCompensation[position] + compareTable$GOS[position])
  compareTable$EmpCompensation[position] <- compareTable$EmpCompensation[position]*shrinkfactor
  compareTable$GOS[position] <- compareTable$GOS[position]*shrinkfactor
  
  compareTable <- compareTable %>% dplyr::mutate(dif = GVA - EmpCompensation - Tax - GOS, errorRate = abs(dif) / GVA) # recompute errorRate
  
  #Output
  switch_return <- switch(return, 'GVA'=1, 'EmpCompensation'=2, 'Tax'=3, 'GOS'=4)
  output <- compareTable %>% dplyr::select(1, 2, switch_return + 2)
  colnames(output)[3] <- as.character(year)
  return(output)
}

#' Assemble Summary-level gross value added sectors (V001, V002, V003) for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' #' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A data frame contains Summary-level gross value added (V001, V002, V003) for all states at a specific year.
assembleStateGrossValueAdded <- function(year, iolevel) {
  US_Use <- get(paste(iolevel, "Use", year, "PRO_BeforeRedef", sep = "_"))*1E6
  industries <- getVectorOfCodes(iolevel, "Industry")
  StateGVA <- data.frame()
  for (sector in c("EmpCompensation", "Tax", "GOS")) {
    # Generate Value Added tables by BEA
    df <- allocateStateTabletoBEASummary(sector, year, allocationweightsource = "Employment")
    # Convert table from long to wide
    df <- reshape2::dcast(df, GeoName ~ BEA_2012_Summary_Code, value.var = as.character(year))
    # Assign row names
    rownames(df) <- df$GeoName
    # Drop GeoName column
    df$GeoName <- NULL
    # Replace NA with 0
    df[is.na(df)] <- 0
    # Calculate Value Added for Overseas
    df["Overseas", ] <- df[rownames(df)=="United States *", ] - colSums(df[rownames(df)!="United States *", ])
    # Drop US values
    df <- df[rownames(df)!="United States *", industries]
    # Modify row names
    sector_code <- ifelse(sector=="EmpCompensation", "V001",
                          ifelse(sector=="Tax", "V002",
                                 ifelse(sector=="GOS", "V003")))
    BEAStateGVAtoBEASummary <- utils::read.table(system.file("extdata", "Crosswalk_StateGVAtoBEASummaryIO2012Schema.csv", package = "stateior"),
                                                 sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
    # Determine BEA line codes and sectors where ratios need adjustment
    allocation_sectors <- BEAStateGVAtoBEASummary[duplicated(BEAStateGVAtoBEASummary$LineCode) |
                                                    duplicated(BEAStateGVAtoBEASummary$LineCode, fromLast = TRUE), ]
    # Apply RAS balancing method to adjust VA_ratio of the disaggregated sectors
    for (linecode in unique(allocation_sectors$LineCode)) {
      # Determine BEA sectors that need allocation
      BEA_sectors <- allocation_sectors[allocation_sectors$LineCode==linecode, "BEA_2012_Summary_Code"]
      # Create m0
      m0 <- as.matrix(df[, BEA_sectors])
      # Create t_r
      GVAComponent <- adjustGVAComponent(year, sector)
      GVAComponent <- reshape2::dcast(GVAComponent, GeoName ~ LineCode, value.var = as.character(year))
      rownames(GVAComponent) <- GVAComponent$GeoName
      GVAComponent$GeoName <- NULL
      GVAComponent["Overseas", ] <- GVAComponent[rownames(GVAComponent)=="United States *", ] -
        colSums(GVAComponent[rownames(GVAComponent)!="United States *", ])
      t_r <- GVAComponent[rownames(m0), linecode]
      # Create t_c
      t_c <- as.numeric(US_Use[sector_code, BEA_sectors])
      # Apply RAS
      m <- applyRAS(m0, t_r, t_c, relative_diff = NULL, absolute_diff = 1, max_itr = 1E6)
      # Replace values in df with m
      df[rownames(m), colnames(m)] <- m
    }
    # Allocate US value added to states by values in df
    df_ratio <- sweep(df, 2, colSums(df), FUN = "/")
    StateGVA_sector <- sweep(df_ratio, 2, as.numeric(US_Use[sector_code, industries]), FUN = "*")
    rownames(StateGVA_sector) <- paste(rownames(StateGVA_sector), sector_code, sep = ".")
    StateGVA <- rbind(StateGVA, StateGVA_sector)
  }
  return (StateGVA)
}

#' Calculate state total PCE (personal consumption expenditures) at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains ratios of statetotal PCE for all states at a specific year at BEA Summary level.
calculateStateTotalPCE <- function(year) {
  # Load state and US PCE
  PCE <- getStatePCE(year)
  # Extract state total PCE
  StateTotalPCE <- PCE[PCE$Line==1 & PCE$GeoName!="United States", ]
  rownames(StateTotalPCE) <- StateTotalPCE$GeoName
  StateTotalPCE <- StateTotalPCE[, as.character(year), drop = FALSE]
  # Extract US total PCE
  USPCE <- sum(PCE[PCE$GeoName=="United States" & PCE$Line==1, as.character(year)])
  # Calculate PCE total in Overseas and append it to the state total table
  StateTotalPCE["Overseas", as.character(year)] <- USPCE - sum(StateTotalPCE[, as.character(year)])
  return(StateTotalPCE)
}

#' Calculate state-US PCE (personal consumption expenditures) ratios at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains ratios of state/US PCE for all states at a specific year at BEA Summary level.
calculateStateUSPCERatio <- function(year) {
  # Load state and US PCE
  PCE <- getStatePCE(year)
  # Extract State PCE
  StatePCE <- PCE[PCE$GeoName!="United States", ]
  # Generate sum of state PCE
  StatePCE_sum <- stats::aggregate(StatePCE[, as.character(year)], by = list(StatePCE$Line), sum)
  colnames(StatePCE_sum) <- c("Line", as.character(year))
  # Extract US PCE
  USPCE <- PCE[PCE$GeoName=="United States", c("Line", as.character(year))]
  # Merge sum of state PCE with US PCE to get PCE of Overseas region
  OverseasPCE <- merge(StatePCE_sum, USPCE, by = "Line")
  OverseasPCE[, as.character(year)] <- OverseasPCE[, paste0(year, ".y")] - OverseasPCE[, paste0(year, ".x")]
  OverseasPCE$GeoName <- "Overseas"
  # Append Overseas PCE to StatePCE
  StatePCE <- rbind(StatePCE, OverseasPCE[, colnames(StatePCE)])
  # Merge State and US PCE by LineCode
  StateUSPCE <- merge(StatePCE, USPCE, by = "Line")
  # Calculate the state-US PCE ratios by LineCode
  StateUSPCE$Ratio <- StateUSPCE[, paste0(year, ".x")]/StateUSPCE[, paste0(year, ".y")]
  # Map to BEA Summary
  StatePCEtoBEASummary <- utils::read.table(system.file("extdata", "Crosswalk_StatePCEtoBEASummaryIO2012Schema.csv", package = "stateior"),
                                            sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  StateUSPCE <- merge(StatePCEtoBEASummary[!StatePCEtoBEASummary$BEA_2012_Summary_Code=="", ],
                      StateUSPCE, by = "Line")
  # Adjust Ratio based on state PCE
  for (state in unique(StateUSPCE$GeoName)) {
    for (sector in unique(StateUSPCE$BEA_2012_Summary_Code)) {
      adjustedratio <- weighted.mean(StateUSPCE[StateUSPCE$GeoName==state&StateUSPCE$BEA_2012_Summary_Code==sector, "Ratio"],
                                     StateUSPCE[StateUSPCE$GeoName==state&StateUSPCE$BEA_2012_Summary_Code==sector, paste0(year, ".x")])
      StateUSPCE[StateUSPCE$GeoName==state&StateUSPCE$BEA_2012_Summary_Code==sector, "Ratio"] <- adjustedratio
    }
  }
  # Replace NaN with zero
  StateUSPCE[is.na(StateUSPCE$Ratio), "Ratio"] <- 0
  StateUSPCE$State <- StateUSPCE$GeoName
  # Keep wanted columns
  StateUSPCE <- unique(StateUSPCE[order(StateUSPCE$State, StateUSPCE$BEA_2012_Summary_Code),
                                  c("BEA_2012_Summary_Code", "State", "Ratio")])
  return(StateUSPCE)
}

#' Estimate state household demand at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state household demand for all states at a specific year at BEA Summary level.
estimateStateHouseholdDemand <- function(year) {
  # Load US Summary Use table
  US_Summary_Use <- getNationalUse("Summary", year)
  # Extract US Household Demand
  US_HouseholdDemand <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity"),
                                       getVectorOfCodes("Summary", "HouseholdDemand"), drop = FALSE]
  # Generate State_PCE_ratio
  PCE_ratio <- calculateStateUSPCERatio(year)
  # Calculate State_HouseholdDemand
  State_HouseholdDemand <- data.frame()
  for (state in unique(PCE_ratio$State)) {
    # Merge PCE_ratio with US_HouseholdDemand to keep all commodities
    HouseholdDemand <- merge(US_HouseholdDemand, PCE_ratio[PCE_ratio$State==state, ],
                             by.x = 0, by.y = "BEA_2012_Summary_Code", all.x = TRUE)
    # Calculate state HouseholdDemand
    HouseholdDemand$F010 <- HouseholdDemand$F010*HouseholdDemand$Ratio
    # Replace NA with zero
    HouseholdDemand[is.na(HouseholdDemand$F010), "F010"] <- 0
    # Assign rownames
    rownames(HouseholdDemand) <- HouseholdDemand$Row.names
    # Re-order table
    HouseholdDemand <- HouseholdDemand[rownames(US_HouseholdDemand), ]
    # Add state name to rownames
    rownames(HouseholdDemand) <- paste(state, rownames(HouseholdDemand), sep = ".")
    State_HouseholdDemand <- rbind.data.frame(State_HouseholdDemand, HouseholdDemand[, "F010", drop = FALSE])
  }
  return(State_HouseholdDemand)
}

#' Estimate state private investment at BEA Summary level.
#' Apply state PCE ratio to F02R.
#' Apply state Gross Output ratio to F02S, F02E, F02N, and F030.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state household demand for all states at a specific year at BEA Summary level.
estimateStatePrivateInvestment <- function(year) {
  US_Summary_Use <- getNationalUse("Summary", year)
  US_PrivateInvestment <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity"),
                                         c(getVectorOfCodes("Summary", "InvestmentDemand"),
                                           getVectorOfCodes("Summary", "ChangeInventories")), drop = FALSE]
  # Separate US_PrivateInvestment into Residential (F02R) and NonResidential (F02S, F02E, F02N, and F030)
  US_ResidentialInvestment <- US_PrivateInvestment[getVectorOfCodes("Summary", "Commodity"), "F02R", drop = FALSE]
  US_NonResidentialInvestment <- US_PrivateInvestment[getVectorOfCodes("Summary", "Commodity"),
                                                      colnames(US_PrivateInvestment)!="F02R"]
  # Apply state PCE ratio to F02R.
  # Generate state PCE ratio
  PCE_ratio <- calculateStateUSPCERatio(year)
  # Apply state Commodity Output ratio to F02S, F02E, F02N, and F030
  # Generate state Commodity Output ratio
  CommOutput_ratio <- calculateStateCommodityOutputRatio(year)
  # Calculate state Private Investment (Residential and NonResidential)
  State_ResidentialInvestment <- data.frame()
  State_NonResidentialInvestment <- data.frame()
  for (state in unique(PCE_ratio$State)) {
    # Residential
    ResidentialInvestment <- merge(US_ResidentialInvestment, PCE_ratio[PCE_ratio$State==state, ],
                                   by.x = 0, by.y = "BEA_2012_Summary_Code", all.x = TRUE)
    rownames(ResidentialInvestment) <- ResidentialInvestment$Row.names
    ResidentialInvestment$F02R <- ResidentialInvestment$F02R * ResidentialInvestment$Ratio
    ResidentialInvestment <- ResidentialInvestment[rownames(US_ResidentialInvestment), "F02R", drop = FALSE]
    ResidentialInvestment[is.na(ResidentialInvestment)] <- 0
    rownames(ResidentialInvestment) <- paste(state, rownames(ResidentialInvestment), sep = ".")
    State_ResidentialInvestment <- rbind.data.frame(State_ResidentialInvestment, ResidentialInvestment)
    # NonResidential
    NonResidentialInvestment <- merge(US_NonResidentialInvestment,
                                      CommOutput_ratio[CommOutput_ratio$State==state, ],
                                      by.x = 0, by.y = "BEA_2012_Summary_Code")
    columns <- colnames(US_NonResidentialInvestment)
    NonResidentialInvestment[, columns] <- NonResidentialInvestment[, columns] * NonResidentialInvestment$Ratio
    rownames(NonResidentialInvestment) <- NonResidentialInvestment$Row.names
    NonResidentialInvestment <- NonResidentialInvestment[rownames(US_ResidentialInvestment), ]
    rownames(NonResidentialInvestment) <- paste(state, rownames(NonResidentialInvestment), sep = ".")
    State_NonResidentialInvestment <- rbind.data.frame(State_NonResidentialInvestment,
                                                       NonResidentialInvestment[, columns])
  }
  # Assemble State Residential and NonResidential Private Investment
  State_PrivateInvestment <- cbind(State_ResidentialInvestment, State_NonResidentialInvestment)
  State_PrivateInvestment <- State_PrivateInvestment[, colnames(US_PrivateInvestment)]
  return(State_PrivateInvestment)
}

#' Estimate state export at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state export for all states at a specific year at BEA Summary level.
estimateStateExport <- function(year) {
  # Load US Summary Use table
  US_Summary_Use <- getNationalUse("Summary", year)
  # Extract US Export
  US_Export <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity"),
                              getVectorOfCodes("Summary", "Export"), drop = FALSE]
  # Generate state Commodity Output ratio
  CommOutput_ratio <- calculateStateCommodityOutputRatio(year)
  # Generate State_export_ratio
  State_export_ratio <- calculateCensusForeignCommodityFlowRatios(year, "export", 2012, "Summary")
  # Add SoITradeRatio of Overseas as zero
  Overseas_export_ratio <- cbind.data.frame(unique(State_export_ratio$BEA_2012_Summary_Code),
                                            "Overseas", "SoITradeRatio")
  colnames(Overseas_export_ratio) <- colnames(State_export_ratio)
  Overseas_export_ratio$SoITradeRatio <- 0
  State_export_ratio <- rbind.data.frame(State_export_ratio, Overseas_export_ratio)
  # For commodities that are not covered by Census data, use Commodity Output ratio instead
  State_export_ratio <- merge(State_export_ratio, CommOutput_ratio,
                              by = c("BEA_2012_Summary_Code", "State"), all.y = TRUE)
  State_export_ratio[is.na(State_export_ratio$SoITradeRatio), "SoITradeRatio"] <- State_export_ratio[is.na(State_export_ratio$SoITradeRatio), "Ratio"]
  # Adjust SoITradeRatio of oil and gas products
  State_export_ratio[State_export_ratio$BEA_2012_Summary_Code==211, "SoITradeRatio"] <- State_export_ratio[State_export_ratio$BEA_2012_Summary_Code==211, "Ratio"]
  # Calculate state export
  State_Export <- merge(US_Export, State_export_ratio, by.x = 0, by.y = "BEA_2012_Summary_Code")
  State_Export$F040 <- State_Export$F040 * State_Export$SoITradeRatio
  rownames(State_Export) <- paste(State_Export$State, State_Export$Row.names, sep = ".")
  State_Export <- State_Export[, "F040", drop = FALSE]
  return(State_Export)
}

#' Calculate state S&L government expenditure ratio at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state S&L government expenditure ratio for all states at a specific year at BEA Summary level.
calculateStateSLGovExpenditureRatio <- function(year) {
  # Load state and local government expenditure
  GovExp <- get(paste0("Census_StateLocalGovExpenditure_", year), as.environment("package:stateior"))
  GovExp[, "Overseas"] <- GovExp[, "United States Total"] - rowSums(GovExp[, c(state.name, "District of Columbia")])
  # Map to BEA Summary sectors
  mapping <- utils::read.table(system.file("extdata", "Crosswalk_StateLocalGovExptoBEASummaryIO2012Schema.csv", package = "stateior"),
                               sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  GovExpBEA <- merge(mapping, GovExp, by = c("Line", "Description"))
  # Calculate ratios
  states <- c(state.name, "District of Columbia", "Overseas")
  GovExpBEA[, states] <- GovExpBEA[, states]/GovExpBEA[, "United States Total"]
  # Drop unwanted columns
  GovExpBEA <- GovExpBEA[, c("FinalDemand", "BEA_2012_Summary_Code", states)]
  # Transform table
  # From wide to long
  GovExpBEA <- reshape2::melt(GovExpBEA, id.vars = c("FinalDemand", "BEA_2012_Summary_Code"))
  # From long to wide
  GovExpBEA <- reshape2::dcast(GovExpBEA, BEA_2012_Summary_Code + variable ~ FinalDemand,
                               value.var = "value")
  # Replace NA with 0
  GovExpBEA[is.na(GovExpBEA)] <- 0
  # Rename column
  colnames(GovExpBEA)[2] <- "State"
  return(GovExpBEA)
}

#' Estimate state S&L government expenditure at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state S&L government expenditure for all states
#' at a specific year at BEA Summary level.
estimateStateSLGovExpenditure <- function(year) {
  # Load US Summary Use table
  US_Summary_Use <- getNationalUse("Summary", year)
  # Extract US S&L Gov Expenditure
  SLGovDemandCodes <- c("F10C", "F10E", "F10N", "F10S")
  US_SLGovExp <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity"),
                                SLGovDemandCodes, drop = FALSE]
  # Generate SLGovExp_ratio
  SLGovExp_ratio <- calculateStateSLGovExpenditureRatio(year)
  # Calculate State_SLGovExp
  State_SLGovExp <- data.frame()
  for (state in unique(SLGovExp_ratio$State)) {
    # Merge US_SLGovExp and SLGovExp_ratio
    State_SLGovExp_state <- merge(SLGovExp_ratio[SLGovExp_ratio$State==state, ], US_SLGovExp,
                                  by.x = "BEA_2012_Summary_Code", by.y = 0, all.y = TRUE)
    # Modify State column
    State_SLGovExp_state$State <- state
    # Repalce NA with 0
    State_SLGovExp_state[is.na(State_SLGovExp_state)] <- 0
    State_SLGovExp_state[, SLGovDemandCodes] <- State_SLGovExp_state[, paste0(SLGovDemandCodes, ".x")] *
      State_SLGovExp_state[, paste0(SLGovDemandCodes, ".y")]
    # Modify rownames
    rownames(State_SLGovExp_state) <- State_SLGovExp_state$BEA_2012_Summary_Code
    State_SLGovExp_state <- State_SLGovExp_state[rownames(US_SLGovExp), ]
    rownames(State_SLGovExp_state) <- paste(state, rownames(State_SLGovExp_state), sep = ".")
    State_SLGovExp <- rbind.data.frame(State_SLGovExp, State_SLGovExp_state[, SLGovDemandCodes])
  }
  return(State_SLGovExp)
}

#' Calculate state-US employee compensation ratios at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state-US employment compensation ratios
#' for all states at a specific year at BEA Summary level.
calculateStateUSEmpCompensationRatio <- function(year) {
  # Generate state Employee Compensation table
  StateEmpCompensation <- allocateStateTabletoBEASummary("EmpCompensation", year, "Employment")
  # Separate into state Employee Compensation
  StateEmpCompensation <- StateEmpCompensation[StateEmpCompensation$GeoName!="United States *", ]
  # Map US Employee Compensation to BEA
  USEmpCompensation <- getStateEmpCompensation(year)
  USEmpCompensation <- USEmpCompensation[USEmpCompensation$GeoName=="United States *", ]
  BEAStateGVAtoBEASummary <- utils::read.table(system.file("extdata", "Crosswalk_StateGVAtoBEASummaryIO2012Schema.csv", package = "stateior"),
                                               sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  allocation_sectors <- BEAStateGVAtoBEASummary[duplicated(BEAStateGVAtoBEASummary$LineCode) | duplicated(BEAStateGVAtoBEASummary$LineCode, fromLast = TRUE), ]
  USEmpCompensation <- merge(USEmpCompensation, BEAStateGVAtoBEASummary, by = "LineCode")
  USEmpCompensation <- merge(USEmpCompensation, useeior::Summary_GrossOutput_IO[, as.character(year), drop = FALSE],
                             by.x = "BEA_2012_Summary_Code", by.y = 0)
  USEmpCompensation[, as.character(year)] <- USEmpCompensation[, paste0(year, ".x")]
  for (linecode in unique(allocation_sectors$LineCode)) {
    value_vector <- USEmpCompensation[USEmpCompensation$LineCode==linecode, paste0(year, ".x")]
    weight_vector <- USEmpCompensation[USEmpCompensation$LineCode==linecode, paste0(year, ".y")]
    USEmpCompensation[USEmpCompensation$LineCode==linecode, as.character(year)] <- value_vector*(weight_vector/sum(weight_vector))
  }
  USEmpCompensation <- USEmpCompensation[, c("BEA_2012_Summary_Code", as.character(year))]
  # Generate sum of state Employee Compensation
  StateEmpCompensation_sum <- stats::aggregate(StateEmpCompensation[, as.character(year)],
                                               by = list(StateEmpCompensation$BEA_2012_Summary_Code),
                                               sum, na.rm = TRUE)
  colnames(StateEmpCompensation_sum) <- c("BEA_2012_Summary_Code", "StateEmpCompensation_sum")
  # Merge sum of state Employee Compensation with US employee Compensation to get employee Compensation of Overseas region
  OverseasEmpCompensation <- merge(StateEmpCompensation_sum, USEmpCompensation,
                                   by = "BEA_2012_Summary_Code", all.x = TRUE)
  OverseasEmpCompensation[is.na(OverseasEmpCompensation)] <- 0
  OverseasEmpCompensation[, paste0(year, ".x")] <- OverseasEmpCompensation[, as.character(year)] - OverseasEmpCompensation$StateEmpCompensation_sum
  OverseasEmpCompensation[, paste0(year, ".y")] <- OverseasEmpCompensation[, as.character(year)]
  OverseasEmpCompensation$GeoName <- "Overseas"
  # Merge state GVA and US Employee Compensation tables
  StateUSEmpCompensation <- merge(StateEmpCompensation, USEmpCompensation, by = "BEA_2012_Summary_Code")
  # Append Overseas EmpCompensation to StateUSEmpCompensation
  StateUSEmpCompensation <- rbind(StateUSEmpCompensation, OverseasEmpCompensation[, colnames(StateUSEmpCompensation)])
  # Calculate the state-US Employee Compensation ratios
  StateUSEmpCompensation$Ratio <- StateUSEmpCompensation[, paste0(year, ".x")]/StateUSEmpCompensation[, paste0(year, ".y")]
  StateUSEmpCompensation$State <- StateUSEmpCompensation$GeoName
  StateUSEmpCompensation <- StateUSEmpCompensation[order(StateUSEmpCompensation$GeoName, StateUSEmpCompensation$BEA_2012_Summary_Code),
                                         c("BEA_2012_Summary_Code", "State", "Ratio")]
  StateUSEmpCompensation[is.na(StateUSEmpCompensation)] <- 0
  rownames(StateUSEmpCompensation) <- NULL
  return(StateUSEmpCompensation)
}

#' Calculate weighting factor of each expenditure component over US total gov expenditure.
#' @param year A numeric value between 2007 and 2019 specifying the year of interest.
#' @param defense A boolean value indicating if the expenditure is spent on defense or not.
#' @return A data frame contains weighting factor of each expenditure component over US total gov expenditure.
calculateUSGovExpenditureWeightFactor <- function(year, defense) {
  # Load data
  GovConsumption <- stateior::GovConsumption_2007_2019
  GovInvestment <- stateior::GovInvestment_2007_2019
  # Keep rows by line code
  if (defense) {
    GovConsumption <- GovConsumption[GovConsumption$Line%in%c(26, 28), ]
    GovInvestment <- GovInvestment[GovInvestment$Line%in%c(20:21, 23:24), ]
  } else {
    GovConsumption <- GovConsumption[GovConsumption$Line%in%c(37, 39), ]
    GovInvestment <- GovInvestment[GovInvestment$Line%in%c(28:29, 31:32), ]
  }
  # Calculate weight factors and stack dfs together
  WeightFactor <- rbind(cbind(GovConsumption[, c("Line", "Description")],
                              GovConsumption[, as.character(year), drop = FALSE]/colSums(GovConsumption[, as.character(year), drop = FALSE])),
                        cbind(GovInvestment[, c("Line", "Description")],
                              GovInvestment[, as.character(year), drop = FALSE]/colSums(GovInvestment[, as.character(year), drop = FALSE])))
  # Modify Description
  WeightFactor$Description <- gsub("\\\\.*", "", WeightFactor$Description)
  return(WeightFactor)
}

#' Calculate state fed government expenditure ratio at BEA Summary level.
#' @param year A numeric value between 2008 and 2019 specifying the year of interest.
#' @return A data frame contains state fed government expenditure ratio for all states at a specific year at BEA Summary level.
calculateStateFedGovExpenditureRatio <- function(year) {
  # Load state and local government expenditure
  GovExpRatio <- data.frame()
  sectors <- paste0(c("Intermediate", "Structure", "Equipment", "IP"),
                    rep(c("Defense", "NonDefense"), each = 4))
  mapping <- unique(useeior::MasterCrosswalk2012[, c("BEA_2012_Summary_Code",
                                                     "NAICS_2012_Code")])
  for(sector in sectors) {
    GovExp <- get(paste("FedGovExp", sector, year, sep = "_"),
                  as.environment("package:stateior"))
    # Change State to full state name
    for (state in unique(GovExp$State)) {
      GovExp[GovExp$State==state, "State"] <- ifelse(state=="DC", "District of Columbia",
                                                     state.name[which(state.abb==state)])
    }
    # Map to BEA Summary sectors
    GovExpBEA <- merge(mapping, GovExp, by.x = "NAICS_2012_Code", by.y = "NAICS")
    # Aggregate by BEA
    GovExpBEA <- stats::aggregate(Amount ~ BEA_2012_Summary_Code + Year + State,
                                  GovExpBEA, sum)
    # Transform table from long to wide
    GovExpBEA <- reshape2::dcast(GovExpBEA, BEA_2012_Summary_Code ~ State,
                                 value.var = "Amount")
    GovExpBEA[is.na(GovExpBEA)] <- 0
    # Calculate ratios
    GovExpBEA[, -1] <- GovExpBEA[, -1]/rowSums(GovExpBEA[, -1])
    # Add missing states
    GovExpBEA[, c(setdiff(state.name, colnames(GovExpBEA[, -1])), "Overseas")] <- 0
    # Transform table from wide to long
    GovExpBEA <- reshape2::melt(GovExpBEA, id.vars = "BEA_2012_Summary_Code",
                                variable.name = "State", value.name = "Ratio")
    # Add Sector column
    GovExpBEA$Sector <- sector
    GovExpRatio <- rbind(GovExpRatio, GovExpBEA)
  }
  # Transform table from long to wide
  GovExpRatio <- reshape2::dcast(GovExpRatio, BEA_2012_Summary_Code + State ~ Sector,
                                 value.var = "Ratio")
  # Replace NA with 0
  GovExpRatio[is.na(GovExpRatio)] <- 0
  # Rename columns
  colnames(GovExpRatio)[c(3:4, 7:10)] <- c("F06E", "F07E", "F06N", "F07N", "F06S", "F07S")
  # Calculate ratios for Consumption expenditures (F06C and F07C)
  # A_C <- X_E * W_E + X_IC * W_IC
  # where X_E is EmpCompensationRatio, X_IC is Fed Gov Intermediate Consumption ratio
  # W_E is GovExpWeightFactor of employment, W_IC is GovExpWeightFactor of IC
  # Generate state-US employment compensation ratios (X_E)
  EmpCompensationRatio <- calculateStateUSEmpCompensationRatio(year)
  # Merge with GovExpRatio
  GovExpRatio <- merge(GovExpRatio, EmpCompensationRatio,
                       by = c("BEA_2012_Summary_Code", "State"), all.x = TRUE)
  # Generate GovExpWeightFactor (W_E and W_IC)
  WeightFactor_D <- calculateUSGovExpenditureWeightFactor(year, defense = TRUE)
  WeightFactor_NonD <- calculateUSGovExpenditureWeightFactor(year, defense = FALSE)
  # Calculate Defense ratios
  W_E_D <- WeightFactor_D[WeightFactor_D$Line==26, as.character(year)]
  W_IC_D <- WeightFactor_D[WeightFactor_D$Line==28, as.character(year)]
  GovExpRatio[, "F06C"] <- GovExpRatio$Ratio * W_E_D + GovExpRatio$IntermediateDefense * W_IC_D
  # Calculate Non-Defense ratios
  W_E_NonD <- WeightFactor_NonD[WeightFactor_NonD$Line==37, as.character(year)]
  W_IC_NonD <- WeightFactor_NonD[WeightFactor_NonD$Line==39, as.character(year)]
  GovExpRatio[, "F07C"] <- GovExpRatio$Ratio * W_E_NonD + GovExpRatio$IntermediateDefense * W_IC_NonD
  # Drop unwanted columns
  GovExpRatio <- GovExpRatio[, c("BEA_2012_Summary_Code", "State", "F06C", "F06E",
                                 "F06N", "F06S", "F07C", "F07E", "F07N", "F07S")]
  return(GovExpRatio)
}

#' Estimate state fed government expenditure at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state fed government expenditure for all states
#' at a specific year at BEA Summary level.
estimateStateFedGovExpenditure <- function(year) {
  # Load FedGovExp data
  # Load US Summary Use table
  US_Summary_Use <- getNationalUse("Summary", year)
  # Extract US S&L Gov Expenditure
  FedGovDemandCodes <- c("F06C", "F06E", "F06N", "F06S", "F07C", "F07E", "F07N", "F07S")
  US_FedGovExp <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity"), FedGovDemandCodes, drop = FALSE]
  # Generate FedGovExp_ratio
  FedGovExp_ratio <- calculateStateFedGovExpenditureRatio(year)
  # Generate state Commodity Output ratio
  CommOutput_ratio <- calculateStateCommodityOutputRatio(year)
  # Determine commodities that not in FedGovExp_ratio
  commodities <- unique(setdiff(CommOutput_ratio$BEA_2012_Summary_Code,
                                FedGovExp_ratio$BEA_2012_Summary_Code))
  # Add CommOutput_ratio of commodities to FedGovExp_ratio
  tmp <- CommOutput_ratio[CommOutput_ratio$BEA_2012_Summary_Code%in%commodities, ]
  tmp[, FedGovDemandCodes] <- tmp$Ratio
  FedGovExp_ratio <- rbind(FedGovExp_ratio, tmp[, colnames(FedGovExp_ratio)])
  # Calculate State_FedGovExp
  State_FedGovExp <- data.frame()
  for (state in unique(FedGovExp_ratio$State)) {
    # Merge US_FedGovExp and FedGovExp_ratio
    State_FedGovExp_state <- merge(FedGovExp_ratio[FedGovExp_ratio$State==state, ],
                                   US_FedGovExp, by.x = "BEA_2012_Summary_Code",
                                   by.y = 0, all.y = TRUE)
    # Modify State column
    State_FedGovExp_state$State <- state
    # Repalce NA with 0
    State_FedGovExp_state[is.na(State_FedGovExp_state)] <- 0
    # Multiply national final demand by state-US ratio
    ratio <- State_FedGovExp_state[, paste0(FedGovDemandCodes, ".x")]
    US_value <- State_FedGovExp_state[, paste0(FedGovDemandCodes, ".y")]
    State_FedGovExp_state[, FedGovDemandCodes] <- ratio * US_value
    # Modify rownames
    rownames(State_FedGovExp_state) <- State_FedGovExp_state$BEA_2012_Summary_Code
    State_FedGovExp_state <- State_FedGovExp_state[rownames(US_FedGovExp), ]
    rownames(State_FedGovExp_state) <- paste(state, rownames(State_FedGovExp_state), sep = ".")
    State_FedGovExp <- rbind.data.frame(State_FedGovExp, State_FedGovExp_state[, FedGovDemandCodes])
  }
  return(State_FedGovExp)
}
