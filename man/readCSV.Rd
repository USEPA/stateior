% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/UtilityFunctions.R
\name{readCSV}
\alias{readCSV}
\title{Read csv files using read.table function from utils package
set header = TRUE, stringsAsFactors = FALSE, and check.names = FALSE}
\usage{
readCSV(filename, fill = FALSE)
}
\arguments{
\item{filename}{A string specifying name of the csv file}

\item{fill}{logical. If TRUE then in case the rows have unequal length,
blank fields are implicitly added.}
}
\value{
The data read
}
\description{
Read csv files using read.table function from utils package
set header = TRUE, stringsAsFactors = FALSE, and check.names = FALSE
}
