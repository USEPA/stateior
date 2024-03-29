% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CalculationFunctions.R
\name{calculateRegionalPurchaseCoefficient}
\alias{calculateRegionalPurchaseCoefficient}
\title{Calculate regional purchase coefficient for specified state and year}
\usage{
calculateRegionalPurchaseCoefficient(SoI2SoIUse, RoUS2SoIUse, iolevel)
}
\arguments{
\item{SoI2SoIUse}{A data.frame of SoI2SoIUse table.}

\item{RoUS2SoIUse}{A data.frame of RoUS2SoIUse table.}

\item{iolevel}{BEA sector level of detail, currently can only be "Summary",
theoretically can be "Detail", or "Sector" in future versions.}
}
\value{
A data.frame contains by-commodity RPC and overall RPC
}
\description{
Calculate regional purchase coefficient for specified state and year
}
