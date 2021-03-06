% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/UtilityFunctions.R
\name{getFileUpdateTimefromLocal}
\alias{getFileUpdateTimefromLocal}
\title{Get a datetime object for desired data file from local folder.}
\usage{
getFileUpdateTimefromLocal(year, iolevel, dataname, path)
}
\arguments{
\item{year}{A numeric value between 2007 and 2017 specifying the year of interest.}

\item{iolevel}{BEA sector level of detail, can be "Detail", "Summary", or "Sector".}

\item{dataname}{Name of desired IO data, can be "Make", "Use", "DomesticUse", "CommodityOutput, and "IndustryOutput".}

\item{path}{User-defined local path.}
}
\value{
A datetime object for desired data file from local folder.
}
\description{
Get a datetime object for desired data file from local folder.
}
