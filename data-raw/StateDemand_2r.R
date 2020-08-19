#'Creates 2-region Use table for given year and state
#'Stores table by year by state .rda files in useeior package

#' 1 - Load state domestic Use for the given year and state
year <- 2012
state <- "Georgia"
load(paste0("data/State_Summary_Domestic_Use_", year, ".rda"))
SoI_Summary_Domestic_Use <- State_Summary_Domestic_Use[gsub("\\..*", "", rownames(State_Summary_Domestic_Use))==state, ]
columns <- colnames(SoI_Summary_Domestic_Use)[!colnames(SoI_Summary_Domestic_Use)%in%c("F040", "F050")]

#' 2 - Generate 2-region ICFs
ICF <- generateDomestic2RegionICFs(state, year, remove_scrap = FALSE, ioschema = 2012, iolevel = "Summary")

#' 3 - Generate SoI2SoI Use
SoI2SoI_Summary_Use <- SoI_Summary_Domestic_Use
SoI2SoI_Summary_Use[, columns] <- SoI_Summary_Domestic_Use[, columns] * ICF$SoI2SoI
# Calculate Interregional Imports
SoI2SoI_Summary_Use$InterregionalImports <- rowSums(SoI_Summary_Domestic_Use[, columns]) - rowSums(SoI2SoI_Summary_Use[, columns])
# Calculate Interregional Exports
load(paste0("data/State_Summary_CommodityOutput_", year, ".rda"))
SoI_Commodity_Output <- State_Summary_CommodityOutput_list[[state]]
SoI2SoI_Summary_Use$InterregionalExports <- SoI_Commodity_Output$StateCommOutput - rowSums(SoI2SoI_Summary_Use[, c(columns, "F040")])
# Calculate Net Exports
SoI2SoI_Summary_Use$NetExports <- SoI2SoI_Summary_Use$InterregionalExports - SoI2SoI_Summary_Use$InterregionalImports

#' 4 - Generate RoUS domestic Use and commodity output
# RoUS domestic Use
US_Summary_Use <- adjustUseTablebyImportMatrix("Summary", year)
FinalDemand_columns <- colnames(US_Summary_Use)[75:94]
US_Summary_Domestic_Use <- US_Summary_Use[1:73, colnames(SoI_Summary_Domestic_Use)] * (1 - calculateUSImportRatioMatrix(year))
RoUS_Summary_Domestic_Use <- US_Summary_Domestic_Use - SoI_Summary_Domestic_Use
# RoUS Commodity Output
US_Summary_Make <- get(paste("Summary_Make", year, "BeforeRedef", sep = "_"), as.environment("package:useeior"))*1E6
US_Summary_MakeTransaction <- US_Summary_Make[-which(rownames(US_Summary_Make)=="Total Commodity Output"),
                                              -which(colnames(US_Summary_Make)=="Total Industry Output")]
US_Commodity_Output <- colSums(US_Summary_MakeTransaction)
RoUS_Commodity_Output <- US_Commodity_Output - SoI_Commodity_Output
colnames(RoUS_Commodity_Output) <- "RoUSCommOutput"
# Adjust RoUS_Commodity_Output
MakeUseDiff <- US_Commodity_Output - rowSums(US_Summary_Domestic_Use[, c(columns, "F040")])
RoUS_Commodity_Output$RoUSCommOutput <- RoUS_Commodity_Output$RoUSCommOutput - MakeUseDiff

#' 5 - Generate RoUS2RoUS Use
RoUS2RoUS_Summary_Use <- RoUS_Summary_Domestic_Use
RoUS2RoUS_Summary_Use[, columns] <- RoUS_Summary_Domestic_Use[, columns] * ICF$RoUS2RoUS
# Calculate Interregional Imports
RoUS2RoUS_Summary_Use$InterregionalImports <- rowSums(RoUS_Summary_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Summary_Use[, columns])
# Calculate Interregional Exports
RoUS2RoUS_Summary_Use$InterregionalExports <- RoUS_Commodity_Output$RoUSCommOutput - rowSums(RoUS2RoUS_Summary_Use[, c(columns, "F040")])
# Calculate Net Exports
RoUS2RoUS_Summary_Use$NetExports <- RoUS2RoUS_Summary_Use$InterregionalExports - RoUS2RoUS_Summary_Use$InterregionalImports

# Save SoI2SoI_Summary_Use and RoUS2RoUS_Summary_Use as baseline tables
SoI2SoI_Summary_Use_0 <- SoI2SoI_Summary_Use
RoUS2RoUS_Summary_Use_0 <- RoUS2RoUS_Summary_Use

#' 6 - Allocate negative InterregionalExports across columns in SoI2SoI Use and RoUS2RoUS Use
for (i in 1:nrow(SoI2SoI_Summary_Use)) {
  # SoI2SoI
  if (SoI2SoI_Summary_Use[i, "InterregionalExports"]<0) {
    value <- SoI2SoI_Summary_Use[i, "InterregionalExports"]
    weight <- SoI2SoI_Summary_Use[i, columns]
    SoI2SoI_Summary_Use[i, columns] <- weight + value*(weight/sum(weight))
  }
  # RoUS2RoUS
  if (RoUS2RoUS_Summary_Use[i, "InterregionalExports"]<0) {
    value <- RoUS2RoUS_Summary_Use[i, "InterregionalExports"]
    weight <- RoUS2RoUS_Summary_Use[i, columns]
    RoUS2RoUS_Summary_Use[i, columns] <- weight + value*(weight/sum(weight))
  }
}
SoI2SoI_Summary_Use$InterregionalImports <- rowSums(SoI_Summary_Domestic_Use[, columns]) - rowSums(SoI2SoI_Summary_Use[, columns])
SoI2SoI_Summary_Use$InterregionalExports <- SoI_Commodity_Output$StateCommOutput - rowSums(SoI2SoI_Summary_Use[, c(columns, "F040")])
RoUS2RoUS_Summary_Use$InterregionalImports <- rowSums(RoUS_Summary_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Summary_Use[, columns])
RoUS2RoUS_Summary_Use$InterregionalExports <- RoUS_Commodity_Output$RoUSCommOutput - rowSums(RoUS2RoUS_Summary_Use[, c(columns, "F040")])

#' 7 - Calculate errors for SoI and RoUS
error <- SoI2SoI_Summary_Use$InterregionalImports - RoUS2RoUS_Summary_Use$InterregionalExports
SoIerror <- error*(SoI_Commodity_Output$StateCommOutput/US_Commodity_Output)
RoUSerror <- error - SoIerror
SoIerror_1 <-SoIerror_2 <- SoIerror

#' 8 - Allocate the errors across columns in SoI2SoI Use and RoUS2RoUS Use
for (i in 1:nrow(SoI2SoI_Summary_Use)) {
  SoIweight <- SoI2SoI_Summary_Use[i, columns]
  RoUSweight <- RoUS2RoUS_Summary_Use[i, columns]
  SoIerror_1[i] <- ifelse(abs(SoIerror[i])<sum(SoIweight), SoIerror[i],
                          ifelse(SoIerror[i]<0, sum(SoIweight)*-1, sum(SoIweight)))
  SoIerror_2[i] <- ifelse(SoIerror_1[i]!=SoIerror[i], SoIerror_1[i]/2, SoIerror[i])
  RoUSerror[i] <- error[i] - SoIerror_2[i]
  SoI2SoI_Summary_Use[i, columns] <- SoIweight + SoIerror_2[i]*(SoIweight/sum(SoIweight))
  RoUS2RoUS_Summary_Use[i, columns] <- RoUSweight - RoUSerror[i]*(RoUSweight/sum(RoUSweight))
}

#' 9 - Re-calculate InterregionalImports, InterregionalExports and NetExports
SoI2SoI_Summary_Use$InterregionalImports <- rowSums(SoI_Summary_Domestic_Use[, columns]) - rowSums(SoI2SoI_Summary_Use[, columns])
SoI2SoI_Summary_Use$InterregionalExports <- SoI_Commodity_Output$StateCommOutput - rowSums(SoI2SoI_Summary_Use[, c(columns, "F040")])
SoI2SoI_Summary_Use$NetExports <- SoI2SoI_Summary_Use$InterregionalExports - SoI2SoI_Summary_Use$InterregionalImports

RoUS2RoUS_Summary_Use$InterregionalImports <- rowSums(RoUS_Summary_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Summary_Use[, columns])
RoUS2RoUS_Summary_Use$InterregionalExports <- RoUS_Commodity_Output$RoUSCommOutput - rowSums(RoUS2RoUS_Summary_Use[, c(columns, "F040")])
RoUS2RoUS_Summary_Use$NetExports <- RoUS2RoUS_Summary_Use$InterregionalExports - RoUS2RoUS_Summary_Use$InterregionalImports

#'10 - Validation
validation <- cbind.data.frame(SoI2SoI_Summary_Use$InterregionalImports - RoUS2RoUS_Summary_Use$InterregionalExports,
                               SoI2SoI_Summary_Use$InterregionalExports - RoUS2RoUS_Summary_Use$InterregionalImports,
                               SoI2SoI_Summary_Use$NetExports + RoUS2RoUS_Summary_Use$NetExports)
rownames(validation) <- rownames(RoUS2RoUS_Summary_Use)
colnames(validation) <- c("GA2GA$InterregionalImports - RoUS2RoUS$InterregionalExports",
                          "GA2GA$InterregionalExports - RoUS2RoUS$InterregionalImports",
                          "GA2GA$NetExports + RoUS2RoUS$NetExports")

# Write results to Excel
GA_2r_list <- list("US Domestic Use" = cbind(rownames(US_Summary_Domestic_Use),
                                             US_Summary_Domestic_Use),
                   "GA Domestic Use" = cbind(rownames(SoI_Summary_Domestic_Use),
                                             SoI_Summary_Domestic_Use),
                   "RoUS Domestic Use" = cbind(rownames(RoUS_Summary_Domestic_Use),
                                               RoUS_Summary_Domestic_Use),
                   "GA Commodity Output" = cbind(rownames(SoI_Commodity_Output),
                                                 SoI_Commodity_Output),
                   "RoUS Commodity Output" = cbind(rownames(RoUS_Commodity_Output),
                                                   RoUS_Commodity_Output),
                   "GA ICF_2r" = ICF,
                   "GA2GA Use 0" = cbind(rownames(SoI2SoI_Summary_Use_0), SoI2SoI_Summary_Use_0),
                   "RoUS2RoUS Use 0" = cbind(rownames(RoUS2RoUS_Summary_Use_0), RoUS2RoUS_Summary_Use_0),
                   "GA2GA Use" = cbind(rownames(SoI2SoI_Summary_Use), SoI2SoI_Summary_Use),
                   "RoUS2RoUS Use" = cbind(rownames(RoUS2RoUS_Summary_Use), RoUS2RoUS_Summary_Use),
                   "Validation" = cbind(rownames(validation), validation))
writexl::write_xlsx(GA_2r_list, "GA_2r_Use_new.xlsx", format_headers = FALSE)

