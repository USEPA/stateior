#' Download Federal Government Spending data by 6-digit NAICS code
#' By state and county from USASpending.gov.
#' @return A list of Federal Government Spending data by 6-digit NAICS
#' by state and county from 2012 to 2017.
getFedGovSpending <- function(year) {
  # Load PSC table
  PSC <- utils::read.csv(system.file("extdata", "USASpending_PSC.csv",
                                     package = "stateior"),
                         stringsAsFactors = FALSE, check.names = FALSE)
  # Prepare PSC codes by category
  psc_ls <- list(PSC[PSC$Purchase_Type == "Intermediate", "4_Digit_PSC"],
                 PSC[PSC$Final_Demand_Category == "Equipment", "4_Digit_PSC"],
                 PSC[PSC$Final_Demand_Category == "Intellectual_Property", "4_Digit_PSC"],
                 PSC[PSC$Final_Demand_Category == "Structures", "4_Digit_PSC"])
  names(psc_ls) <- c("Intermediate", "Equipment", "IP", "Structure")
  # Load NAICS table
  NAICStoPull <- utils::read.csv(system.file("extdata",
                                             "USASpending_NAICStoPull.csv",
                                             package = "stateior"),
                                 stringsAsFactors = FALSE, check.names = FALSE)
  
  # Because the original data is by fiscal year (Oct-Sept) instead of calendar year (Jan-Dec)
  # Download and load data from all years to compile complete data by calendar year
  # Need get 2012-2017 data, extend the range to 2011-2018 to retrieve complete records
  year_range <- (year - 1):(year + 1)
  df_ls <- list()
  df_ls[as.character(year_range)] <- data.frame()
  # Get data_date for archived award data
  notes <- readLines("https://files.usaspending.gov/database_download")
  tmp <- readLines("https://www.usaspending.gov/download_center/award_data_archive")
  data_date <- gsub("-", "",
                    stringr::str_match(notes[grep("USAspending Database", notes)],
                                       "Database (.*?) zip")[2])
  for (year_N in year_range) {
    # Create the placeholder file
    FedGovExpzip <- paste0("inst/extdata/FY", year_N, "_All_Contracts_Full_",
                           data_date, ".zip")
    if (!file.exists(FedGovExpzip)) {
      utils::download.file(paste0("https://files.usaspending.gov/award_data_archive/FY",
                                  year_N, "_All_Contracts_Full_", data_date, ".zip"),
                           FedGovExpzip, mode = "wb",
                           timeout = max(500, getOption("timeout")))
    }
    # Get the name of all files in the zip archive
    fname <- unzip(FedGovExpzip, list = TRUE)[unzip(FedGovExpzip, list = TRUE)$Length > 0, ]$Name
    # Unzip the file to the designated directory
    unzip(FedGovExpzip, files = fname, exdir = "inst/extdata/USAspending", overwrite = TRUE)
    # Load data
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
      df_slice <- as.data.frame(data.table::fread(filename,
                                                  select = columns,
                                                  stringsAsFactors = FALSE))
      # Subset data
      df_slice <- unique(df_slice[df_slice$primary_place_of_performance_country_code == "USA" &
                                    df_slice$award_type_code %in% c("A", "B", "C", "D") &
                                    df_slice$primary_place_of_performance_state_code %in% c(state.abb, "DC") &
                                    !is.na(df_slice$federal_action_obligation) &
                                    !is.na(df_slice$naics_code) &
                                    df_slice$federal_action_obligation >= 0, ])
      # Assign calendar Year column
      df_slice$Year <- as.integer(substr(df_slice$action_date, 1, 4))
      df <- rbind(df, df_slice)
      rm(df_slice)
    }
    # Paste df in df_ls
    df_ls[[as.character(year_N)]] <- rbind(df_ls[[as.character(year_N)]],
                                           df[df$Year == year_N, ])
    df_ls[[as.character(year_N - 1)]] <- rbind(df_ls[[as.character(year_N - 1)]],
                                               df[df$Year == (year_N - 1), ])
  }
  # Subset data
  # Load df for the year
  df_year <- df_ls[[as.character(year)]]
  # Subset df_year by category and type (Defense and NonDefense)
  for (category in names(psc_ls)) {
    # Extract records for Defense and Non-Defense (based on awarding agency and PSC code)
    for (type in c("Defense", "NonDefense")) {
      if (type == "Defense") {
        df_type <- df_year[df_year$product_or_service_code %in% psc_ls[[category]] &
                             df_year$awarding_agency_name == "DEPARTMENT OF DEFENSE (DOD)" |
                             df_year$product_or_service_code %in% PSC[grep("DEFENSE", PSC$PSC_Code), "4_Digit_PSC"], ]
      } else {
        df_type <- df_year[df_year$product_or_service_code %in% psc_ls[[category]] &
                             df_year$awarding_agency_name != "DEPARTMENT OF DEFENSE (DOD)", ]
      }
      # Aggregate
      df <- stats::aggregate(df_type$federal_action_obligation,
                             by = list(df_type$Year, df_type$naics_code,
                                       df_type$primary_place_of_performance_state_code,
                                       df_type$primary_place_of_performance_county_name),
                             sum)
      colnames(df) <- c("Year", "NAICS", "State", "County", "Amount")
      # Write data to .rds
      data_name <- paste("FedGovExp", category, type, year,
                         utils::packageDescription("stateior", fields = "Version"),
                         sep = "_")
      saveRDS(object = df,
              file = paste0(file.path("data", data_name), ".rds"))
      # Write metadata to JSON
      useeior:::writeMetadatatoJSON(package = "stateior",
                                    name = data_name,
                                    year = year,
                                    source = "USA spending",
                                    url = "https://www.usaspending.gov/download_center/award_data_archive",
                                    date_last_modified = "unknown",
                                    date_accessed = as.character(Sys.Date()))
    }
  }
}
# Download, save and document 2012-2017 federal government spending data by state (from USASpending)
getFedGovSpending(year)
