

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

  # TODO: Include disaggregation of domestic use for each state
  # TODO: Include validation checks for row/column sums - note that there may be unexpected results due to existing negative values in state use tables.

  for (disagg in model$DisaggregationSpecs){

    logging::loginfo(paste0("Disaggregating ", disagg$OrignalSectorName," for ", state))
    
    # Formatting model objects according to useeior disaggregation formats
    model$MakeTransactions <- formatMakeFromStateToUSEEIO(model, state) #Formatting MakeTransactions object
    model$FullUse <- formatFullUseFromStateToUSEEIO(model$FullUse) # Formatting row/column names in FullUse object
    model <- splitFullUse(model) # Splitting FullUse into UseTransactions, UseValueAdded, and FinalDemand objects
 
    # Disaggregating specified model objects
    model$MakeTransactions <- useeior:::disaggregateMakeTable(model, disagg)
    
    model$UseTransactions <- useeior:::disaggregateUseTable(model, disagg)
    model$FinalDemand <- useeior:::disaggregateFinalDemand(model, disagg, domestic = FALSE)
    model$UseValueAdded <- useeior:::disaggregateVA(model, disagg)
    
    if(model$specs$CommodityorIndustryType=="Commodity") {
      model <- calculateStateIndustryCommodityOuput(model) # Also formats the disaggregated industry and commodity outputs to stateior formats
      
    }
    
    # Formatting disaggregated model objects back to stateior formats
    model$MakeTransactions <- formatMakeFromUSEEIOtoState(model, state)
    model$FullUse <- formatFullUseFromUSEEIOtoState(model, state)
    
  }
  
  return(model)
  
  
} 


#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param disagg Specifications for model disaggregation
#' @return A stateior model with the disaggregateed objects
disaggregateNationalObjectsInStateModel <- function(model, disagg){

  # Format specified national stateior objects to model to prepare for disaggregation
  
  # Format Make
  model$MakeTransactions <- formatMakeFromStateToUSEEIO(model, state) #Formatting MakeTransactions object
  
  # Format individual domestic use objects (DomesticUseTransactions, DomesticFinalDemand)
  model$US_DomesticFullUse <- formatFullUseFromStateToUSEEIO(model$US_DomesticFullUse) # Note that the domestic full use object does not include value added rows
  model <- splitFullUse(model, domestic = TRUE) # Splitting FullUse into UseTransactions, UseValueAdded, and FinalDemand objects
  model$specs$CommodityorIndustryType <- "Commodity" # Needed for disaggregation of model$FinalDemand model object in useeior 
  
  # Disaggregate model objects
  
  model$MakeTransactions <- useeior:::disaggregateMakeTable(model, disagg)
  model$DomesticUseTransactions <- useeior:::disaggregateUseTable(model, disagg, domestic = TRUE)
  model$DomesticFinalDemand <- useeior:::disaggregateFinalDemand(model, disagg, domestic = TRUE)
  # Disaggregate industry and commodity lists last because the original lists are used in the disaggregation of the other obejcts
  model$Industries <- disaggregateStateSectorLists(model$Industries, disagg)
  model$Commodities <- disaggregateStateSectorLists(model$Commodities, disagg)
  
  # Convert disaggregated objects back to stateior formats. Note that commodities and industries did not change format in disaggregation.
  
  model$MakeTransactions <- formatMakeFromUSEEIOtoState(model, state = "National")
  model$US_DomesticFullUse <- formatFullUseFromUSEEIOtoState(model, state, domestic = TRUE)

  
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

#' @param table FullUse table
#' @return The FullUse model object with useeior formatting fit for disaggregation functions
formatFullUseFromStateToUSEEIO <- function(table){

  rowLabels <- rownames(table)
  rowLabels <- paste0(rowLabels, "/US")
  rownames(table) <- rowLabels
  
  columnLabels <- colnames(table)
  columnLabels <- paste0(columnLabels, "/US")
  colnames(table) <- columnLabels
  
  return(table)
}

#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return A stateior make table formatted according to stateior specifications
formatMakeFromUSEEIOtoState <- function(model, state){
  
  rowLabels <- rownames(model$MakeTransactions)
  rowLabels <- gsub("\\/.*","",rowLabels) # remove everything after "/"
  if(state != "National"){
    rowLabels <- paste0(state,".",rowLabels) # add state and . before sector name to match original format for state models only
  }

  rownames(model$MakeTransactions) <- rowLabels # Replace old row labels with new ones
  
  columnLabels <- colnames(model$MakeTransactions)
  columnLabels <- gsub("\\/.*","",columnLabels) # remove everything after "/" 
  colnames(model$MakeTransactions) <- columnLabels # replace old column labels with new ones
  
  return(model$MakeTransactions)
}

#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @param domestic A boolean that indicates whether the table to format is the domesticUse table or not
#' @return A stateior FullUse table formatted according to stateior specifications
formatFullUseFromUSEEIOtoState <- function(model, state, domestic = FALSE){

  if(domestic == TRUE){
    model$US_DomesticFullUse <- cbind(model$DomesticUseTransactions, model$DomesticFinalDemand) # combine UseTransactions and FinalDemand columns

    # Format row and column names
    rownames(model$US_DomesticFullUse) <- gsub("\\/.*","",rownames(model$US_DomesticFullUse)) # remove everything after "/"
    colnames(model$US_DomesticFullUse) <- gsub("\\/.*","",colnames(model$US_DomesticFullUse)) # remove everything after "/"
    
    return(model$US_DomesticFullUse)
    
  }else{
    tempFullUse <- cbind(model$UseTransactions, model$FinalDemand) # combine UseTransactions and FinalDemand columns
    
    # Create the empty section of FullUse that is VA rows by FD columns (NA values)
    VAbyFDSection <- data.frame(matrix(nrow = dim(model$UseValueAdded)[1], 
                                       ncol = ncol(tempFullUse) - ncol(model$UseTransactions))) 
    
    # Rename rows and cols of new dataframe to allow cbind operation
    colnames(VAbyFDSection) <- colnames(model$FinalDemand)
    rownames(VAbyFDSection) <- rownames(model$UseValueAdded)
    
    tempVA <- cbind(model$UseValueAdded, VAbyFDSection) # combine UseValueAdded and VAbyFDSection columns
    
    # Assemble FullUse table and remane according to stateior formats
    model$FullUse <- rbind(tempFullUse, tempVA)
    rownames(model$FullUse) <- gsub("\\/.*","",rownames(model$FullUse)) # remove everything after "/"
    colnames(model$FullUse) <- gsub("\\/.*","",colnames(model$FullUse)) # remove everything after "/"
    
    return(model$FullUse)
  }

}
#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param domestic A boolean that indicates whether the table to format is the domesticUse table or not
#' @return A model object with FullUse split into UseTransactions, FinalDemand, and UseValueAdded objects
splitFullUse <- function(model, domestic = FALSE){
 
  if(domestic == TRUE){
    numCommodities <- length(model$Commodities) # Find number of commodities
    numIndustries <- length(model$Industries) # Find number of industries
    
    model$DomesticUseTransactions <- model$US_DomesticFullUse[1:numCommodities, 1:numIndustries] # Get subset of FullUse with numCommodities rows and numIndustries columns
    model$DomesticFinalDemand <- model$US_DomesticFullUse[1:numCommodities,-(1:numIndustries)] # Get subset of FullUse, with numCommodities rows and starting from columns after numIndustries
    
  }else{
    numCommodities <- dim(model$CommodityOutput)[1] # Find number of commodities
    numIndustries <- dim(model$IndustryOutput)[1] # Find number of industries
    
    model$UseTransactions <- model$FullUse[1:numCommodities, 1:numIndustries] # Get subset of FullUse with numCommodities rows and numIndustries columns
    model$UseValueAdded <- model$FullUse[-(1:numCommodities),1:numIndustries] # Get subset of FullUse, starting from rows after numCommodities, with numIndustries columns
    model$FinalDemand <- model$FullUse[1:numCommodities,-(1:numIndustries)] # Get subset of FullUse, with numCommodities rows and starting from columns after numIndustries
  }

  return(model)
  
}

#' @param model An stateior model object with model specs and specific IO tables loaded
#' @return A model object with disaggregated IndustryOutput and CommodityOutput objects
calculateStateIndustryCommodityOuput <- function(model){

  # Calculating and formatting IndustryOutput
  model$IndustryOutput <- data.frame(colSums(model$UseTransactions) + colSums(model$UseValueAdded))
  colnames(model$IndustryOutput) <- "Output"
  rowLabels <- rownames(model$IndustryOutput)
  rowLabels <- gsub("\\/.*","",rowLabels) # remove everything after "/"
  rownames(model$IndustryOutput) <- rowLabels
  
  # Calculating and formatting CommodityOuput
  model$CommodityOutput <- data.frame(rowSums(model$UseTransactions) + rowSums(model$FinalDemand))
  colnames(model$CommodityOutput) <- "Output"
  rowLabels <- rownames(model$CommodityOutput)
  rowLabels <- gsub("\\/.*","",rowLabels) # remove everything after "/"
  rownames(model$CommodityOutput) <- rowLabels
    
  return(model)
}

#' Disaggregate model$Commodity or model$Industry dataframes in the main model object
#' @param code_vector A list of sector codes (industry or commodity)
#' @param disagg Specifications for disaggregating the current Table
#' @return newList A list which contain the disaggregated model$Commodity or model$Industry objects
disaggregateStateSectorLists <- function(code_vector, disagg) {
  
  originalSectorCode <- gsub("\\/.*","",disagg$OriginalSectorCode) # remove everything after "/"
  disaggCodes <- gsub("\\/.*","",disagg$DisaggregatedSectorCodes) # remove everything after "/"
  originalIndex <- grep(paste0("^",originalSectorCode,"$"), code_vector) # the ^ and $ are required to find an exact match
 
  newList <- append(code_vector[1:originalIndex -1], disaggCodes)
  newList <- append(newList, code_vector[-(1:originalIndex)] ) # have to do this in two steps otherwise get an error

  return(newList)
}
