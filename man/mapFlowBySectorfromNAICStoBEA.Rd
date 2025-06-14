% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SectorMappingFunctions.R
\name{mapFlowBySectorfromNAICStoBEA}
\alias{mapFlowBySectorfromNAICStoBEA}
\title{Map FlowBySector data from NAICS to BEA (Sector/Summary/Detail) sectors.}
\usage{
mapFlowBySectorfromNAICStoBEA(fbs, year, iolevel, specs)
}
\arguments{
\item{fbs}{A data frame contains FlowBySector (by NAICS) data from flowsa.}

\item{year}{A numeric value specifying the year of interest.}

\item{iolevel}{A character value, the level of BEA sector to map to.}

\item{specs}{A list of model specs including 'BaseIOSchema',}
}
\value{
A data frame contains FlowBySector by BEA.
}
\description{
Map FlowBySector data from NAICS to BEA (Sector/Summary/Detail) sectors.
}
