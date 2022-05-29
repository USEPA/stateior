

commodities <- getVectorOfCodes("Summary", "Commodity")
industries <- getVectorOfCodes("Summary", "Industry")
FD_cols <- getFinalDemandCodes("Summary")
VA_rows <- getVectorOfCodes("Summary", "ValueAdded")

states <- c(state.name,"Overseas")


