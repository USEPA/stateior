# Create 2-region Use tables for specified state and year
GA_2r <- buildTwoRegionStateDemandModel("Georgia", year = 2012, ioschema = 2012, "Summary")
MN_2r <- buildTwoRegionStateDemandModel("Minnesota", year = 2012, ioschema = 2012, "Summary")
OR_2r <- buildTwoRegionStateDemandModel("Oregon", year = 2012, ioschema = 2012, "Summary")
WA_2r <- buildTwoRegionStateDemandModel("Washington", year = 2012, ioschema = 2012, "Summary")

# Write 2-region Use tables to .xlsx file
writexl::write_xlsx(list("GA2GA" = cbind(rownames(GA_2r$SoI2SoI), GA_2r$SoI2SoI),
                         "GA2RoUS" = cbind(rownames(GA_2r$SoI2RoUS), GA_2r$SoI2RoUS),
                         "RoUS2GA" = cbind(rownames(GA_2r$RoUS2SoI), GA_2r$RoUS2SoI),
                         "RoUS2RoUS" = cbind(rownames(GA_2r$RoUS2RoUS), GA_2r$RoUS2RoUS),
                         "Validation" = cbind(rownames(GA_2r$Validation), GA_2r$Validation)),
                    "GA_2r_Use.xlsx", format_headers = FALSE)
writexl::write_xlsx(list("MN2MN" = cbind(rownames(MN_2r$SoI2SoI), MN_2r$SoI2SoI),
                         "RoUS2MN" = cbind(rownames(MN_2r$SoI2RoUS), MN_2r$SoI2RoUS),
                         "MN2RoUS" = cbind(rownames(MN_2r$RoUS2SoI), MN_2r$RoUS2SoI),
                         "RoUS2RoUS" = cbind(rownames(MN_2r$RoUS2RoUS), MN_2r$RoUS2RoUS),
                         "Validation" = cbind(rownames(MN_2r$Validation), MN_2r$Validation)),
                    "MN_2r_Use.xlsx", format_headers = FALSE)
writexl::write_xlsx(list("OR2OR" = cbind(rownames(OR_2r$SoI2SoI), OR_2r$SoI2SoI),
                         "OR2RoUS" = cbind(rownames(OR_2r$SoI2RoUS), OR_2r$SoI2RoUS),
                         "RoUS2OR" = cbind(rownames(OR_2r$RoUS2SoI), OR_2r$RoUS2SoI),
                         "RoUS2RoUS" = cbind(rownames(OR_2r$RoUS2RoUS), OR_2r$RoUS2RoUS),
                         "Validation" = cbind(rownames(OR_2r$Validation), OR_2r$Validation)),
                    "OR_2r_Use.xlsx", format_headers = FALSE)
writexl::write_xlsx(list("WA2WA" = cbind(rownames(WA_2r$SoI2SoI), WA_2r$SoI2SoI),
                         "WA2RoUS" = cbind(rownames(WA_2r$SoI2RoUS), WA_2r$SoI2RoUS),
                         "RoUS2WA" = cbind(rownames(WA_2r$RoUS2SoI), WA_2r$RoUS2SoI),
                         "RoUS2RoUS" = cbind(rownames(WA_2r$RoUS2RoUS), WA_2r$RoUS2RoUS),
                         "Validation" = cbind(rownames(WA_2r$Validation), WA_2r$Validation)),
                    "WA_2r_Use.xlsx", format_headers = FALSE)
