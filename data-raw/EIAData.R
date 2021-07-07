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
#' in million kilowatt hours or gigawatt hours) from EIA State Energy Data Systems (SEDS)
#' @param startyear A numeric value specifying start year of the year range of interest.
#' @param endyear A numeric value specifying end year of the year range of interest.
#' @return A data frame of state electricity consumption data (including total consumption
#' and interstate trade, in million kilowatt hours or gigawatt hours) from EIA SEDS
getEIASEDSStateElectricityConsumption <- function (startyear, endyear) {
  # Download state electricity consumption data from EIA State Energy Data Systems (SEDS)
  ConsumptionFile <- "inst/extdata/EIA_SEDS_consumption.csv"
  if(!file.exists(ConsumptionFile)) {
    download.file("https://www.eia.gov/state/seds/sep_use/total/csv/use_all_phy.csv",
                  ConsumptionFile, mode = "wb")
  }
  Consumption <- readCSV(ConsumptionFile)[, c("State", "MSN",
                                              as.character(seq(startyear, endyear)))]
  return(Consumption)
}
EIA_SEDS_StateElectricityConsumption_2010_2019 <- getEIASEDSStateElectricityConsumption(2010, 2019)
usethis::use_data(EIA_SEDS_StateElectricityConsumption_2010_2019, overwrite = TRUE)

#' Get state electricity expenditure data (in million dollars) from EIA SEDS.
#' @param startyear A numeric value specifying start year of the year range of interest.
#' @param endyear A numeric value specifying end year of the year range of interest.
#' @return A data frame of state electricity expenditure data (in million dollars) from EIA SEDS.
getEIASEDSStateElectricityExpenditure <- function(startyear, endyear) {
  # Download state electricity expenditure data from EIA State Energy Data Systems (SEDS)
  ExpenditureFile <- "inst/extdata/EIA_SEDS_expenditure.csv"
  if(!file.exists(ExpenditureFile)) {
    download.file("https://www.eia.gov/state/seds/sep_prices/total/csv/ex_all.csv",
                  ExpenditureFile, mode = "wb")
  }
  Expenditure <- readCSV(ExpenditureFile)[, c("State", "MSN",
                                              as.character(seq(startyear, endyear)))]
  return(Expenditure)
}
EIA_SEDS_StateElectricityExpenditure_2010_2019 <- getEIASEDSStateElectricityExpenditure(2010, 2019)
usethis::use_data(EIA_SEDS_StateElectricityExpenditure_2010_2019, overwrite = TRUE)

#' Get state electricity generation data (in gigawatt hours) from EIA.
#' @param startyear A numeric value specifying start year of the year range of interest.
#' @param endyear A numeric value specifying end year of the year range of interest.
#' @return A data frame of state electricity generation data (in gigawatt hours) from EIA.
getEIAStateElectricityGeneration <- function(startyear, endyear) {
  # Download state annual generation from EIA
  filename <- "inst/extdata/EIA_StateNetGenration.csv"
  if(!file.exists(filename)) {
    download.file("https://www.eia.gov/electricity/data/state/annual_generation_state.xls",
                  filename, mode = "wb")
  }
  # Load and data
  df <- as.data.frame(readxl::read_excel(filename, skip = 1))
  df <- df[df$YEAR%in%seq(startyear, endyear) &
             df$STATE%in%c(toupper(state.abb), "DC") &
             complete.cases(df), ]
  # Convert generation from megawatt hours to gigawatt hours
  df[, "GENERATION (Gigawatt hours)"] <- df[, "GENERATION (Megawatthours)"]*1E-3
  df[, "GENERATION (Megawatthours)"] <- NULL
  return(df)
}
EIA_StateElectricityGeneration_2010_2019 <- getEIAStateElectricityGeneration(2010, 2019)
usethis::use_data(EIA_StateElectricityGeneration_2010_2019, overwrite = TRUE)
