#' Load make tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load make tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) make tables.
#' @export
loadTwoRegionMakeTable <- function(state, year, iolevel) {
  Make <- get(paste("TwoRegion", iolevel, "Make", year, sep = "_"),
              as.environment("package:stateior"))[[state]]
  return(Make)
}

#' Load commodity output tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load commodity output tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) commodity output.
#' @export
loadTwoRegionCommodityOutput <- function(state, year, iolevel) {
  CommOutput <- get(paste("TwoRegion", iolevel, "CommodityOutput", year, sep = "_"),
                    as.environment("package:stateior"))[[state]]
  return(CommOutput)
}

#' Load industry output tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load industry output tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) industry output.
#' @export
loadTwoRegionIndustryOutput <- function(state, year, iolevel) {
  IndOutput <- get(paste("TwoRegion", iolevel, "IndustryOutput", year, sep = "_"),
                   as.environment("package:stateior"))[[state]]
  return(IndOutput)
}

#' Load use tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load use tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) use tables.
#' @export
loadTwoRegionUseTable <- function(state, year, iolevel) {
  Use <- get(paste("TwoRegion", iolevel, "Use", year, sep = "_"),
             as.environment("package:stateior"))[[state]]
  return(Use)
}

#' Load domestic use tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load domestic use tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) domestic use tables.
#' @export
loadTwoRegionDomesticUseTable <- function(state, year, iolevel) {
  DomesticUse <- get(paste("TwoRegion", iolevel, "DomesticUse", year, sep = "_"),
                     as.environment("package:stateior"))[[state]]
  return(DomesticUse)
}


#' Load demand (trade) tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @description Load demand (trade) tables of a state of interest (SoI) and its corresponding rest-of-US (RoUS) for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of a state of interest (SoI) and its corresponding rest-of-US (RoUS) demand (trade) tables.
#' @export
loadTwoRegionDemandTable <- function(state, year, iolevel) {
  TwoRegionDemand <- get(paste("TwoRegion", iolevel, "Demand", year, sep = "_"),
                         as.environment("package:stateior"))[[state]]
  return(TwoRegionDemand)
}
