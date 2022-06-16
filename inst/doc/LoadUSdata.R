# Load year-specific US Make, Use, and DomesticUse tables
# year must already be defined to source this script

US_Summary_Make <- getNationalMake("Summary", year)
US_Summary_Use <- getNationalUse("Summary", year)
US_Summary_DomesticUse <- generateUSDomesticUse("Summary", year)
