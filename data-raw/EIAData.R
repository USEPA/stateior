#' Get EIA State Energy Data Systems (SEDS) code and description of state electricity data.
#' @return A data frame of EIA SEDS code and description of state electricity data.
getEIASEDSCodeDescription <- function() {
  # Download SEDS Codes and Descriptions table
  CodeDescFile <- "inst/extdata/EIA_SEDS_CodesDescriptions.xlsx"
  # Download EIA State Energy Data Systems (SEDS) consumption data
  if(!file.exists(CodeDescFile)) {
    utils::download.file("https://www.eia.gov/state/seds/CDF/Codes_and_Descriptions.xlsx",
                  CodeDescFile, mode = "wb")
  }
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
                                url = "https://www.eia.gov/state/seds/CDF/Codes_and_Descriptions.xlsx")
}
# Download, save and document state electricity consumption code and description (from EIA)
getEIASEDSCodeDescription()

#' Get state electricity consumption data (including total consumption and interstate trade,
#' in million kilowatt hours) from EIA State Energy Data Systems (SEDS)
#' @param year A numeric value specifying year of interest.
#' @return A data frame of state electricity consumption data (including total consumption
#' and interstate trade, in million kilowatt hours) from EIA SEDS
getEIASEDSStateElectricityConsumption <- function (year) {
  # Download state electricity consumption data from EIA State Energy Data Systems (SEDS)
  ConsumptionFile <- "inst/extdata/EIA_SEDS_consumption.csv"
  if(!file.exists(ConsumptionFile)) {
    utils::download.file("https://www.eia.gov/state/seds/sep_use/total/csv/use_all_phy.csv",
                  ConsumptionFile, mode = "wb")
  }
  Consumption <- readCSV(ConsumptionFile)[, c("State", "MSN",  as.character(year))]
  # Write data to .rds
  data_name <- paste("EIA_SEDS_StateElectricityConsumption", year,
                     utils::packageDescription("stateior", fields = "Version"),
                     sep = "_")
  saveRDS(object = Consumption,
          file = paste0(file.path("data", data_name), ".rds"))
  # Write metadata to JSON
  useeior:::writeMetadatatoJSON(package = "stateior",
                                name = data_name,
                                year = year,
                                source = "US Energy Information Administration",
                                url = "https://www.eia.gov/state/seds/sep_use/total/csv/use_all_phy.csv")
}
# Download, save and document 2012-2017 state electricity consumption (from EIA)
for (year in 2012:2017) {
  getEIASEDSStateElectricityConsumption(year)
}
