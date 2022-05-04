#' Get US Use table (intermediaete + final demand) of specified iolevel and year.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @param year A numeric value specifying the year of interest.
#' @return The US Use table (intermediaete + final demand) of specified iolevel and year.
getNationalUse <- function(iolevel, year) {
  # Load pre-saved US Use table
  Use <- loadDatafromUSEEIOR(paste(iolevel, "Use", year, "PRO_BeforeRedef", sep = "_"))*1E6
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
  StateEmpCompensation <- loadStateIODataFile("State_Compensation_2007_2017")
  StateEmpCompensation <- StateEmpCompensation[, c("GeoName", "LineCode", as.character(year))]
  return(StateEmpCompensation)
}

#' Get industry-level Tax for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state Tax for all states at a specific year.
getStateTax <- function(year) {
  # Load pre-saved state Tax 2007-2017
  StateTax <- loadStateIODataFile("State_Tax_2007_2017")
  StateTax <- StateTax[, c("GeoName", "LineCode", as.character(year))]
  return(StateTax)
}

#' Get industry-level Gross Operating Surplus (GOS) for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state GOS for all states at a specific year.
getStateGOS <- function(year) {
  # Load pre-saved state GOS 2007-2017
  StateGOS <- loadStateIODataFile("State_GOS_2007_2017")
  StateGOS <- StateGOS[, c("GeoName", "LineCode", as.character(year))]
  return(StateGOS)
}

#' Get commodity-level Personal Consumption Expenditure (PCE) for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state PCE for all states at a specific year.
getStatePCE <- function(year) {
  # Load pre-saved state PCE 2007-2018
  StatePCE <- loadStateIODataFile("State_PCE_2007_2018")
  StatePCE <- StatePCE[, c("GeoName", "LineCode", as.character(year))]
  return(StatePCE)
}

#' Calculate state-US Commodity Output ratios at BEA Summary level.
#' Apply row sum to state and US Make tables to get commodity output vectors and
#' then Commodity Output Ratio (COR).
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state-US Commodity Output ratios at BEA Summary level.
calculateStateCommodityOutputRatio <- function(year) {
  # Load state Make table
  StateMake_ls <- loadStateIODataFile(paste0("State_Summary_Make_", year))
  states <- names(StateMake_ls)
  # Load US Commodity output
  US_Make <- getNationalMake("Summary", year)
  # Calculate state Commodity output ratio
  State_COR <- data.frame()
  for (state in states) {
    COR <- cbind.data.frame(names(colSums(US_Make)), state,
                            colSums(StateMake_ls[[state]])/colSums(US_Make),
                            stringsAsFactors = FALSE)
    rownames(COR) <- NULL
    colnames(COR) <- c("BEA_2012_Summary_Code", "State", "Ratio")
    State_COR <- rbind(State_COR, COR)
  }
  return(State_COR)
}

#' Estimate state Intermediate Consumption at BEA Summary level.
#' For each state and industry, calculate state_US_IndustryOutput_ratio,
#' then multiply US_Use_Intermediate by the ratio to get State_Use_Intermediate.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A list of data.frames containing state Intermediate Consumption.
estimateStateIntermediateConsumption <- function(year) {
  # Define industries, commodities and # Define final demand columns
  industries <- getVectorOfCodes("Summary", "Industry")
  commodities <- getVectorOfCodes("Summary", "Commodity")
  
  # Load state Make table
  StateMake_ls <- loadStateIODataFile(paste0("State_Summary_Make_", year))
  # Load US Make and Use tables
  US_Make <- getNationalMake("Summary", year)
  US_Use <- getNationalUse("Summary", year)
  
  logging::loginfo("Estimating state intermediate consumption...")
  # For each state and industry, calculate state_US_IndustryOutput_ratio
  # Multiply US_Use_Intermediate by state_US_IndustryOutput_ratio 
  State_Use_Intermediate_ls <- list()
  for (state in names(StateMake_ls)) {
    IOR <- rowSums(StateMake_ls[[state]])/rowSums(US_Make)
    State_Use_Intermediate <- as.matrix(US_Use[commodities, industries]) %*% diag(IOR)
    colnames(State_Use_Intermediate) <- colnames(US_Use[commodities, industries])
    State_Use_Intermediate_ls[[state]] <- as.data.frame(State_Use_Intermediate)
  }
  return(State_Use_Intermediate_ls)
}

#' Adjust EmpComp, Tax, and GOS to fill NA and make them consistent with GVA
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param return A character string showing which attribute to return. 'comp', 'tax', 'gos'
#' @importFrom magrittr %>%
#' @return A data frame contains adjusted EmpComp, Tax, GOS, and GVA
adjustGVAComponent <- function(year, return) {
  # Load data
  gva <- getStateGVA(year)
  comp <- getStateEmpCompensation(year)
  tax <- getStateTax(year)
  gos <- getStateGOS(year)
  
  # Join into one table
  compareTable <- gva %>% 
    dplyr::left_join(., comp, by=c('GeoName','LineCode')) %>% 
    dplyr::left_join(., tax, by=c('GeoName','LineCode')) %>%
    dplyr::left_join(., gos, by=c('GeoName','LineCode')) 
  colnames(compareTable)[3:6] <- c('GVA','EmpCompensation','Tax','GOS')
  
  # Adjust NA in Tax (simple, add/subtract)
  compareTable[is.na(compareTable$Tax),]$Tax <- compareTable[is.na(compareTable$Tax),]$GVA - 
    compareTable[is.na(compareTable$Tax),]$EmpCompensation - 
    compareTable[is.na(compareTable$Tax),]$GOS
  
  # Adjust NA in gva (simple, add/subtract)
  compareTable[is.na(compareTable$GVA),]$GVA <- compareTable[is.na(compareTable$GVA),]$Tax +
    compareTable[is.na(compareTable$GVA),]$EmpCompensation + 
    compareTable[is.na(compareTable$GVA),]$GOS
  # Further adjust NA in gva using state employment
  if (nrow(compareTable[is.na(compareTable$GVA), ]) > 0) {
    GVAtoBEAmapping <- loadBEAStateDatatoBEASummaryMapping("GVA")
    StateEmp <- getStateEmploymentbyBEASummary(year)
    # Extract State and LineCode that have NA in gva from compareTable
    StateLineCodePair <- compareTable[is.na(compareTable$GVA), c("GeoName", "LineCode")]
    for (i in 1:nrow(StateLineCodePair)) {
      # Determine corresponding BEA sector
      BEAsector <- GVAtoBEAmapping[GVAtoBEAmapping$LineCode==StateLineCodePair[i, "LineCode"],
                                   "BEA_2012_Summary_Code"]
      # Extract state emp number for the BEA sector
      StateEmp_i <- StateEmp[StateEmp$State==StateLineCodePair[i, "GeoName"] &
                               StateEmp$BEA_2012_Summary_Code%in%BEAsector, "Emp"]
      # Calculate state-US EmpRatio
      EmpRatio <- StateEmp_i/sum(StateEmp[StateEmp$BEA_2012_Summary_Code%in%BEAsector, "Emp"])
      # Determine US gva for the target LineCode
      US_GVA <- compareTable[compareTable$GeoName=="United States *" &
                               compareTable$LineCode==StateLineCodePair[i, "LineCode"], "GVA"]
      # Replace NA with US_GVA * EmpRatio
      compareTable[rownames(StateLineCodePair), "GVA"] <- US_GVA * EmpRatio
    }
  }
  
  # Adjust NA in EmpComp and GOS 
  ## Step 1: calculate EmpComp-GVA ratio and GOS-GVA ratio for each LineCode
  ratioTable <- compareTable %>%
    stats::na.omit() %>% 
    dplyr::mutate(compRatio = EmpCompensation / GVA, gosRatio = GOS / GVA) %>%
    stats::na.omit() %>%
    dplyr::group_by(LineCode) %>%
    dplyr::summarise(avgCompRatio = mean(compRatio), avgGOSRatio = mean(gosRatio))
  ## Step 2: impute EmpComp and GOS values
  position <- union(which(is.na(compareTable$EmpCompensation) == TRUE),
                    which(is.na(compareTable$GOS) == TRUE))
  for (i in position) {
    if (compareTable$GVA[i] != 0) {
      # EmpComp
      ratio_comp <- ratioTable[ratioTable$LineCode == compareTable$LineCode[i],]$avgCompRatio
      compareTable$EmpCompensation[i] <- compareTable$GVA[i] * ratio_comp
      # GOS
      ratio_gos <- ratioTable[ratioTable$LineCode == compareTable$LineCode[i],]$avgGOSRatio
      compareTable$GOS[i] <- compareTable$GVA[i] * ratio_gos
    } else if (compareTable$GVA[i] == 0) {
      if (compareTable$Tax[i] == 0) {
        compareTable$EmpCompensation[i] <- 0
        compareTable$GOS[i] <- 0
      } else {
        compareTable$EmpCompensation[i] <- 0
        compareTable$GOS[i] <- 0 - compareTable$Tax[i]
      }
    }
  }
  ## Step 3: check row sum and apply adjustment factor to estiamted rows 
  compareTable <- compareTable %>% 
    dplyr::mutate(dif = GVA - EmpCompensation - Tax - GOS, errorRate = abs(dif) / GVA)
  shrinkfactor <- 1.0 + compareTable$dif[position] / (compareTable$EmpCompensation[position] + compareTable$GOS[position])
  compareTable$EmpCompensation[position] <- compareTable$EmpCompensation[position]*shrinkfactor
  compareTable$GOS[position] <- compareTable$GOS[position]*shrinkfactor
  
  compareTable <- compareTable %>% 
    dplyr::mutate(dif = GVA - EmpCompensation - Tax - GOS, errorRate = abs(dif) / GVA) # recompute errorRate
  
  # Check if GVA = EmpCompensation + Tax + GOS, with tolerance of $10 million
  check_condition <- abs(compareTable$dif) > 1E7
  if (any(check_condition)) {
    geoname <- compareTable[check_condition, "GeoName"]
    linecode <- compareTable[check_condition, "LineCode"]
    logging::logwarn(glue::glue("In {geoname} for {linecode}",
                                "GVA components do not add up to total GVA."))
    stop("GVA components by line code do not add up to total GVA by line code.")
  }
  
  #Output
  switch_return <- switch(return, 'GVA'=1, 'EmpCompensation'=2, 'Tax'=3, 'GOS'=4)
  output <- compareTable %>% dplyr::select(1, 2, switch_return + 2)
  colnames(output)[3] <- as.character(year)
  return(output)
}

#' Assemble Summary-level gross value added sectors (V001, V002, V003) for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains Summary-level gross value added (V001, V002, V003) for all states at a specific year.
assembleStateSummaryGrossValueAdded <- function(year) {
  US_Use <- loadDatafromUSEEIOR(paste("Summary_Use", year, "PRO_BeforeRedef", sep = "_"))*1E6
  industries <- getVectorOfCodes("Summary", "Industry")
  # Determine BEA line codes and sectors where ratios need adjustment
  GVAtoBEAmapping <- loadBEAStateDatatoBEASummaryMapping("GVA")
  allocation_sectors <- GVAtoBEAmapping[duplicated(GVAtoBEAmapping$LineCode) |
                                          duplicated(GVAtoBEAmapping$LineCode, fromLast = TRUE), ]
  logging::loginfo("Estimating state value added...")
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
    # Calculate Value Added for Overseas
    df["Overseas", ] <- df[rownames(df)=="United States *", ] - colSums(df[rownames(df)!="United States *", ])
    # Drop US values
    df <- df[rownames(df)!="United States *", industries]
    # Modify row names
    sector_code <- ifelse(sector=="EmpCompensation", "V001",
                          ifelse(sector=="Tax", "V002",
                                 ifelse(sector=="GOS", "V003", NULL)))
    GVAComponent <- adjustGVAComponent(year, sector)
    GVAComponent <- reshape2::dcast(GVAComponent, GeoName ~ LineCode, value.var = as.character(year))
    rownames(GVAComponent) <- GVAComponent$GeoName
    GVAComponent$GeoName <- NULL
    GVAComponent["Overseas", ] <- GVAComponent[rownames(GVAComponent)=="United States *", ] -
      colSums(GVAComponent[rownames(GVAComponent)!="United States *", ])
    # Apply RAS balancing method to adjust VA_ratio of the disaggregated sectors
    for (linecode in unique(allocation_sectors$LineCode)) {
      # Determine BEA sectors that need allocation
      BEA_sectors <- allocation_sectors[allocation_sectors$LineCode==linecode, "BEA_2012_Summary_Code"]
      # Create m0, t_r and t_c
      m0 <- as.matrix(df[, BEA_sectors])
      t_r <- GVAComponent[rownames(m0), linecode]
      t_c <- as.numeric(US_Use[sector_code, BEA_sectors])
      # Apply RAS
      m <- applyRAS(m0, t_r, t_c, relative_diff = NULL, absolute_diff = 1, max_itr = 1E6)
      # Replace values in df with m
      df[rownames(m), colnames(m)] <- m
    }
    # Create df_ratio based on df, replace NaNs caused by colSums(df)==0 with 1/nrow(df)
    df_ratio <- sweep(df, 2, colSums(df), FUN = "/")
    df_ratio[is.na(df_ratio)] <- 1/nrow(df)
    # Allocate US value added to states by values in df
    StateGVA_sector <- sweep(df_ratio, 2, as.numeric(US_Use[sector_code, industries]), FUN = "*")
    rownames(StateGVA_sector) <- paste(rownames(StateGVA_sector), sector_code, sep = ".")
    StateGVA <- rbind(StateGVA, StateGVA_sector)
  }
  
  logging::loginfo("Balancing state value added...")
  # Balance StateGVA with (rowSums(Make) - colSums(Use))
  # Step 1. Balance VA-by-state table
  # Sum StateGVA to get VA-by-state table
  StateGVA_sum <- as.data.frame(rowSums(StateGVA))
  colnames(StateGVA_sum) <- "Value"
  StateGVA_sum$State <- sub("\\..*", "", rownames(StateGVA_sum))
  StateGVA_sum$Sector <- sub(".*\\.", "", rownames(StateGVA_sum))
  StateGVA_sum_table <- reshape2::dcast(StateGVA_sum, Sector ~ State, value.var = "Value")
  rownames(StateGVA_sum_table) <- StateGVA_sum_table$Sector
  StateGVA_sum_table$Sector <- NULL
  # Prepare m0, t_r and t_c
  StateGVA_sum_m0 <- as.matrix(StateGVA_sum_table)
  t_r <- as.numeric(rowSums(US_Use[c("V001", "V002", "V003"), industries]))
  StateMake_ls <- loadStateIODataFile(paste0("State_Summary_Make_", year))
  State_Use_Intermediate_ls <- estimateStateIntermediateConsumption(year)
  t_c <- as.numeric(unlist(lapply(names(StateMake_ls),
                                  function(x) sum(StateMake_ls[[x]]))) -
                      unlist(lapply(names(State_Use_Intermediate_ls),
                                    function(x) sum(State_Use_Intermediate_ls[[x]]))))
  # Apply RAS to get m
  StateGVA_sum_m <- applyRAS(StateGVA_sum_m0, t_r, t_c, relative_diff = NULL,
                             absolute_diff = 1, max_itr = 1E6)
  # Step 2. Balance each state's VA-by-Industry table
  StateGVA_balanced <- data.frame()
  for (state in names(StateMake_ls)) {
    m0 <- as.matrix(StateGVA[gsub("\\..*", "", rownames(StateGVA))==state, ])
    t_r <- StateGVA_sum_m[, state]
    t_c <- rowSums(StateMake_ls[[state]]) - colSums(State_Use_Intermediate_ls[[state]])
    m <- applyRAS(m0, t_r, t_c, relative_diff = NULL, absolute_diff = 1, max_itr = 1E6)
    StateGVA_balanced <- rbind(StateGVA_balanced, as.data.frame(m))
    # Validation - interrupt if industry output (x) from Make != x from Use by 1E-5
    GVA <- StateGVA_balanced[gsub("\\..*", "", rownames(StateGVA_balanced))==state, ]
    x_make <- rowSums(StateMake_ls[[state]])
    x_use <- colSums(as.data.frame(GVA)) + colSums(State_Use_Intermediate_ls[[state]])
    rel_diff <- (x_use - x_make)/x_make
    if(max(abs(rel_diff), na.rm = TRUE)>1E-5&&state!="Overseas") {
      stop(paste0(state, "'s Make and Use tables are not balanced ",
                  "in terms of industry output."))
    }
  }
  return (StateGVA_balanced)
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
  colnames(StatePCE_sum) <- c("LineCode", as.character(year))
  # Extract US PCE
  USPCE <- PCE[PCE$GeoName=="United States", c("LineCode", as.character(year))]
  # Merge sum of state PCE with US PCE to get PCE of Overseas region
  OverseasPCE <- merge(StatePCE_sum, USPCE, by = "LineCode")
  OverseasPCE[, as.character(year)] <- OverseasPCE[, paste0(year, ".y")] - OverseasPCE[, paste0(year, ".x")]
  OverseasPCE$GeoName <- "Overseas"
  # Append Overseas PCE to StatePCE
  StatePCE <- rbind(StatePCE, OverseasPCE[, colnames(StatePCE)])
  # Merge State and US PCE by LineCode
  StateUSPCE <- merge(StatePCE, USPCE, by = "LineCode")
  # Calculate the state-US PCE ratios by LineCode
  StateUSPCE$Ratio <- StateUSPCE[, paste0(year, ".x")]/StateUSPCE[, paste0(year, ".y")]
  # Map to BEA Summary
  filename <- "Crosswalk_StatePCEtoBEASummaryIO2012Schema.csv"
  StatePCEtoBEASummary <- readCSV(system.file("extdata", filename, package = "stateior"))
  StateUSPCE <- merge(StatePCEtoBEASummary[!StatePCEtoBEASummary$BEA_2012_Summary_Code=="", ],
                      StateUSPCE, by.x = "Line", by.y = "LineCode")
  # Adjust Ratio based on state PCE
  for (state in unique(StateUSPCE$GeoName)) {
    for (sector in unique(StateUSPCE$BEA_2012_Summary_Code)) {
      df <- StateUSPCE[StateUSPCE$GeoName==state&
                         StateUSPCE$BEA_2012_Summary_Code==sector, ]
      adjustedratio <- weighted.mean(df$Ratio, df[, paste0(year, ".x")])
      StateUSPCE[StateUSPCE$GeoName==state&
                   StateUSPCE$BEA_2012_Summary_Code==sector, "Ratio"] <- adjustedratio
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
  # Define BEA_col
  BEA_col <- "BEA_2012_Summary_Code"
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
  Overseas_export_ratio <- cbind.data.frame(unique(State_export_ratio[, BEA_col]),
                                            "Overseas", "SoITradeRatio")
  colnames(Overseas_export_ratio) <- colnames(State_export_ratio)
  Overseas_export_ratio$SoITradeRatio <- 0
  State_export_ratio <- rbind.data.frame(State_export_ratio, Overseas_export_ratio)
  # For commodities that are not covered by Census data, use Commodity Output ratio instead
  State_export_ratio <- merge(State_export_ratio, CommOutput_ratio,
                              by = c(BEA_col, "State"), all.y = TRUE)
  # Replace NA in SoITradeRatio with Ratio
  ratio_replacement <- State_export_ratio[is.na(State_export_ratio$SoITradeRatio), "Ratio"]
  State_export_ratio[is.na(State_export_ratio$SoITradeRatio), "SoITradeRatio"] <- ratio_replacement
  # Adjust SoITradeRatio of oil and gas products
  ratio_oilgas <- State_export_ratio[State_export_ratio[, BEA_col]==211, "Ratio"]
  State_export_ratio[State_export_ratio[, BEA_col]==211, "SoITradeRatio"] <- ratio_oilgas
  # Calculate state export
  State_Export <- merge(US_Export, State_export_ratio, by.x = 0, by.y = BEA_col)
  State_Export$F040 <- State_Export$F040 * State_Export$SoITradeRatio
  rownames(State_Export) <- paste(State_Export$State, State_Export$Row.names, sep = ".")
  State_Export <- State_Export[, "F040", drop = FALSE]
  
  # Adjust state international exports to avoid state exports > state commodity output
  StateMake_ls <- loadStateIODataFile(paste0("State_Summary_Make_", year))
  State_CommOutput <- as.data.frame(unlist(lapply(names(StateMake_ls),
                                                  function(x) colSums(StateMake_ls[[x]]))))
  rownames(State_CommOutput) <- paste(rep(names(StateMake_ls), each = ncol(StateMake_ls[[1]])),
                                      colnames(StateMake_ls[[1]]),
                                      sep = ".")
  colnames(State_CommOutput) <- "Output"
  State_CommOutput <- State_CommOutput[rownames(State_Export), , drop = FALSE]
  # Prepare vectors of commodities and states that will be examined and adjusted
  commodities <- setdiff(unique(gsub(".*\\.", "", rownames(State_CommOutput))),
                         c("Other", "Used"))
  states <- setdiff(unique(gsub("\\..*", "", rownames(State_CommOutput))), "Overseas")
  states_comms <- paste(states, rep(commodities, length(states)), sep = ".")
  # Prepare a static copy of State_Export 
  State_Export_original <- State_Export
  
  # Determine original condition:
  # Compare state commodity output against the sum of state export and following FD sectors
  # whose state values are derived using COR (or ratios similar to COR, e.g. gross output ratios)
  # F02S - Nonresidential private fixed investment in structures
  # F02N - Nonresidential private fixed investment in intellectual property products
  # F030 - Change in private inventories
  StatePI <- estimateStatePrivateInvestment(year)
  StatePI_sum <- rowSums(StatePI[, c("F02S", "F02N", "F030")])
  original_condition <- State_Export[states_comms, ] + StatePI_sum[states_comms] > State_CommOutput[states_comms, ]
  
  # For each problematic commodity, apply the adjustment
  for (comm in unique(gsub(".*\\.", "", states_comms[original_condition]))) {
    # Set i and states_comm
    i <- 1
    states_comm <- paste(states, comm, sep = ".")
    # Enter the while loop as long as there are state exports + state PI > commodity output
    max_itr <- 1E3
    while(any(State_Export[states_comm, ] + StatePI_sum[states_comm] > State_CommOutput[states_comm, ])) {
      # Determine new condition for each iteration in while loop
      new_condition <- State_Export[states_comm, ] + StatePI_sum[states_comm] > State_CommOutput[states_comm, ]
      # Set state and trouble_rows
      state <- unique(gsub("\\..*", "", states_comm[new_condition]))
      trouble_rows <- paste(state, comm, sep = ".")
      # Calculate total residual
      comm_output_ratio <- CommOutput_ratio[CommOutput_ratio[, BEA_col]==comm&
                                              CommOutput_ratio$State%in%state, "Ratio"]
      residual <- sum(State_Export[trouble_rows, ] - US_Export[comm, ]*comm_output_ratio)
      # Determine allocate_to_rows
      allocate_to_rows <- paste(setdiff(states, state), comm, sep = ".")
      # Use original export amount as weight
      weight <- State_Export_original[allocate_to_rows, ]
      # Allocate residual to all other states 
      residual_df <- as.data.frame(residual*(weight/sum(weight)),
                                   row.names = allocate_to_rows)
      # Adjust State_Export
      State_Export[allocate_to_rows, ] <- State_Export[allocate_to_rows, ] + residual_df
      State_Export[trouble_rows, ] <- US_Export[comm, ]*comm_output_ratio
      i <- i + 1
      if (i >= max_itr) {
        stop("Allocation of export residuals exceeds maximum iteration.")
      }
    }
  }
  return(State_Export)
}

#' Calculate state S&L government expenditure ratio at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state S&L government expenditure ratio for all states at a specific year at BEA Summary level.
calculateStateSLGovExpenditureRatio <- function(year) {
  # Load state and local government expenditure
  GovExp <- loadStateIODataFile(paste0("Census_StateLocalGovExpenditure_", year))
  GovExp_statetotal <- rowSums(GovExp[, c(state.name, "District of Columbia")])
  GovExp[, "Overseas"] <- GovExp[, "United States Total"] - GovExp_statetotal
  # Map to BEA Summary sectors
  filename <- "Crosswalk_StateLocalGovExptoBEASummaryIO2012Schema.csv"
  mapping <- readCSV(system.file("extdata", filename, package = "stateior"))
  GovExpBEA <- merge(mapping, GovExp, by = c("Line", "Description"))
  # Calculate ratios
  states <- c(state.name, "District of Columbia", "Overseas")
  GovExpBEA[, states] <- GovExpBEA[, states]/GovExpBEA[, "United States Total"]
  # Drop unwanted columns
  GovExpBEA <- GovExpBEA[, c("FinalDemand", "BEA_2012_Summary_Code", states)]
  # Transform table
  # From wide to long
  GovExpBEA <- reshape2::melt(GovExpBEA, id.vars = c("FinalDemand",
                                                     "BEA_2012_Summary_Code"))
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
    State_SLGovExp_state <- merge(SLGovExp_ratio[SLGovExp_ratio$State==state, ],
                                  US_SLGovExp, by.x = "BEA_2012_Summary_Code",
                                  by.y = 0, all.y = TRUE)
    # Modify State column
    State_SLGovExp_state$State <- state
    # Repalce NA with 0
    State_SLGovExp_state[is.na(State_SLGovExp_state)] <- 0
    x_value <- State_SLGovExp_state[, paste0(SLGovDemandCodes, ".x")]
    y_value <- State_SLGovExp_state[, paste0(SLGovDemandCodes, ".y")]
    State_SLGovExp_state[, SLGovDemandCodes] <- x_value * y_value
    # Modify rownames
    rownames(State_SLGovExp_state) <- State_SLGovExp_state$BEA_2012_Summary_Code
    State_SLGovExp_state <- State_SLGovExp_state[rownames(US_SLGovExp), ]
    rownames(State_SLGovExp_state) <- paste(state, rownames(State_SLGovExp_state),
                                            sep = ".")
    State_SLGovExp <- rbind.data.frame(State_SLGovExp,
                                       State_SLGovExp_state[, SLGovDemandCodes])
  }
  return(State_SLGovExp)
}

#' Calculate state-US employee compensation ratios at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains state-US employment compensation ratios
#' for all states at a specific year at BEA Summary level.
calculateStateUSEmpCompensationRatio <- function(year) {
  # Define BEA_col
  BEA_col <- "BEA_2012_Summary_Code"
  # Generate state Employee Compensation table
  StateEmpComp <- allocateStateTabletoBEASummary("EmpCompensation", year, "Employment")
  # Separate into state Employee Compensation
  StateEmpComp <- StateEmpComp[StateEmpComp$GeoName!="United States *", ]
  # Map US Employee Compensation to BEA
  USEmpComp <- getStateEmpCompensation(year)
  USEmpComp <- USEmpComp[USEmpComp$GeoName=="United States *", ]
  GVAtoBEAmapping <- loadBEAStateDatatoBEASummaryMapping("GVA")
  allocation_sectors <- GVAtoBEAmapping[duplicated(GVAtoBEAmapping$LineCode) |
                                          duplicated(GVAtoBEAmapping$LineCode, fromLast = TRUE), ]
  USEmpComp <- merge(USEmpComp, GVAtoBEAmapping, by = "LineCode")
  USEmpComp <- merge(USEmpComp,useeior::Summary_GrossOutput_IO[, as.character(year), drop = FALSE],
                     by.x = BEA_col, by.y = 0)
  USEmpComp[, as.character(year)] <- USEmpComp[, paste0(year, ".x")]
  for (linecode in unique(allocation_sectors$LineCode)) {
    value_vector <- USEmpComp[USEmpComp$LineCode==linecode, paste0(year, ".x")]
    weight_vector <- USEmpComp[USEmpComp$LineCode==linecode, paste0(year, ".y")]
    ratio <- value_vector*(weight_vector/sum(weight_vector))
    USEmpComp[USEmpComp$LineCode==linecode, as.character(year)] <- ratio
  }
  USEmpComp <- USEmpComp[, c(BEA_col, as.character(year))]
  # Generate sum of state Employee Compensation
  StateEmpComp_sum <- stats::aggregate(StateEmpComp[, as.character(year)],
                                       by = list(StateEmpComp[, BEA_col]),
                                       sum, na.rm = TRUE)
  colnames(StateEmpComp_sum) <- c(BEA_col, "StateEmpComp_sum")
  # Merge sum of state Employee Compensation with US employee Compensation
  # to get employee Compensation of Overseas region
  OverseasEmpComp <- merge(StateEmpComp_sum, USEmpComp, by = BEA_col, all.x = TRUE)
  OverseasEmpComp[is.na(OverseasEmpComp)] <- 0
  OverseasEmpComp[, paste0(year, ".x")] <- OverseasEmpComp[, as.character(year)] - OverseasEmpComp$StateEmpComp_sum
  OverseasEmpComp[, paste0(year, ".y")] <- OverseasEmpComp[, as.character(year)]
  OverseasEmpComp$GeoName <- "Overseas"
  # Merge state GVA and US Employee Compensation tables
  StateUSEmpComp <- merge(StateEmpComp, USEmpComp, by = BEA_col)
  # Append Overseas EmpComp to StateUSEmpComp
  StateUSEmpComp <- rbind(StateUSEmpComp, OverseasEmpComp[, colnames(StateUSEmpComp)])
  # Calculate the state-US Employee Compensation ratios
  StateUSEmpComp$Ratio <- StateUSEmpComp[, paste0(year, ".x")]/StateUSEmpComp[, paste0(year, ".y")]
  StateUSEmpComp$State <- StateUSEmpComp$GeoName
  StateUSEmpComp <- StateUSEmpComp[order(StateUSEmpComp$GeoName, StateUSEmpComp[, BEA_col]),
                                   c(BEA_col, "State", "Ratio")]
  StateUSEmpComp[is.na(StateUSEmpComp)] <- 0
  rownames(StateUSEmpComp) <- NULL
  return(StateUSEmpComp)
}

#' Calculate weighting factor of each expenditure component over US total gov expenditure.
#' @param year A numeric value between 2007 and 2019 specifying the year of interest.
#' @param defense A logical value indicating if the expenditure is spent on defense or not.
#' @return A data frame contains weighting factor of each expenditure component over US total gov expenditure.
calculateUSGovExpenditureWeightFactor <- function(year, defense) {
  # Load data
  GovConsumption <- loadStateIODataFile("GovConsumption_2007_2019")
  GovInvestment <- loadStateIODataFile("GovInvestment_2007_2019")
  # Keep rows by line code
  if (defense) {
    GovConsumption <- GovConsumption[GovConsumption$Line%in%c(26, 28), ]
    GovInvestment <- GovInvestment[GovInvestment$Line%in%c(20:21, 23:24), ]
  } else {
    GovConsumption <- GovConsumption[GovConsumption$Line%in%c(37, 39), ]
    GovInvestment <- GovInvestment[GovInvestment$Line%in%c(28:29, 31:32), ]
  }
  # 
  # Calculate weight factors and stack dfs together
  consumption_df <- GovConsumption[, as.character(year), drop = FALSE]
  investment_df <- GovInvestment[, as.character(year), drop = FALSE]
  WeightFactor <- rbind(cbind(GovConsumption[, c("Line", "Description")],
                              consumption_df/colSums(consumption_df)),
                        cbind(GovInvestment[, c("Line", "Description")],
                              investment_df/colSums(investment_df)))
  # Modify Description
  WeightFactor$Description <- gsub("\\\\.*", "", WeightFactor$Description)
  return(WeightFactor)
}

#' Calculate state fed government expenditure ratio at BEA Summary level.
#' @param year A numeric value between 2008 and 2019 specifying the year of interest.
#' @return A data frame contains state fed government expenditure ratio
#' for all states at a specific year at BEA Summary level.
calculateStateFedGovExpenditureRatio <- function(year) {
  # Load state and local government expenditure
  GovExpRatio <- data.frame()
  types <- paste(c("Intermediate", "Structure", "Equipment", "IP"),
                 rep(c("Defense", "NonDefense"), each = 4), sep = "_")
  mapping <- unique(useeior::MasterCrosswalk2012[, c("BEA_2012_Summary_Code",
                                                     "NAICS_2012_Code")])
  for(type in types) {
    GovExp <- loadStateIODataFile(paste("FedGovExp", type, year, sep = "_"))
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
    GovExpBEA[rowSums(GovExpBEA[, -1])==0, 2:ncol(GovExpBEA)] <- 1
    GovExpBEA[, -1] <- GovExpBEA[, -1]/rowSums(GovExpBEA[, -1])
    # Add missing states
    GovExpBEA[, c(setdiff(state.name, colnames(GovExpBEA[, -1])), "Overseas")] <- 0
    # Transform table from wide to long
    GovExpBEA <- reshape2::melt(GovExpBEA, id.vars = "BEA_2012_Summary_Code",
                                variable.name = "State", value.name = "Ratio")
    # Add Type column
    GovExpBEA$Type <- type
    GovExpRatio <- rbind(GovExpRatio, GovExpBEA)
  }
  # Transform table from long to wide
  GovExpRatio <- reshape2::dcast(GovExpRatio, BEA_2012_Summary_Code + State ~ Type,
                                 value.var = "Ratio")
  # Replace NA with 0
  GovExpRatio[is.na(GovExpRatio)] <- 0
  # For each BEA sector, if each state's expenditure ratio by type == 0,
  # replace each state' ratio with 1/51 (50 states + DC), while keeping Overseas 0,
  # so when national total !=0 it can still be allocate to states.
  for (bea in unique(GovExpRatio$BEA_2012_Summary_Code)) {
    for (type in types) {
      if (all(GovExpRatio[GovExpRatio$BEA_2012_Summary_Code==bea, type]==0)) {
        GovExpRatio[GovExpRatio$BEA_2012_Summary_Code==bea & 
                      GovExpRatio$State!="Overseas", type] <- 1/51
      }
    }
  }
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
  WeightFactor_ND <- calculateUSGovExpenditureWeightFactor(year, defense = FALSE)
  # Calculate Defense ratios
  W_E_D <- WeightFactor_D[WeightFactor_D$Line==26, as.character(year)]
  W_IC_D <- WeightFactor_D[WeightFactor_D$Line==28, as.character(year)]
  GovExpRatio[, "F06C"] <- GovExpRatio$Ratio * W_E_D + GovExpRatio$Intermediate_Defense * W_IC_D
  # Calculate Non-Defense ratios
  W_E_ND <- WeightFactor_ND[WeightFactor_ND$Line==37, as.character(year)]
  W_IC_ND <- WeightFactor_ND[WeightFactor_ND$Line==39, as.character(year)]
  GovExpRatio[, "F07C"] <- GovExpRatio$Ratio * W_E_ND + GovExpRatio$Intermediate_Defense * W_IC_ND
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
  US_FedGovExp <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity"),
                                 FedGovDemandCodes, drop = FALSE]
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
    # Replace NA with 0
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
