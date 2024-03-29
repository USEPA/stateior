% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CalculationFunctions.R
\name{setToleranceforRAS}
\alias{setToleranceforRAS}
\title{Calculate tolerance for RAS. Takes a target row sum vector and target colsum vector.
Specify either relative difference or absolute difference.}
\usage{
setToleranceforRAS(t_r, t_c, relative_diff = NULL, absolute_diff = NULL)
}
\arguments{
\item{t_r}{A vector setting the target row sums of the matrix.}

\item{t_c}{A vector setting the target column sums of the matrix.}

\item{relative_diff}{A numeric value setting the relative difference of the two numerical vectors.}

\item{absolute_diff}{A numeric value setting the mean absolute difference of the two numerical vectors.}
}
\value{
A numeric value of relative difference of t_r and t_c.
}
\description{
Calculate tolerance for RAS. Takes a target row sum vector and target colsum vector.
Specify either relative difference or absolute difference.
}
