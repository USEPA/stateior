#' Generate two-region (SoI and RoUS) domestic use tables.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param ioschema A numeric value of either 2012 or 2007 specifying the io schema year.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A list of domestic 2-region use tables.
generateTwoRegionDomesticUse <- function(state, year, ioschema, iolevel) {
  # 1 - Load state domestic Use for the specified year
  load(paste0("data/State_Summary_DomesticUse_", year, ".rda"))
  SoI_Domestic_Use <- State_Summary_DomesticUse_list[[state]]
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
  ICF <- generateDomestic2RegionICFs(state, year, remove_scrap = FALSE, ioschema = 2012, iolevel = iolevel)
  
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
  US_Domestic_Use <- estimateUSDomesticUse(iolevel, year)
  RoUS_Domestic_Use <- US_Domestic_Use - SoI_Domestic_Use
  # RoUS Commodity Output
  US_Make <- getNationalMake(iolevel, year)
  US_Commodity_Output <- colSums(US_Make)
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

calcualteTwoRegionAmatrix <- function(state, year, ioschema, iolevel) {
  # SoI Make
  industries <- getVectorOfCodes(iolevel, "Industry")
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  SoI_Make <- State_Summary_MakeTransaction_balanced[paste(state, industries, sep = "."),
                                                     commodities]
  # SoI commodity output
  SoI_Commodity_Output <- State_Summary_CommodityOutput_list[[state]]
  # SoI A matrix
  SoI_A <- sweep(SoI_Make, 2, SoI_Commodity_Output$Output, `/`)
  
  # RoUS Make
  US_Make <- getNationalMake(iolevel, year)
  RoUS_Make <- US_Make - SoI_Make
  # RoUS domestic Use
  load(paste0("data/State_Summary_DomesticUse_", year, ".rda"))
  SoI_Domestic_Use <- State_Summary_DomesticUse_list[[state]]
  columns <- colnames(SoI_Domestic_Use)[!colnames(SoI_Domestic_Use)%in%c("F040", "F050")]
  US_Domestic_Use <- estimateUSDomesticUse("Summary", year)
  RoUS_Domestic_Use <- US_Domestic_Use - SoI_Domestic_Use
  # RoUS commodity output
  US_Commodity_Output <- colSums(US_Make)
  RoUS_Commodity_Output <- US_Commodity_Output - SoI_Commodity_Output
  colnames(RoUS_Commodity_Output) <- "Output"
  # Adjust RoUS_Commodity_Output
  MakeUseDiff <- US_Commodity_Output - rowSums(US_Domestic_Use[, c(columns, "F040")])
  RoUS_Commodity_Output$Output <- RoUS_Commodity_Output$Output - MakeUseDiff
  # SoI A matrix
  RoUS_A <- sweep(RoUS_Make, 2, RoUS_Commodity_Output$Output, `/`)
  
  # Two-region A matrix
  ls <- generateTwoRegionDomesticUse(state, year, ioschema, iolevel)
  SoI_Industry_Output <- State_Summary_IndustryOutput_list[[state]]
  RoUS_Industry_Output <- rowSums(US_Make) - SoI_Industry_Output
  SoI2SoI_A <- sweep(ls[["SoI2SoI"]][, industries], 2, SoI_Industry_Output$Output, `/`)
  RoUS2SoI_A <- sweep(ls[["RoUS2SoI"]][, industries], 2, SoI_Industry_Output$Output, `/`)
  SoI2RoUS_A <- sweep(ls[["SoI2RoUS"]][, industries], 2, RoUS_Industry_Output$Output, `/`)
  RoUS2RoUS_A <- sweep(ls[["RoUS2RoUS"]][, industries], 2, RoUS_Industry_Output$Output, `/`)
  
  # Assemble A matrix
  A_top <- cbind(diag(rep(0, length(commodities)*2)),
                 cbind(rbind(SoI2SoI_A, RoUS2SoI_A),
                       rbind(SoI2RoUS_A, RoUS2RoUS_A)))
  A_btm <- cbind.data.frame(as.matrix(Matrix::bdiag(list(as.matrix(SoI_A),
                                              as.matrix(RoUS_A)))),
                            diag(rep(0, length(industries)*2)))
  A <- as.matrix(rbind(A_top, setNames(A_btm, colnames(A_top))))
  rownames(A) <- paste(c(rep(c(state, "RoUS"), each = length(commodities)),
                         rep(c(state, "RoUS"), each = length(industries))),
                       c(rep(commodities, 2), rep(industries, 2)),
                       c(rep("Commodity", length(commodities)*2),
                         rep("Industry", length(industries)*2)),
                       sep = ".")
  colnames(A) <- rownames(A)
  A[is.na(A)] <- 0
  A[is.infinite(A)] <- 0
  
  # Calculate L matrix
  I <- diag(nrow(A))
  L <- solve(I - A)
  
  # Calculate Final Demand (y)
  SoI_y <- rowSums(SoI_Domestic_Use[, getFinalDemandCodes("Summary")])
  RoUS_y <- rowSums(RoUS_Domestic_Use[, getFinalDemandCodes("Summary")])
  y <- c(SoI_y, RoUS_y, rep(0, length(industries)*2))
  
  # Validate L * y == Output
  validation <- L %*% y - c(SoI_Commodity_Output$Output,
                            RoUS_Commodity_Output$Output,
                            SoI_Industry_Output$Output,
                            RoUS_Industry_Output$Output)
  colnames(validation) <- "L*y-output"
}


