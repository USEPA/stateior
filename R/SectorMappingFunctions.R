#' Map FlowBySector data from NAICS to BEA (Sector/Summary/Detail) sectors.
#' @param fbs A data frame contains FlowBySector (by NAICS) data from flowsa.
#' @param year A numeric value specifying the year of interest.
#' @param iolevel A character value, the level of BEA sector to map to.
#' @param specs A list of model specs including 'BaseIOSchema',
#' @return A data frame contains FlowBySector by BEA.
mapFlowBySectorfromNAICStoBEA <- function(fbs, year, iolevel, specs) {
  # Define BEA_col and year_col
  schema <- specs$BaseIOSchema
  BEA_col <- paste0("BEA_", schema, "_Summary_Code")
  # Get NAICStoBEA crosswalk
  schema <- specs$BaseIOSchema
  BEA_cols <- paste("BEA", schema, c("Sector", "Summary", "Detail"), "Code", sep = "_")
  MasterCrosswalk <- loadDatafromUSEEIOR(paste0("MasterCrosswalk",schema), appendSchema = FALSE)
  NAICStoBEA <- unique(MasterCrosswalk[, c(BEA_cols, paste0("NAICS_", schema, "_Code"))])
  NAICStoBEA <- NAICStoBEA[!is.na(NAICStoBEA[, paste0("NAICS_", schema, "_Code")]),]
  # Merge fbs with NAICStoBEA
  fbs <- merge(fbs[, c("Location", "SectorProducedBy", "FlowAmount")],
               NAICStoBEA, by.x = "SectorProducedBy", by.y = paste0("NAICS_", schema, "_Code"))
  # Create BEA-coded bls_qcew table for each FIPS
  fbs_BEA <- stats::aggregate(fbs$FlowAmount,
                              by = list(fbs[, paste("BEA", schema,iolevel,"Code", sep = "_")],
                                        fbs$Location),sum)
  colnames(fbs_BEA) <- c(paste("BEA", schema, iolevel, "Code", sep = "_"),
                         "FIPS",
                         "FlowAmount")
  return(fbs_BEA)
}
