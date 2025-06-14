#' Generate US domestic Use table by adjusting US Use table based on Import matrix.
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param year A numeric value specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A US Domestic Use table with rows as commodity codes and columns as industry and final demand codes
generateUSDomesticUse <- function(iolevel, year, specs) {
  # Load Use table and Import matrix
  Use <- getNationalUse(iolevel, year, specs)
  Import <- loadDatafromUSEEIOR(paste(iolevel, "Import", year, "BeforeRedef",
                                      paste0(substr(specs$BaseIOSchema, 3, 4), "sch"),
                                      sep = "_"))*1E6
  # Subtract Import from Use
  DomesticUse <- Use - Import[rownames(Use), colnames(Use)]
  # Adjust Import column in DomesticUse to 0
  DomesticUse[, getVectorOfCodes(iolevel, "Import", specs)] <- 0
  # Append international trade adjustment as the last column in DomesticUse table
  if (iolevel == "Detail") {
    DomesticUse[, "F05100"] <- generateInternationalTradeAdjustmentVector(iolevel, year, specs)
  } else {
    DomesticUse[, "F051"] <- generateInternationalTradeAdjustmentVector(iolevel, year, specs)
  }
  return(DomesticUse)
}

#' Generate international trade adjustment vector from Use and Import matrix.
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param year A numeric value specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return An international trade adjustment vector with names as commodity codes
generateInternationalTradeAdjustmentVector <- function(iolevel, year, specs) {
  # Load Use table and Import matrix
  Use <- getNationalUse(iolevel, year, specs)
  Import <- loadDatafromUSEEIOR(paste(iolevel, "Import", year, "BeforeRedef",
                                      paste0(substr(specs$BaseIOSchema, 3, 4), "sch"),
                                      sep = "_"))*1E6
  # Define Import code
  ImportCode <- getVectorOfCodes(iolevel, "Import", specs)
  # Calculate InternationalTradeAdjustment
  # In the Import matrix, the imports column is in domestic (US) port value.
  # But in the Use table, it is in foreign port value.
  # domestic port value = foreign port value + value of all transportation and insurance services to import + customs duties
  # See documentation of the Import matrix (https://apps.bea.gov/industry/xls/io-annual/ImportMatrices_Before_Redefinitions_DET_2007_2012.xlsx)
  # So, InternationalTradeAdjustment <- Use$Imports - Import$Imports
  # InternationalTradeAdjustment is essentially 'value of all transportation and insurance services to import' and 'customs duties'
  InternationalTradeAdjustment <- Use[, ImportCode] - Import[rownames(Use), ImportCode]
  names(InternationalTradeAdjustment) <- rownames(Use)
  return(InternationalTradeAdjustment)
}

#' Calculate US International Transport Margins Ratio (matrix).
#' @param iolevel Level of detail, can be "Sector", "Summary, "Detail".
#' @param year A numeric value specifying the year of interest.
#' @param specs A list of model specs including 'BaseIOSchema'
#' @return A data frame contains US International Transport Margins Ratio (matrix) at a specific year at BEA Summary level.
calculateUSInternationalTransportMarginsRatioMatrix <- function(iolevel, year, specs) {
  # Load US Use and Import tables
  US_Use <- getNationalUse(iolevel, year, specs)
  US_Import <- loadDatafromUSEEIOR(paste(iolevel, "Import", year, "BeforeRedef",
                                         paste0(substr(schema, 3, 4), "sch"),
                                         sep = "_"))*1E6
  # Calculate US Domestic Use ratios (w/ International Transport Margins)
  DomesticUsewIntlTransMarginsRatio <- (US_Use - US_Import[rownames(US_Use), colnames(US_Use)])/US_Use
  DomesticUsewIntlTransMarginsRatio[is.na(DomesticUsewIntlTransMarginsRatio)] <- 0
  # Calculate IntlTransportMargins (vector)
  IntlTransportMargins <- US_Use[, "F050"] - US_Import[, "F050"]
  # Allocate InternationalMargins to get InternationalMarginsMatrix
  drop_cols <- c("F040", "F050")
  DistributionRatio <- sweep(US_Use, 1, FUN = "/",
                             rowSums(US_Use[, !colnames(US_Use) %in% drop_cols]))
  DistributionRatio[is.na(DistributionRatio)] <- 0
  IntlTransportMarginsMatrix <- sweep(DistributionRatio, 1, FUN = "*",
                                      IntlTransportMargins)
  # Calculate IntlTransportMarginsRatio
  IntlTransportMarginsRatio <- IntlTransportMarginsMatrix/US_Use
  IntlTransportMarginsRatio[is.na(IntlTransportMarginsRatio)] <- 0
  return(IntlTransportMarginsRatio)
}
