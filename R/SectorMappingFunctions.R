#' Map BLS QCEW data from NAICS to BEA (Sector/Summary/Detail) sectors.
#' @param bls_qcew A data frame contains BLS QCEW by NAICS data, directly loaded from flowsa.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel A character value, the level of BEA sector to map to.
#' @return A data frame contains BLS QCEW by BEA.
mapBLSQCEWtoBEA <- function (bls_qcew, year, iolevel) {
  # Get NAICStoBEA crosswalk
  NAICStoBEA <- unique(useeior::MasterCrosswalk2012[, c(paste("BEA_2012",
                                                              c("Sector", "Summary", "Detail"),
                                                              "Code", sep = "_"),
                                                        "NAICS_2012_Code")])
  NAICStoBEA <- NAICStoBEA[!is.na(NAICStoBEA[, "NAICS_2012_Code"]),]
  BEAColumns <- paste("BEA_2012", c("Sector", "Summary", "Detail"), "Code", sep = "_")
  # Merge bls_qcew with NAICStoBEA
  bls_qcew <- merge(bls_qcew[, c("Location", "ActivityProducedBy", "FlowAmount")],
                    NAICStoBEA, by.x = "ActivityProducedBy", by.y = "NAICS_2012_Code")
  # Create BEA-coded bls_qcew table for each FIPS
  QCEW_BEA_list <- list()
  for (fips in unique(bls_qcew$Location)) {
    bls_qcew_fips <- bls_qcew[bls_qcew$Location==fips, ]
    QCEW_BEA <- as.data.frame(matrix(0, nrow = nrow(unique(NAICStoBEA[, BEAColumns])), ncol = 4))
    colnames(QCEW_BEA) <- c(BEAColumns, "FlowAmount")
    QCEW_BEA[, BEAColumns] <- unique(NAICStoBEA[, BEAColumns])
    # Adjust the bls_qcew data using the following logic:
    # Prioritize BEA Detail code;
    # For each BEAcode, first find all possible corresponding 6-digit NAICS (digit = 6) and ValueColumns and determine:
    # If there is non-zero values in all rows of the FlowAmount (i.e. tmp), keep tmp to represent this BEAcode's corresponding FlowAmount;
    # If values in all rows of the FlowAmount (i.e. tmp) are zero, go to the corresponding 5-digit NAICS (digit = digit - 1) and repeat the previous steps.
    for (code in unique(QCEW_BEA$BEA_2012_Detail_Code)) {
      digit <- 6
      ind <- FALSE
      while(ind==FALSE & digit>1) {
        tmp <- sum(bls_qcew_fips[bls_qcew_fips$BEA_2012_Detail_Code==code & nchar(bls_qcew_fips$ActivityProducedBy)==digit, "FlowAmount"])
        if (tmp>0) {
          QCEW_BEA[QCEW_BEA$BEA_2012_Detail_Code==code, "FlowAmount"] <- tmp
          ind <- TRUE
        } else {
          digit <- digit - 1
        }
      }
    }
    # Aggregate to desired IO level
    QCEW_BEA <- aggregate(QCEW_BEA$FlowAmount,
                          by = list(QCEW_BEA[, paste("BEA_2012", iolevel, "Code", sep = "_")]), sum)
    colnames(QCEW_BEA) <- c(paste("BEA_2012", iolevel, "Code", sep = "_"), "FlowAmount")
    QCEW_BEA$FIPS <- fips
    QCEW_BEA_list[[fips]] <- QCEW_BEA
  }
  QCEW_BEA <- do.call(rbind, QCEW_BEA_list)
  rownames(QCEW_BEA) <- NULL
  return(QCEW_BEA)
}
