

commodities <- getVectorOfCodes("Summary", "Commodity")
industries <- getVectorOfCodes("Summary", "Industry")
FD_cols <- getFinalDemandCodes("Summary")
VA_rows <- getVectorOfCodes("Summary", "ValueAdded")
import_col <- getVectorOfCodes("Summary", "Import")
ITA_col <- "F051"

states <- c(state.name,"Overseas")


