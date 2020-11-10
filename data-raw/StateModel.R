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

### 2012 Two-region State Demand Model
StateTwoRegionDemandModel <- buildTwoRegionStateDemandModel(state, year, ioschema, iolevel)
