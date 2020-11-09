# Generate and save state-US value added ratios
StateUS_VA_Ratio_2012 <- finalizeStateUSValueAddedRatio(2012)
usethis::use_data(StateUS_VA_Ratio_2012, overwrite = TRUE)
StateUS_VA_Ratio_2017 <- finalizeStateUSValueAddedRatio(2017)
usethis::use_data(StateUS_VA_Ratio_2017, overwrite = TRUE)

# Generate and save alternative state commodity output ratio
AlternativeStateCommodityOutputRatio_2012 <- getStateCommodityOutputRatioEstimates(2012)
usethis::use_data(AlternativeStateCommodityOutputRatio_2012, overwrite = TRUE)
AlternativeStateCommodityOutputRatio_2017 <- getStateCommodityOutputRatioEstimates(2017)
usethis::use_data(AlternativeStateCommodityOutputRatio_2017, overwrite = TRUE)
