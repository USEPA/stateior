#'Creates 2-region Use table for given year and state
#'Stores table by year by state .rda files in useeior package

#' 1 - Load state domestic Use for the given year and state
year <- 2012
state <- "Georgia"
state_abb <- state.abb[which(state.name==state)]
load(paste0("data/State_Summary_Domestic_Use_", year, ".rda"))
SoI_Domestic_Use <- State_Summary_Domestic_Use[gsub("\\..*", "", rownames(State_Summary_Domestic_Use))==state, ]
columns <- colnames(SoI_Domestic_Use)[!colnames(SoI_Domestic_Use)%in%c("F040", "F050")]

#' 2 - Generate 2-region ICFs
ICF <- generateDomestic2RegionICFs(state, year, remove_scrap = FALSE, ioschema = 2012, iolevel = "Summary")

#' 3 - Generate SoI2SoI Use
SoI2SoI_Use <- SoI_Domestic_Use
SoI2SoI_Use[, columns] <- SoI_Domestic_Use[, columns] * ICF$SoI2SoI
# Calculate Interregional Imports
SoI2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(SoI2SoI_Use[, columns])
# Calculate Interregional Exports
load(paste0("data/State_Summary_CommodityOutput_", year, ".rda"))
SoI_Commodity_Output <- State_Summary_CommodityOutput_list[[state]]
SoI2SoI_Use$InterregionalExports <- SoI_Commodity_Output[, 1] - rowSums(SoI2SoI_Use[, c(columns, "F040")])
# Calculate Net Exports
SoI2SoI_Use$NetExports <- SoI2SoI_Use$InterregionalExports - SoI2SoI_Use$InterregionalImports

#' 4 - Generate RoUS Make, domestic Use and commodity output
# US Make
US_Make <- get(paste("Summary_Make", year, "BeforeRedef", sep = "_"), as.environment("package:useeior"))*1E6
US_MakeTransaction <- US_Make[-which(rownames(US_Make)=="Total Commodity Output"),
                              -which(colnames(US_Make)=="Total Industry Output")]
# SoI Make
load(paste0("data/State_Summary_Make_", year, ".rda"))
SoI_Make <- State_Summary_MakeTransaction_balanced[gsub("\\..*", "", rownames(State_Summary_MakeTransaction_balanced))==state, ]
# RoUS Make
RoUS_Make <- US_MakeTransaction - SoI_Make

# RoUS domestic Use
US_Domestic_Use <- estimateUSDomesticUse("Summary", year)
RoUS_Domestic_Use <- US_Domestic_Use - SoI_Domestic_Use
# RoUS Commodity Output
US_Commodity_Output <- colSums(US_MakeTransaction)
RoUS_Commodity_Output <- US_Commodity_Output - SoI_Commodity_Output
colnames(RoUS_Commodity_Output) <- "RoUSCommOutput"
# Adjust RoUS_Commodity_Output
MakeUseDiff <- US_Commodity_Output - rowSums(US_Domestic_Use[, c(columns, "F040")])
RoUS_Commodity_Output$Output <- RoUS_Commodity_Output$Output - MakeUseDiff

#' 5 - Generate RoUS2RoUS Use
RoUS2RoUS_Use <- RoUS_Domestic_Use
RoUS2RoUS_Use[, columns] <- RoUS_Domestic_Use[, columns] * ICF$RoUS2RoUS
# Calculate Interregional Imports
RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Use[, columns])
# Calculate Interregional Exports
RoUS2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(RoUS2RoUS_Use[, c(columns, "F040")])
# Calculate Net Exports
RoUS2RoUS_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports

# Save SoI2SoI_Use and RoUS2RoUS_Use as baseline tables
SoI2SoI_Use_0 <- SoI2SoI_Use
RoUS2RoUS_Use_0 <- RoUS2RoUS_Use

#' 6 - Allocate negative InterregionalExports across columns in SoI2SoI Use and RoUS2RoUS Use
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
SoI2SoI_Use$InterregionalExports <- SoI_Commodity_Output[, 1] - rowSums(SoI2SoI_Use[, c(columns, "F040")])
RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Use[, columns])
RoUS2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(RoUS2RoUS_Use[, c(columns, "F040")])

#' 7 - Calculate errors for SoI and RoUS
error <- SoI2SoI_Use$InterregionalImports - RoUS2RoUS_Use$InterregionalExports
SoIerror <- error*(SoI_Commodity_Output[, 1]/US_Commodity_Output)
RoUSerror <- error - SoIerror
SoIerror_1 <-SoIerror_2 <- SoIerror

#' 8 - Allocate the errors across columns in SoI2SoI Use and RoUS2RoUS Use
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

#' 9 - Re-calculate InterregionalImports, InterregionalExports and NetExports
SoI2SoI_Use$InterregionalImports <- rowSums(SoI_Domestic_Use[, columns]) - rowSums(SoI2SoI_Use[, columns])
SoI2SoI_Use$InterregionalExports <- SoI_Commodity_Output[, 1] - rowSums(SoI2SoI_Use[, c(columns, "F040")])
SoI2SoI_Use$NetExports <- SoI2SoI_Use$InterregionalExports - SoI2SoI_Use$InterregionalImports

RoUS2RoUS_Use$InterregionalImports <- rowSums(RoUS_Domestic_Use[, columns]) - rowSums(RoUS2RoUS_Use[, columns])
RoUS2RoUS_Use$InterregionalExports <- RoUS_Commodity_Output$Output - rowSums(RoUS2RoUS_Use[, c(columns, "F040")])
RoUS2RoUS_Use$NetExports <- RoUS2RoUS_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports

#'10 - Validation
validation <- cbind.data.frame(SoI2SoI_Use$InterregionalImports - RoUS2RoUS_Use$InterregionalExports,
                               SoI2SoI_Use$InterregionalExports - RoUS2RoUS_Use$InterregionalImports,
                               SoI2SoI_Use$NetExports + RoUS2RoUS_Use$NetExports)
rownames(validation) <- rownames(RoUS2RoUS_Use)
colnames(validation) <- c(paste0(state_abb, "2", state_abb, "$InterregionalImports - RoUS2RoUS$InterregionalExports"),
                          paste0(state_abb, "2", state_abb, "$InterregionalExports - RoUS2RoUS$InterregionalImports"),
                          paste0(state_abb, "2", state_abb, "$NetExports + RoUS2RoUS$NetExports"))

# Write results to Excel
SoIRoUS_2r_list <- list("US Domestic Use" = cbind(rownames(US_Domestic_Use),
                                                  US_Domestic_Use),
                        "SoI Domestic Use" = cbind(rownames(SoI_Domestic_Use),
                                                   SoI_Domestic_Use),
                        "RoUS Domestic Use" = cbind(rownames(RoUS_Domestic_Use),
                                                    RoUS_Domestic_Use),
                        "SoI Commodity Output" = cbind(rownames(SoI_Commodity_Output),
                                                       SoI_Commodity_Output),
                        "RoUS Commodity Output" = cbind(rownames(RoUS_Commodity_Output),
                                                        RoUS_Commodity_Output),
                        "SoI ICF_2r" = ICF,
                        "SoI2SoI Use 0" = cbind(rownames(SoI2SoI_Use_0), SoI2SoI_Use_0),
                        "RoUS2RoUS Use 0" = cbind(rownames(RoUS2RoUS_Use_0), RoUS2RoUS_Use_0),
                        "SoI2SoI Use" = cbind(rownames(SoI2SoI_Use), SoI2SoI_Use),
                        "RoUS2RoUS Use" = cbind(rownames(RoUS2RoUS_Use), RoUS2RoUS_Use),
                        "Validation" = cbind(rownames(validation), validation))
writexl::write_xlsx(SoIRoUS_2r_list, paste0(state_abb, "_2r_Use_new.xlsx"), format_headers = FALSE)

GA_2r <- generateDomestic2RegionUse("Georgia", 2012, 2012, "Summary")
MN_2r <- generateDomestic2RegionUse("Minnesota", 2012, 2012, "Summary")
OR_2r <- generateDomestic2RegionUse("Oregon", 2012, 2012, "Summary")
WA_2r <- generateDomestic2RegionUse("Washington", 2012, 2012, "Summary")

writexl::write_xlsx(list("GA2GA" = cbind(rownames(GA_2r$SoI2SoI), GA_2r$SoI2SoI),
                         "RoUS2RoUS" = cbind(rownames(GA_2r$RoUS2RoUS), GA_2r$RoUS2RoUS),
                         "RoUS2GA" = cbind(rownames(GA_2r$RoUS2SoI), GA_2r$RoUS2SoI),
                         "GA2RoUS" = cbind(rownames(GA_2r$SoI2RoUS), GA_2r$SoI2RoUS),
                         "Validation" = cbind(rownames(GA_2r$Validation), GA_2r$Validation)),
                    "GA_2r_Use.xlsx", format_headers = FALSE)
writexl::write_xlsx(list("MN2MN" = cbind(rownames(MN_2r$SoI2SoI), MN_2r$SoI2SoI),
                         "RoUS2RoUS" = cbind(rownames(MN_2r$RoUS2RoUS), MN_2r$RoUS2RoUS),
                         "MN2RoUS" = cbind(rownames(MN_2r$RoUS2SoI), MN_2r$RoUS2SoI),
                         "RoUS2MN" = cbind(rownames(MN_2r$SoI2RoUS), MN_2r$SoI2RoUS),
                         "Validation" = cbind(rownames(MN_2r$Validation), MN_2r$Validation)),
                    "MN_2r_Use.xlsx", format_headers = FALSE)
writexl::write_xlsx(list("OR2OR" = cbind(rownames(OR_2r$SoI2SoI), OR_2r$SoI2SoI),
                         "RoUS2RoUS" = cbind(rownames(OR_2r$RoUS2RoUS), OR_2r$RoUS2RoUS),
                         "RoUS2OR" = cbind(rownames(OR_2r$RoUS2SoI), OR_2r$RoUS2SoI),
                         "OR2RoUS" = cbind(rownames(OR_2r$SoI2RoUS), OR_2r$SoI2RoUS),
                         "Validation" = cbind(rownames(OR_2r$Validation), OR_2r$Validation)),
                    "OR_2r_Use.xlsx", format_headers = FALSE)
writexl::write_xlsx(list("WA2WA" = cbind(rownames(WA_2r$SoI2SoI), WA_2r$SoI2SoI),
                         "RoUS2RoUS" = cbind(rownames(WA_2r$RoUS2RoUS), WA_2r$RoUS2RoUS),
                         "RoUS2WA" = cbind(rownames(WA_2r$RoUS2SoI), WA_2r$RoUS2SoI),
                         "WA2RoUS" = cbind(rownames(WA_2r$SoI2RoUS), WA_2r$SoI2RoUS),
                         "Validation" = cbind(rownames(WA_2r$Validation), WA_2r$Validation)),
                    "WA_2r_Use.xlsx", format_headers = FALSE)
