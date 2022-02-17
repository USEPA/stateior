#' Load two-region IO data of specified iolevel and year
#' from user's local directory or the EPA Data Commons.
#' @description Load two-region IO data of specified iolevel and year
#' from user's local directory or the EPA Data Commons.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse",
#' "UseTransactions", "FinalDemand", "InternationalTradeAdjustment,
#' "DomesticUseTransactions", "DomesticFinalDemand",
#' "CommodityOutput, "IndustryOutput", and "DomesticUsewithTrade".
#' @return A list of two-region IO data of specified iolevel and year.
loadTwoRegionIOData <- function(year, iolevel, dataname) {
  checkIOLevel(iolevel)
  # Define data file name
  filename <- getTwoRegionDataFileName(year, iolevel, dataname)
  # Adjust filename to fit what is on the Data Commons
  if (dataname%in%c("UseTransactions", "FinalDemand")) {
    filename <- gsub(dataname, "Use", filename)
  } else if (dataname%in%c("DomesticUseTransactions", "DomesticFinalDemand")) {
    filename <- gsub(dataname, "DomesticUse", filename)
  }
  TwoRegionIOData <- loadStateIODataFile(filename)
  # Try loading data from local folder
  return(TwoRegionIOData)
}

#' Check state name. Stop function execution if input parameter is not a valid state name.
#' @param state A text value specifying state of interest.
checkStateName <- function(state) {
  if (!state%in%c(state.name, "District of Columbia", "Overseas")) {
    stop(paste(state, "is not a valid state name. No data is found."))
  }
}

#' Check IO level. Stop function execution if input parameter is not "Summary".
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
checkIOLevel <- function(iolevel) {
  if(iolevel!="Summary"){
    stop(paste(iolevel, "level data are not available. Only 'Summary' level data are available."))
  }
}

#' Load make transactions of a state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load make transactions of a SoI and its correspondingRoUS
#' for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of SoI's and RoUS' make transactions.
#' @export
getTwoRegionMakeTransactions <- function(state, year, iolevel) {
  checkStateName(state)
  Make <- loadTwoRegionIOData(year, iolevel, "Make")[[state]]
  return(Make)
}

#' Load two-region total use transactions (intermediate consumption)
#' in state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load two-region total use transactions (intermediate consumption)
#' in SoI and its corresponding RoUS for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of two-region total use transactions.
#' @export
getTwoRegionUseTransactions <- function(state, year, iolevel) {
  checkStateName(state)
  df <- loadTwoRegionIOData(year, iolevel, "UseTransactions")[[state]]
  row_names <- c(getBEASectorCodeLocation("Commodity", state, iolevel),
                 getBEASectorCodeLocation("Commodity", "RoUS", iolevel))
  col_names <- c(getBEASectorCodeLocation("Industry", state, iolevel),
                 getBEASectorCodeLocation("Industry", "RoUS", iolevel))
  UseTransactions <- df[row_names, col_names]
  return(UseTransactions)
}

#' Load two-region final demand in state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load two-region final demand in SoI and RoUS for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of two-region final demand.
#' @export
getTwoRegionFinalDemand <- function(state, year, iolevel) {
  checkStateName(state)
  df <- loadTwoRegionIOData(year, iolevel, "FinalDemand")[[state]]
  row_names <- c(getBEASectorCodeLocation("Commodity", state, iolevel),
                 getBEASectorCodeLocation("Commodity", "RoUS", iolevel))
  col_names <- c(getBEASectorCodeLocation("FinalDemand", state, iolevel),
                 getBEASectorCodeLocation("FinalDemand", "RoUS", iolevel))
  FinalDemand <- df[row_names, col_names]
  return(FinalDemand)
}

#' Load two-region domestic use transactions (intermediate consumption)
#' in state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load two-region domestic use transactions (intermediate consumption)
#' in SoI and its corresponding RoUS for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of two-region domestic use transactions.
#' @export
getTwoRegionDomesticUseTransactions <- function(state, year, iolevel) {
  checkStateName(state)
  df <- loadTwoRegionIOData(year, iolevel, "DomesticUseTransactions")[[state]]
  row_names <- c(getBEASectorCodeLocation("Commodity", state, iolevel),
                 getBEASectorCodeLocation("Commodity", "RoUS", iolevel))
  col_names <- c(getBEASectorCodeLocation("Industry", state, iolevel),
                 getBEASectorCodeLocation("Industry", "RoUS", iolevel))
  DomesticUseTransactions <- df[row_names, col_names]
  return(DomesticUseTransactions)
}

#' Load domestic two-region final demand in state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load two-region domestic final demand in SoI and RoUS for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of two-region domestic final demand.
#' @export
getTwoRegionDomesticFinalDemand <- function(state, year, iolevel) {
  checkStateName(state)
  df <- loadTwoRegionIOData(year, iolevel, "DomesticFinalDemand")[[state]]
  row_names <- c(getBEASectorCodeLocation("Commodity", state, iolevel),
                 getBEASectorCodeLocation("Commodity", "RoUS", iolevel))
  col_names <- c(getBEASectorCodeLocation("FinalDemand", state, iolevel),
                 getBEASectorCodeLocation("FinalDemand", "RoUS", iolevel))
  DomesticFinalDemand <- df[row_names, col_names]
  return(DomesticFinalDemand)
}

#' Load two-region international trade adjustment
#' in state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load two-region international trade adjustment vector
#' in SoI and its corresponding RoUS for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of two-region international trade adjustment.
#' @export
getTwoRegionInternationalTradeAdjustment <- function(state, year, iolevel) {
  checkStateName(state)
  ITA <- loadTwoRegionIOData(year, iolevel, "InternationalTradeAdjustment")[[state]]
  return(ITA)
}

#' Load two-region value added in state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load two-region value added of a SoI and its corresponding RoUS
#' for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of two-region value added.
#' @export
getTwoRegionValueAdded <- function(state, year, iolevel) {
  checkStateName(state)
  df <- loadTwoRegionIOData(year, iolevel, "ValueAdded")[[state]]
  row_names <- c(getBEASectorCodeLocation("ValueAdded", state, iolevel),
                 getBEASectorCodeLocation("ValueAdded", "RoUS", iolevel))
  col_names <- c(getBEASectorCodeLocation("Industry", state, iolevel),
                 getBEASectorCodeLocation("Industry", "RoUS", iolevel))
  ValueAdded <- df[row_names, col_names]
  return(ValueAdded)
}

#' Load commodity output tables of a state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load commodity output tables of a SoI and its corresponding RoUS
#' for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of SoI's and RoUS' commodity output.
#' @export
getTwoRegionCommodityOutput <- function(state, year, iolevel) {
  checkStateName(state)
  CommOutput <- loadTwoRegionIOData(year, iolevel, "CommodityOutput")[[state]]
  return(CommOutput)
}

#' Load industry output tables of a state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load industry output tables of a SoI and its corresponding RoUS
#' for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of SoI's and RoUS' industry output.
#' @export
getTwoRegionIndustryOutput <- function(state, year, iolevel) {
  checkStateName(state)
  IndOutput <- loadTwoRegionIOData(year, iolevel, "IndustryOutput")[[state]]
  return(IndOutput)
}

#' Load two-region domestic use table (intermediate consumption and final demand)
#' and interregional trade in state of interest (SoI) and its corresponding rest-of-US (RoUS)
#' for a given year.
#' @description Load two-region domestic use table (intermediate consumption and final demand)
#' and interregional trade in state of interest (SoI) and its corresponding rest-of-US (RoUS)
#' for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, currently can only be "Summary",
#' theoretically can be "Detail", or "Sector" in future versions.
#' @return A data.frame of SoI's and RoUS' complete demand (trade) tables.
#' @export
getTwoRegionDomesticUsewithTrade <- function(state, year, iolevel) {
  checkStateName(state)
  TwoRegionDomesticUsewithTrade <- loadTwoRegionIOData(year,
                                                       iolevel,
                                                       "DomesticUsewithTrade")[[state]]
  return(TwoRegionDomesticUsewithTrade)
}
