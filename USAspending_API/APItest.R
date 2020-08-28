#' Download Federal Government Spending data by 6-digit NAICS code
#' By state and zipcode from USASpending.gov.
#' @param category String, can be "intermediate", "equipment", "ip", or "structure".
#' @return A data frame of Federal Government Spending data by 6-digit NAICS
#' by state and zipcode from 2008 to 2019.
downloadFedGovSpending <- function(category) {
  # Create url
  url <- "https://api.usaspending.gov/api/v2/search/spending_by_award/"
  # Load PSC and NAICS tables
  PSC <- utils::read.csv(system.file("extdata", "USASpending_PSC.csv", package = "stateior"),
                         stringsAsFactors = FALSE, check.names = FALSE)
  NAICStoPull <- utils::read.csv(system.file("extdata", "USASpending_NAICStoPull.csv", package = "stateior"),
                                 stringsAsFactors = FALSE, check.names = FALSE)
  # Generate desired psc tables and NAICS vector
  if (category=="intermediate") {
    psc <- PSC[PSC$Purchase_Type=="Intermediate", ]
    NAICS <- unique(NAICStoPull$NAICS_2012_Code)
  } else if (category=="equipment") {
    psc <- PSC[PSC$Final_Demand_Category=="Equipment", ]
    NAICS <- unique(NAICStoPull[NAICStoPull$F06E00!=0 | NAICStoPull$F07E00!=0, "NAICS_2012_Code"])
  } else if (category=="ip") {
    psc <- PSC[PSC$Final_Demand_Category=="Intellectual_Property", ]
    NAICS <- unique(NAICStoPull[NAICStoPull$F06N00!=0 | NAICStoPull$F07N00!=0, "NAICS_2012_Code"])
  } else if (category=="structure") {
    psc <- PSC[PSC$Final_Demand_Category=="Structures", ]
    NAICS <- unique(NAICStoPull[NAICStoPull$F06S00!=0 | NAICStoPull$F07S00!=0, "NAICS_2012_Code"])
  }
  # Generate psc_list for API callings
  psc_list <- list()
  for (i in 1:nrow(psc)) {
    if (psc[i, "Category0"]=="Product") {
      psc_list[[i]] <- c(psc[i, "Category0"],
                         substr(psc[i, "4_Digit_PSC"], 1, 2),
                         psc[i, "4_Digit_PSC"])
    } else if (psc[i, "Category0"]=="Service") {
      psc_list[[i]] <- c(psc[i, "Category0"],
                         substr(psc[i, "4_Digit_PSC"], 1, 1),
                         substr(psc[i, "4_Digit_PSC"], 1, 2),
                         psc[i, "4_Digit_PSC"])
    } else if (psc[i, "Category0"]=="Research and Development") {
      psc_list[[i]] <- c(psc[i, "Category0"],
                         substr(psc[i, "4_Digit_PSC"], 1, 2),
                         substr(psc[i, "4_Digit_PSC"], 1, 3),
                         psc[i, "4_Digit_PSC"])
    }
  }
  FedGovSpending <- data.frame()
  for (i in 1:length(NAICS)) {
    # Generate filterObject
    filterObject <- list(naics_codes = list(require = array(NAICS[i])),
                         time_period = list(list(start_date = "2008-01-01",
                                                 end_date = "2018-12-31")),
                         place_of_performance_locations = list(list(country = "USA")),
                         award_type_codes = c("A", "B", "C", "D"),
                         psc_codes = list(require = psc_list))
    # Generate queryObject
    queryObject <- list(filters = filterObject,
                        fields = c("Start Date", "Award Amount", "Awarding Agency",
                                   "Place of Performance State Code",
                                   "Place of Performance Zip5"),
                        limit = 100,
                        page = 1)
    # Split psc_list, so that each list contains < 1000 elements
    splits <- ceiling(length(psc_list)/1000)
    psc_list_split <- list()
    # Download and process
    df <- data.frame()
    for (j in 1:splits) {
      if (j < splits) {
        psc_list_split[[j]] <- psc_list[c(1:1000) + (j-1)*1000]
      } else {
        psc_list_split[[j]] <- psc_list[c((1+(j-1)*1000):length(psc_list))]
      }
      queryObject$filters$psc_codes <- list(require = psc_list_split[[j]])
      # Get response
      resp <- POST(url, body = queryObject, encode = "json")
      # Download data
      gresp <- jsonlite::fromJSON(content(resp, "text", encoding = "UTF-8"))
      df_split <- gresp$results
      while(length(filterObject$psc_codes$require) - 1000 >1000) {
        queryObject$page <- queryObject$page + 1
        resp <- POST(url, body = queryObject, encode = "json")
        gresp <- jsonlite::fromJSON(content(resp, "text", encoding = "UTF-8"))
        df_split <- rbind(df_split, gresp$results)
      }
      df <- rbind(df, df_split)
    }
    # Add NAICS column
    if (nrow(df)!=0) {
      df$NAICS <- NAICS[i]
    }
    FedGovSpending <- rbind(FedGovSpending, df)
  }
  return(FedGovSpending)
}
