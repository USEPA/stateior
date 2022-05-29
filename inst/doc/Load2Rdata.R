# Load two-region tables
# year must already be defined to source this script

TwoRegionMake_ls <- loadStateIODataFile(paste0("TwoRegion_Summary_Make_", year))
TwoRegionCommodityOutput_ls <- loadStateIODataFile(paste0("TwoRegion_Summary_CommodityOutput_", year))
TwoRegionIndustryOutput_ls <- loadStateIODataFile(paste0("TwoRegion_Summary_IndustryOutput_", year))
TwoRegionDomesticUse_ls <- loadStateIODataFile(paste0("TwoRegion_Summary_DomesticUse_", year))
TwoRegionDomesticUsewithTrade_ls <- loadStateIODataFile(paste0("TwoRegion_Summary_DomesticUsewithTrade_", year))
TwoRegionITA_ls <- loadStateIODataFile(paste0("TwoRegion_Summary_InternationalTradeAdjustment_", year))
