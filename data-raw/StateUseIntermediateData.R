# For state supply model, generate and save (1) state-US value added ratios and
# (2) state alternative commodity output ratios
# Generate and save alternative state gross value added
df <- assembleStateSummaryGrossValueAdded(year)
data_name <- paste("State_Summary_GrossValueAdded", year,
                   utils::packageDescription("stateior", fields = "Version"),
                   sep = "_")
source <- "US Bureau of Economic Analysis"
# Write data to .rds
saveRDS(object = df,
        file = paste0(file.path("data", data_name), ".rds"))
# Write metadata to JSON
useeior:::writeMetadatatoJSON(package = "stateior",
                              name = data_name,
                              year = year,
                              source = source,
                              url = NULL)
