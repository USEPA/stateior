#' # Need to insert following code in appropriate script":
#' 
#' # # Check for disaggregation
#' # model <- getStateDisaggregationSpecs(model, configpaths)
#' # if(length(model$DisaggregationSpecs)!=0){
#' #   model <- disaggregateModel(model)
#' # }
#' 
#' 
#' ## TODO: Note that this is an outline of the expected sequence of steps to load the data and disaggregation specs into R. Need to incorporate in
#' ## correct places within stateior code
#' 
#' #' Obtain disaggregation specs for each state and year from input files.
#' #' Assumes buildStateSupplyModel and buildStateUseModel have been called and the data generated for each state.
#' #' @param model An stateior model object with model specs and IO tables loaded
#' #' @param configpaths str vector, paths (including file name) of disagg configuration file(s).
#' #' If NULL, built-in config files are used.
#' #' @return A model with the specified aggregation and disaggregation specs.
#' stateDisaggregationSpecs <- function(model, configpaths){
#' 
#'   # Get State list
#'   states <- unique(StateUS_VA_Ratio$GeoName) # Taken from buildStateSupplyModel function. Unsure if this variable will be globally available.
#'   stateModel <- list()
#' 
#'   for (year in 2012:2017) {
#' 
#'     for(state in states){
#'       stateMode$Use <- loadStateIODataFile(paste0("State_Summary_Use_",
#'                                                   year))[[state]] # Need to very parameters and adequacy of function call
#'       stateModel$Make <- loadStateIODataFile(paste0("State_Summary_Use_",
#'                                                     year))[[state]] # Need to very parameters and adequacy of function call
#'       # Check for disaggregation
#'       stateModel <- getDisaggregationSpecs(stateModel, configpaths)
#' 
#'     }
#' 
#' 
#'   }# end of for year loop
#' 
#' }


#' @param model An stateior model object with model specs and IO tables loaded
#' @param configpaths str vector, paths (including file name) of disagg configuration file(s).
#' If NULL, built-in config files are used.
#' @return A model with the specified aggregation and disaggregation specs.
getStateDisaggregationSpecs <- function(model, configpaths){
  #TODO: Need to make this work with calls to useeior::
  
}