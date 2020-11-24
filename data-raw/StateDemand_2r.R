states <- sort(c(state.name, "District of Columbia"))
# Generate and save two-region interregional commodity flow (ICF) ratios
TwoRegion_Summary_ICF_Ratios_2012 <- list()
for (state in states) {
  ICF <- generateDomestic2RegionICFs(state, year = 2012, remove_scrap = FALSE,
                                     ioschema = 2012, iolevel = "Summary")
  TwoRegion_Summary_ICF_Ratios_2012[[state]] <- ICF
  print(state)
}
usethis::use_data(TwoRegion_Summary_ICF_Ratios_2012, overwrite = TRUE)

# # Create 2-region Use tables for specified state and year
# GA_2r <- buildTwoRegionDemandModel("Georgia", year = 2012, ioschema = 2012, "Summary")
# MN_2r <- buildTwoRegionDemandModel("Minnesota", year = 2012, ioschema = 2012, "Summary")
# OR_2r <- buildTwoRegionDemandModel("Oregon", year = 2012, ioschema = 2012, "Summary")
# WA_2r <- buildTwoRegionDemandModel("Washington", year = 2012, ioschema = 2012, "Summary")
# 
# # Write 2-region Use tables to .xlsx file
# writexl::write_xlsx(list("GA2GA" = cbind(rownames(GA_2r$SoI2SoI), GA_2r$SoI2SoI),
#                          "GA2RoUS" = cbind(rownames(GA_2r$SoI2RoUS), GA_2r$SoI2RoUS),
#                          "RoUS2GA" = cbind(rownames(GA_2r$RoUS2SoI), GA_2r$RoUS2SoI),
#                          "RoUS2RoUS" = cbind(rownames(GA_2r$RoUS2RoUS), GA_2r$RoUS2RoUS),
#                          "Validation" = cbind(rownames(GA_2r$Validation), GA_2r$Validation)),
#                     "GA_2r_Use.xlsx", format_headers = FALSE)
# writexl::write_xlsx(list("MN2MN" = cbind(rownames(MN_2r$SoI2SoI), MN_2r$SoI2SoI),
#                          "RoUS2MN" = cbind(rownames(MN_2r$SoI2RoUS), MN_2r$SoI2RoUS),
#                          "MN2RoUS" = cbind(rownames(MN_2r$RoUS2SoI), MN_2r$RoUS2SoI),
#                          "RoUS2RoUS" = cbind(rownames(MN_2r$RoUS2RoUS), MN_2r$RoUS2RoUS),
#                          "Validation" = cbind(rownames(MN_2r$Validation), MN_2r$Validation)),
#                     "MN_2r_Use.xlsx", format_headers = FALSE)
# writexl::write_xlsx(list("OR2OR" = cbind(rownames(OR_2r$SoI2SoI), OR_2r$SoI2SoI),
#                          "OR2RoUS" = cbind(rownames(OR_2r$SoI2RoUS), OR_2r$SoI2RoUS),
#                          "RoUS2OR" = cbind(rownames(OR_2r$RoUS2SoI), OR_2r$RoUS2SoI),
#                          "RoUS2RoUS" = cbind(rownames(OR_2r$RoUS2RoUS), OR_2r$RoUS2RoUS),
#                          "Validation" = cbind(rownames(OR_2r$Validation), OR_2r$Validation)),
#                     "OR_2r_Use.xlsx", format_headers = FALSE)
# writexl::write_xlsx(list("WA2WA" = cbind(rownames(WA_2r$SoI2SoI), WA_2r$SoI2SoI),
#                          "WA2RoUS" = cbind(rownames(WA_2r$SoI2RoUS), WA_2r$SoI2RoUS),
#                          "RoUS2WA" = cbind(rownames(WA_2r$RoUS2SoI), WA_2r$RoUS2SoI),
#                          "RoUS2RoUS" = cbind(rownames(WA_2r$RoUS2RoUS), WA_2r$RoUS2RoUS),
#                          "Validation" = cbind(rownames(WA_2r$Validation), WA_2r$Validation)),
#                     "WA_2r_Use.xlsx", format_headers = FALSE)
