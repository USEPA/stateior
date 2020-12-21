#' Load two-region IO data of specified iolevel and year from user's local directory or the EPA Data Commons.
#' @description Load two-region IO data of specified iolevel and year from user's local directory or the EPA Data Commons.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @param dataname Name of desired IO data, can be "Make", "Use", "DomesticUse",
#' "UseTransactions", "FinalDemand", "DomesticUseTransactions", "DomesticFinalDemand",
#' "CommodityOutput, and "IndustryOutput".
#' @return A list of two-region IO data of specified iolevel and year.
#' @export
loadTwoRegionIOData <- function(year, iolevel, dataname) {
  # Define data file name
  filename <- getTwoRegionDataFileName(year, iolevel, dataname)
  # Adjust filename to fit what is on the Data Commons
  if (dataname%in%c("UseTransactions", "FinalDemand")) {
    filename <- gsub(dataname, "Use", filename)
  } else if (dataname%in%c("DomesticUseTransactions", "DomesticFinalDemand")) {
    filename <- gsub(dataname, "DomesticUse", filename)
  }
  # Try loading data from local folder
  logging::loginfo(paste("Loading", year, "two-region", iolevel, dataname, "from local folder ..."))
  filefolder <- file.path(rappdirs::user_data_dir(), "stateio")
  if (!dir.exists(filefolder)) {
    dir.create(filefolder, recursive = TRUE) 
  }
  filepath <- paste0(filefolder, "/", filename, ".rda")
  # If data not found in local folder, try loading from Data Commons
  if (!file.exists(filepath)) {
    logging::logwarn(paste("File not found in local folder, loading from Data Commons ..."))
    # Define URL then download from the Data Commons
    url <- paste0("https://edap-ord-data-commons.s3.amazonaws.com/stateio/", filename, ".rda")
    download.file(url, filepath, quiet = TRUE)
  }
  # Load the data
  TwoRegionIOData <- get(load(filepath))
  return(TwoRegionIOData)
}

#' Load make transactions of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load make transactions of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) make transactions.
#' @export
getTwoRegionMakeTransactions <- function(state, year, iolevel) {
  Make <- loadTwoRegionIOData(year, iolevel, "Make")[[state]]
  return(Make)
}

#' Load commodity output tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load commodity output tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) commodity output.
#' @export
getTwoRegionCommodityOutput <- function(state, year, iolevel) {
  CommOutput <- loadTwoRegionIOData(year, iolevel, "CommodityOutput")[[state]]
  return(CommOutput)
}

#' Load industry output tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load industry output tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) industry output.
#' @export
getTwoRegionIndustryOutput <- function(state, year, iolevel) {
  IndOutput <- loadTwoRegionIOData(year, iolevel, "IndustryOutput")[[state]]
  return(IndOutput)
}

#' Load use transactions (intermediate consumption) of a state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load use transactions (intermediate consumption) of a state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) use transactions.
#' @export
getTwoRegionUseTransactions <- function(state, year, iolevel) {
  df <- loadTwoRegionIOData(year, iolevel, "UseTransactions")[[state]]
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  industries <- getVectorOfCodes(iolevel, "Industry")
  UseTransactions <- df[c(apply(cbind(state, commodities), 1, FUN = joinStringswithSlashes),
                          apply(cbind("RoUS", commodities), 1, FUN = joinStringswithSlashes)),
                        c(apply(cbind(state, industries), 1, FUN = joinStringswithSlashes),
                          apply(cbind("RoUS", industries), 1, FUN = joinStringswithSlashes))]
  return(UseTransactions)
}

#' Load final demand of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load final demand of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) final demand.
#' @export
getTwoRegionFinalDemand <- function(state, year, iolevel) {
  df <- loadTwoRegionIOData(year, iolevel, "FinalDemand")[[state]]
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  finaldemand <- getFinalDemandCodes(iolevel)
  FinalDemand <- df[c(apply(cbind(state, commodities), 1, FUN = joinStringswithSlashes),
                      apply(cbind("RoUS", commodities), 1, FUN = joinStringswithSlashes)),
                    c(apply(cbind(state, finaldemand), 1, FUN = joinStringswithSlashes),
                      apply(cbind("RoUS", finaldemand), 1, FUN = joinStringswithSlashes))]
  return(FinalDemand)
}

#' Load domestic use transactions (intermediate consumption) of a state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load domestic use transactions (intermediate consumption) of a state of interest (SoI)
#' and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) domestic use transactions.
#' @export
getTwoRegionDomesticUseTransactions <- function(state, year, iolevel) {
  df <- loadTwoRegionIOData(year, iolevel, "DomesticUseTransactions")[[state]]
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  industries <- getVectorOfCodes(iolevel, "Industry")
  DomesticUseTransactions <- df[c(apply(cbind(state, commodities), 1, FUN = joinStringswithSlashes),
                                  apply(cbind("RoUS", commodities), 1, FUN = joinStringswithSlashes)),
                                c(apply(cbind(state, industries), 1, FUN = joinStringswithSlashes),
                                  apply(cbind("RoUS", industries), 1, FUN = joinStringswithSlashes))]
  return(DomesticUseTransactions)
}

#' Load domestic final demand of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load domestic final demand of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) domestic final demand.
#' @export
getTwoRegionDomesticFinalDemand <- function(state, year, iolevel) {
  df <- loadTwoRegionIOData(year, iolevel, "DomesticFinalDemand")[[state]]
  commodities <- getVectorOfCodes(iolevel, "Commodity")
  finaldemand <- getFinalDemandCodes(iolevel)
  DomesticFinalDemand <- df[c(apply(cbind(state, commodities), 1, FUN = joinStringswithSlashes),
                              apply(cbind("RoUS", commodities), 1, FUN = joinStringswithSlashes)),
                            c(apply(cbind(state, finaldemand), 1, FUN = joinStringswithSlashes),
                              apply(cbind("RoUS", finaldemand), 1, FUN = joinStringswithSlashes))]
  return(DomesticFinalDemand)
}

#' Load demand (trade) tables, including intermediate consumption and final demand,
#' of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load demand (trade) tables, including intermediate consumption and final demand,
#' of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) demand (trade) tables.
#' @export
getTwoRegionDemandTable <- function(state, year, iolevel) {
  TwoRegionDemand <- loadTwoRegionIOData(year, iolevel, "Demand")[[state]]
  return(TwoRegionDemand)
}

#' Load demand (trade) tables, including intermediate consumption, final demand, exports and imports
#' of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load demand (trade) tables, including intermediate consumption and final demand,
#' of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) demand (trade) tables.
#' @export
getTwoRegionCompleteDemandTable <- function(state, year, iolevel) {
  TwoRegionCompleteDemand <- loadTwoRegionIOData(year, iolevel, "CompleteDemand")[[state]]
  return(TwoRegionCompleteDemand)
}
