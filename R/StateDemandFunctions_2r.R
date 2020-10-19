#' Generate two-region (SoI and RoUS) domestic use tables.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A list of domestic 2-region use tables.
generateTwoRegionDomesticUse <- function(state, year, ioschema, iolevel) {
  # 1 - Load state domestic Use for the specified year
  load(paste0("data/State_Summary_DomesticUse_", year, ".rda"))
  SoI_Domestic_Use <- State_Summary_DomesticUse[gsub("\\..*", "", rownames(State_Summary_DomesticUse))==state, ]
  # Load BEA schema_info based on iolevel
  SchemaInfoFile <- paste0(ioschema, "_", iolevel, "_Schema_Info.csv")
  SchemaInfo <- utils::read.table(system.file("extdata", SchemaInfoFile, package = "useeior"),
                                  sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  # Extract desired columns from SchemaInfo, return vectors with strings of codes
  columns <- unlist(sapply(list("Industry", "HouseholdDemand", "InvestmentDemand",
                                "ChangeInventories", "GovernmentDemand"),
                           getVectorOfCodes, iolevel = iolevel))
  ExportCodes <- getVectorOfCodes(iolevel, "Export")
  
  # 2 - Generate 2-region ICFs
  ICF <- generateDomestic2RegionICFs(state, year, remove_scrap = FALSE, ioschema = 2012, iolevel = "Summary")
  
  # 3 - Generate SoI2SoI domestic Use
  SoI2SoI_Use <- SoI_Domestic_Use
  SoI2SoI_Use[, columns] <- SoI_Domestic_Use[, columns] * ICF$SoI2SoI
  # Load state commodity output
  load(paste0("data/State_Summary_CommodityOutput_", year, ".rda"))
  SoI_Commodity_Output <- State_Summary_CommodityOutput_list[[state]]
  # Calculate Interregional Imports, Exports, and Net Exports
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(SoI2SoI_Use[, columns])
  SoI2SoI_Use$InterregionalExports <- SoI_Commodity_Output$Output - rowSums(SoI2SoI_Use[, c(columns, ExportCodes)])
  SoI2SoI_Use$NetExports <- SoI2SoI_Use$InterregionalExports - SoI2SoI_Use$InterregionalImports
  
  # 4 - Generate RoUS domestic Use and commodity output
  # RoUS domestic Use
  US_Domestic_Use <- estimateUSDomesticUse("Summary", year)
  RoUS_Domestic_Use <- US_Domestic_Use - SoI_Domestic_Use
  # RoUS Commodity Output
  US_Make <- get(paste("Summary_Make", year, "BeforeRedef", sep = "_"), as.environment("package:useeior"))*1E6
  US_MakeTransaction <- US_Make[-which(rownames(US_Make)=="Total Commodity Output"),
                                -which(colnames(US_Make)=="Total Industry Output")]
  US_Commodity_Output <- colSums(US_MakeTransaction)
  RoUS_Commodity_Output <- US_Commodity_Output - SoI_Commodity_Output
  colnames(RoUS_Commodity_Output) <- "Output"
  # Adjust RoUS_Commodity_Output
  MakeUseDiff <- US_Commodity_Output - rowSums(US_Domestic_Use[, c(columns, ExportCodes)])
  RoUS_Commodity_Output$Output <- RoUS_Commodity_Output$Output - MakeUseDiff
  
  # 5 - Generate RoUS2RoUS domestic Use
  RoUS2RoUS_Use <- RoUS_Domestic_Use
  RoUS2RoUS_Use[, columns] <- RoUS_Domestic_Use[, columns] * ICF$RoUS2RoUS
  # Calculate Interregional Imports, Exports, and Net Exports
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Use[, columns])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(RoUS2RoUS_Use[, c(columns, ExportCodes)])
  RoUS2RoUS_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports
  
  # 6 - Allocate negative InterregionalExports across columns in SoI2SoI Use and RoUS2RoUS Use
  for (i in 1:nrow(SoI2SoI_Use)) {
    # SoI2SoI
    if (SoI2SoI_Use[i, "InterregionalExports"]<0) {
      value <- SoI2SoI_Use[i, "InterregionalExports"]
      weight <- SoI2SoI_Use[i, columns]
      SoI2SoI_Use[i, columns] <- weight + value*(weight/sum(weight))
    }
    # RoUS2RoUS
    if (RoUS2RoUS_Use[i, "InterregionalExports"]<0) {
      value <- RoUS2RoUS_Use[i, "InterregionalExports"]
      weight <- RoUS2RoUS_Use[i, columns]
      RoUS2RoUS_Use[i, columns] <- weight + value*(weight/sum(weight))
    }
  }
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(SoI2SoI_Use[, columns])
  SoI2SoI_Use$InterregionalExports <- SoI_Commodity_Output$Output - rowSums(SoI2SoI_Use[, c(columns, ExportCodes)])
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Use[, columns])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(RoUS2RoUS_Use[, c(columns, ExportCodes)])
  
  # 7 - Calculate errors for SoI and RoUS
  error <- SoI2SoI_Use$InterregionalImports - RoUS2RoUS_Use$InterregionalExports
  SoIerror <- error*(SoI_Commodity_Output$Output/US_Commodity_Output)
  RoUSerror <- error - SoIerror
  SoIerror_1 <-SoIerror_2 <- SoIerror
  
  # 8 - Allocate the errors across columns in SoI2SoI Use and RoUS2RoUS Use
  for (i in 1:nrow(SoI2SoI_Use)) {
    SoIweight <- SoI2SoI_Use[i, columns]
    RoUSweight <- RoUS2RoUS_Use[i, columns]
    SoIerror_1[i] <- ifelse(abs(SoIerror[i])<sum(SoIweight), SoIerror[i],
                            ifelse(SoIerror[i]<0, sum(SoIweight)*-1, sum(SoIweight)))
    SoIerror_2[i] <- ifelse(SoIerror_1[i]!=SoIerror[i], SoIerror_1[i]/2, SoIerror[i])
    RoUSerror[i] <- error[i] - SoIerror_2[i]
    SoI2SoI_Use[i, columns] <- SoIweight + SoIerror_2[i]*(SoIweight/sum(SoIweight))
    RoUS2RoUS_Use[i, columns] <- RoUSweight - RoUSerror[i]*(RoUSweight/sum(RoUSweight))
  }
  # Check if negative cells in SoI2SoI_Use and RoUS2RoUS_Use are also negative in US_Domestic_Use
  
  
  # 9 - Re-calculate InterregionalImports, InterregionalExports and NetExports
  # SoI2SoI
  SoI2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(SoI2SoI_Use[, columns])
  SoI2SoI_Use$InterregionalExports <- SoI_Commodity_Output$Output - rowSums(SoI2SoI_Use[, c(columns, ExportCodes)])
  SoI2SoI_Use$NetExports <- SoI2SoI_Use$InterregionalExports - SoI2SoI_Use$InterregionalImports
  # RoUS2RoUS
  RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Use[, columns])
  RoUS2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(RoUS2RoUS_Use[, c(columns, ExportCodes)])
  RoUS2RoUS_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports
  # Check if there are negative values in InterregionalImports, InterregionalExports and NetExports in SoI2SoI_Use and RoUS2RoUS_Use
  
  # 10 - Generate SoI2RoUS and RoUS2SoI Use
  # SoI2RoUS
  SoI2RoUS_Use <- RoUS_Domestic_Use - RoUS2RoUS_Use[rownames(RoUS_Domestic_Use), colnames(RoUS_Domestic_Use)]
  SoI2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(SoI2RoUS_Use[, columns])
  SoI2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(SoI2RoUS_Use[, c(columns, ExportCodes)])
  SoI2RoUS_Use$NetExports <- SoI2RoUS_Use$InterregionalExports - SoI2RoUS_Use$InterregionalImports
  # RoUS2SoI
  RoUS2SoI_Use <- SoI_Domestic_Use - SoI2SoI_Use[rownames(SoI_Domestic_Use), colnames(SoI_Domestic_Use)]
  RoUS2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(RoUS2SoI_Use[, columns])
  RoUS2SoI_Use$InterregionalExports <- SoI_Commodity_Output$Output - rowSums(RoUS2SoI_Use[, c(columns, ExportCodes)])
  RoUS2SoI_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2SoI_Use$InterregionalImports
  
  # 11 - Create validation
  validation <- cbind.data.frame(SoI2SoI_Use$InterregionalImports - RoUS2RoUS_Use$InterregionalExports,
                                 SoI2SoI_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports,
                                 SoI2SoI_Use$NetExports + RoUS2RoUS_Use$NetExports,
                                 SoI2RoUS_Use$InterregionalImports - RoUS2SoI_Use$InterregionalExports,
                                 SoI2RoUS_Use$InterregionalExports - RoUS2SoI_Use$InterregionalImports,
                                 SoI2RoUS_Use$NetExports + RoUS2SoI_Use$NetExports)
  rownames(validation) <- rownames(RoUS2RoUS_Use)
  colnames(validation) <- c("SoI2SoI$InterregionalImports - RoUS2RoUS$InterregionalExports",
                            "SoI2SoI$InterregionalExports - RoUS2RoUS$InterregionalImports",
                            "SoI2SoI$NetExports + RoUS2RoUS$NetExports",
                            "SoI2RoUS$InterregionalImports - RoUS2SoI$InterregionalExports",
                            "SoI2RoUS$InterregionalExports - RoUS2SoI$InterregionalImports",
                            "SoI2RoUS$NetExports + RoUS2SoI$NetExports")
  
  # 12 - Assemble SoI2SoI Use, RoUS2RoUS Use
  Domestic2RegionUse <- list()
  Domestic2RegionUse[["SoI2SoI"]] <- SoI2SoI_Use
  Domestic2RegionUse[["RoUS2RoUS"]] <- RoUS2RoUS_Use
  Domestic2RegionUse[["RoUS2SoI"]] <- RoUS2SoI_Use
  Domestic2RegionUse[["SoI2RoUS"]] <- SoI2RoUS_Use
  Domestic2RegionUse[["Validation"]] <- validation
  return(Domestic2RegionUse)
}

