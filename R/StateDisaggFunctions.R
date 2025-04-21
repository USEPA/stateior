#' Read and assign disaggregation specifications
#' Function assumes all states will be disaggregated with the same config file 
#' and allocations unless a statefile parameter is included as input.
#' In this case, the function assumes the statefile paramter will modify the
#' allocation values present in configfile for each state, rather than loading
#' in 50 different sets of allocation values.
#' @param configfile str, name of disaggregation specification file
#' @param statefile str, name of state-specific disaggregation spec file that will
#' modify the standard configfile for each state. Should be 1 config file that has
#' the required modifications of configfile for each state
#' @return A stateior model object with the disaggregation specs loaded.
getStateModelDisaggSpecs <- function(configfile, statefile = NULL){
  model <- list() 
  model$specs$DisaggregationSpecs <- configfile
  model$specs$IODataSource <- ""
  disaggConfigpath <- system.file(paste0("extdata/disaggspecs/"), paste0(configfile,".yml"), package = "stateior")
  model <- useeior:::getDisaggregationSpecs(model, disaggConfigpath, pkg = "stateior")
  
  for(disagg in model$DisaggregationSpecs)
  {
    if(!is.null(disagg$stateFile)){
      disagg$stateDF <- getStateSpecificDisaggSpecs(disaggConfigpath, disagg$stateFile) 
      model$DisaggregationSpecs[[disagg$OriginalSectorCode]] <- disagg
    }
  }
  return(model)
}

#' Read in state-specific disaggregation values
#' This function assumes values contained in statefile will modify disaggregation
#' values present in the main disaggregation config file.
#' @param statefile str, name of state-specific disaggregation spec file that will
#' modify the standard configfile for each state. Should be 1 config file that has
#' the required modifications of configfile for each state
#' @param disaggConfigpath str, path for statefile 
#' @return A stateior model object with the state-specific disaggregation specs
#' included in model$specs$STateDisaggSpecs object
getStateSpecificDisaggSpecs <- function(disaggConfigpath, statefile){
  filename <- file.path(dirname(disaggConfigpath), statefile)
  stateFileDF <- utils::read.table(filename, sep = ",", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
  return(stateFileDF)
}

#' Disaggregate state make and use tables
#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param state A string value that indicates the state model being disaggregated
#' @return A stateior model with the disaggregateed objects
disaggregateStateModel <- function(model, state){

  # TODO: Include validation checks for row/column sums - note that there may be unexpected
  # results due to existing negative values in state use tables.

  for (disagg in model$DisaggregationSpecs){

    logging::loginfo(paste0("Disaggregating ", disagg$OriginalSectorName," for ", state))
    
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
  # Note that the domestic full use object does not include value added rows
  model$DomesticFullUse <- formatFullUseFromStateToUSEEIO(model$DomesticFullUse)
  # Splitting FullUse into UseTransactions, UseValueAdded, and FinalDemand objects
  model <- splitFullUse(model, domestic = TRUE)
  model$FullUse <- formatFullUseFromStateToUSEEIO(model$FullUse)
  model <- splitFullUse(model, domestic = FALSE)
  
  # Disaggregate model objects
  # model$MakeTransactions <- useeior:::disaggregateMakeTable(model, disagg)
  # model$MakeTransactions[is.na(model$MakeTransactions)] <- 0
  
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

  model$MakeTransactions <- useeior:::disaggregateMakeTable(model, disagg)
  model$MakeTransactions[is.na(model$MakeTransactions)] <- 0
  
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
    
    # Assemble FullUse table and rename according to stateior formats
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
    # Get subset of FullUse with numCommodities rows and numIndustries columns
    model$DomesticUseTransactions <- model$DomesticFullUse[1:numCommodities, 1:numIndustries]
    # Get subset of FullUse, with numCommodities rows and starting from columns after numIndustries
    model$DomesticFinalDemand <- model$DomesticFullUse[1:numCommodities,-(1:numIndustries)]
    
  } else {
    # Get subset of FullUse with numCommodities rows and numIndustries columns
    model$UseTransactions <- model$FullUse[1:numCommodities, 1:numIndustries]
    # Get subset of FullUse, starting from rows after numCommodities, with numIndustries columns
    model$UseValueAdded <- model$FullUse[-(1:numCommodities),1:numIndustries]
    # Get subset of FullUse, with numCommodities rows and starting from columns after numIndustries
    model$FinalDemand <- model$FullUse[1:numCommodities,-(1:numIndustries)]
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
  model$CommodityOutput <- data.frame(colSums(model$MakeTransactions))
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
  disaggCodes <- gsub("\\/.*","",disagg$NewSectorCodes) # remove everything after "/"
  originalIndex <- grep(paste0("^",originalSectorCode,"$"), code_vector) # the ^ and $ are required to find an exact match
 
  newList <- append(code_vector[1:originalIndex -1], disaggCodes)
  newList <- append(newList, code_vector[-(1:originalIndex)] ) # have to do this in two steps otherwise get an error

  return(newList)
}


#### Functions below this line are used for creating disaggFiles from Proxy data, e.g., Make and USe files from Employment ratios.

#' Create Make, Use, and Env ratio files for each state from Proxy data for the relevant sectors.
#' @param model An stateior model object with model specs and specific IO tables loaded
#' @param disagg Specifications for disaggregating the current Table
#' @param disaggYear Integer specifying the state model year
#' @param disaggState A string value that indicates the state model being disaggregated. For national models, string should be "US"
#' @return A stateior model with disaggregation specs included
createDisaggFilesFromProxyData <- function(model, disagg, disaggYear, disaggState){
  
  # Note: this function assumes: 
  # 1) The disaggregation will use the same proxy values for all disaggregated sectors across all rows and columns. 
  #    That is, if we are disaggregating Summary 22 into the 3 Detail utility sectors, and the proxy allocations are (for example) 0.5/0.25/0.25, then 
  #    in the Use table, the three Detail utility commodities (rows) will have that same split for across all columns (industries/final demand)
  # 2) The disagg parameter will contain a disagg$stateDF variable that includes the data for the relevant disaggState and disaggYear parameters.
  
  stop("The function is not yet valid")
  
  #Get subset of ratios for current year
  stateDFYear <- subset(disagg$stateDF, Year == disaggYear & State == disaggState)
  
  # If the state/year combination is not found, assume a uniform split between sectors
  if(dim(stateDFYear)[1] == 0){

    activity <- unlist(disagg$NewSectorCodes)
    uniformAllocationVector <- 1/length(disagg$NewSectorCodes)
    share <- rep(uniformAllocationVector,length(disagg$NewSectorCodes))
    
    stateDFYear <- data.frame(State = rep(disaggState, length(disagg$NewSectorCodes)),
                              Activity = activity,
                              Share = share,
                              Year = rep(disaggYear, length(disagg$NewSectorCodes)))
  }

  print(paste0("For ",disaggState,"-",disaggYear, " the allocation to disaggregate ", 
               disagg$OriginalSectorCode, " into ", disagg$NewSectorCodes, " is ", stateDFYear$Share))
  
  # Default Make DF based on proxy employment values
  # Specifying commodity disaggregation (column splits) for Make DF
  industries <- c(rep(disagg$OriginalSectorCode,length(disagg$NewSectorCodes)))
  commodities <- unlist(disagg$NewSectorCodes)
  PercentMake <- stateDFYear$Share
  # need to add code to ensure that the order of stateDF$Share is the same as the order of disagg$NewSectorCodes
  note <- c(rep("CommodityDisagg", length(disagg$NewSectorCodes)))
  
  # need to rename the columns with the correct column names
  makeDF <- data.frame(cbind(data.frame(industries), data.frame(commodities), data.frame(PercentMake), data.frame(note)))
  colnames(makeDF) <- c("IndustryCode","CommodityCode",	"PercentMake",	"Note")
  
  
  # Default Use DF based on employment ratios
  # Specifying industry disaggregation (column splits) for Use DF
  industries <- unlist(disagg$NewSectorCodes)
  commodities <- c(rep(disagg$OriginalSectorCode,length(disagg$NewSectorCodes)))
  PercentUse <- stateDFYear$Share
  note <- c(rep("IndustryDisagg", length(disagg$NewSectorCodes)))
  
  # need to rename the columns with the correct column names
  useDF <- data.frame(cbind(data.frame(industries), data.frame(commodities), data.frame(PercentUse), data.frame(note)))
  useDF_2 <- makeDF # so that colnames match
  colnames(useDF) <- c("IndustryCode","CommodityCode",	"PercentUse",	"Note")
  colnames(useDF_2) <- c("IndustryCode","CommodityCode",	"PercentUse",	"Note")
  
  # need to bind makeDF because disaggregation procedure requires the UseDF to have the default commodity and industry output.
  useDF <- rbind(useDF, useDF_2) 
    
  # Add new DFs to disagg and to model
  disagg$MakeFileDF <- makeDF
  disagg$UseFileDF <- useDF
  
  model$DisaggregationSpecs[[disagg$OriginalSectorCode]] <- disagg

  return(model)
  
}
