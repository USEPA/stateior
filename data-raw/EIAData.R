#' Get EIA State Energy Data Systems (SEDS) code and description of state electricity data.
#' @return A data frame of EIA SEDS code and description of state electricity data.
getEIASEDSCodeDescription <- function() {
  # Download SEDS Codes and Descriptions table
  CodeDescFile <- "inst/extdata/EIA_SEDS_CodesDescriptions.xlsx"
  # Download EIA State Energy Data Systems (SEDS) consumption data
  if(!file.exists(CodeDescFile)) {
    download.file("https://www.eia.gov/state/seds/CDF/Codes_and_Descriptions.xlsx",
                  CodeDescFile, mode = "wb")
  }
  CodeDesc <- as.data.frame(readxl::read_excel(CodeDescFile,
                                               sheet = "MSN Descriptions",
                                               skip = 9))
  return(CodeDesc)
}
EIA_SEDS_CodeDescription <- getEIASEDSCodeDescription()
usethis::use_data(EIA_SEDS_CodeDescription, overwrite = TRUE)

#' Get state electricity consumption data (including total consumption and interstate trade,
#' in million kilowatt hours) from EIA State Energy Data Systems (SEDS)
#' @param year A numeric value specifying year of interest.
#' @return A data frame of state electricity consumption data (including total consumption
#' and interstate trade, in million kilowatt hours) from EIA SEDS
getEIASEDSStateElectricityConsumption <- function (year) {
  # Download state electricity consumption data from EIA State Energy Data Systems (SEDS)
  ConsumptionFile <- "inst/extdata/EIA_SEDS_consumption.csv"
  if(!file.exists(ConsumptionFile)) {
    download.file("https://www.eia.gov/state/seds/sep_use/total/csv/use_all_phy.csv",
                  ConsumptionFile, mode = "wb")
  }
  Consumption <- readCSV(ConsumptionFile)[, c("State", "MSN",  as.character(year))]
  return(Consumption)
}
EIA_SEDS_StateElectricityConsumption_2012 <- getEIASEDSStateElectricityConsumption(2012)
usethis::use_data(EIA_SEDS_StateElectricityConsumption_2012, overwrite = TRUE)
EIA_SEDS_StateElectricityConsumption_2013 <- getEIASEDSStateElectricityConsumption(2013)
usethis::use_data(EIA_SEDS_StateElectricityConsumption_2013, overwrite = TRUE)
EIA_SEDS_StateElectricityConsumption_2014 <- getEIASEDSStateElectricityConsumption(2014)
usethis::use_data(EIA_SEDS_StateElectricityConsumption_2014, overwrite = TRUE)
EIA_SEDS_StateElectricityConsumption_2015 <- getEIASEDSStateElectricityConsumption(2015)
usethis::use_data(EIA_SEDS_StateElectricityConsumption_2015, overwrite = TRUE)
EIA_SEDS_StateElectricityConsumption_2016 <- getEIASEDSStateElectricityConsumption(2016)
usethis::use_data(EIA_SEDS_StateElectricityConsumption_2016, overwrite = TRUE)
EIA_SEDS_StateElectricityConsumption_2017 <- getEIASEDSStateElectricityConsumption(2017)
usethis::use_data(EIA_SEDS_StateElectricityConsumption_2017, overwrite = TRUE)
