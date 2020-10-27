# Generate and save state-US value added ratios
state_US_VA_ratio <- finalizeStateUSValueAddedRatio(2012)
save(state_US_VA_ratio, file = "data/StateUS_VAratio_2012.rda")
state_US_VA_ratio <- finalizeStateUSValueAddedRatio(2017)
save(state_US_VA_ratio, file = "data/StateUS_VAratio_2017.rda")

# Generate and save alternative state commodity output ratio
AlternativeStateCommodityOutputRatio <- getStateCommodityOutputRatioEstimates(2012)
save(AlternativeStateCommodityOutputRatio, file = "data/AlternativeStateCommodityOutputRatio_2012.rda")
AlternativeStateCommodityOutputRatio <- getStateCommodityOutputRatioEstimates(2017)
save(AlternativeStateCommodityOutputRatio, file = "data/AlternativeStateCommodityOutputRatio_2017.rda")
