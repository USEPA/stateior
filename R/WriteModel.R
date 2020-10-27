#' Write state supply model to .rda
#' @description Write state supply model to .rda
#' @param model A state supply model, must contain a list of state Make tables,
#' a list of state industry output, and a list of state commodity output.
#' @export
writeStateSupplyModel <- function(model) {
  # Make table
  State_Summary_Make_list <- model$Make
  save(State_Summary_Make_list,
       file = paste0("data/State_Summary_Make_", year, ".rda"))
  # Industry Output
  State_Summary_IndustryOutput_list <- model$IndustryOutput
  save(State_Summary_IndustryOutput_list,
       file = paste0("data/State_Summary_IndustryOutput_", year, ".rda"))
  # Commodity Output
  State_Summary_CommodityOutput_list <- model$CommodityOutput
  save(State_Summary_CommodityOutput_list,
       file = paste0("data/State_Summary_CommodityOutput_", year, ".rda"))
}

#' Write state demand model to .rda
#' @description Write state demand model to .rda
#' @param model A state demand model, must contain a list of state Use tables and
#' a list of state domestic Use tables.
#' @export
writeStateDemandModel <- function(model) {
  # Use table
  State_Summary_Use_list <- model$Use
  save(State_Summary_Use_list,
       file = paste0("data/State_Summary_Use_", year, ".rda"))
  # Domestic Use table
  State_Summary_DomesticUse_list <- model$DomesticUse
  save(State_Summary_DomesticUse_list,
       file = paste0("data/State_Summary_DomesticUse_", year, ".rda"))
}
