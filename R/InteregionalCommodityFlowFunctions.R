#' Calculate domestic local and traded ratio, which will be used in the next function generateDomestic2RegionICFs
#' @param state State name.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @param SoI A boolean variable indicating whether to calculate local and traded ratios for SoI or RoUS.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A data frame contains local and traded ratios by BEA sectors for the specified state.
calculateLocalandTradedRatios <- function (state, year, SoI = TRUE, ioschema, iolevel) {
  # Specify BEA code
  bea <- paste("BEA", ioschema, iolevel, "Code", sep = "_")
  # Load the cluster mapping for NAICS to Traded/Local (from clustermapping.us)
  clustermapping <- "Crosswalk_ClusterMappingNAICStoTradedorLocal.csv"
  NAICStoTradedorLocal <- utils::read.table(system.file("extdata", clustermapping, package = "stateior"),
                                            sep = ",", header = TRUE, check.names = FALSE, stringsAsFactors = FALSE)
  # Map NAICStoTradedorLocal to BEA
  BEAtoTradedorLocal <- merge(unique(useeior::MasterCrosswalk2012[, c("NAICS_2012_Code", bea)]),
                              NAICStoTradedorLocal, by.x = "NAICS_2012_Code", by.y = "NAICS")
  # Load pre-saved state commodity output data
  StateCommOutput <- get(paste0("State_", iolevel, "_CommodityOutput_", year),
                         as.environment("package:stateior"))[[state]]
  colnames(StateCommOutput) <- "CommodityOutput"
  # Merge with BEAtoTradedorLocal
  StateCommOutput <- merge(unique(BEAtoTradedorLocal[, c(bea, "Type")]),
                           StateCommOutput, by.x = bea, by.y = 0)
  if (SoI == FALSE) {
    US_Make <- get(paste(iolevel, "Make", year, "BeforeRedef", sep = "_"),
                   as.environment("package:useeior"))*1E6
    USCommOutput <- colSums(US_Make[-which(rownames(US_Make)=="Total Commodity Output"),
                                    -which(colnames(US_Make)=="Total Industry Output")])
    StateCommOutput <- merge(StateCommOutput, USCommOutput, by.x = bea, by.y = 0)
    StateCommOutput$CommodityOutput <- StateCommOutput$y - StateCommOutput$CommodityOutput
  }
  # Transform table from long to wide
  LocalorTraded <- reshape2::dcast(StateCommOutput, paste(bea, "~ Type"), value.var = "CommodityOutput")
  LocalorTraded[is.na(LocalorTraded)] <- 0
  # Calculate local and traded ratios
  LocalorTraded$LocalRatio <- LocalorTraded$Local/(LocalorTraded$Local + LocalorTraded$Traded)
  LocalorTraded$TradedRatio <- LocalorTraded$Traded/(LocalorTraded$Local + LocalorTraded$Traded)  
  LocalandTradedRatiosbyBEA <- LocalorTraded[, c(bea, "LocalRatio", "TradedRatio")]
  return(LocalandTradedRatiosbyBEA)
}

#' Generate domestic 2 region inter-regional commodity flows (ICFs) table.
#' @param state State name.
#' @param year A numeric value between 2012 and 2017 specifying the year of interest.
#' @param remove_scrap A boolean variable indicating whether to remove scrap from the table.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A data frame contains domestic 2 region ICFs.
generateDomestic2RegionICFs <- function (state, year, remove_scrap = FALSE, ioschema, iolevel) {
  # Specify BEA code
  bea <- paste("BEA", ioschema, iolevel, "Code", sep = "_")
  # Generate SoI-RoUS commodity flow ratios
  ICF_2r <- calculateCommodityFlowRatios(state, year, "domestic", ioschema, iolevel)
  ICF_2r$flowpath <- paste0(ICF_2r$ORIG, "2", ICF_2r$DEST)
  ICF_2r_wide <- reshape2::dcast(ICF_2r[, c(bea, "ratio", "flowpath")],
                                 paste(bea, "~", "flowpath"), value.var = "ratio")
  ICF_2r_wide$source <- "FAF"
  # Calculate interregional commodity flow (ICF) ratios for all commodities
  # Merge ICF_2r_wide with complete BEA Commodity list
  CommodityCodeName <- get(paste(iolevel, "CommodityCodeName_2012", sep = "_"),
                           as.environment("package:useeior"))
  ICF <- merge(ICF_2r_wide, CommodityCodeName[, 1, drop = FALSE], by.x = bea,
               by.y = paste("BEA", ioschema, iolevel, "Commodity_Code", sep = "_"),
               all.y = TRUE)
  # Calculate SoI local and traded ratios
  LocalTradeSoI <- calculateLocalandTradedRatios(state, year, SoI = TRUE, ioschema, iolevel)
  # Calculate RoUS local and traded ratios
  LocalTradeRoUS <- calculateLocalandTradedRatios(state, year, SoI = FALSE, ioschema, iolevel)
  # Generate SoI Commodity Output
  # Generate state Commodity Output ratio
  CommOutput_ratio <- calculateStateCommodityOutputRatio(year)
  CommOutput_ratio <- CommOutput_ratio[CommOutput_ratio$State==state, ]
  # Use local and traded ratios and SoI commodity output
  for (BEAcode in Reduce(intersect, list(ICF[is.na(ICF$SoI2SoI), bea],
                                         LocalTradeSoI[, bea],
                                         LocalTradeRoUS[, bea]))) {
    # Assign data source
    ICF[ICF[, bea]==BEAcode, "source"] <- "Cluster Mapping and state commodity output"
    # Calculate LocalRoUS, TradedRoUS and COR (Comm Output Ratio)
    LocalRoUS <- LocalTradeRoUS[LocalTradeRoUS[, bea]==BEAcode, "LocalRatio"]
    TradedRoUS <- LocalTradeRoUS[LocalTradeRoUS[, bea]==BEAcode, "TradedRatio"]
    COR <- CommOutput_ratio[CommOutput_ratio[, bea]==BEAcode, "Ratio"]
    # Assign ratios
    ICF[ICF[, bea]==BEAcode, "RoUS2RoUS"] <- LocalRoUS + TradedRoUS*COR
    ICF[ICF[, bea]==BEAcode, "SoI2SoI"] <- LocalTradeSoI[LocalTradeSoI[, bea]==BEAcode, "LocalRatio"]
    # If SoI2SoI == 0, replace it with COR
    if (ICF[ICF[, bea]==BEAcode, "SoI2SoI"]==0) {
      ICF[ICF[, bea]==BEAcode, "SoI2SoI"] <- COR
      ICF[ICF[, bea]==BEAcode, "source"] <- "state commodity output"
    }
    ICF[ICF[, bea]==BEAcode, "RoUS2SoI"] <- 1 - ICF[ICF[, bea]==BEAcode, "SoI2SoI"]
    ICF[ICF[, bea]==BEAcode, "SoI2RoUS"] <- 1 - ICF[ICF[, bea]==BEAcode, "RoUS2RoUS"]
  }
  # Use SoI commodity output
  for (BEAcode in intersect(ICF[is.na(ICF$source), bea], CommOutput_ratio[, bea])) {
    # Assign data source
    ICF[ICF[, bea]==BEAcode, "source"] <- "state commodity output"
    # Assign ratios
    COR <- CommOutput_ratio[CommOutput_ratio[, bea]==BEAcode, "Ratio"]
    ICF[ICF[, bea]==BEAcode, "RoUS2RoUS"] <- 1 - COR
    ICF[ICF[, bea]==BEAcode, "SoI2SoI"] <- COR
    ICF[ICF[, bea]==BEAcode, "RoUS2SoI"] <- 1 - COR
    ICF[ICF[, bea]==BEAcode, "SoI2RoUS"] <- COR
  }
  # Re-order by BEA code
  ICF <- ICF[order(match(ICF[, bea], CommodityCodeName[, 1])), ]
  return(ICF)
}
