#' Download Federal Government Spending data by 6-digit NAICS code
#' By state and county from USASpending.gov.
#' @return A list of Federal Government Spending data by 6-digit NAICS
#' by state and county from 2008 to 2019.
getFedGovSpending <- function() {
  # Load PSC table
  PSC <- utils::read.csv(system.file("extdata", "USASpending_PSC.csv",
                                     package = "stateior"),
                         stringsAsFactors = FALSE, check.names = FALSE)
  # Prepare PSC codes by category
  psc_ls <- list(PSC[PSC$Purchase_Type=="Intermediate", "4_Digit_PSC"],
                 PSC[PSC$Final_Demand_Category=="Equipment", "4_Digit_PSC"],
                 PSC[PSC$Final_Demand_Category=="Intellectual_Property", "4_Digit_PSC"],
                 PSC[PSC$Final_Demand_Category=="Structures", "4_Digit_PSC"])
  names(psc_ls) <- c("Intermediate", "Equipment", "IP", "Structure")
  # Load NAICS table
  NAICStoPull <- utils::read.csv(system.file("extdata",
                                             "USASpending_NAICStoPull.csv",
                                             package = "stateior"),
                                 stringsAsFactors = FALSE, check.names = FALSE)
  # Download data from all years
  df_ls <- list()
  df_ls[as.character(2008:2019)] <- data.frame()
  FedGovExp_ls <- list()
  for (year in 2008:2019) {
    # Create the placeholder file
    FedGovExpzip <- paste0("inst/extdata/FY", year, "_All_Contracts_Full_20200713.zip")
    if(!file.exists(FedGovExpzip)) {
      download.file(paste0("https://files.usaspending.gov/award_data_archive/FY",
                           year, "_All_Contracts_Full_20200713.zip"),
                    FedGovExpzip, mode = "wb")
      # Get the name of all files in the zip archive
      fname <- unzip(FedGovExpzip, list = TRUE)[unzip(FedGovExpzip, list = TRUE)$Length > 0, ]$Name
      # Unzip the file to the designated directory
      unzip(FedGovExpzip, files = fname, exdir = "inst/extdata/USAspending", overwrite = TRUE)
    } else {
      fname <- unzip(FedGovExpzip, list = TRUE)[unzip(FedGovExpzip, list = TRUE)$Length > 0, ]$Name
    }
    df <- data.frame()
    for (i in 1:length(fname)) {
      # Specify desired columns
      columns <- c("award_id_piid", "action_date", "awarding_agency_name",
                   "federal_action_obligation",
                   "primary_place_of_performance_country_code",
                   "primary_place_of_performance_state_code",
                   "primary_place_of_performance_county_name",
                   "award_type_code", "naics_code", "product_or_service_code")
      # Define filename
      filename <- paste0("inst/extdata/USAspending/", fname[i])
      # Load data
      df_slice <- data.table::fread(filename, select = columns, stringsAsFactors = FALSE)
      # Subset data
      df_slice <- unique(df_slice[df_slice$primary_place_of_performance_country_code=="USA" &
                                    df_slice$award_type_code%in%c("A", "B", "C", "D") &
                                    df_slice$primary_place_of_performance_state_code%in%c(state.abb, "DC") &
                                    !is.na(df_slice$federal_action_obligation) &
                                    !is.na(df_slice$naics_code), ])
      # Assign calendar Year column
      df_slice$Year <- as.integer(substr(df_slice$action_date, 1, 4))
      df <- rbind(df, df_slice)
      rm(df_slice)
    }
    # Paste df in df_ls
    df_ls[[as.character(year)]] <- rbind(df_ls[[as.character(year)]],
                                           df[df$Year==year, ])
    df_ls[[as.character(year-1)]] <- rbind(df_ls[[as.character(year-1)]],
                                             df[df$Year==(year-1), ])
    for (category in names(psc_ls)) {
      # Load df for the year
      df_year <- df_ls[[as.character(year)]]
      # Extract records for Defense (based on awarding agency and PSC code)
      df_defense <- df_year[df_year$product_or_service_code%in%psc_ls[[category]] &
                              df_year$awarding_agency_name=="DEPARTMENT OF DEFENSE (DOD)" |
                              df_year$product_or_service_code%in%PSC[grep("DEFENSE", PSC$PSC_Code), "4_Digit_PSC"], ]
      # Aggregate
      df_defense <- stats::aggregate(df_defense$federal_action_obligation,
                                     by = list(df_defense$Year, df_defense$naics_code,
                                               df_defense$primary_place_of_performance_state_code,
                                               df_defense$primary_place_of_performance_county_name),
                                     sum)
      colnames(df_defense) <- c("Year", "NAICS", "State", "County", "Amount")
      # Store in list
      FedGovExp_ls[[as.character(year)]][[category]][["Defense"]] <- df_defense
      # Extract records for Non-Defense (based on awarding agency)
      df_nondefense <- df_year[df_year$product_or_service_code%in%psc_ls[[category]] &
                                 df_year$awarding_agency_name!="DEPARTMENT OF DEFENSE (DOD)", ]
      # Aggregate
      df_nondefense <- stats::aggregate(df_nondefense$federal_action_obligation,
                                     by = list(df_nondefense$Year, df_nondefense$naics_code,
                                               df_nondefense$primary_place_of_performance_state_code,
                                               df_nondefense$primary_place_of_performance_county_name),
                                     sum)
      colnames(df_nondefense) <- colnames(df_defense)
      # Store in list
      FedGovExp_ls[[as.character(year)]][[category]][["NonDefense"]] <- df_nondefense
    }
  }
  return(FedGovExp_ls)
}

USASpending <- getFedGovSpending()
# 2012
FedGovExp_IntermediateDefense_2012 <- USASpending[["2012"]][["Intermediate"]][["Defense"]]
usethis::use_data(FedGovExp_IntermediateDefense_2012, overwrite = TRUE)
FedGovExp_IntermediateNonDefense_2012 <- USASpending[["2012"]][["Intermediate"]][["NonDefense"]]
usethis::use_data(FedGovExp_IntermediateNonDefense_2012, overwrite = TRUE)

FedGovExp_EquipmentDefense_2012 <- USASpending[["2012"]][["Equipment"]][["Defense"]]
usethis::use_data(FedGovExp_EquipmentDefense_2012, overwrite = TRUE)
FedGovExp_EquipmentNonDefense_2012 <- USASpending[["2012"]][["Equipment"]][["NonDefense"]]
usethis::use_data(FedGovExp_EquipmentNonDefense_2012, overwrite = TRUE)

FedGovExp_IPDefense_2012 <- USASpending[["2012"]][["IP"]][["Defense"]]
usethis::use_data(FedGovExp_IPDefense_2012, overwrite = TRUE)
FedGovExp_IPNonDefense_2012 <- USASpending[["2012"]][["IP"]][["NonDefense"]]
usethis::use_data(FedGovExp_IPNonDefense_2012, overwrite = TRUE)

FedGovExp_StructureDefense_2012 <- USASpending[["2012"]][["Structure"]][["Defense"]]
usethis::use_data(FedGovExp_StructureDefense_2012, overwrite = TRUE)
FedGovExp_StructureNonDefense_2012 <- USASpending[["2012"]][["Structure"]][["NonDefense"]]
usethis::use_data(FedGovExp_StructureNonDefense_2012, overwrite = TRUE)

# 2013
FedGovExp_IntermediateDefense_2013 <- USASpending[["2013"]][["Intermediate"]][["Defense"]]
usethis::use_data(FedGovExp_IntermediateDefense_2013, overwrite = TRUE)
FedGovExp_IntermediateNonDefense_2013 <- USASpending[["2013"]][["Intermediate"]][["NonDefense"]]
usethis::use_data(FedGovExp_IntermediateNonDefense_2013, overwrite = TRUE)

FedGovExp_EquipmentDefense_2013 <- USASpending[["2013"]][["Equipment"]][["Defense"]]
usethis::use_data(FedGovExp_EquipmentDefense_2013, overwrite = TRUE)
FedGovExp_EquipmentNonDefense_2013 <- USASpending[["2013"]][["Equipment"]][["NonDefense"]]
usethis::use_data(FedGovExp_EquipmentNonDefense_2013, overwrite = TRUE)

FedGovExp_IPDefense_2013 <- USASpending[["2013"]][["IP"]][["Defense"]]
usethis::use_data(FedGovExp_IPDefense_2013, overwrite = TRUE)
FedGovExp_IPNonDefense_2013 <- USASpending[["2013"]][["IP"]][["NonDefense"]]
usethis::use_data(FedGovExp_IPNonDefense_2013, overwrite = TRUE)

FedGovExp_StructureDefense_2013 <- USASpending[["2013"]][["Structure"]][["Defense"]]
usethis::use_data(FedGovExp_StructureDefense_2013, overwrite = TRUE)
FedGovExp_StructureNonDefense_2013 <- USASpending[["2013"]][["Structure"]][["NonDefense"]]
usethis::use_data(FedGovExp_StructureNonDefense_2013, overwrite = TRUE)

# 2014
FedGovExp_IntermediateDefense_2014 <- USASpending[["2014"]][["Intermediate"]][["Defense"]]
usethis::use_data(FedGovExp_IntermediateDefense_2014, overwrite = TRUE)
FedGovExp_IntermediateNonDefense_2014 <- USASpending[["2014"]][["Intermediate"]][["NonDefense"]]
usethis::use_data(FedGovExp_IntermediateNonDefense_2014, overwrite = TRUE)

FedGovExp_EquipmentDefense_2014 <- USASpending[["2014"]][["Equipment"]][["Defense"]]
usethis::use_data(FedGovExp_EquipmentDefense_2014, overwrite = TRUE)
FedGovExp_EquipmentNonDefense_2014 <- USASpending[["2014"]][["Equipment"]][["NonDefense"]]
usethis::use_data(FedGovExp_EquipmentNonDefense_2014, overwrite = TRUE)

FedGovExp_IPDefense_2014 <- USASpending[["2014"]][["IP"]][["Defense"]]
usethis::use_data(FedGovExp_IPDefense_2014, overwrite = TRUE)
FedGovExp_IPNonDefense_2014 <- USASpending[["2014"]][["IP"]][["NonDefense"]]
usethis::use_data(FedGovExp_IPNonDefense_2014, overwrite = TRUE)

FedGovExp_StructureDefense_2014 <- USASpending[["2014"]][["Structure"]][["Defense"]]
usethis::use_data(FedGovExp_StructureDefense_2014, overwrite = TRUE)
FedGovExp_StructureNonDefense_2014 <- USASpending[["2014"]][["Structure"]][["NonDefense"]]
usethis::use_data(FedGovExp_StructureNonDefense_2014, overwrite = TRUE)

# 2015
FedGovExp_IntermediateDefense_2015 <- USASpending[["2015"]][["Intermediate"]][["Defense"]]
usethis::use_data(FedGovExp_IntermediateDefense_2015, overwrite = TRUE)
FedGovExp_IntermediateNonDefense_2015 <- USASpending[["2015"]][["Intermediate"]][["NonDefense"]]
usethis::use_data(FedGovExp_IntermediateNonDefense_2015, overwrite = TRUE)

FedGovExp_EquipmentDefense_2015 <- USASpending[["2015"]][["Equipment"]][["Defense"]]
usethis::use_data(FedGovExp_EquipmentDefense_2015, overwrite = TRUE)
FedGovExp_EquipmentNonDefense_2015 <- USASpending[["2015"]][["Equipment"]][["NonDefense"]]
usethis::use_data(FedGovExp_EquipmentNonDefense_2015, overwrite = TRUE)

FedGovExp_IPDefense_2015 <- USASpending[["2015"]][["IP"]][["Defense"]]
usethis::use_data(FedGovExp_IPDefense_2015, overwrite = TRUE)
FedGovExp_IPNonDefense_2015 <- USASpending[["2015"]][["IP"]][["NonDefense"]]
usethis::use_data(FedGovExp_IPNonDefense_2015, overwrite = TRUE)

FedGovExp_StructureDefense_2015 <- USASpending[["2015"]][["Structure"]][["Defense"]]
usethis::use_data(FedGovExp_StructureDefense_2015, overwrite = TRUE)
FedGovExp_StructureNonDefense_2015 <- USASpending[["2015"]][["Structure"]][["NonDefense"]]
usethis::use_data(FedGovExp_StructureNonDefense_2015, overwrite = TRUE)

# 2016
FedGovExp_IntermediateDefense_2016 <- USASpending[["2016"]][["Intermediate"]][["Defense"]]
usethis::use_data(FedGovExp_IntermediateDefense_2016, overwrite = TRUE)
FedGovExp_IntermediateNonDefense_2016 <- USASpending[["2016"]][["Intermediate"]][["NonDefense"]]
usethis::use_data(FedGovExp_IntermediateNonDefense_2016, overwrite = TRUE)

FedGovExp_EquipmentDefense_2016 <- USASpending[["2016"]][["Equipment"]][["Defense"]]
usethis::use_data(FedGovExp_EquipmentDefense_2016, overwrite = TRUE)
FedGovExp_EquipmentNonDefense_2016 <- USASpending[["2016"]][["Equipment"]][["NonDefense"]]
usethis::use_data(FedGovExp_EquipmentNonDefense_2016, overwrite = TRUE)

FedGovExp_IPDefense_2016 <- USASpending[["2016"]][["IP"]][["Defense"]]
usethis::use_data(FedGovExp_IPDefense_2016, overwrite = TRUE)
FedGovExp_IPNonDefense_2016 <- USASpending[["2016"]][["IP"]][["NonDefense"]]
usethis::use_data(FedGovExp_IPNonDefense_2016, overwrite = TRUE)

FedGovExp_StructureDefense_2016 <- USASpending[["2016"]][["Structure"]][["Defense"]]
usethis::use_data(FedGovExp_StructureDefense_2016, overwrite = TRUE)
FedGovExp_StructureNonDefense_2016 <- USASpending[["2016"]][["Structure"]][["NonDefense"]]
usethis::use_data(FedGovExp_StructureNonDefense_2016, overwrite = TRUE)

# 2017
FedGovExp_IntermediateDefense_2017 <- USASpending[["2017"]][["Intermediate"]][["Defense"]]
usethis::use_data(FedGovExp_IntermediateDefense_2017, overwrite = TRUE)
FedGovExp_IntermediateNonDefense_2017 <- USASpending[["2017"]][["Intermediate"]][["NonDefense"]]
usethis::use_data(FedGovExp_IntermediateNonDefense_2017, overwrite = TRUE)

FedGovExp_EquipmentDefense_2017 <- USASpending[["2017"]][["Equipment"]][["Defense"]]
usethis::use_data(FedGovExp_EquipmentDefense_2017, overwrite = TRUE)
FedGovExp_EquipmentNonDefense_2017 <- USASpending[["2017"]][["Equipment"]][["NonDefense"]]
usethis::use_data(FedGovExp_EquipmentNonDefense_2017, overwrite = TRUE)

FedGovExp_IPDefense_2017 <- USASpending[["2017"]][["IP"]][["Defense"]]
usethis::use_data(FedGovExp_IPDefense_2017, overwrite = TRUE)
FedGovExp_IPNonDefense_2017 <- USASpending[["2017"]][["IP"]][["NonDefense"]]
usethis::use_data(FedGovExp_IPNonDefense_2017, overwrite = TRUE)

FedGovExp_StructureDefense_2017 <- USASpending[["2017"]][["Structure"]][["Defense"]]
usethis::use_data(FedGovExp_StructureDefense_2017, overwrite = TRUE)
FedGovExp_StructureNonDefense_2017 <- USASpending[["2017"]][["Structure"]][["NonDefense"]]
usethis::use_data(FedGovExp_StructureNonDefense_2017, overwrite = TRUE)
