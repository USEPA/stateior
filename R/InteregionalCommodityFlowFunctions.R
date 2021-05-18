#' Calculate domestic local and traded ratio, used for calculating ICF ratios.
#' @param state State name.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @param SoI A logical variable indicating whether to calculate
#' local and traded ratios for SoI or RoUS.
#' @param ioschema A numeric value of either 2012 or 2007.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A data frame contains local and traded ratios by BEA sectors
#' for the specified state.
calculateLocalandTradedRatios <- function (state, year, SoI = TRUE, ioschema, iolevel) {
  # Specify BEA code
  bea <- paste("BEA", ioschema, iolevel, "Code", sep = "_")
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
  if (iolevel=="Detail") {
    crosswalk <- unique(useeior::MasterCrosswalk2012[, c("NAICS_2012_Code", bea)])
    BEAtoTradedorLocal <- merge(crosswalk, NAICStoTradedorLocal,
                                by.x = "NAICS_2012_Code", by.y = "NAICS")
    BEAtoTradedorLocal <- unique(BEAtoTradedorLocal[, c(bea, "Type")])
    BEAtoTradedorLocal$weight <- 1
  } else {
    crosswalk <- unique(useeior::MasterCrosswalk2012[, c("NAICS_2012_Code",
                                                         "BEA_2012_Detail_Code",
                                                         bea)])
    BEAtoTradedorLocal <- merge(crosswalk, NAICStoTradedorLocal,
                                by.x = "NAICS_2012_Code", by.y = "NAICS")
    # Use 2012 US data (substitute with more recent data when available)
    USCommOutput <- as.data.frame(colSums(getNationalMake("Detail", 2012)))
    colnames(USCommOutput) <- "CommodityOutput"
    BEA_cols <- paste("BEA", ioschema, c("Sector", "Summary", "Detail"),
                      "Code", sep = "_")
    USCommOutput <- merge(unique(useeior::MasterCrosswalk2012[, BEA_cols]),
                          USCommOutput, by.x = "BEA_2012_Detail_Code", by.y = 0,
                          all.y = TRUE)
    BEAtoTradedorLocal <- merge(BEAtoTradedorLocal, USCommOutput,
                                by = paste("BEA", ioschema, c("Detail", iolevel),
                                           "Code", sep = "_"),
                                all.x = TRUE)
    BEAtoTradedorLocal <- stats::aggregate(BEAtoTradedorLocal$CommodityOutput,
                                           by = list(BEAtoTradedorLocal[, bea],
                                                     BEAtoTradedorLocal$Type),
                                           sum, na.rm = TRUE)
    colnames(BEAtoTradedorLocal) <- c(bea, "Type", "weight")
  }
  # Load pre-saved state commodity output data
  StateCommOutput <- get(paste0("State_", iolevel, "_CommodityOutput_", year),
                         as.environment("package:stateior"))[[state]]
  colnames(StateCommOutput) <- "CommodityOutput"
  # Merge with BEAtoTradedorLocal
  StateCommOutput <- merge(BEAtoTradedorLocal, StateCommOutput,
                           by.x = bea, by.y = 0)
  # Adjust state CommOutput based on "weight"
  for (BEAcode in unique(StateCommOutput[, bea])) {
    value <- StateCommOutput[StateCommOutput[, bea]==BEAcode, "CommodityOutput"]
    weight <- StateCommOutput[StateCommOutput[, bea]==BEAcode, "weight"]
    StateCommOutput[StateCommOutput[, bea]==BEAcode,
                    "AdjustedCommodityOutput"] <- value*(weight/sum(weight))
  }
  if (SoI == FALSE) {
    USCommOutput <- colSums(getNationalMake(iolevel, 2012))
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
  LocalandTradedRatiosbyBEA <- LocalorTraded[, c(bea, "LocalRatio", "TradedRatio")]
  return(LocalandTradedRatiosbyBEA)
}

#' Generate domestic 2 region inter-regional commodity flows (ICFs) table.
#' @param state State name.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A data frame contains domestic 2 region ICFs.
generateDomestic2RegionICFs <- function (state, year, ioschema, iolevel) {
  # Specify BEA code
  bea <- paste("BEA", ioschema, iolevel, "Code", sep = "_")
  # Generate SoI-RoUS commodity flow ratios from FAF
  ICF_2r <- calculateCommodityFlowRatios(state, year, "domestic", ioschema, iolevel)
  ICF_2r$flowpath <- paste0(ICF_2r$ORIG, "2", ICF_2r$DEST)
  ICF_2r_wide <- reshape2::dcast(ICF_2r[, c(bea, "ratio", "flowpath")],
                                 paste(bea, "~", "flowpath"), value.var = "ratio")
  # Assume Other Transportation (487OS) has SoI2SoI and RoUS2RoUS ratio == 1
  ICF_2r_wide[is.na(ICF_2r_wide$SoI2SoI),
              "SoI2SoI"] <- ICF_2r_wide[is.na(ICF_2r_wide$SoI2SoI), "RoUS2RoUS"]
  ICF_2r_wide[is.na(ICF_2r_wide$RoUS2RoUS),
              "RoUS2RoUS"] <- ICF_2r_wide[is.na(ICF_2r_wide$RoUS2RoUS), "SoI2SoI"]
  # Fill NAs
  ICF_2r_wide[is.na(ICF_2r_wide$RoUS2SoI),
              "RoUS2SoI"] <- 1 - ICF_2r_wide[is.na(ICF_2r_wide$RoUS2SoI), "RoUS2RoUS"]
  ICF_2r_wide[is.na(ICF_2r_wide$SoI2RoUS),
              "SoI2RoUS"] <- 1 - ICF_2r_wide[is.na(ICF_2r_wide$SoI2RoUS), "SoI2SoI"]
  ICF_2r_wide$source <- "FAF"
  # Merge ICF_2r_wide with complete BEA Commodity list
  CommodityCodeName <- loadDatafromUSEEIOR(paste(iolevel,
                                                 "CommodityCodeName_2012",
                                                 sep = "_"))
  ICF <- merge(ICF_2r_wide, CommodityCodeName, by.x = bea,
               by.y = paste("BEA", ioschema, iolevel, "Commodity_Code", sep = "_"),
               all.y = TRUE)
  # Assume Transit and ground passenger transportation has SoI2SoI and RoUS2RoUS ratio == 1
  bea_name <- paste("BEA", ioschema, iolevel, "Commodity_Name", sep = "_")
  transit_name <- "Transit and ground passenger transportation"
  ICF[ICF[, bea_name]==transit_name, c("SoI2SoI", "RoUS2RoUS",
                                       "SoI2RoUS", "RoUS2SoI")] <- c(1, 1, 0, 0)
  ICF[ICF[, bea_name]==transit_name, "source"] <- "FAF"
  
  # Calculate SoI local and traded ratios
  LocalTradeSoI <- calculateLocalandTradedRatios(state, year, SoI = TRUE,
                                                 ioschema, iolevel)
  # Calculate RoUS local and traded ratios
  LocalTradeRoUS <- calculateLocalandTradedRatios(state, year, SoI = FALSE,
                                                  ioschema, iolevel)
  # Generate state Commodity Output ratio
  CommOutput_ratio <- calculateStateCommodityOutputRatio(year)
  CommOutput_ratio <- CommOutput_ratio[CommOutput_ratio$State==state, ]
  # Use local and traded ratios and SoI CommOutput_ratio
  for (BEAcode in Reduce(intersect, list(ICF[is.na(ICF$SoI2SoI), bea],
                                         LocalTradeSoI[, bea],
                                         LocalTradeRoUS[, bea]))) {
    # Assign data source
    ICF[ICF[, bea]==BEAcode, "source"] <- "Cluster Mapping and state commodity output"
    # Calculate LocalSoI, LocalRoUS, TradedRoUS and COR (Comm Output Ratio)
    LocalSoI <- LocalTradeSoI[LocalTradeSoI[, bea]==BEAcode, "LocalRatio"]
    LocalRoUS <- LocalTradeRoUS[LocalTradeRoUS[, bea]==BEAcode, "LocalRatio"]
    TradedRoUS <- LocalTradeRoUS[LocalTradeRoUS[, bea]==BEAcode, "TradedRatio"]
    COR <- CommOutput_ratio[CommOutput_ratio[, bea]==BEAcode, "Ratio"]
    # Assign ratios
    ICF[ICF[, bea]==BEAcode, "SoI2SoI"] <- LocalSoI
    ICF[ICF[, bea]==BEAcode, "RoUS2RoUS"] <- LocalRoUS + TradedRoUS*(1-COR)
    # If SoI2SoI == 0, replace it with COR
    if (ICF[ICF[, bea]==BEAcode, "SoI2SoI"]==0) {
      ICF[ICF[, bea]==BEAcode, "SoI2SoI"] <- COR
      ICF[ICF[, bea]==BEAcode, "source"] <- "state commodity output"
    }
    ICF[ICF[, bea]==BEAcode, "RoUS2SoI"] <- 1 - ICF[ICF[, bea]==BEAcode, "RoUS2RoUS"]
    ICF[ICF[, bea]==BEAcode, "SoI2RoUS"] <- 1 - ICF[ICF[, bea]==BEAcode, "SoI2SoI"]
  }
  # Use SoI CommOutput_ratio
  for (BEAcode in intersect(ICF[is.na(ICF$source), bea], CommOutput_ratio[, bea])) {
    # Determine ratios
    if (substr(BEAcode, 1, 1)=="G") {
      # Assume no interregional trade in government sectors
      SoI2SoIratio <- 1
      RoUS2RoUSratio <- 1
      # Assign data source
      ICF[ICF[, bea]==BEAcode, "source"] <- "manual assignment assuming no interregional trade for government commodities"
    } else {
      # Assume SoI2SoIratio is COR of the commodity
      SoI2SoIratio <- CommOutput_ratio[CommOutput_ratio[, bea]==BEAcode, "Ratio"]
      RoUS2RoUSratio <- 1 - SoI2SoIratio
      # Assign data source
      ICF[ICF[, bea]==BEAcode, "source"] <- "state commodity output"
    }
    ICF[ICF[, bea]==BEAcode, "SoI2SoI"] <- SoI2SoIratio
    ICF[ICF[, bea]==BEAcode, "SoI2RoUS"] <- 1 - SoI2SoIratio
    ICF[ICF[, bea]==BEAcode, "RoUS2RoUS"] <- RoUS2RoUSratio
    ICF[ICF[, bea]==BEAcode, "RoUS2SoI"] <- 1 - RoUS2RoUSratio
  }
  # Re-order by BEA commodity code
  ICF <- ICF[order(match(CommodityCodeName[, 1], ICF[, bea])), ]
  return(ICF)
}
