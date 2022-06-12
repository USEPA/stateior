

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

    logging::loginfo(paste0("Disaggregating ", disagg$OrignalSectorName," for ", state))
    
    # Formatting model objects according to useeior disaggregation formats
    model$MakeTransactions <- formatMakeFromStateToUSEEIO(model, state) #Formatting MakeTransactions object
    model$FullUse <- formatFullUseFromStateToUSEEIO(model, state) # Formatting row/column names in FullUse object
    model <- splitFullUse(model, state) # Splitting FullUse into UseTransactions, UseValueAdded, and FinalDemand objects
 
    # Disaggregating specified model objects
    model$MakeTransactions <- useeior:::disaggregateMakeTable(model, disagg)
    
    model$UseTransactions <- useeior:::disaggregateUseTable(model, disagg)
    model$FinalDemand <- useeior:::disaggregateFinalDemand(model, disagg, domestic = FALSE)
    model$UseValueAdded <- useeior:::disaggregateVA(model, disagg)
    
    # Formatting disaggregated model objects back to stateior formats
    model$MakeTransactions <- formatMakeFromUSEEIOtoState(model, state)
    model$FullUse <- formatFullUseFromUSEEIOToState(model, state)
    
    temp <- 1
    
  }
  
  temp <- 2
  
  return(model)
  
  
} 


#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return A stateior make table formatted for disaggregation with useeior functions
formatMakeFromStateToUSEEIO <- function(model, state){
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
  
  return(model$MakeTransactions)
}

#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return The FullUse model object with useeior formatting fit for disaggregation functions
formatFullUseFromStateToUSEEIO <- function(model, state){
  temp <- 1
  
  rowLabels <- rownames(model$FullUse)
  rowLabels <- paste0(rowLabels, "/US")
  rownames(model$FullUse) <- rowLabels
  
  columnLabels <- colnames(model$FullUse)
  columnLabels <- paste0(columnLabels, "/US")
  colnames(model$FullUse) <- columnLabels
  
  return(model$FullUse)
}

#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return A stateior make table formatted according to stateior specifications
formatMakeFromUSEEIOtoState <- function(model, state){
  
  rowLabels <- rownames(model$MakeTransactions)
  rowLabels <- gsub("\\/.*","",rowLabels) # remove everything after "/"
  rowLabels <- paste0(state,".",rowLabels) # add state and . before sector name to match original format
  rownames(model$MakeTransactions) <- rowLabels # Replace old row labels with new ones
  
  columnLabels <- colnames(model$MakeTransactions)
  columnLabels <- gsub("\\/.*","",columnLabels) # remove everything after "/" 
  colnames(model$MakeTransactions) <- columnLabels # replace old column labels with new ones
  
  return(model$MakeTransactions)
}

#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return A stateior FullUse table formatted according to stateior specifications
formatFullUseFromUSEEIOtoState <- function(model, state){
  
  # rowLabels <- rownames(model$MakeTransactions)
  # rowLabels <- gsub("\\/.*","",rowLabels) # remove everything after "/"
  # rowLabels <- paste0(state,".",rowLabels) # add state and . before sector name to match original format
  # rownames(model$MakeTransactions) <- rowLabels # Replace old row labels with new ones
  # 
  # columnLabels <- colnames(model$MakeTransactions)
  # columnLabels <- gsub("\\/.*","",columnLabels) # remove everything after "/" 
  # colnames(model$MakeTransactions) <- columnLabels # replace old column labels with new ones
  
  return(model$FullUse)
}
#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return A model object with FullUse split into UseTransactions, FinalDemand, and UseValueAdded objects
splitFullUse <- function(model, state){
  numCommodities <- dim(model$CommodityOutput)[1] # Find number of commodities
  numIndustries <- dim(model$IndustryOutput)[1] # Find number of industries
  model$UseTransactions <- model$FullUse[1:numCommodities, 1:numIndustries] # Get subset of FullUse with numCommodities rows and numIndustries columns
  model$UseValueAdded <- model$FullUse[-(1:numCommodities),1:numIndustries] # Get subset of FullUse, starting from rows after numCommodities, with numIndustries columns
  model$FinalDemand <- model$FullUse[1:numCommodities,-(1:numIndustries)] # Get subset of FullUse, with numCommodities rows and starting from columns after numIndustries
  
  return(model)
  
}


