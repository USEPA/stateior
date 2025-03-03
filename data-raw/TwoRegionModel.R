# Generate and save two-region IO tables

# model_spec <- "StateIOv1.2-milkbar" # Utilities disaggregation
# model_spec <- "StateIOv1.2-shoofly" # base model
# year <- 2019

# Load model spec
logging::loginfo(paste("Generating two region model for", model_spec))
configpath <- system.file("extdata/modelspecs/", paste0(model_spec, ".yml"), package = "stateior")
specs <- configr::read.config(configpath)

# Build model
specs <- {}
specs$BaseIOSchema <- 2017
specs$model_ver <- "0.4.0"

TwoRegionModel <- assembleTwoRegionIO(year, iolevel = "Summary", specs,
                                      disagg_specs = specs$DisaggregationSpecs)
alias <- gsub("^.*-", "", model_spec)

# Subset data set
for (name in names(TwoRegionModel)) {
  df <- TwoRegionModel[[name]]
  # Write data to .rds
  data_name <- paste("TwoRegion_Summary", name, alias, year,
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
