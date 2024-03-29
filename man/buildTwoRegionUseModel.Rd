% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BuildModel.R
\name{buildTwoRegionUseModel}
\alias{buildTwoRegionUseModel}
\title{Build a two-region Use model}
\usage{
buildTwoRegionUseModel(
  state,
  year,
  ioschema,
  iolevel,
  ICF_sensitivity_analysis = FALSE,
  adjust_by = 0,
  domestic = TRUE
)
}
\arguments{
\item{state}{A text value specifying state of interest.}

\item{year}{A numeric value between 2007 and 2017 specifying the year of interest.}

\item{ioschema}{A numeric value of either 2012 or 2007 specifying the io schema year.}

\item{iolevel}{BEA sector level of detail, currently can only be "Summary",
theoretically can be "Detail", or "Sector" in future versions.}

\item{ICF_sensitivity_analysis}{A logical value indicating whether to conduct
sensitivity analysis on ICF, default is FALSE.}

\item{adjust_by}{A numeric value between 0 and 1 indicating the manual adjustment
to ICF if a sensitivity analysis is conducted, default is 0 due to no SA.}

\item{domestic}{A logical value indicating whether to use Domestic Use tables,
default is TRUE.}
}
\value{
A list of domestic two-region Use tables.
}
\description{
Generate two-region (SoI and RoUS) Use tables
with interregional exports and imports.
}
