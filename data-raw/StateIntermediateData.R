for (year in 2012:2017) {
  for (name in c("VAR", "COR", "GVA")) {
    if (name=="VAR") {
      # Generate and save state-US value added ratios
      df <- finalizeStateUSValueAddedRatio(year)
      data_name <- paste("StateUS_VA_Ratio", year,
                         utils::packageDescription("stateior", fields = "Version"),
                         sep = "_")
      source <- "US Bureau of Economic Analysis"
    } else if (name=="COR") {
      # Generate and save alternative state commodity output ratio
      df <- getStateCommodityOutputRatioEstimates(year)
      data_name <- paste("AlternativeStateCommodityOutputRatio", year,
                         utils::packageDescription("stateior", fields = "Version"),
                         sep = "_")
      source <- paste("US Department of Agriculture",
                      "National Oceanic and Atmospheric Administration",
                      "US Oak Ridge National Laboratory",
                      sep = ",")
    } else if (name=="GVA") {
      # Generate and save alternative state gross value added
      df <- assembleStateSummaryGrossValueAdded(year)
      data_name <- paste("State_Summary_GrossValueAdded", year,
                         utils::packageDescription("stateior", fields = "Version"),
                         sep = "_")
      source <- "US Bureau of Economic Analysis"
    }
    # Write data to .rds
    saveRDS(object = df,
            file = paste0(file.path("data", data_name), ".rds"))
    # Write metadata to JSON
    useeior:::writeMetadatatoJSON(package = "stateior",
                                  name = data_name,
                                  year = year,
                                  source = source,
                                  url = NULL)
  }
}
