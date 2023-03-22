
#' Read and assign disaggregation specifications
#' @param configfile str, name of disaggregation specification
#' @return A stateior model object with the disaggregation specs loaded.
getStateModelDisaggSpecs <- function(configfile){
  model <- list() 
  model$specs$DisaggregationSpecs <- configfile
  model$specs$IODataSource <- ""
  disaggConfigpath <- system.file(paste0("extdata/disaggspecs/"), paste0(configfile,".yml"), package = "stateior")
  model <- useeior:::getDisaggregationSpecs(model, disaggConfigpath, pkg = "stateior")
  return(model)
  
}

#' Disaggregate state make and use tables
#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return A stateior model with the disaggregateed objects
disaggregateStateModel <- function(model, state){

  # TODO: Include validation checks for row/column sums - note that there may be unexpected results due to existing negative values in state use tables.

  for (disagg in model$DisaggregationSpecs){

    logging::loginfo(paste0("Disaggregating ", disagg$OrignalSectorName," for ", state))
    
    # Formatting model objects according to useeior disaggregation formats
    model$MakeTransactions <- formatMakeFromStateToUSEEIO(model, state) #Formatting MakeTransactions object
    model$FullUse <- formatFullUseFromStateToUSEEIO(model$FullUse) # Formatting row/column names in FullUse object
    model$DomesticFullUse <- formatFullUseFromStateToUSEEIO(model$DomesticFullUse)
    model <- splitFullUse(model) # Splitting FullUse into UseTransactions, UseValueAdded, and FinalDemand objects
    model <- splitFullUse(model, domestic = TRUE)
 
    # Disaggregating specified model objects
    model$MakeTransactions <- useeior:::disaggregateMakeTable(model, disagg)
    model$MakeTransactions[is.na(model$MakeTransactions)] <- 0
        
    model$UseTransactions <- useeior:::disaggregateUseTable(model, disagg)
    model$UseTransactions[is.na(model$UseTransactions)] <- 0
    model$FinalDemand <- useeior:::disaggregateFinalDemand(model, disagg, domestic = FALSE)
    model$FinalDemand[is.na(model$FinalDemand)] <- 0
    model$DomesticUseTransactions <- useeior:::disaggregateUseTable(model, disagg, domestic = TRUE)
    model$DomesticUseTransactions[is.na(model$DomesticUseTransactions)] <- 0
    model$DomesticFinalDemand <- useeior:::disaggregateFinalDemand(model, disagg, domestic = TRUE)
    model$DomesticFinalDemand[is.na(model$DomesticFinalDemand)] <- 0
    model$UseValueAdded <- useeior:::disaggregateVA(model, disagg)
    model$UseValueAdded[is.na(model$UseValueAdded)] <- 0
    
    if(model$specs$CommodityorIndustryType=="Commodity") {
      model <- calculateStateIndustryCommodityOuput(model) # Also formats the disaggregated industry and commodity outputs to stateior formats
      
    }
    
    # Formatting disaggregated model objects back to stateior formats
    model$MakeTransactions <- formatMakeFromUSEEIOtoState(model, state)
    model$FullUse <- formatFullUseFromUSEEIOtoState(model, state)
    model$DomesticFullUse <- formatFullUseFromUSEEIOtoState(model, state, domestic = TRUE)
    
  }
  
  return(model)
  
  
} 


#' Disaggregate national make and use tables
#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param disagg Specifications for model disaggregation
#' @return A stateior model with the disaggregateed objects
disaggregateNationalObjectsInStateModel <- function(model, disagg){

  # Format specified national stateior objects to model to prepare for disaggregation
  model$origCommodities <- ncol(model$MakeTransactions)
  model$origIndustries <- nrow(model$MakeTransactions)
  # Format Make
  model$MakeTransactions <- formatMakeFromStateToUSEEIO(model, state) #Formatting MakeTransactions object

  # Format individual domestic use objects (DomesticUseTransactions, DomesticFinalDemand)
  model$DomesticFullUse <- formatFullUseFromStateToUSEEIO(model$DomesticFullUse) # Note that the domestic full use object does not include value added rows
  model <- splitFullUse(model, domestic = TRUE) # Splitting FullUse into UseTransactions, UseValueAdded, and FinalDemand objects
  model$FullUse <- formatFullUseFromStateToUSEEIO(model$FullUse)
  model <- splitFullUse(model, domestic = FALSE)
  
  # Disaggregate model objects
  model$MakeTransactions <- useeior:::disaggregateMakeTable(model, disagg)
  model$MakeTransactions[is.na(model$MakeTransactions)] <- 0
  
  model$DomesticUseTransactions <- useeior:::disaggregateUseTable(model, disagg, domestic = TRUE)
  model$DomesticUseTransactions[is.na(model$DomesticUseTransactions)] <- 0
  model$DomesticFinalDemand <- useeior:::disaggregateFinalDemand(model, disagg, domestic = TRUE)
  model$DomesticFinalDemand[is.na(model$DomesticFinalDemand)] <- 0
  model$UseTransactions <- useeior:::disaggregateUseTable(model, disagg)
  model$UseTransactions[is.na(model$UseTransactions)] <- 0
  model$FinalDemand <- useeior:::disaggregateFinalDemand(model, disagg, domestic = FALSE)
  model$FinalDemand[is.na(model$FinalDemand)] <- 0
  model$UseValueAdded <- useeior:::disaggregateVA(model, disagg)
  model$UseValueAdded[is.na(model$UseValueAdded)] <- 0  

  model$Industries <- disaggregateStateSectorLists(model$Industries, disagg)
  model$Commodities <- disaggregateStateSectorLists(model$Commodities, disagg)
  
  # Convert disaggregated objects back to stateior formats. Note that commodities and industries did not change format in disaggregation.
  model$MakeTransactions <- formatMakeFromUSEEIOtoState(model, state = "National")
  model$DomesticFullUse <- formatFullUseFromUSEEIOtoState(model, state, domestic = TRUE)
  model$FullUse <- formatFullUseFromUSEEIOtoState(model, state)

  return(model)

} 

#' Format model objects to prepare for use in useeior functions
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

#' Format Use table objects to prepare for use in useeior functions
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

#' Format Make table objects back to stateior format
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

#' Format Use table objects back to stateior format
#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @param domestic A boolean that indicates whether the table to format is the domesticUse table or not
#' @return A stateior FullUse table formatted according to stateior specifications
formatFullUseFromUSEEIOtoState <- function(model, state, domestic = FALSE){

  if(domestic == TRUE){
    model$DomesticFullUse <- cbind(model$DomesticUseTransactions, model$DomesticFinalDemand) # combine UseTransactions and FinalDemand columns

    # Format row and column names
    rownames(model$DomesticFullUse) <- gsub("\\/.*","",rownames(model$DomesticFullUse)) # remove everything after "/"
    colnames(model$DomesticFullUse) <- gsub("\\/.*","",colnames(model$DomesticFullUse)) # remove everything after "/"
    return(model$DomesticFullUse)
    
  } else {
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

#' Separate full use table into model components
#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param domestic A boolean that indicates whether the table to format is the domesticUse table or not
#' @return A model object with FullUse split into UseTransactions, FinalDemand, and UseValueAdded objects
splitFullUse <- function(model, domestic = FALSE){
 
  numCommodities <- model$origCommodities # Find number of commodities
  numIndustries <- model$origIndustries # Find number of industries
  if(domestic == TRUE){
    model$DomesticUseTransactions <- model$DomesticFullUse[1:numCommodities, 1:numIndustries] # Get subset of FullUse with numCommodities rows and numIndustries columns
    model$DomesticFinalDemand <- model$DomesticFullUse[1:numCommodities,-(1:numIndustries)] # Get subset of FullUse, with numCommodities rows and starting from columns after numIndustries
    
  }else{
    model$UseTransactions <- model$FullUse[1:numCommodities, 1:numIndustries] # Get subset of FullUse with numCommodities rows and numIndustries columns
    model$UseValueAdded <- model$FullUse[-(1:numCommodities),1:numIndustries] # Get subset of FullUse, starting from rows after numCommodities, with numIndustries columns
    model$FinalDemand <- model$FullUse[1:numCommodities,-(1:numIndustries)] # Get subset of FullUse, with numCommodities rows and starting from columns after numIndustries
  }

  return(model)
  
}

#' Calculate output from model objects
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
