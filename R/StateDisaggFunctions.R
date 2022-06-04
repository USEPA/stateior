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



#' Gets a stored or user specified model or aggregation/disaggregation configuration file
#' @param configname str, name of the configuration file
#' @param configtype str, configuration type, can be "model", "disagg", or "agg"
#' @param configpaths str vector, paths (including file name) of model configuration file
#' and optional agg/disagg configuration file(s). If NULL, built-in config files are used.
#' @return A list of model specifications.
getConfigurationStateior <- function(configname, configtype, configpaths = NULL) {
  configfile <- paste0(configname, ".yml")
  if (is.null(configpaths)) {
    configpath <- system.file(paste0("extdata/", configtype, "specs/"), configfile, package = "stateior")
  } else {
    configpath <- configpaths[endsWith(configpaths, configfile)]
  }
  if (!file.exists(configpath)) {
    stop(paste(configfile, "must be available in ", dirname(configpath)),
         call. = FALSE)
  }
  config <- configr::read.config(configpath)
  return(config)
}


#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return A stateior model with the disaggregateed objects
disaggregateStateModel <- function(model, state){

  temp <- 1
  # Need to export all disagg functions from useeior package? 
  disaggregateMakeTable <- utils::getFromNamespace("disaggregateMakeTable","useeior")
  

  
  for (disagg in model$DisaggregationSpecs){
    # TODO: add call to other disaggregation functions
    
    
    # Format stateior model objects to conform to useeior disaggregation formats
    # Format for MakeFileDF
    oldIndIndeces <- which(!(disagg$MakeFileDF$IndustryCode %in% disagg$DisaggregatedSectorCodes)) # Find Ind indeces for MakeFileDF which do not contain new sectors 
    disagg$MakeFileDF$IndustryCode[oldIndIndeces] <- gsub("\\/.*", "",disagg$MakeFileDF$IndustryCode[oldIndIndeces]) # remove the /US from oldIndIndces
    disagg$MakeFileDF$IndustryCode[oldIndIndeces] <- paste0(state,".",disagg$MakeFileDF$IndustryCode[oldIndIndeces]) # add state name to oldIndIndeces sectors
    
    #same as above, but for commodity codes in the make table
    oldComIndeces <- which(!(disagg$MakeFileDF$CommodityCode %in% disagg$DisaggregatedSectorCodes))
    disagg$MakeFileDF$CommodityCode[oldComIndeces] <- gsub("\\/.*", "",disagg$MakeFileDF$CommodityCode[oldComIndeces]) # remove the /US from oldIndIndces
    
    # Format for UseFileDF...
    
    model$MakeTransactions <- disaggregateMakeTable(model, disagg)
    
  }
  
  

  
  temp <- 2
  
  return(model)
  
  
}