#' Map FlowBySector data from NAICS to BEA (Sector/Summary/Detail) sectors.
#' @param fbs A data frame contains FlowBySector (by NAICS) data from flowsa.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel A character value, the level of BEA sector to map to.
#' @return A data frame contains FlowBySector by BEA.
mapFlowBySectorfromNAICStoBEA <- function(fbs, year, iolevel) {
  # Get NAICStoBEA crosswalk
  BEA_cols <- paste("BEA_2012", c("Sector", "Summary", "Detail"), "Code", sep = "_")
  NAICStoBEA <- unique(useeior::MasterCrosswalk2012[, c(BEA_cols, "NAICS_2012_Code")])
  NAICStoBEA <- NAICStoBEA[!is.na(NAICStoBEA[, "NAICS_2012_Code"]),]
  # Merge fbs with NAICStoBEA
  fbs <- merge(fbs[, c("Location", "SectorProducedBy", "FlowAmount")],
               NAICStoBEA, by.x = "SectorProducedBy", by.y = "NAICS_2012_Code")
  # Create BEA-coded bls_qcew table for each FIPS
  fbs_BEA <- stats::aggregate(fbs$FlowAmount,
                              by = list(fbs[, paste("BEA_2012",
                                                    iolevel,
                                                    "Code",
                                                    sep = "_")],
                                        fbs$Location),
                              sum)
  colnames(fbs_BEA) <- c(paste("BEA_2012", iolevel, "Code", sep = "_"),
                         "FIPS",
                         "FlowAmount")
  return(fbs_BEA)
}
