#' Get US Use table (intermediadete + final demand) of specified iolevel and year.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @param year A numeric value specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return The US Use table (intermediate + final demand) of specified iolevel and year.
getNationalUse <- function(iolevel, year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load pre-saved US Use table
  Use <- loadDatafromUSEEIOR(paste(iolevel, "Use", year, "PRO_BeforeRedef",
                                   paste0(substr(schema, 3, 4), "sch"), sep = "_"))*1E6
  # Keep intermediate and final demand
  Use <- Use[getVectorOfCodes("Summary", "Commodity", specs),
             c(getVectorOfCodes("Summary", "Industry", specs), getFinalDemandCodes("Summary", specs))]
  return(Use)
}

#' Get industry-level Compensation for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state Compensation for all states at a specific year.
getStateEmpCompensation <- function(year, specs) {
  # Load pre-saved state Compensation 2007-2017
  StateEmpCompensation <- loadStateIODataFile(paste0("State_Compensation_", year),
                                              ver = specs$model_ver)
  StateEmpCompensation <- StateEmpCompensation[, c("GeoName", "LineCode", as.character(year))]
  return(StateEmpCompensation)
}

#' Get industry-level Tax for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state Tax for all states at a specific year.
getStateTax <- function(year, specs) {
  # Load pre-saved state Tax 2007-2017
  StateTax <- loadStateIODataFile(paste0("State_Tax_", year),
                                  ver = specs$model_ver)
  StateTax <- StateTax[, c("GeoName", "LineCode", as.character(year))]
  return(StateTax)
}

#' Get industry-level Gross Operating Surplus (GOS) for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state GOS for all states at a specific year.
getStateGOS <- function(year, specs) {
  # Load pre-saved state GOS 2007-2017
  StateGOS <- loadStateIODataFile(paste0("State_GOS_", year),
                                  ver = specs$model_ver)
  StateGOS <- StateGOS[, c("GeoName", "LineCode", as.character(year))]
  return(StateGOS)
}

#' Get commodity-level Personal Consumption Expenditure (PCE) for all states at a specific year.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state PCE for all states at a specific year.
getStatePCE <- function(year, specs) {
  # Load pre-saved state PCE
  StatePCE <- loadStateIODataFile(paste0("State_PCE_", year),
                                  ver = specs$model_ver)
  StatePCE <- StatePCE[, c("GeoName", "LineCode", as.character(year))]
  return(StatePCE)
}

#' Calculate state-US Commodity Output ratios at BEA Summary level.
#' Apply row sum to state and US Make tables to get commodity output vectors and
#' then Commodity Output Ratio (COR).
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state-US Commodity Output ratios at BEA Summary level.
calculateStateCommodityOutputRatio <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load state Make table
  StateMake_ls <- loadStateIODataFile(paste0("State_Summary_Make_", year),
                                      ver = specs$model_ver)
  states <- names(StateMake_ls)
  # Load US Commodity output
  US_Make <- getNationalMake("Summary", year, specs)
  # Calculate state Commodity output ratio
  State_COR <- data.frame()
  for (state in states) {
    COR <- cbind.data.frame(names(colSums(US_Make)), state,
                            colSums(StateMake_ls[[state]])/colSums(US_Make),
                            stringsAsFactors = FALSE)
    rownames(COR) <- NULL
    colnames(COR) <- c(BEA_col, "State", "Ratio")
    State_COR <- rbind(State_COR, COR)
  }
  return(State_COR)
}

#' Estimate state Intermediate Consumption at BEA Summary level.
#' For each state and industry, calculate state_US_IndustryOutput_ratio,
#' then multiply US_Use_Intermediate by the ratio to get State_Use_Intermediate.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A list of data.frames containing state Intermediate Consumption.
estimateStateIntermediateConsumption <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Define industries, commodities and # Define final demand columns
  industries <- getVectorOfCodes("Summary", "Industry", specs)
  commodities <- getVectorOfCodes("Summary", "Commodity", specs)
  
  # Load state Make table
  StateMake_ls <- loadStateIODataFile(paste0("State_Summary_Make_", year),
                                      ver = specs$model_ver)
  # Load US Make and Use tables
  US_Make <- getNationalMake("Summary", year, specs)
  US_Use <- getNationalUse("Summary", year, specs)
  
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

#' Adjust EmpComp, Tax, and GOS to fill NA and make them consistent with GVA.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param return A character string showing which attribute to return.
#' Can be "GVA", "EmpCompensation", "Tax", or "GOS".
#' @importFrom magrittr %>%
#' @return A data frame contains adjusted EmpComp, Tax, GOS, and GVA.
adjustGVAComponent <- function(year, return) {
  # 0. Load data
  gva <- getStateGVA(year, specs)
  comp <- getStateEmpCompensation(year, specs)
  tax <- getStateTax(year, specs)
  gos <- getStateGOS(year, specs)

  # 1. Join into one table
  # Note #1: NaN represents (L), meaning Less than $50,000.
  # Note #2: NA represents (D), meaning Not shown to avoid disclosure of
  # confidential information; estimates are included in higher-level totals.
  # Normally, there should not be (D), i.e. NA, in GVA for states or US, so the
  # nest step will focus on impute NaNs in GVA.
  compareTable <- gva %>% 
    dplyr::left_join(., comp, by = c("GeoName", "LineCode")) %>% 
    dplyr::left_join(., tax, by = c("GeoName", "LineCode")) %>%
    dplyr::left_join(., gos, by = c("GeoName", "LineCode")) 
  colnames(compareTable)[3:6] <- c("GVA", "EmpCompensation", "Tax", "GOS")
  detail_gva_cols <- c("EmpCompensation", "Tax", "GOS")
  
  # 2. Adjust NaN in GVA
  # Because NaN represents (L), meaning Less than $50,000, NaN in GVA is assigned
  # $25,000 by default, unless the sum of EmpCompensation, Tax, and Tax is greater
  # than $25,000 while less than $50,000.
  # To find all 
  if (any(is.nan(compareTable$GVA))) {
    for (row in rownames(compareTable[is.nan(compareTable$GVA), ])) {
      if (any(sapply(compareTable[row, detail_gva_cols], is.na))) {
        # If there is NaN (nondislosed value) in detail GVA columns, impute GVA with
        # the following assumption:
        # 1. If sum of non-NA detail GVA values < $50,000, the upper limit of (L)),
        # GVA = the larger number between the sum and $25,000 (mean of 0 and $50,000).
        # 2. If the sum >= $50,000, GVA = the larger number between $49,999 and $25,000.
        gva_sum <- sum(compareTable[row, detail_gva_cols],
                       na.rm = TRUE)
        if (gva_sum < 50000) {
          gva_possible_values <- c(25000, gva_sum)
        } else {
          gva_possible_values <- 49999
        }
        compareTable[row, "GVA"] <- max(gva_possible_values)
      } else {
        # If there is NOT NaN (nondislosed value) in detail GVA columns, impute GVA
        # by summing GVA components
        compareTable[row, "GVA"] <- sum(compareTable[row, detail_gva_cols])
      }
    }
  }
  
  # 3. Adjust NA (not disclosed value) in GVA components
  # 3.1. Adjust NA in Tax (simple, add/subtract)
  compareTable[is.na(compareTable$Tax), "Tax"] <- compareTable[is.na(compareTable$Tax), "GVA"] - 
    compareTable[is.na(compareTable$Tax), "EmpCompensation"] - 
    compareTable[is.na(compareTable$Tax), "GOS"]
  
  # 3.2. Adjust NA (not disclosed value) in EmpComp and GOS 
  # 3.2.1. Calculate EmpComp-GVA ratio and GOS-GVA ratio for each LineCode
  ratioTable <- compareTable %>%
    stats::na.omit() %>% 
    dplyr::mutate(compRatio = EmpCompensation / GVA, gosRatio = GOS / GVA) %>%
    stats::na.omit() %>%
    dplyr::group_by(LineCode) %>%
    dplyr::summarise(avgCompRatio = mean(compRatio), avgGOSRatio = mean(gosRatio))
  # 3.2.2. impute EmpComp and GOS values
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
  # 3.2.3. check row sum and apply adjustment factor to estimated rows 
  compareTable <- compareTable %>% 
    dplyr::mutate(dif = GVA - EmpCompensation - Tax - GOS, errorRate = abs(dif) / GVA)
  shrinkfactor <- 1.0 + compareTable$dif[position] / (compareTable$EmpCompensation[position] + compareTable$GOS[position])
  shrinkfactor[is.nan(shrinkfactor)] <- 1.0
  compareTable$EmpCompensation[position] <- compareTable$EmpCompensation[position]*shrinkfactor
  compareTable$GOS[position] <- compareTable$GOS[position]*shrinkfactor
  # Re-calculate errorRate
  compareTable <- compareTable %>% 
    dplyr::mutate(dif = GVA - EmpCompensation - Tax - GOS, errorRate = abs(dif) / GVA)
  
  # 4. Check if GVA = EmpCompensation + Tax + GOS, with tolerance of $10 million
  check_condition <- abs(compareTable$dif) > 1E7
  if (any(check_condition)) {
    geoname <- compareTable[check_condition, "GeoName"]
    linecode <- compareTable[check_condition, "LineCode"]
    logging::logwarn(glue::glue("In {geoname} for {linecode}",
                                "GVA components do not add up to total GVA."))
    stop("GVA components by line code do not add up to total GVA by line code.")
  }
  
  # 5. Output
  switch_return <- switch(return, "GVA" = 1, "EmpCompensation" = 2, "Tax" = 3, "GOS" = 4)
  output <- compareTable %>% dplyr::select(1, 2, switch_return + 2)
  colnames(output)[3] <- as.character(year)
  return(output)
}

#' Assemble Summary-level gross value added sectors (V001, V002, V003)
#' for all states at a specific year. For each value added sector, the same set of
#' state/US GVA ratios is used to regionalize US VA to states.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains Summary-level gross value added (V001, V002, V003)
#' for all states at a specific year.
assembleStateSummaryGrossValueAdded <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Prepare US_Use, industries, and VA_rows
  US_Use <- loadDatafromUSEEIOR(paste("Summary_Use", year, "PRO_BeforeRedef",
                                      paste0(substr(schema, 3, 4), "sch"), sep = "_"))*1E6
  industries <- getVectorOfCodes("Summary", "Industry", specs)
  VA_rows <- getVectorOfCodes("Summary", "ValueAdded", specs)
  
  # Calculate state/US VA ratio
  logging::loginfo("Estimating state value added...")
  state_US_VA_ratio <- calculateStateUSValueAddedRatio(year, specs)
  va_ratio <- reshape2::dcast(state_US_VA_ratio, GeoName ~ get(BEA_col),
                              value.var = "Ratio")
  rownames(va_ratio) <- va_ratio$GeoName
  va_ratio$GeoName <- NULL
  va_ratio <- va_ratio[, industries]
  
  # Estimate state value added components using the same state/US total GVA ratio
  StateGVA <- data.frame()
  for (sector in c("EmpCompensation", "Tax", "GOS")) {
    # Modify row names
    code <- ifelse(sector == "EmpCompensation", "V001",
                   ifelse(sector == "Tax", "V002",
                          ifelse(sector == "GOS", "V003", NULL)))
    # Allocate US value added to states by values in df
    StateGVA_sector <- sweep(va_ratio, 2, as.numeric(US_Use[code, industries]), FUN = "*")
    rownames(StateGVA_sector) <- paste(rownames(StateGVA_sector), code, sep = ".")
    StateGVA <- rbind(StateGVA, StateGVA_sector)
  }
  return(StateGVA)
}

#' Calculate state total PCE (personal consumption expenditures) at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @return A data frame contains ratios of statetotal PCE for all states at a specific year at BEA Summary level.
calculateStateTotalPCE <- function(year) {
  # Load state and US PCE
  PCE <- getStatePCE(year)
  # Extract state total PCE
  StateTotalPCE <- PCE[PCE$Line == 1 & PCE$GeoName != "United States", ]
  rownames(StateTotalPCE) <- StateTotalPCE$GeoName
  StateTotalPCE <- StateTotalPCE[, as.character(year), drop = FALSE]
  # Extract US total PCE
  USPCE <- sum(PCE[PCE$GeoName == "United States" & PCE$Line == 1,
                   as.character(year)])
  # Calculate PCE total in Overseas and append it to the state total table
  StateTotalPCE["Overseas", as.character(year)] <- USPCE - sum(StateTotalPCE[, as.character(year)])
  return(StateTotalPCE)
}

#' Calculate state-US PCE (personal consumption expenditures) ratios at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains ratios of state/US PCE for all states at a specific year at BEA Summary level.
calculateStateUSPCERatio <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load state and US PCE
  PCE <- getStatePCE(year, specs)
  # Extract State PCE
  StatePCE <- PCE[PCE$GeoName != "United States", ]
  # Generate sum of state PCE
  StatePCE_sum <- stats::aggregate(StatePCE[, as.character(year)], by = list(StatePCE$Line), sum)
  colnames(StatePCE_sum) <- c("LineCode", as.character(year))
  # Extract US PCE
  USPCE <- PCE[PCE$GeoName == "United States", c("LineCode", as.character(year))]
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
  filename <- paste0("Crosswalk_StatePCEtoBEASummaryIO", schema, "Schema.csv")
  StatePCEtoBEASummary <- readCSV(system.file("extdata", filename, package = "stateior"))
  StateUSPCE <- merge(StatePCEtoBEASummary[!StatePCEtoBEASummary[[paste0("BEA_", schema, "_Summary_Code")]] == "", ],
                      StateUSPCE, by.x = "Line", by.y = "LineCode")
  # Adjust Ratio based on state PCE
  for (state in unique(StateUSPCE$GeoName)) {
    for (sector in unique(StateUSPCE[[paste0("BEA_", schema, "_Summary_Code")]])) {
      df <- StateUSPCE[StateUSPCE$GeoName  == state &
                         StateUSPCE[[paste0("BEA_", schema, "_Summary_Code")]] == sector, ]
      adjustedratio <- weighted.mean(df$Ratio, df[, paste0(year, ".x")])
      StateUSPCE[StateUSPCE$GeoName == state &
                   StateUSPCE[[paste0("BEA_", schema, "_Summary_Code")]] == sector, "Ratio"] <- adjustedratio
    }
  }
  # Replace NaN with zero
  StateUSPCE[is.na(StateUSPCE$Ratio), "Ratio"] <- 0
  StateUSPCE$State <- StateUSPCE$GeoName
  # Keep wanted columns
  StateUSPCE <- unique(StateUSPCE[order(StateUSPCE$State, StateUSPCE[[paste0("BEA_", schema, "_Summary_Code")]]),
                                  c(paste0("BEA_", schema, "_Summary_Code"), "State", "Ratio")])
  return(StateUSPCE)
}

#' Estimate state household demand at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state household demand for all states at a specific year at BEA Summary level.
estimateStateHouseholdDemand <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load US Summary Use table
  US_Summary_Use <- getNationalUse("Summary", year, specs)
  # Extract US Household Demand
  US_HouseholdDemand <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity", specs),
                                       getVectorOfCodes("Summary", "HouseholdDemand", specs), drop = FALSE]
  # Generate State_PCE_ratio
  PCE_ratio <- calculateStateUSPCERatio(year, specs)
  # Calculate State_HouseholdDemand
  State_HouseholdDemand <- data.frame()
  for (state in unique(PCE_ratio$State)) {
    # Merge PCE_ratio with US_HouseholdDemand to keep all commodities
    HouseholdDemand <- merge(US_HouseholdDemand, PCE_ratio[PCE_ratio$State == state, ],
                             by.x = 0, by.y = BEA_col, all.x = TRUE)
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
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state household demand for all states at a specific year at BEA Summary level.
estimateStatePrivateInvestment <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  US_Summary_Use <- getNationalUse("Summary", year, specs)
  US_PrivateInvestment <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity", specs),
                                         c(getVectorOfCodes("Summary", "InvestmentDemand", specs),
                                           getVectorOfCodes("Summary", "ChangeInventories", specs)), drop = FALSE]
  # Separate US_PrivateInvestment into Residential (F02R) and NonResidential (F02S, F02E, F02N, and F030)
  US_ResidentialInvestment <- US_PrivateInvestment[getVectorOfCodes("Summary", "Commodity", specs), "F02R", drop = FALSE]
  US_NonResidentialInvestment <- US_PrivateInvestment[getVectorOfCodes("Summary", "Commodity", specs),
                                                      colnames(US_PrivateInvestment) != "F02R"]
  # Apply state PCE ratio to F02R.
  # Generate state PCE ratio
  PCE_ratio <- calculateStateUSPCERatio(year, specs)
  # Apply state Commodity Output ratio to F02S, F02E, F02N, and F030
  # Generate state Commodity Output ratio
  CommOutput_ratio <- calculateStateCommodityOutputRatio(year, specs)
  # Calculate state Private Investment (Residential and NonResidential)
  State_ResidentialInvestment <- data.frame()
  State_NonResidentialInvestment <- data.frame()
  for (state in unique(PCE_ratio$State)) {
    # Residential
    ResidentialInvestment <- merge(US_ResidentialInvestment, PCE_ratio[PCE_ratio$State == state, ],
                                   by.x = 0, by.y = BEA_col, all.x = TRUE)
    rownames(ResidentialInvestment) <- ResidentialInvestment$Row.names
    ResidentialInvestment$F02R <- ResidentialInvestment$F02R * ResidentialInvestment$Ratio
    ResidentialInvestment <- ResidentialInvestment[rownames(US_ResidentialInvestment), "F02R", drop = FALSE]
    ResidentialInvestment[is.na(ResidentialInvestment)] <- 0
    rownames(ResidentialInvestment) <- paste(state, rownames(ResidentialInvestment), sep = ".")
    State_ResidentialInvestment <- rbind.data.frame(State_ResidentialInvestment, ResidentialInvestment)
    # NonResidential
    NonResidentialInvestment <- merge(US_NonResidentialInvestment,
                                      CommOutput_ratio[CommOutput_ratio$State == state, ],
                                      by.x = 0, by.y = BEA_col)
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
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state export for all states at a specific year at BEA Summary level.
estimateStateExport <- function(year, specs) {
  # Define BEA_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load US Summary Use table
  US_Summary_Use <- getNationalUse("Summary", year, specs)
  # Extract US Export
  US_Export <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity", specs),
                              getVectorOfCodes("Summary", "Export", specs), drop = FALSE]
  # Generate state Commodity Output ratio
  CommOutput_ratio <- calculateStateCommodityOutputRatio(year, specs)
  # Generate State_export_ratio
  State_export_ratio <- calculateCensusForeignCommodityFlowRatios(year, "export", specs, "Summary")
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
  ratio_oilgas <- State_export_ratio[State_export_ratio[, BEA_col] == 211, "Ratio"]
  State_export_ratio[State_export_ratio[, BEA_col] == 211, "SoITradeRatio"] <- ratio_oilgas
  # Calculate state export
  State_Export <- merge(US_Export, State_export_ratio, by.x = 0, by.y = BEA_col)
  State_Export$F040 <- State_Export$F040 * State_Export$SoITradeRatio
  rownames(State_Export) <- paste(State_Export$State, State_Export$Row.names, sep = ".")
  State_Export <- State_Export[, "F040", drop = FALSE]
  
  # Adjust state international exports to avoid state exports > state commodity output
  StateMake_ls <- loadStateIODataFile(paste0("State_Summary_Make_", year),
                                      ver = specs$model_ver)
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
  StatePI <- estimateStatePrivateInvestment(year, specs)
  StatePI_sum <- rowSums(StatePI[, c("F02S", "F02N", "F030")])
  original_condition <- State_Export[states_comms, ] + StatePI_sum[states_comms] > State_CommOutput[states_comms, ]
  
  # For each problematic commodity, apply the adjustment
  for (comm in unique(gsub(".*\\.", "", states_comms[original_condition]))) {
    # Set i and states_comm
    i <- 1
    states_comm <- paste(states, comm, sep = ".")
    # Enter the while loop as long as there are state exports + state PI > commodity output
    max_itr <- 1E3
    while (any(State_Export[states_comm, ] + StatePI_sum[states_comm] > State_CommOutput[states_comm, ])) {
      # Determine new condition for each iteration in while loop
      new_condition <- State_Export[states_comm, ] + StatePI_sum[states_comm] > State_CommOutput[states_comm, ]
      # Set state and trouble_rows
      state <- unique(gsub("\\..*", "", states_comm[new_condition]))
      trouble_rows <- paste(state, comm, sep = ".")
      # Calculate total residual
      comm_output_ratio <- CommOutput_ratio[CommOutput_ratio[, BEA_col] == comm &
                                              CommOutput_ratio$State %in% state, "Ratio"]
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
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state S&L government expenditure ratio for all states at a specific year at BEA Summary level.
calculateStateSLGovExpenditureRatio <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load state and local government expenditure
  if(year > 2022) {
    # Until 2023 data year available, revert to 2022
    tryCatch({
        GovExp <- loadStateIODataFile(paste0("Census_StateLocalGovExpenditure_", year),
                                      ver = specs$model_ver)
        },
      error = function(e) {
        logging::logwarn(paste0("State and Local Government Expenditure data not ",
                        "available for ", year, ". Using the prior year's data."))
        },
      finally = {
        GovExp <- loadStateIODataFile(paste0("Census_StateLocalGovExpenditure_", year - 1),
                                      ver = specs$model_ver)
        }
    )
  } else {
    GovExp <- loadStateIODataFile(paste0("Census_StateLocalGovExpenditure_", year),
                                  ver = specs$model_ver)    
  }
  GovExp_statetotal <- rowSums(GovExp[, c(state.name, "District of Columbia")])
  GovExp[, "Overseas"] <- GovExp[, "United States Total"] - GovExp_statetotal
  # Map to BEA Summary sectors
  filename <- paste0("Crosswalk_StateLocalGovExptoBEASummaryIO", schema, "Schema.csv")
  mapping <- readCSV(system.file("extdata", filename, package = "stateior"))
  if(year < 2022) {
    # Starting in 2022, a specific line was dropped. Thus, select new mappings should
    # only be included starting in 2022. Those mappings that are flagged are to be
    # dropped prior to 2022. See issue #50
    mapping <- mapping[mapping["method_flag"] != "x", ]
  }
  mapping$method_flag <- NULL
  GovExpBEA <- merge(mapping, GovExp, by = c("Line", "Description"))
  # Calculate ratios
  states <- c(state.name, "District of Columbia", "Overseas")
  GovExpBEA[, states] <- GovExpBEA[, states]/GovExpBEA[, "United States Total"]
  # Drop unwanted columns
  GovExpBEA <- GovExpBEA[, c("FinalDemand", BEA_col, states)]
  # Transform table
  # From wide to long
  GovExpBEA <- reshape2::melt(GovExpBEA, id.vars = c("FinalDemand",
                                                     BEA_col))
  # From long to wide
  GovExpBEA <- reshape2::dcast(GovExpBEA, get(BEA_col) + variable ~ FinalDemand,
                               value.var = "value")
  colnames(GovExpBEA)[colnames(GovExpBEA) == "get(BEA_col)"] <- BEA_col
  # Replace NA with 0
  GovExpBEA[is.na(GovExpBEA)] <- 0
  # Rename column
  colnames(GovExpBEA)[2] <- "State"
  return(GovExpBEA)
}

#' Estimate state S&L government expenditure at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state S&L government expenditure for all states
#' at a specific year at BEA Summary level.
estimateStateSLGovExpenditure <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load US Summary Use table
  US_Summary_Use <- getNationalUse("Summary", year, specs)
  # Extract US S&L Gov Expenditure
  SLGovDemandCodes <- c("F10C", "F10E", "F10N", "F10S")
  US_SLGovExp <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity", specs),
                                SLGovDemandCodes, drop = FALSE]
  # Generate SLGovExp_ratio
  SLGovExp_ratio <- calculateStateSLGovExpenditureRatio(year, specs)
  # Calculate State_SLGovExp
  State_SLGovExp <- data.frame()
  for (state in unique(SLGovExp_ratio$State)) {
    # Merge US_SLGovExp and SLGovExp_ratio
    State_SLGovExp_state <- merge(SLGovExp_ratio[SLGovExp_ratio$State == state, ],
                                  US_SLGovExp, by.x = BEA_col,
                                  by.y = 0, all.y = TRUE)
    # Modify State column
    State_SLGovExp_state$State <- state
    # Repalce NA with 0
    State_SLGovExp_state[is.na(State_SLGovExp_state)] <- 0
    x_value <- State_SLGovExp_state[, paste0(SLGovDemandCodes, ".x")]
    y_value <- State_SLGovExp_state[, paste0(SLGovDemandCodes, ".y")]
    State_SLGovExp_state[, SLGovDemandCodes] <- x_value * y_value
    # Modify rownames
    rownames(State_SLGovExp_state) <- State_SLGovExp_state[[BEA_col]]
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
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state-US employment compensation ratios
#' for all states at a specific year at BEA Summary level.
calculateStateUSEmpCompensationRatio <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Generate state Employee Compensation table
  StateEmpComp <- allocateStateTabletoBEASummary("EmpCompensation", year, "Compensation", specs)
  # Separate into state Employee Compensation
  StateEmpComp <- StateEmpComp[StateEmpComp$GeoName != "United States *", ]
  # Map US Employee Compensation to BEA
  USEmpComp <- getStateEmpCompensation(year, specs)
  USEmpComp <- USEmpComp[USEmpComp$GeoName == "United States *", ]
  GVAtoBEAmapping <- loadBEAStateDatatoBEASummaryMapping("GVA", schema=schema)
  allocation_sectors <- GVAtoBEAmapping[duplicated(GVAtoBEAmapping$LineCode) |
                                          duplicated(GVAtoBEAmapping$LineCode, fromLast = TRUE), ]
  USEmpComp <- merge(USEmpComp, GVAtoBEAmapping, by = "LineCode")
  Summary_GrossOutput_IO <- loadDatafromUSEEIOR(paste0("Summary_GrossOutput_IO_",
                                                       substr(schema, 3, 4), "sch"))
  USEmpComp <- merge(USEmpComp, Summary_GrossOutput_IO[, as.character(year), drop = FALSE],
                     by.x = BEA_col, by.y = 0)
  USEmpComp[, as.character(year)] <- USEmpComp[, paste0(year, ".x")]
  for (linecode in unique(allocation_sectors$LineCode)) {
    value_vector <- USEmpComp[USEmpComp$LineCode == linecode, paste0(year, ".x")]
    weight_vector <- USEmpComp[USEmpComp$LineCode == linecode, paste0(year, ".y")]
    ratio <- value_vector*(weight_vector/sum(weight_vector))
    USEmpComp[USEmpComp$LineCode == linecode, as.character(year)] <- ratio
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
  GovConsumption <- loadStateIODataFile(paste0("GovConsumption_", year),
                                        ver = specs$model_ver)
  GovInvestment <- loadStateIODataFile(paste0("GovInvestment_", year),
                                       ver = specs$model_ver)
  # Keep rows by line code
  if (defense) {
    GovConsumption <- GovConsumption[GovConsumption$Line %in% c(26, 28), ]
    GovInvestment <- GovInvestment[GovInvestment$Line %in% c(20:21, 23:24), ]
  } else {
    GovConsumption <- GovConsumption[GovConsumption$Line %in% c(37, 39), ]
    GovInvestment <- GovInvestment[GovInvestment$Line %in% c(28:29, 31:32), ]
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
#' @param year A numeric value between 2008 and 2023 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state fed government expenditure ratio
#' for all states at a specific year at BEA Summary level.
calculateStateFedGovExpenditureRatio <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load state and local government expenditure
  GovExpRatio <- data.frame()
  types <- paste(c("Intermediate", "Structure", "Equipment", "IP"),
                 rep(c("Defense", "NonDefense"), each = 4), sep = "_")
  # load data using 2017 or 2012 schema, if other year is set, 2017 default is used.
  if(schema == 2012){
    mapping <- unique(useeior::MasterCrosswalk2012[, c(BEA_col,
                                                       paste0("NAICS_", schema, "_Code"))])
  } else if(schema == 2017){
    mapping <- unique(useeior::MasterCrosswalk2017[, c(BEA_col,
                                                       paste0("NAICS_", schema, "_Code"))])
  } else {
    mapping <- unique(useeior::MasterCrosswalk2017[, c(BEA_col,
                                                       paste0("NAICS_", schema, "_Code"))])
  }
 
  for (type in types) {
    GovExp <- loadStateIODataFile(paste("FedGovExp", type, year, sep = "_"),
                                  ver = specs$model_ver)
    # Change State to full state name
    for (state in unique(GovExp$State)) {
      GovExp[GovExp$State == state, "State"] <- ifelse(state == "DC",
                                                       "District of Columbia",
                                                       state.name[which(state.abb == state)])
    }
    # Map to BEA Summary sectors
    GovExpBEA <- merge(mapping, GovExp, by.x = paste0("NAICS_", schema, "_Code"), by.y = "NAICS")
    # Aggregate by BEA
    GovExpBEA <- GovExpBEA %>%
           dplyr::group_by(!!sym(BEA_col), Year, State) %>%
           dplyr::summarise(Amount = sum(Amount, na.rm = TRUE), .groups = "keep")
    # Transform table from long to wide
    formula <- as.formula(paste(BEA_col, "~ State"))
    GovExpBEA <- reshape2::dcast(GovExpBEA, formula, value.var = "Amount")
    GovExpBEA[is.na(GovExpBEA)] <- 0
    # Calculate ratios
    GovExpBEA[rowSums(GovExpBEA[, -1]) == 0, 2:ncol(GovExpBEA)] <- 1
    GovExpBEA[, -1] <- GovExpBEA[, -1]/rowSums(GovExpBEA[, -1])
    # Add missing states
    GovExpBEA[, c(setdiff(state.name, colnames(GovExpBEA[, -1])), "Overseas")] <- 0
    # Transform table from wide to long
    GovExpBEA <- reshape2::melt(GovExpBEA, id.vars = BEA_col,
                                variable.name = "State", value.name = "Ratio")
    # Add Type column
    GovExpBEA$Type <- type
    GovExpRatio <- rbind(GovExpRatio, GovExpBEA)
  }
  # Transform table from long to wide
  GovExpRatio <- reshape2::dcast(GovExpRatio, get(BEA_col) + State ~ Type, value.var = "Ratio")
  colnames(GovExpRatio)[colnames(GovExpRatio) == "get(BEA_col)"] <- BEA_col
  # Replace NA with 0
  GovExpRatio[is.na(GovExpRatio)] <- 0
  # For each BEA sector, if each state's expenditure ratio by type == 0,
  # replace each state' ratio with 1/51 (50 states + DC), while keeping Overseas 0,
  # so when national total !=0 it can still be allocate to states.
  for (bea in unique(GovExpRatio[[BEA_col]])) {
    for (type in types) {
      if (all(GovExpRatio[GovExpRatio[[BEA_col]] == bea, type] == 0)) {
        GovExpRatio[GovExpRatio[[BEA_col]] == bea & 
                      GovExpRatio$State != "Overseas", type] <- 1/51
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
  EmpCompensationRatio <- calculateStateUSEmpCompensationRatio(year, specs)
  # Merge with GovExpRatio
  GovExpRatio <- merge(GovExpRatio, EmpCompensationRatio,
                       by = c(BEA_col, "State"), all.x = TRUE)
  # Generate GovExpWeightFactor (W_E and W_IC)
  WeightFactor_D <- calculateUSGovExpenditureWeightFactor(year, defense = TRUE)
  WeightFactor_ND <- calculateUSGovExpenditureWeightFactor(year, defense = FALSE)
  # Calculate Defense ratios
  W_E_D <- WeightFactor_D[WeightFactor_D$Line == 26, as.character(year)]
  W_IC_D <- WeightFactor_D[WeightFactor_D$Line == 28, as.character(year)]
  GovExpRatio[, "F06C"] <- GovExpRatio$Ratio * W_E_D + GovExpRatio$Intermediate_Defense * W_IC_D
  # Calculate Non-Defense ratios
  W_E_ND <- WeightFactor_ND[WeightFactor_ND$Line == 37, as.character(year)]
  W_IC_ND <- WeightFactor_ND[WeightFactor_ND$Line == 39, as.character(year)]
  GovExpRatio[, "F07C"] <- GovExpRatio$Ratio * W_E_ND + GovExpRatio$Intermediate_Defense * W_IC_ND
  # Drop unwanted columns
  GovExpRatio <- GovExpRatio[, c(BEA_col, "State", "F06C", "F06E",
                                 "F06N", "F06S", "F07C", "F07E", "F07N", "F07S")]
  return(GovExpRatio)
}

#' Estimate state fed government expenditure at BEA Summary level.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains state fed government expenditure for all states
#' at a specific year at BEA Summary level.
estimateStateFedGovExpenditure <- function(year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load FedGovExp data
  # Load US Summary Use table
  US_Summary_Use <- getNationalUse("Summary", year, specs)
  # Extract US S&L Gov Expenditure
  FedGovDemandCodes <- c("F06C", "F06E", "F06N", "F06S", "F07C", "F07E", "F07N", "F07S")
  US_FedGovExp <- US_Summary_Use[getVectorOfCodes("Summary", "Commodity", specs),
                                 FedGovDemandCodes, drop = FALSE]
  # Generate FedGovExp_ratio
  FedGovExp_ratio <- calculateStateFedGovExpenditureRatio(year, specs)
  # Generate state Commodity Output ratio
  CommOutput_ratio <- calculateStateCommodityOutputRatio(year, specs)
  # Determine commodities that not in FedGovExp_ratio
  commodities <- unique(setdiff(CommOutput_ratio[[BEA_col]],
                                FedGovExp_ratio[[BEA_col]]))
  # Add CommOutput_ratio of commodities to FedGovExp_ratio
  tmp <- CommOutput_ratio[CommOutput_ratio[[paste0("BEA_", schema, "_Summary_Code")]] %in% commodities, ]
  tmp[, FedGovDemandCodes] <- tmp$Ratio
  FedGovExp_ratio <- rbind(FedGovExp_ratio, tmp[, colnames(FedGovExp_ratio)])
  # Calculate State_FedGovExp
  State_FedGovExp <- data.frame()
  for (state in unique(FedGovExp_ratio$State)) {
    # Merge US_FedGovExp and FedGovExp_ratio
    State_FedGovExp_state <- merge(FedGovExp_ratio[FedGovExp_ratio$State == state, ],
                                   US_FedGovExp, by.x = BEA_col,
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
    rownames(State_FedGovExp_state) <- State_FedGovExp_state[[paste0("BEA_", schema, "_Summary_Code")]]
    State_FedGovExp_state <- State_FedGovExp_state[rownames(US_FedGovExp), ]
    rownames(State_FedGovExp_state) <- paste(state, rownames(State_FedGovExp_state), sep = ".")
    State_FedGovExp <- rbind.data.frame(State_FedGovExp, State_FedGovExp_state[, FedGovDemandCodes])
  }
  return(State_FedGovExp)
}
