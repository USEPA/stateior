# Checks two region domestic Leontief x final demand against output

TR_LagaintsOutput <- list()
TR_LagaintsOutput_failures <- list()
for (s in sel_states) {
  TR_LagaintsOutput[[s]] <- validateTwoRegionLagainstOutput(s, year, ioschema = 2012, iolevel = "Summary")
  TR_LagaintsOutput_failures[[s]] <- formatValidationResult(TR_LagaintsOutput[[s]]$`L*y-output` - 0,abs_diff = TRUE, tolerance = 1E6)[["Failure"]]
}
