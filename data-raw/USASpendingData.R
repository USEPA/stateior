#' Download Federal Government Spending data by 6-digit NAICS code
#' By state and zipcode from USASpending.gov.
#' @param year Integer, A numeric value between 2008-2018 specifying the year of interest
#' @param scope String, "GAcounty" or "state"
#' @param sector String, "intermediate", "equipment", "ip", or "structure"
#' @param Defense A boolean variable indicating whether to get defense of non-defense data.
#' @return A data frame of Federal Government Spending data by 6-digit NAICS
#' by state and zipcode from 2008 to 2019.
getFedGovSpending <- function(sector) {
  # Load USA Spending data
  # ! replace the loading code with actual downloading code
  filename <- paste0("fedspending_", sector, ".csv")
  df <- utils::read.csv(system.file("extdata", filename, package = "stateio"),
                        stringsAsFactors = FALSE, check.names = FALSE)
  # Assign year, state and zipcode
  df$Year <- as.integer(substr(as.character(as.Date(df$`Start Date`, "%m/%d/%y")), 1, 4))
  df <- df[df$`Place of Performance State Code`%in%c(state.abb, "DC"), ]
  df$State <- state.name[match(df$`Place of Performance State Code`, state.abb)]
  df[df$`Place of Performance State Code`=="DC", "State"] <- "District of Columbia"
  df$Zipcode <- df$`Place of Performance Zip5`
  df$Amount <- df$`Award Amount`
  # Separate and store dfs in list
  FedGovSpending <- list()
  columns <- c("NAICS", "Year", "State", "Zipcode", "Amount")
  for (year in 2008:2019) {
    
    FedGovSpending[["Defense"]][[as.character(year)]] <- df[df$`Awarding Agency`=="Department of Defense" &
                                                              df$Year==year, columns]
    FedGovSpending[["NonDefense"]][[as.character(year)]] <- df[df$`Awarding Agency`!="Department of Defense" &
                                                                 df$Year==year, columns]
  }
  return(FedGovSpending)
}

USASpending_Intermediate <- getFedGovSpending("intermediate")
FedGovExp_IntermediateDefense_2012 <- USASpending_Intermediate[["Defense"]][["2012"]]
usethis::use_data(FedGovExp_IntermediateDefense_2012, overwrite = TRUE)
FedGovExp_IntermediateNonDefense_2012 <- USASpending_Intermediate[["NonDefense"]][["2012"]]
usethis::use_data(FedGovExp_IntermediateNonDefense_2012, overwrite = TRUE)

USASpending_Equipment <- getFedGovSpending("equipment")
FedGovExp_EquipmentDefense_2012 <- USASpending_Equipment[["Defense"]][["2012"]]
usethis::use_data(FedGovExp_EquipmentDefense_2012, overwrite = TRUE)
FedGovExp_EquipmentNonDefense_2012 <- USASpending_Equipment[["NonDefense"]][["2012"]]
usethis::use_data(FedGovExp_EquipmentNonDefense_2012, overwrite = TRUE)

USASpending_IP <- getFedGovSpending("ip")
FedGovExp_IPDefense_2012 <- USASpending_IP[["Defense"]][["2012"]]
usethis::use_data(FedGovExp_IPDefense_2012, overwrite = TRUE)
FedGovExp_IPNonDefense_2012 <- USASpending_IP[["NonDefense"]][["2012"]]
usethis::use_data(FedGovExp_IPNonDefense_2012, overwrite = TRUE)

USASpending_Structure <- getFedGovSpending("structure")
FedGovExp_StructureDefense_2012 <- USASpending_Structure[["Defense"]][["2012"]]
usethis::use_data(FedGovExp_StructureDefense_2012, overwrite = TRUE)
FedGovExp_StructureNonDefense_2012 <- USASpending_Structure[["NonDefense"]][["2012"]]
usethis::use_data(FedGovExp_StructureNonDefense_2012, overwrite = TRUE)
