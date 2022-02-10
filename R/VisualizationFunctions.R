## Functions for visualizing model results and comparative analyses

#' @import ggplot2
NULL

#' Plot SoI2SoI or RoUS2RoUS ICF and state RPC
#' @param ICF_df A data.frame contains SoI2SoI ICF ratios
#' @param RPC_df A data.frame contains state RPC ratios
#' @param isSoI A logical value indicating whether to plot ICF and RPC of SoI or not.
#' @export
plotICFandRPC <- function(ICF_df, RPC_df, isSoI = TRUE) {
  # ICF
  adjust_by <- unique(ICF_df$AdjustBy)
  icf_remove_cols <- c("source", "source (adjusted)", "AdjustBy")
  ICF_df_long <- reshape2::melt(ICF_df[, !colnames(ICF_df)%in%icf_remove_cols],
                                id.vars = c("Sector", "Name"))
  # RPC
  RPC_df <- merge(RPC_df, unique(ICF_df_long[, c("Sector", "Name")]), by = "Sector")
  rpc_remove_cols <- c("OverallRPC", "OverallRPC (adjusted)")
  RPC_df_long <- reshape2::melt(RPC_df[, !colnames(RPC_df)%in%rpc_remove_cols],
                                id.vars = c("Sector", "Name"))
  if (isSoI) {
    RPC_df_long$variable <- paste("SoI", RPC_df_long$variable)
  } else {
    RPC_df_long$variable <- paste("RoUS", RPC_df_long$variable)
  }
  # plot
  SectorName <- ICF_df[, c("Sector", "Name")]
  p <- ggplot(ICF_df_long, aes(x = value, y = factor(Name, levels = rev(SectorName$Name)))) +
    # ICF
    geom_line(aes(group = Sector)) +
    geom_point(data = ICF_df_long[ICF_df_long$variable==unique(ICF_df_long$variable)[2], ],
               aes(color = variable), size = 3) +
    geom_point(data = ICF_df_long[ICF_df_long$variable==unique(ICF_df_long$variable)[1], ],
               aes(color = variable), size = 3) +
    # RPC
    geom_line(data = RPC_df_long[RPC_df_long$value>=0, ], aes(group = Sector)) +
    geom_point(data = RPC_df_long[RPC_df_long$value>=0, ], aes(shape = variable), size = 3) +
    scale_shape_manual(values = c(15, 17)) +
    # Overall RPC
    geom_vline(data = RPC_df, aes(xintercept = mean(RPC_df[, "OverallRPC"]),
                                  linetype = ifelse(isSoI, "SoI Overall RPC",
                                                    "Overall RPC")))+
    geom_vline(data = RPC_df, aes(xintercept = mean(RPC_df[, "OverallRPC (adjusted)"]),
                                  linetype = ifelse(isSoI, "SoI Overall RPC (adjusted)",
                                                    "Overall RPC (adjusted)"))) +
    # general aesthetics
    labs(x = "", y = "", shape = "", linetype = "",
         col = paste("Adjusted ICF =", adjust_by, "+ ICF * (1 -", paste0(adjust_by, ")"))) +
    scale_x_continuous(breaks = scales::breaks_pretty(n = 10),
                       sec.axis = sec_axis(~., name = "",
                                           breaks = scales::breaks_pretty(n = 10))) +
    theme_linedraw(base_size = 15) +
    theme(axis.text = element_text(color = "black", size = 15),
          axis.ticks = element_blank(), panel.grid.minor.x = element_blank(),
          legend.text = element_text(size = 15), legend.key.size = unit(1, "cm")) +
    guides(color = guide_legend(order = 1),
           shape = guide_legend(order = 2),
           linetype = guide_legend(order = 3))
  return(p)
}

#' Plot SoI2SoI ICF and state RPC
#' @param df A data.frame contains residual values
#' @export
plotResidual <- function(df) {
  adjust_by <- unique(df$AdjustBy)
  keep_cols <- c("Sector", "Name", "residual", "residual (adjusted)")
  df_long <- reshape2::melt(df[, colnames(df)%in%keep_cols],
                            id.vars = c("Sector", "Name"))
  df_long$value <- df_long$value * 1E-9
  SectorName <- df[, c("Sector", "Name")]
  x_lab <- "Residual (SoI Imports from RoUS - RoUS Exports to SoI, in billion $)"
  # plot
  p <- ggplot(df_long, aes(x = value,
                           y = factor(Name, levels = rev(SectorName$Name)))) +
    geom_line(aes(group = Sector)) +
    geom_point(data = df_long[df_long$variable==unique(df_long$variable)[2], ],
               aes(color = variable), size = 3) +
    geom_point(data = df_long[df_long$variable==unique(df_long$variable)[1], ],
               aes(color = variable), size = 3) +
    geom_vline(xintercept = 0) +
    # general aesthetics
    labs(x = x_lab, y = "", col = paste("Adjusted ICF =", adjust_by, "+ ICF * (1 -",
                                        paste0(adjust_by, ")"))) +
    scale_x_continuous(breaks = scales::breaks_pretty(),
                       sec.axis = sec_axis(~., name = x_lab,
                                           breaks = scales::breaks_pretty())) +
    theme_linedraw(base_size = 15) +
    theme(axis.text = element_text(color = "black", size = 15),
          axis.ticks = element_blank(),
          legend.text = element_text(size = 15),
          legend.key.size = unit(1, "cm"))
  return(p)
}
