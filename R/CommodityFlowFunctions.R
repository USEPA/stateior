#' Calculate domestic/import/export commodity flow ratios by state
#' @param state State name.
#' @param year A numeric value specifying the year of interest.
#' @param flow_ratio_type Type of commodity flow, can be "domestic", "export", or "import".
#' @param specs A list of model specs including 'BaseIOSchema'
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data frame contains commodity flow ratios by BEA.
calculateCommodityFlowRatios <- function(state, year, flow_ratio_type, specs, iolevel) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load pre-saved FAF4 commodity flow data
  FAF <- loadStateIODataFile(paste("FAF", year, sep = "_"),
                             ver = specs$model_ver)
  # Load state FIPS and determine fips code for the state of interest (SoI)
  FIPS_STATE <- readCSV(system.file("extdata", "StateFIPS.csv", package = "stateior"))
  fips <- FIPS_STATE[FIPS_STATE$State == state, "State_FIPS"]
  
  # Define value_col, orig_col, and dest_col
  if (year == 2012) {
    value_col <- paste0("value_", year)
  } else if (year %in% c(2013:2018)) {
    value_col <- paste0("curval_", year)
  } else if (year == 2019) {
    value_col <- paste0("current_value_", year)
  } else if (year >= 2020) { # forecast of 2020 data are in 2012 dollar (value_2020)
    value_col <- paste0("value_", year)
  }
  orig_col <- colnames(FAF)[startsWith(colnames(FAF), "dms_orig")]
  dest_col <- colnames(FAF)[startsWith(colnames(FAF), "dms_dest")]
  
  # Generate FAF_2r
  if (flow_ratio_type == "domestic") {
    FAF <- FAF[FAF$trade_type == 1, c(orig_col, dest_col, "sctg2",
                                      "dms_mode", value_col)]
    colnames(FAF) <- c("ORIG", "DEST", "SCTG", "MODE", "VALUE")
    FAF$ORIG <- ifelse(FAF$ORIG == fips, "SoI", "RoUS")
    FAF$DEST <- ifelse(FAF$DEST == fips, "SoI", "RoUS") 
    # Aggregate to 2 regions 
    FAF_2r <- stats::aggregate(VALUE ~ ORIG + DEST + SCTG + MODE, FAF, sum)
    # Calculate commodity flow amount in warehousing & storage sector
    FAF_2r_ws <- stats::aggregate(VALUE ~ ORIG + DEST, FAF, sum)
  } else if (flow_ratio_type == "export") {
    FAF <- FAF[FAF$trade_type == 3, c(orig_col, "sctg2", "fr_outmode", value_col)]
    colnames(FAF) <- c("ORIG", "SCTG", "MODE", "VALUE")
    FAF$ORIG <- ifelse(FAF$ORIG == fips, "SoI", "RoUS")
    FAF$DEST <- "RoW"
    # Aggregate to 2 regions 
    FAF_2r <- stats::aggregate(VALUE ~ ORIG + SCTG + MODE, FAF, sum)
    # Calculate commodity flow amount in warehousing & storage sector
    FAF_2r_ws <- stats::aggregate(VALUE ~ ORIG, FAF, sum)
  } else if (flow_ratio_type == "import") {
    FAF <- FAF[FAF$trade_type == 2, c(dest_col, "sctg2", "fr_inmode", value_col)]
    colnames(FAF) <- c("DEST", "SCTG", "MODE", "VALUE")
    FAF$ORIG <- "RoW"
    FAF$DEST <- ifelse(FAF$DEST == fips, "SoI", "RoUS")
    # Aggregate to 2 regions 
    FAF_2r <- stats::aggregate(VALUE ~ DEST + SCTG + MODE, FAF, sum)
    # Calculate commodity flow amount in warehousing & storage sector
    FAF_2r_ws <- stats::aggregate(VALUE ~ DEST, FAF, sum)
  }
  ## Calculate commodity flow amount in transportation sectors
  filename <- paste0("Crosswalk_FAFTransportationModetoBEA", schema, "Schema.csv")
  FAF_mode <- readCSV(system.file("extdata", filename, package = "stateior"))
  bea <- paste("BEA", schema, iolevel, "Code", sep = "_")
  FAF_2r_transportation <- merge(unique(FAF_mode[, c(bea, "Code", "Mode")]),
                                 FAF_2r, by.x = "Code", by.y = "MODE")
  
  ## Calculate commodity flow ratio
  # Load SCTGtoBEA mapping table
  SCTGtoBEA <- readCSV(system.file("extdata", "Crosswalk_SCTGtoBEA.csv",
                                   package = "stateior"))
  SCTGtoBEA <- unique(SCTGtoBEA[, c("SCTG", bea)])
  FAF_2r <- merge(FAF_2r, SCTGtoBEA, by = "SCTG")
  if (iolevel == "Detail") {
    # Use previous code and approach
  } else if (iolevel == "Summary") {
    # Determine BEA sectors that need allocation
    allocation_sectors <- SCTGtoBEA[duplicated(SCTGtoBEA$SCTG) |
                                      duplicated(SCTGtoBEA$SCTG, fromLast = TRUE), ]
    # Use State Compensation data to allocate
    # StateDF <- getStateEmploymentbyBEASummary(year, specs)
    StateDF <- getStateCompensationbyBEASummary(year, specs)
    # Merge with allocation_sectors
    state_df <- merge(StateDF, allocation_sectors, by = BEA_col)
    # Merge FAF_2r and Emp
    FAF_2r <- merge(FAF_2r, state_df[state_df$State == state, ],
                    by = c("SCTG", BEA_col), all.x = TRUE)
    FAF_2r[is.na(FAF_2r$State), "State"] <- state
    FAF_2r[is.na(FAF_2r$Value), "Value"] <- 1
    for (sctg in unique(FAF_2r$SCTG)) {
      # Calculate allocation factor
      weight_vector <- FAF_2r[FAF_2r$SCTG == sctg, "Value"]
      allocation_factor <- weight_vector/sum(weight_vector/4, na.rm = TRUE)
      # Allocate Value
      value <- FAF_2r[FAF_2r$SCTG == sctg, "VALUE"]*allocation_factor
      FAF_2r[FAF_2r$SCTG == sctg, "VALUE"] <- value
      # Aggregate by BEA and ORIG/DEST
      if (flow_ratio_type == "domestic") {
        formula <- as.formula(paste("VALUE ~ ORIG + DEST +", BEA_col))
      } else if (flow_ratio_type == "export") {
        formula <- as.formula(paste("VALUE ~ ORIG +", BEA_col))
      } else if (flow_ratio_type == "import") {
        formula <- as.formula(paste("VALUE ~ DEST +", BEA_col))
      }
      FAF_2r <- stats::aggregate(formula, FAF_2r, sum, na.rm = TRUE)
    }
    # Combine FAF_2r with FAF_2r_transportation and FAF_2r_ws
    common_cols <- c(BEA_col, "ORIG", "DEST", "VALUE")
    FAF_2r_ws[, BEA_col] <- "493"
    formula <- as.formula(paste("VALUE ~ ORIG + DEST +", BEA_col))
    FAF_2r_transportation <- stats::aggregate(formula, FAF_2r_transportation, sum, na.rm = TRUE)
    FAF_2r <- rbind(FAF_2r[, common_cols], FAF_2r_ws[, common_cols],
                    FAF_2r_transportation[, common_cols])
    
    # Calculate commodity flow ratio
    if (flow_ratio_type == "domestic") {
      formula <- as.formula(paste("VALUE ~ DEST +", BEA_col))
      totalflow <- stats::aggregate(formula, FAF_2r, sum)
      FAF_2r <- merge(FAF_2r, totalflow, by = c("DEST", BEA_col))
      FAF_2r$ratio <- FAF_2r$VALUE.x / FAF_2r$VALUE.y
      FAF_2r <- FAF_2r[, c("ORIG", "DEST", BEA_col, "ratio")]
    } else {
      formula <- as.formula(paste("VALUE ~ +", BEA_col))
      totalflow <- stats::aggregate(formula, FAF_2r, sum)
      FAF_2r <- merge(FAF_2r, totalflow, by = BEA_col)
      FAF_2r$ratio <- FAF_2r$VALUE.x / FAF_2r$VALUE.y
      if (flow_ratio_type == "export") {
        FAF_2r <- FAF_2r[, c("ORIG", BEA_col, "ratio")]
      } else if (flow_ratio_type == "import") {
        FAF_2r <- FAF_2r[, c("DEST", BEA_col, "ratio")]
      }
    }
  } else if (iolevel == "Sector") {
    # To be completed
  }
  return(FAF_2r)
}

#' Calculate Census import/export commodity flow ratios by BEA for all available states.
#' @param year A numeric value specifying the year of interest.
#' @param flow_ratio_type Type of commodity flow, can be "export" or "import".
#' @param specs A list of model specs including 'BaseIOSchema'
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data frame contains international commodity flow ratios by BEA for all available states.
calculateCensusForeignCommodityFlowRatios <- function(year, flow_ratio_type, specs, iolevel) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Load pre-saved state export/import data
  if (year < 2013) {
    trade <- loadStateIODataFile(paste0("Census_USATrade",
                                        capitalize(flow_ratio_type),
                                        "_", year),
                                 ver = specs$model_ver)
  } else {
    trade <- loadStateIODataFile(paste0("Census_State",
                                        capitalize(flow_ratio_type),
                                        "_", year),
                                 ver = specs$model_ver)
  }
  # Map from NAICS to BEA
  bea_code <- paste("BEA", schema, iolevel, "Code", sep = "_")
  cw <- loadDatafromUSEEIOR(paste0("MasterCrosswalk", schema), appendSchema = FALSE)
  trade <- merge(unique(cw[, c(paste0("NAICS_", schema, "_Code"), bea_code)]),
                 trade, by.x = paste0("NAICS_", schema, "_Code"), by.y = "NAICS")

  # Adjust the import data using the following logic:
  # For each BEA code, find all possible corresponding 4-digit NAICS (dig = 4)
  # and create a subset, then determine:
  # If nrow of the subset is larger than 0, keep the subset;
  # Otherwise, go to the corresponding 3-digit NAICS (dig = dig - 1)
  # and repeat the previous steps.
  trade_BEA <- data.frame()
  for (state in unique(trade$State)) {
    for (bea in unique(trade[, bea_code])) {
      dig <- 4
      ind <- FALSE
      while (ind == FALSE & dig > 1) {
        tmp <- trade[trade$State == state & trade[, bea_code] == bea &
                       nchar(trade$NAICS) == dig, ]
        if (nrow(tmp) > 0) {
          tmp$NAICS_digit <- dig # mark the NAICS digit used for this USEEIO code
          ind <- TRUE
        } else {
          dig <- dig - 1
        }
      }
      # If state trade table does not include bea, set Value to 0
      if (dig == 1) {
        tmp[1, 2:4] <- c(bea, state, year)
        tmp$Value <- 0
        tmp$NAICS_digit <- ""
      }
      trade_BEA <- rbind.data.frame(trade_BEA, tmp)
    }
  }
  # Aggregate by BEA and State
  trade_BEA <- stats::aggregate(trade_BEA$Value,
                                by = list(trade_BEA[, bea_code],
                                          trade_BEA$State), sum)
  colnames(trade_BEA) <- c(bea_code, "State", "StateValue")
  # Calculate US_trade_BEA
  US_trade_BEA <- stats::aggregate(trade_BEA$StateValue,
                                   by = list(trade_BEA[, bea_code]), sum)
  colnames(US_trade_BEA) <- c(bea_code, "USValue")
  # Merge trade_BEA and US_trade_BEA
  state_US_trade_BEA <- merge(trade_BEA, US_trade_BEA, by = bea_code)
  # Calculate trade ratio
  ratio <- state_US_trade_BEA$StateValue/state_US_trade_BEA$USValue
  state_US_trade_BEA$SoITradeRatio <- ratio
  state_US_trade_BEA[, c("StateValue", "USValue")] <- NULL
  return(state_US_trade_BEA)
}

#' Calculate domestic hazardous waste management services flow ratios by state
#' @param state State name.
#' @param year A numeric value specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains hazardous waste management services flow ratios by BEA.
calculateHazWasteManagementServiceFlowRatios <- function(state, year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Modify year due to the fact that RCRAInfo is biennial
  year <- ifelse(year %% 2 == 0, year - 1, year)
  # Load data
  SummaryBR <- utils::read.csv(system.file("extdata",
                                           paste0("RCRAInfoBR/SummaryBR_", year, ".csv"),
                                           package = "stateior"),
                               header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  SummaryBR[, 2:ncol(SummaryBR)] <- lapply(SummaryBR[, 2:ncol(SummaryBR)],
                                           function(x){as.numeric(gsub(",", "", x))})
  SummaryBR <- SummaryBR[SummaryBR$`Location Name` %in% toupper(c(state.name, "District of Columbia")), ]
  
  InterstateFlow <- utils::read.csv(system.file("extdata",
                                                paste0("RCRAInfoBR/Interstate_", year, ".csv"),
                                                package = "stateior"),
                                    header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  InterstateFlow[, 2:ncol(InterstateFlow)] <- lapply(InterstateFlow[, 2:ncol(InterstateFlow)],
                                                     function(x){as.numeric(gsub(",", "", x))})
  InterstateFlow <- InterstateFlow[InterstateFlow$`Location Name` %in% toupper(c(state.name, "District of Columbia")), ]
  # Calculate total managed, shipped and received
  # Total Managed
  TM_SoI <- SummaryBR[SummaryBR$`Location Name` == toupper(state), "Managed (Tons)"]
  TM_RoUS <- sum(SummaryBR[SummaryBR$`Location Name` != toupper(state), "Managed (Tons)"])
  # Total Interstate Receipts
  TR_SoI <- InterstateFlow[InterstateFlow$`Location Name` == toupper(state), "Interstate Receipts (Tons)"]
  TR_RoUS <- sum(InterstateFlow[InterstateFlow$`Location Name` != toupper(state), "Interstate Receipts (Tons)"])
  
  # Calculate two-region ICF ratios. !!! imports of HW == exports of HW management service
  HazWaste_ICF_2r <- data.frame("SoI2SoI"   = 1 - TR_SoI/TM_SoI, # the remainder after exporting service to RoUS
                                "SoI2RoUS"  = TR_SoI/TM_SoI, # receiving HW == exporting service
                                "RoUS2SoI"  = TR_RoUS/TM_RoUS, # receiving HW == exporting service
                                "RoUS2RoUS" = 1 - TR_RoUS/TM_RoUS) # the remainder after exporting service to SoI
  # Adjust ICF ratios if TM value is 0
  if (TM_SoI == 0) {
    HazWaste_ICF_2r[, c("SoI2SoI", "SoI2RoUS")] <- c(1, 0)
  }
  if (TM_RoUS == 0) {
    HazWaste_ICF_2r[, c("RoUS2RoUS", "RoUS2SoI")] <- c(1, 0)
  }
  # Adjust ICF ratios if TR/TM > 1
  if (HazWaste_ICF_2r$SoI2RoUS > 1) {
    HazWaste_ICF_2r[, c("SoI2SoI", "SoI2RoUS")] <- c(0, 1)
  }
  if (HazWaste_ICF_2r$RoUS2SoI > 1) {
    HazWaste_ICF_2r[, c("RoUS2RoUS", "RoUS2SoI")] <- c(0, 1)
  }
  return(HazWaste_ICF_2r)
}

#' Calculate domestic waste management services flow ratios by state
#' @param state State name.
#' @param year A numeric value specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains waste management services flow ratios by BEA.
calculateWasteManagementServiceFlowRatios <- function(state, year, specs) {
  # Assume non-haz waste ICF ratios == commodity output ratios
  COR <- calculateStateCommodityOutputRatio(year, specs)
  BEA_col <- paste0("BEA_", specs$BaseIOSchema, "_Summary_Code")
  SoIWasteCOR <- COR[COR[[BEA_col]] == "562" & COR$State == state, "Ratio"]
  RoUSWasteCOR <- 1 - SoIWasteCOR
  NonHazWaste_ICF_2r <- data.frame("SoI2SoI"   = SoIWasteCOR,
                                   "SoI2RoUS"  = 1 - SoIWasteCOR,
                                   "RoUS2SoI"  = 1 - RoUSWasteCOR,
                                   "RoUS2RoUS" = RoUSWasteCOR)
  # Generate haz waste two-region ICF ratios
  HazWaste_ICF_2r <- calculateHazWasteManagementServiceFlowRatios(state, year, specs)
  # Combine ICF ratios
  Waste_ICF_2r <- (HazWaste_ICF_2r + NonHazWaste_ICF_2r)*0.5
  return(Waste_ICF_2r)
}

#' Calculate domestic interregional electricity flow ratios by state
#' @param state State name.
#' @param year A numeric value specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains domestic interregional electricity flow ratios by state.
calculateElectricityFlowRatios <- function(state, year, specs) {
  state_abb <- getStateAbbreviation(state)
  # Load consumption data
  CodeDesc <- loadStateIODataFile("EIA_SEDS_CodeDescription", ver = specs$model_ver)
  if (year == 2023) {
    logging::logwarn(paste0("EIA SEDS data for Electricity Consumption not yet final ",
                            "for ", year, ". Using the prior year's data."))
    year = year - 1
    }
  Consumption <- loadStateIODataFile(paste0("EIA_SEDS_StateElectricityConsumption_",
                                            year),
                                     ver = specs$model_ver)
  # Subset SoI and RoUS total consumption
  consumption_desc <- "Electricity total consumption (electricity sales to ultimate customers)"
  ConsumptionMSN <- CodeDesc[CodeDesc$Description == consumption_desc &
                               CodeDesc$Unit == "Million kilowatthours", "MSN"]
  Consumption_SoI <- Consumption[Consumption$MSN == ConsumptionMSN &
                                   Consumption$State == state_abb,
                                 as.character(year)]
  Consumption_RoUS <- Consumption[Consumption$MSN == ConsumptionMSN &
                                    Consumption$State == "US",
                                  as.character(year)] - Consumption_SoI
  # Subset SoI and RoUS net interstate trade
  trade_desc <- "Net interstate flow of electricity (negative indicates flow out of state)"
  NetInterstateTradeMSN <- CodeDesc[CodeDesc$Description == trade_desc &
                                      CodeDesc$Unit == "Million kilowatthours", "MSN"]
  NetInterstateTrade_SoI <- Consumption[Consumption$MSN == NetInterstateTradeMSN &
                                          Consumption$State == state_abb,
                                        as.character(year)]
  NetInterstateTrade_RoUS <- Consumption[Consumption$MSN == NetInterstateTradeMSN &
                                           Consumption$State == "US",
                                         as.character(year)] - NetInterstateTrade_SoI
  # Note that abs(NetInterstateTrade_SoI)==abs(NetInterstateTrade_RoUS)
  
  if (NetInterstateTrade_SoI < 0) {
    # If NetInterstateTrade_SoI < 0, SoI is a net exporter
    # the amount of net export is considered total electricity traded from SoI to RoUS
    Elec_ICF_2r <- data.frame("SoI2SoI" = 1,
                              "SoI2RoUS" = abs(NetInterstateTrade_SoI)/Consumption_RoUS,
                              "RoUS2SoI" = 0,
                              "RoUS2RoUS" = 1 - abs(NetInterstateTrade_SoI)/Consumption_RoUS)
  } else {
    # If NetInterstateTrade_SoI > 0, SoI is a net importer
    # the amount of net import is considered total electricity traded from RoUS to SoI 
    Elec_ICF_2r <- data.frame("SoI2SoI" = 1 - abs(NetInterstateTrade_RoUS)/Consumption_SoI,
                              "SoI2RoUS" = 0,
                              "RoUS2SoI" = abs(NetInterstateTrade_RoUS)/Consumption_SoI,
                              "RoUS2RoUS" = 1)
    # NetInterstateTrade_SoI = 0 means there is no interstate trade between SoI and RoUS
    # ICF_SoI2SoI and ICF_RoUS2RoUS are both 0
  }
  return(Elec_ICF_2r)
}

#' Calculate domestic interregional utilities flow ratios by state,
#' utilities include electricity generation, transmission and distribution,
#' natural gas distribution and water, sewage and other
#' @param state State name.
#' @param year A numeric value specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains domestic interregional utilities flow ratios by state.
calculateUtilitiesFlowRatios <- function(state, year, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Get state employment for utilities sector
  EmploymentFBS <- getFlowsaData("Employment", year)
  StateDetailEmp <- mapFlowBySectorfromNAICStoBEA(EmploymentFBS, year, "Detail", specs)
  StateDetailEmp$State <- mapFIPS5toLocationNames(StateDetailEmp$FIPS, "FIPS")
  utilities <- c("221100", "221200", "221300")
  StateUtilitiesEmp <- StateDetailEmp[StateDetailEmp[[BEA_col]] %in% utilities &
                                        StateDetailEmp$State == state, ]
  # Calulate weight and ratios, matching utilities sector order
  weight <- StateUtilitiesEmp[match(utilities, StateUtilitiesEmp[[BEA_col]]),
                              "FlowAmount"]
  ratios <- weight/sum(weight)
  # Assume natural gas distribution and water, sewage and other are all 100% local.
  Gas_ICF_2r <- Water_ICF_2r <- data.frame("SoI2SoI" = 1,
                                           "SoI2RoUS" = 0,
                                           "RoUS2SoI" = 0,
                                           "RoUS2RoUS" = 1)
  # Generate electricity two-region ICF ratios
  Elec_ICF_2r <- calculateElectricityFlowRatios(state, year, specs)
  # Combine ICF ratios based on state employment
  Utilities_ICF_2r <- Elec_ICF_2r*ratios[1] + Gas_ICF_2r*ratios[2] + Water_ICF_2r*ratios[3]
  return(Utilities_ICF_2r)
}
