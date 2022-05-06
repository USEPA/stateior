#' Get EIA State Energy Data Systems (SEDS) code and description of state electricity data.
#' @return A data frame of EIA SEDS code and description of state electricity data.
getEIASEDSCodeDescription <- function() {
  # Download SEDS Codes and Descriptions table
  CodeDescFile <- "inst/extdata/EIA_SEDS_CodesDescriptions.xlsx"
  url <- "https://www.eia.gov/state/seds/CDF/Codes_and_Descriptions.xlsx"
  # Download EIA State Energy Data Systems (SEDS) consumption data
  if (!file.exists(CodeDescFile)) {
    utils::download.file(url, CodeDescFile, mode = "wb")
  }
  date_accessed <- as.character(as.Date(file.mtime(CodeDescFile)))
  CodeDesc <- as.data.frame(readxl::read_excel(CodeDescFile,
                                               sheet = "MSN Descriptions",
                                               skip = 9))
  # Write data to .rds
  data_name <- paste("EIA_SEDS_CodeDescription",
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = CodeDesc,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = NULL,
                                source = "US Energy Information Administration",
                                url = url,
                                date_last_modified = "unknown",
                                date_accessed = date_accessed)
}
# Download, save and document state electricity consumption code and description (from EIA)
getEIASEDSCodeDescription()

#' Get state electricity consumption data (total consumption and interstate trade,
#' in million kilowatt hours) from EIA State Energy Data Systems (SEDS), from
#' 2012 to the latest year available 
#' @param year A numeric value specifying year of interest.
#' @return A data frame of state electricity consumption data (total consumption
#' and interstate trade, in million kilowatt hours) from EIA SEDS.
getEIASEDSStateElectricityConsumption <- function() {
  # Download state electricity consumption data from EIA State Energy Data Systems (SEDS)
  ConsumptionFile <- "inst/extdata/EIA_SEDS_consumption.csv"
  url <- "https://www.eia.gov/state/seds/sep_use/total/csv/use_all_phy.csv"
  if (!file.exists(ConsumptionFile)) {
    utils::download.file(url, ConsumptionFile, mode = "wb")
  }
  Consumption <- utils::read.table(ConsumptionFile, sep = ",", header = TRUE,
                                   stringsAsFactors = FALSE, check.names = FALSE,
                                   fill = TRUE)
  # Find latest data year
  end_year <- colnames(Consumption)[ncol(Consumption)]
  # Create year_cols
  year_cols <- as.character(2012:end_year)
  # Save data
  for (year in year_cols) {
    df <- Consumption[, c("State", "MSN",  year)]
    # Write data to .rds
    data_name <- paste("EIA_SEDS_StateElectricityConsumption", year,
                       utils::packageDescription("stateior", fields = "Version"),
                       sep = "_")
    saveRDS(object = df,
            file = paste0(file.path("data", data_name), ".rds"))
    # Write metadata to JSON
    useeior:::writeMetadatatoJSON(package = "stateior",
                                  name = data_name,
                                  year = year,
                                  source = "US Energy Information Administration",
                                  url = url,
                                  date_last_modified = date_last_modified,
                                  date_accessed = date_accessed)
  }
}
# Download, save and document EIA's state electricity consumption from 2012 to
# the latest year available 
getEIASEDSStateElectricityConsumption(year)
