# Generate and save state Make tables
# Build model
specs <- {}
specs$BaseIOSchema <- 2017
specs$model_ver <- "0.4.0"

StateSupplyModel <- buildStateSupplyModel(year, specs)
# Subset data set
for (name in names(StateSupplyModel)) {
  df <- StateSupplyModel[[name]]
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
                                url = NULL,
                                date_last_modified = as.character(Sys.Date()),
                                date_accessed = NULL)
}
