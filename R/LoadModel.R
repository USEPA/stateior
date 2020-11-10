#' Load make table of a specific state for a given year.
#' @description Load make table of a specific state for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of state make table.
#' @export
loadStateMakeTable <- function(state, year, iolevel) {
  Make <- get(paste("State", iolevel, "Make", year, sep = "_"),
              as.environment("package:stateior"))[[state]]
  return(Make)
}

#' Load commodity output of a specific state for a given year.
#' @description Load commodity output of a specific state for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of state commodity output.
#' @export
loadStateCommodityOutput <- function(state, year, iolevel) {
  CommOutput <- get(paste("State", iolevel, "CommodityOutput", year, sep = "_"),
                    as.environment("package:stateior"))[[state]]
  return(CommOutput)
}

#' Load industry output of a specific state for a given year.
#' @description Load industry output of a specific state for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of state industry output.
#' @export
loadStateIndustryOutput <- function(state, year, iolevel) {
  IndOutput <- get(paste("State", iolevel, "IndustryOutput", year, sep = "_"),
                   as.environment("package:stateior"))[[state]]
  return(IndOutput)
}

#' Load use table of a specific state for a given year.
#' @description Load use table of a specific state for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of state use table.
#' @export
loadStateUseTable <- function(state, year, iolevel) {
  Use <- get(paste("State", iolevel, "Use", year, sep = "_"),
             as.environment("package:stateior"))[[state]]
  return(Use)
}

#' Load domestic use table of a specific state for a given year.
#' @description Load domestic use table of a specific state for a given year.
#' @param state A text value specifying state of interest.
#' @param year A numeric value between 2007 and 2017 specifying the year of interest.
#' @param iolevel BEA sector level of detail, can be "Detail", "Summary", or "Sector".
#' @return A dataframe of state domestic use table.
#' @export
loadStateDomesticUseTable <- function(state, year, iolevel) {
  DomesticUse <- get(paste("State", iolevel, "DomesticUse", year, sep = "_"),
                     as.environment("package:stateior"))[[state]]
  return(DomesticUse)
}
