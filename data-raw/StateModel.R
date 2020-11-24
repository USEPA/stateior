### 2012 State Supply Model
StateSupplyModel_2012 <- buildStateSupplyModel(2012)
# Make table
State_Summary_Make_2012 <- StateSupplyModel_2012$Make
usethis::use_data(State_Summary_Make_2012, overwrite = TRUE)
# Industry Output
State_Summary_IndustryOutput_2012 <- StateSupplyModel_2012$IndustryOutput
usethis::use_data(State_Summary_IndustryOutput_2012, overwrite = TRUE)
# Commodity Output
State_Summary_CommodityOutput_2012 <- StateSupplyModel_2012$CommodityOutput
usethis::use_data(State_Summary_CommodityOutput_2012, overwrite = TRUE)

### 2012 State Demand Model
StateDemandModel_2012 <- buildStateDemandModel(2012)
# Use table
State_Summary_Use_2012 <- StateDemandModel_2012$Use
usethis::use_data(State_Summary_Use_2012, overwrite = TRUE)
# Domestic Use table
State_Summary_DomesticUse_2012 <- StateDemandModel_2012$DomesticUse
usethis::use_data(State_Summary_DomesticUse_2012, overwrite = TRUE)

### 2012 Two-region IO tables and industry and commodity output
TwoRegion_Summary_IO_2012 <- assembleTwoRegionIO(iolevel = "Summary", 2012)
# Make
TwoRegion_Summary_Make_2012 <- TwoRegion_Summary_IO_2012$Make
usethis::use_data(TwoRegion_Summary_Make_2012, overwrite = TRUE)
# Use
TwoRegion_Summary_Use_2012 <- TwoRegion_Summary_IO_2012$Use
usethis::use_data(TwoRegion_Summary_Use_2012, overwrite = TRUE)
# DomesticUse
TwoRegion_Summary_DomesticUse_2012 <- TwoRegion_Summary_IO_2012$DomesticUse
usethis::use_data(TwoRegion_Summary_DomesticUse_2012, overwrite = TRUE)
# Demand
TwoRegion_Summary_Demand_2012 <- TwoRegion_Summary_IO_2012$Demand
usethis::use_data(TwoRegion_Summary_Demand_2012, overwrite = TRUE)
# Industry Output
TwoRegion_Summary_IndustryOutput_2012 <- TwoRegion_Summary_IO_2012$IndustryOutput
usethis::use_data(TwoRegion_Summary_IndustryOutput_2012, overwrite = TRUE)
# Commodity Output
TwoRegion_Summary_CommodityOutput_2012 <- TwoRegion_Summary_IO_2012$CommodityOutput
usethis::use_data(TwoRegion_Summary_CommodityOutput_2012, overwrite = TRUE)
