## Functions for visualizing model results and comparative analyses

#' @import ggplot2
NULL

#' Plot SoI2SoI ICF and state RPC
#' @param ICF_df A data.frame contains SoI2SoI ICF ratios
#' @param RPC_df A data.frame contains state RPC ratios
#' @export
plotICFandRPC <- function(ICF_df, RPC_df) {
  # ICF
  ICF_df_long <- reshape2::melt(ICF_df[, !colnames(ICF_df)%in%c("source", "source (w/ manual adjustment)")],
                                id.vars = c("Sector", "Name"))
  # RPC
  RPC_df <- merge(RPC_df, unique(ICF_df_long[, c("Sector", "Name")]), by = "Sector")
  RPC_df_long <- reshape2::melt(RPC_df[, !colnames(RPC_df)%in%c("OverallRPC", "OverallRPC (w/ manual adjustment)")],
                                id.vars = c("Sector", "Name"))
  # plot
  SectorName <- ICF_df[, c("Sector", "Name")]
  p <- ggplot(ICF_df_long, aes(x = value, y = factor(Name, levels = rev(SectorName$Name)))) +
    # ICF
    geom_line(aes(group = Sector)) +
    geom_point(data = ICF_df_long[ICF_df_long$variable=="SoI2SoI_ICF (w/ manual adjustment)", ],
               aes(color = variable), size = 3) +
    geom_point(data = ICF_df_long[ICF_df_long$variable=="SoI2SoI_ICF", ],
               aes(color = variable), size = 3) +
    # RPC
    geom_line(data = RPC_df_long[RPC_df_long$value>=0, ], aes(group = Sector)) +
    geom_point(data = RPC_df_long[RPC_df_long$value>=0, ], aes(shape = variable), size = 3) +
    # general aesthetics
    labs(x = "", y = "") +
    scale_x_continuous(breaks = scales::pretty_breaks(),
                       sec.axis = sec_axis(~., name = "", breaks = scales::pretty_breaks())) +
    #scale_y_discrete(labels = function(x) stringr::str_wrap(x, 50)) +
    theme_linedraw(base_size = 15) +
    theme(axis.text = element_text(color = "black", size = 15),
          axis.text.y = element_text(size = 15),
          axis.title.x = element_text(size = 10), axis.ticks = element_blank(),
          legend.title = element_blank(), legend.position = "top",
          legend.text = element_text(size = 15), legend.key.size = unit(1, "cm"))
  return(p)
}
