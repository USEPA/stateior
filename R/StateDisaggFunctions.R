

#' @return A stateior model object with the disaggregation specs loaded.
getStateModelDisaggSpecs <- function(){

  # Initialize model for every state
  model <- list() 
  configfile <- "UtilityDisaggregation"
  disaggConfigpath <- system.file(paste0("extdata/disaggspecs/"), paste0(configfile,".yml"), package = "stateior")
  
  model$specs$DisaggregationSpecs <- configfile
  
  model <- useeior:::getDisaggregationSpecs(model, disaggConfigpath)
  return(model)
  
}


#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return A stateior model with the disaggregateed objects
disaggregateStateModel <- function(model, state){

  temp <- 1
  # Need to export all disagg functions from useeior package? 
#  disaggregateMakeTable <- utils::getFromNamespace("disaggregateMakeTable","useeior")
  

  
  for (disagg in model$DisaggregationSpecs){
    # TODO: add call to other disaggregation functions
    
    logging::loginfo(paste0("Disaggregating ", disagg$OrignalSectorName," for ", state))
    
    # Formatting Make row and column names according to useeior disaggregation formats
    # For make rows
    rowLabels <- rownames(model$MakeTransactions)
    rowLabels <- gsub(".*\\.", "", rowLabels)
    rowLabels <- paste0(rowLabels, "/US")
    
    # For make cols
    colLabels <- colnames(model$MakeTransactions)
    colLabels <- paste0(colLabels, "/US")
    
    # Replace names with new labels
    rownames(model$MakeTransactions) <- rowLabels
    colnames(model$MakeTransactions) <- colLabels
    
    
    #model$MakeTransactions <- disaggregateMakeTable(model, disagg)
    model$MakeTransactions <- useeior:::disaggregateMakeTable(model, disagg)
    
    temp <- 1
    
  }
  
  

  
  temp <- 2
  
  return(model)
  
  
}