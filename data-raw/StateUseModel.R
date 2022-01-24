# Generate and save state Use and Domestic Use tables
for (year in 2012:2017) {
  # Build model
  StateUseModel <- buildStateUseModel(year)
  # Subset data set
  for (name in names(StateUseModel)) {
    df <- StateUseModel[[name]]
    # Write data to .rds
    data_name <- paste("State_Summary", name, year,
                       utils::packageDescription("stateior", fields = "Version"),
                       sep = "_")
    saveRDS(object = df,
            file = paste0(file.path("data", data_name), ".rds"))
    # Write metadata to JSON
    useeior:::writeMetadatatoJSON(package = "stateior",
                                  name = data_name,
                                  year = year,
                                  source = "stateior",
                                  url = NULL)
  }
}
