# Generate and save state gross value added
State_GrossValueAdded_2012 <- assembleStateGrossValueAdded(2012, "Summary")
usethis::use_data(State_GrossValueAdded_2012, overwrite = TRUE)

State_GrossValueAdded_2017 <- assembleStateGrossValueAdded(2017, "Summary")
usethis::use_data(State_GrossValueAdded_2017, overwrite = TRUE)
