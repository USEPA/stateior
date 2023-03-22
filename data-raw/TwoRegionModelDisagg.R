# Generate and save two-region IO tables
## Temp code inputs:
model_spec <- "StateIOv1.0.0-75"
year <- "2017"

# Load model spec
specs <- useeior:::getConfiguration(model_spec, "model", pkg="stateior")

# Build model
TwoRegionModel <- assembleTwoRegionIO(year, iolevel = specs$BaseIOLevel,
                                      disagg_specs = specs$DisaggregationSpecs)
# Subset data set
for (name in names(TwoRegionModel)) {
  df <- TwoRegionModel[[name]]
  # Write data to .rds
  data_name <- paste("TwoRegion_Summary", name, spec$DisaggregationSpecs, year,
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

