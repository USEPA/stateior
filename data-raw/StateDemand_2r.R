#'Creates 2-region Use table for given year and state
#'Stores table by year by state .rda files in useeior package

#' 1 - Load state domestic Use for the given year and state
year <- 2012
state <- "Georgia"
load(paste0("data/State_Summary_Domestic_Use_", year, ".rda"))
SoI_Summary_Domestic_Use <- State_Summary_Domestic_Use[gsub("\\..*", "", rownames(State_Summary_Domestic_Use))==state, ]

#' 2 - Generate 2-region ICFs
ICF <- generateDomestic2RegionICFs(state, year, remove_scrap = FALSE, 2012, "Summary")

#' 3 - Generate SoI2SoI Use
SoI2SoI_Summary_Use <- SoI_Summary_Domestic_Use * ICF$SoI2SoI
columns <- colnames(SoI2SoI_Summary_Use)
# Calculate Interregional Imports
SoI2SoI_Summary_Use$InterregionalImports <- rowSums(SoI_Summary_Domestic_Use[, columns[!columns%in%c("F040", "F050")]]) - rowSums(SoI2SoI_Summary_Use[, columns[!columns%in%c("F040", "F050")]])
# Calculate Interregional Exports
load(paste0("data/State_Summary_CommodityOutput_", year, ".rda"))
SoI_Commodity_Output <- State_Summary_CommodityOutput_list[[state]]
SoI2SoI_Summary_Use$InterregionalExports <- SoI_Commodity_Output$StateCommOutput - rowSums(SoI2SoI_Summary_Use[, columns[columns!="F050"]])
# Calculate Net Exports
SoI2SoI_Summary_Use$NetExports <- SoI2SoI_Summary_Use$InterregionalExports - SoI2SoI_Summary_Use$InterregionalImports

#' 4 - Generate RoU2RoU Use
RoU2RoU_Summary_Use <- SoI_Summary_Domestic_Use * ICF$RoUS2RoUS

# Write results to Excel
GA_2r_list <- list("GA Domestic Use" = cbind(rownames(SoI_Summary_Domestic_Use),
                                             SoI_Summary_Domestic_Use),
                   "GA Commodity Output" = cbind(rownames(State_Summary_CommodityOutput_list[["Georgia"]]),
                                                 State_Summary_CommodityOutput_list[["Georgia"]]),
                   "GA ICF_2r" = ICF,
                   "GA2GA Use" = cbind(rownames(SoI2SoI_Summary_Use), SoI2SoI_Summary_Use),
                   "RoU2RoU Use" = cbind(rownames(RoU2RoU_Summary_Use), RoU2RoU_Summary_Use))
writexl::write_xlsx(GA_2r_list, "GA_2r_Use.xlsx")
