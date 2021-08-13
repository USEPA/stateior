#' Map BLS QCEW data from NAICS to BEA (Sector/Summary/Detail) sectors.
#' @param bls_qcew A data frame contains BLS QCEW by NAICS data, directly loaded from flowsa.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel A character value, the level of BEA sector to map to.
#' @return A data frame contains BLS QCEW by BEA.
mapBLSQCEWtoBEA <- function (bls_qcew, year, iolevel) {
  # Get NAICStoBEA crosswalk
  BEA_cols <- paste("BEA_2012", c("Sector", "Summary", "Detail"), "Code", sep = "_")
  NAICStoBEA <- unique(useeior::MasterCrosswalk2012[, c(BEA_cols, "NAICS_2012_Code")])
  NAICStoBEA <- NAICStoBEA[!is.na(NAICStoBEA[, "NAICS_2012_Code"]),]
  # Merge bls_qcew with NAICStoBEA
  bls_qcew <- merge(bls_qcew[, c("Location", "SectorProducedBy", "FlowAmount")],
                    NAICStoBEA, by.x = "SectorProducedBy", by.y = "NAICS_2012_Code")
  # Create BEA-coded bls_qcew table for each FIPS
  QCEW_BEA <- stats::aggregate(bls_qcew$FlowAmount,
                               by = list(bls_qcew[, paste("BEA_2012", iolevel, "Code", sep = "_")],
                                         bls_qcew$Location),
                               sum)
  colnames(QCEW_BEA) <- c(paste("BEA_2012", iolevel, "Code", sep = "_"), "FIPS", "FlowAmount")
  return(QCEW_BEA)
}
