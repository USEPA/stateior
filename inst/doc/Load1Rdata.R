# Load year-specific single region data
# year must already be defined to source this script

# Load state Make, industry and commodity output
State_Summary_Make_ls <- loadStateIODataFile(paste0("State_Summary_Make_", year))
states <- names(State_Summary_Make_ls)

# Load state total Use and domestic Use
State_Summary_Use_ls <- loadStateIODataFile(paste0("State_Summary_Use_", year))
State_Summary_DomesticUse_ls <- loadStateIODataFile(paste0("State_Summary_DomesticUse_", year))
State_Summary_IndustryOutput_ls <- loadStateIODataFile(paste0("State_Summary_IndustryOutput_", year))
State_Summary_CommodityOutput_ls <- loadStateIODataFile(paste0("State_Summary_CommodityOutput_", year))

cat("State and two-region IO data successfully loaded.")
