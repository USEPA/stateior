#' Calculate domestic local and traded ratio, used for calculating ICF ratios.
#' @param state State name.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @param SoI A logical variable indicating whether to calculate
#' local and traded ratios for SoI or RoUS.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data frame contains local and traded ratios by BEA sectors
#' for the specified state.
calculateLocalandTradedRatios <- function(state, year, SoI = TRUE, specs, iolevel) {
  # Define BEA and year_col
  schema <- specs$BaseIOSchema
  bea <- paste("BEA", schema, iolevel, "Code", sep = "_")
  NAICSCode<- paste0("NAICS_", schema, "_Code")
  # Load useeio Crosswalk
  MasterCrosswalk <- loadDatafromUSEEIOR(paste0('MasterCrosswalk', schema), appendSchema = FALSE)
  # Load the cluster mapping for NAICS to Traded/Local (from clustermapping.us)
  clustermapping <- system.file("extdata",
                                "Crosswalk_ClusterMappingNAICStoTradedorLocal.csv",
                                package = "stateior")
  NAICStoTradedorLocal <- readCSV(clustermapping)
  # Map 6-digit NAICStoTradedorLocal to BEA
  # If iolevel != "Detail", one BEA code is mapped to several 6-digit NAICS and
  # mixed info of Traded/Local, then use US commodity output ratio
  # (Detail/Summary or Detail/Sector) to estimate in one BEA commodity category
  # how much is Traded and how much is Local.
  if (iolevel == "Detail") {
    crosswalk <- unique(MasterCrosswalk[, c(NAICSCode, bea)])
    BEAtoTradedorLocal <- merge(crosswalk, NAICStoTradedorLocal,
                                by.x = NAICSCode, by.y = "NAICS")
    BEAtoTradedorLocal <- unique(BEAtoTradedorLocal[, c(bea, "Type")])
    BEAtoTradedorLocal$weight <- 1
  } else {
    crosswalk <- unique(MasterCrosswalk[, c(NAICSCode,paste0("BEA_", schema, "_Detail_Code"),
                                                         bea)])
    BEAtoTradedorLocal <- merge(crosswalk, NAICStoTradedorLocal,
                                by.x = NAICSCode, by.y = "NAICS")
    # Use schema year US data (substitute with more recent data when available)
    USCommOutput <- as.data.frame(colSums(getNationalMake("Detail", schema, specs)))
    colnames(USCommOutput) <- "CommodityOutput"
    BEA_cols <- paste("BEA", schema, c("Sector", "Summary", "Detail"),
                      "Code", sep = "_")
    USCommOutput <- merge(unique(MasterCrosswalk[, BEA_cols]),
                          USCommOutput, by.x = paste0 ("BEA_", schema, "_Detail_Code"), by.y = 0,
                          all.y = TRUE)
    BEAtoTradedorLocal <- merge(BEAtoTradedorLocal, USCommOutput,
                                by = paste("BEA", schema, c("Detail", iolevel),
                                           "Code", sep = "_"),
                                all.x = TRUE)
    BEAtoTradedorLocal <- stats::aggregate(BEAtoTradedorLocal$CommodityOutput,
                                           by = list(BEAtoTradedorLocal[, bea],
                                                     BEAtoTradedorLocal$Type),
                                           sum, na.rm = TRUE)
    colnames(BEAtoTradedorLocal) <- c(bea, "Type", "weight")
  }
  # Load pre-saved state commodity output data
  StateCommOutput <- loadStateIODataFile(paste0("State_",
                                                iolevel,
                                                "_CommodityOutput_",
                                                year),
                                         ver = specs$model_ver)[[state]]
  colnames(StateCommOutput) <- "CommodityOutput"
  # Merge with BEAtoTradedorLocal
  StateCommOutput <- merge(BEAtoTradedorLocal, StateCommOutput,
                           by.x = bea, by.y = 0)
  # Adjust state CommOutput based on "weight"
  for (BEAcode in unique(StateCommOutput[, bea])) {
    value <- StateCommOutput[StateCommOutput[, bea] == BEAcode, "CommodityOutput"]
    weight <- StateCommOutput[StateCommOutput[, bea] == BEAcode, "weight"]
    StateCommOutput[StateCommOutput[, bea] == BEAcode,
                    "AdjustedCommodityOutput"] <- value*(weight/sum(weight))
  }
  if (SoI == FALSE) {
    USCommOutput <- colSums(getNationalMake(iolevel, year, specs))
    StateCommOutput <- merge(StateCommOutput, USCommOutput, by.x = bea, by.y = 0)
    adjusted_output <- StateCommOutput$y - StateCommOutput$AdjustedCommodityOutput
    StateCommOutput$AdjustedCommodityOutput <- adjusted_output
  }
  # Transform table from long to wide
  LocalorTraded <- reshape2::dcast(StateCommOutput, paste(bea, "~ Type"),
                                   value.var = "AdjustedCommodityOutput")
  LocalorTraded[is.na(LocalorTraded)] <- 0
  # Calculate local and traded ratios
  LocalorTraded$Total <- LocalorTraded$Local + LocalorTraded$Traded
  LocalorTraded$LocalRatio <- LocalorTraded$Local/LocalorTraded$Total
  LocalorTraded$TradedRatio <- LocalorTraded$Traded/LocalorTraded$Total
  LocalorTraded$LocalRatio[is.na(LocalorTraded$LocalRatio)] <- 0
  LocalorTraded$TradedRatio[is.na(LocalorTraded$TradedRatio)] <- 1
  # ^^ to avoid errors in the balancing for DC when a commodity has not output
  LocalandTradedRatiosbyBEA <- LocalorTraded[, c(bea, "LocalRatio", "TradedRatio")]
  return(LocalandTradedRatiosbyBEA)
}

#' Generate domestic 2 region inter-regional commodity flows (ICFs) table.
#' @param state State name.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @param ICF_sensitivity_analysis A logical value indicating whether to conduct
#' sensitivity analysis on ICF, default is FALSE.
#' @param adjust_by A numeric value between 0 and 1 indicating the manual adjustment
#' to ICF if a sensitivity analysis is conducted, default is 0 due to no SA.
#' @param allocation_type A string with options "Compensation" or "Employment" for choosing allocation type
#' If NULL default to compensation
#' #' @return A data frame contains domestic 2 region ICFs.
generateDomestic2RegionICFs <- function(state, year, specs, iolevel,
                                        ICF_sensitivity_analysis = FALSE,
                                        adjust_by = 0, allocation_type = NULL) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  bea <- paste0("BEA_", schema, "_Summary_Code")
  # Specify BEA code
  # Generate SoI-RoUS commodity flow ratios from FAF
  ICF_2r <- calculateCommodityFlowRatios(state, year, "domestic", specs, iolevel, allocation_type)
  ICF_2r$flowpath <- paste0(ICF_2r$ORIG, "2", ICF_2r$DEST)
  ICF_2r_wide <- reshape2::dcast(ICF_2r[, c(bea, "ratio", "flowpath")],
                                 paste(bea, "~", "flowpath"), value.var = "ratio")
  # Assume Other Transportation (487OS) has SoI2SoI and RoUS2RoUS ratio == 1
  ICF_2r_wide[ICF_2r_wide[[paste0("BEA_",schema,"_Summary_Code")]] == "487OS", c("SoI2SoI", "RoUS2RoUS")] <- 1
  # Fill NAs
  ICF_2r_wide[is.na(ICF_2r_wide$SoI2SoI) & is.na(ICF_2r_wide$RoUS2SoI), "SoI2SoI"] <- 0.5
  ICF_2r_wide[is.na(ICF_2r_wide$RoUS2RoUS) & is.na(ICF_2r_wide$SoI2RoUS), "SoI2RoUS"] <- 0.5
  ICF_2r_wide[is.na(ICF_2r_wide$SoI2SoI), "SoI2SoI"] <- 1 - ICF_2r_wide[is.na(ICF_2r_wide$SoI2SoI), "RoUS2SoI"]
  ICF_2r_wide[is.na(ICF_2r_wide$SoI2RoUS), "SoI2RoUS"] <- 1 - ICF_2r_wide[is.na(ICF_2r_wide$SoI2RoUS), "RoUS2RoUS"]
  ICF_2r_wide[is.na(ICF_2r_wide$RoUS2RoUS), "RoUS2RoUS"] <- 1 - ICF_2r_wide[is.na(ICF_2r_wide$RoUS2RoUS), "SoI2RoUS"]
  ICF_2r_wide[is.na(ICF_2r_wide$RoUS2SoI), "RoUS2SoI"] <- 1 - ICF_2r_wide[is.na(ICF_2r_wide$RoUS2SoI), "SoI2SoI"]
  ICF_2r_wide$source <- "FAF"
  # Adjust SoI2SoI and RoUS2RoUS ICF ratios of air, rail and water transportation and
  # waste management and remediation services
  cols <- colnames(ICF_2r_wide)[2:5]
  if (iolevel == "Summary") {
    # Adjust air, rail and water transportation
    for (BEAcode in c("481", "482", "483")) {
      # Determine adjust_by ratio
      adjust_by <- 0.5
      # Calculate adjusted ICF ratios
      SoI2SoI_original <- ICF_2r_wide[ICF_2r_wide[, bea] == BEAcode, "SoI2SoI"]
      SoI2SoI_adjusted <- adjust_by + SoI2SoI_original*(1 - adjust_by)
      RoUS2RoUS_original <- ICF_2r_wide[ICF_2r_wide[, bea] == BEAcode, "RoUS2RoUS"]
      RoUS2RoUS_adjusted <- adjust_by + RoUS2RoUS_original*(1 - adjust_by)
      # Add adjusted ratios to ICF_2r_wide
      ICF_2r_wide[ICF_2r_wide[, bea] == BEAcode, "SoI2SoI"] <- SoI2SoI_adjusted
      ICF_2r_wide[ICF_2r_wide[, bea] == BEAcode, "SoI2RoUS"] <- 1 - RoUS2RoUS_adjusted
      ICF_2r_wide[ICF_2r_wide[, bea] == BEAcode, "RoUS2RoUS"] <- RoUS2RoUS_adjusted
      ICF_2r_wide[ICF_2r_wide[, bea] == BEAcode, "RoUS2SoI"] <- 1 - SoI2SoI_adjusted
      ICF_2r_wide[ICF_2r_wide[, bea] == BEAcode, "source"] <- paste("FAF w/ manual adjustment by",
                                                                    adjust_by)
    }
  }
  # Merge ICF_2r_wide with complete BEA Commodity list
  CommodityCodeName <- loadDatafromUSEEIOR(paste(iolevel,
                                                 paste0("CommodityCodeName_" , schema),
                                                 sep = "_"),
                                           appendSchema = FALSE)
  ICF <- merge(ICF_2r_wide, CommodityCodeName, by.x = bea,
               by.y = paste("BEA", schema, iolevel, "Commodity_Code", sep = "_"),
               all.y = TRUE)
  if (iolevel == "Summary") {
    # Adjust utilities
    ICF[ICF[, bea] == "22", cols] <- calculateUtilitiesFlowRatios(state, year, specs)[, cols]
    ICF[ICF[, bea] == "22", "source"] <- "EIA"
    # Adjust waste management and remediation services
    ICF[ICF[, bea] == "562", cols] <- calculateWasteManagementServiceFlowRatios(state, year, specs)[, cols]
    ICF[ICF[, bea] == "562", "source"] <- "RCRAInfo and SMP"
    # Adjust construction, used and other
    ICF[ICF[, bea] == "23", cols] <- c(1, 0, 0, 1)
    ICF[ICF[, bea] %in% c("Other", "Used"), cols] <- ICF[ICF[, bea] == "23", cols]
    ICF[ICF[, bea] %in% c("23", "Other", "Used"), "source"] <- "Assuming no interregional trade"
  }
  # Assume Transit and ground passenger transportation has SoI2SoI and RoUS2RoUS ratio == 1
  bea_name <- paste("BEA", schema, iolevel, "Commodity_Name", sep = "_")
  transit_name <- "Transit and ground passenger transportation"
  ICF[ICF[, bea_name] == transit_name, cols] <- c(1, 0, 0, 1)
  ICF[ICF[, bea_name] == transit_name, "source"] <- "Assuming no interregional trade"
  
  # Calculate SoI local and traded ratios
  LocalTradeSoI <- calculateLocalandTradedRatios(state, year, SoI = TRUE,
                                                 specs, iolevel)
  # Calculate RoUS local and traded ratios
  LocalTradeRoUS <- calculateLocalandTradedRatios(state, year, SoI = FALSE,
                                                  specs, iolevel)
  # Generate state Commodity Output ratio
  CommOutput_ratio <- calculateStateCommodityOutputRatio(year, specs)
  CommOutput_ratio <- CommOutput_ratio[CommOutput_ratio$State == state, ]
  # Use local and traded ratios and SoI CommOutput_ratio
  for (BEAcode in Reduce(intersect, list(ICF[is.na(ICF$SoI2SoI), bea],
                                         LocalTradeSoI[, bea],
                                         LocalTradeRoUS[, bea]))) {
    # Assign data source
    ICF[ICF[, bea] == BEAcode, "source"] <- "Cluster Mapping and state commodity output"
    # Calculate LocalSoI, LocalRoUS, TradedRoUS and CORSoI (Comm Output Ratio)
    LocalSoI <- LocalTradeSoI[LocalTradeSoI[, bea] == BEAcode, "LocalRatio"]
    LocalRoUS <- LocalTradeRoUS[LocalTradeRoUS[, bea] == BEAcode, "LocalRatio"]
    TradedRoUS <- LocalTradeRoUS[LocalTradeRoUS[, bea] == BEAcode, "TradedRatio"]
    CORSoI <- CommOutput_ratio[CommOutput_ratio[, bea] == BEAcode, "Ratio"]
    # Assign ratios
    ICF[ICF[, bea] == BEAcode, "SoI2SoI"] <- LocalSoI
    ICF[ICF[, bea] == BEAcode, "RoUS2RoUS"] <- LocalRoUS + TradedRoUS*(1 - CORSoI)
    if (ICF[ICF[, bea] == BEAcode, "RoUS2RoUS"] > 1) {
      stop("RoUS2RoUS ICF > 1")
    }
    # If SoI2SoI == 0, replace it with CORSoI
    if (ICF[ICF[, bea] == BEAcode, "SoI2SoI"] == 0) {
      ICF[ICF[, bea] == BEAcode, "SoI2SoI"] <- CORSoI
      ICF[ICF[, bea] == BEAcode, "source"] <- "state commodity output"
      # Manually adjust ratios
      adjust_by <- ifelse(ICF_sensitivity_analysis, adjust_by, 0.8)
      ICF[ICF[, bea] == BEAcode, "SoI2SoI"] <- adjust_by + CORSoI*(1 - adjust_by)
      RoUS2RoUS_original <- ICF[ICF[, bea] == BEAcode, "RoUS2RoUS"]
      ICF[ICF[, bea] == BEAcode, "RoUS2RoUS"] <- adjust_by + RoUS2RoUS_original*(1 - adjust_by)
      ICF[ICF[, bea] == BEAcode, "source"] <- paste(ICF[ICF[, bea] == BEAcode, "source"],
                                                    "w/ manual adjustment by", adjust_by)
    }
    if (substr(BEAcode, 1, 2) == "22") {
      # Use ElectricityLCI to estimate ICF ratios for utilities
    }
    ICF[ICF[, bea] == BEAcode, "RoUS2SoI"] <- 1 - ICF[ICF[, bea] == BEAcode, "SoI2SoI"]
    ICF[ICF[, bea] == BEAcode, "SoI2RoUS"] <- 1 - ICF[ICF[, bea] == BEAcode, "RoUS2RoUS"]
  }
  # Use SoI CommOutput_ratio
  for (BEAcode in intersect(ICF[is.na(ICF$source), bea], CommOutput_ratio[, bea])) {
    # Determine ratios
    if (substr(BEAcode, 1, 1) == "G") {
      # Assume no interregional trade in government sectors
      SoI2SoIratio <- 1
      RoUS2RoUSratio <- 1
      # Assign data source
      ICF[ICF[, bea] == BEAcode, "source"] <- "manual assignment assuming no interregional trade for government commodities"
    } else {
      CORSoI <- CommOutput_ratio[CommOutput_ratio[, bea] == BEAcode, "Ratio"]
      # Assign data source
      ICF[ICF[, bea] == BEAcode, "source"] <- "state commodity output"
      # Assume SoI2SoIratio is CORSoI of the commodity
      SoI2SoIratio <- CORSoI
      RoUS2RoUSratio <- 1 - CORSoI
    }
    ICF[ICF[, bea] == BEAcode, "SoI2SoI"] <- SoI2SoIratio
    ICF[ICF[, bea] == BEAcode, "SoI2RoUS"] <- 1 - RoUS2RoUSratio
    ICF[ICF[, bea] == BEAcode, "RoUS2RoUS"] <- RoUS2RoUSratio
    ICF[ICF[, bea] == BEAcode, "RoUS2SoI"] <- 1 - SoI2SoIratio
  }
  # Re-order by BEA commodity code
  ICF <- ICF[match(CommodityCodeName[, 1], ICF[, bea]), ]
  return(ICF)
}
