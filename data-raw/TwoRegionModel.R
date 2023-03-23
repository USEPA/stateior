# Generate and save two-region IO tables
## Temp code inputs:
# model_spec <- "StateIOv1.0.0-75"
# model_spec <- "StateIOv1.0.0-s"
# year <- 2017

# Load model spec
logging::loginfo(paste("Generating two region model for", model_spec))
configpath <- system.file("extdata/modelspecs/", paste0(model_spec, ".yml"), package = "stateior")
specs <- configr::read.config(configpath)
# specs <- useeior:::getConfiguration(model_spec, "model", pkg="stateior")

# Build model
TwoRegionModel <- assembleTwoRegionIO(year, iolevel = specs$BaseIOLevel,
                                      disagg_specs = specs$DisaggregationSpecs)

stub <- ifelse(is.null(specs$DisaggregationSpecs), "", specs$DisaggregationSpecs)

# Subset data set
for (name in names(TwoRegionModel)) {
  df <- TwoRegionModel[[name]]
  # Write data to .rds
  data_name <- paste("TwoRegion_Summary", name, stub, year,
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
