# stateior <img src="inst/img/logo.png" align="right" width="240" />
<!-- badges: start -->
[![R CI/CD test](https://github.com/USEPA/stateior/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/USEPA/stateior/actions/workflows/R-CMD-check.yaml)

`stateior` is an R package for building multi-regional input-output (MRIO) models in the United States in support of creating [USEEIO models](https://www.epa.gov/land-research/us-environmentally-extended-input-output-useeio-models) in the [`useeior`](https://github.com/USEPA/useeior) package for US states and other purposes.

`stateior` describes a robust StateIO modeling framework and offers various functions for calculating, validating, visualizing, and writing out StateIO models.
`stateior` is in a stable development state.
Users intending to use the package for production purposes and applications should use [Releases](https://github.com/USEPA/stateior/releases).

See the following sections for installation and basic usage of `stateior`.

See [Wiki](https://github.com/USEPA/stateior/wiki) for advanced uses, details about modeling approach, data and metadata, and how to contribute to `stateior`.

## Installation

```r
# Install development version from GitHub
install.packages("devtools")
devtools::install_github("USEPA/stateior")
```

```r
# Install a previously released version (e.g. v0.1.0) from GitHub
devtools::install_github("USEPA/stateior@v0.1.0")
```

See [Releases](https://github.com/USEPA/stateior/releases) for all previously realeased versions.

## Usage

Currently, `stateior` is capable of building two-region MRIO models at the [BEA](https://www.bea.gov/) Summary level of resolution in the US.
The two regions are State of Interest (SoI) and Rest of the US (RoUS).

Load two-region MRIO model results

```r
library(stateior)

# Load the latest version by default
data <- loadStateIODataFile(dataname)
# Example
TwoRegionDomesticUse_GA_RoUS <- loadStateIODataFile("TwoRegion_Summary_DomesticUse_2012")[["Georgia"]]

# Specify version_number if a particular version is desired
data <- loadStateIODataFile(dataname, ver = version_number)
# Example
TwoRegionDomesticUse_GA_RoUS <- loadStateIODataFile("TwoRegion_Summary_DomesticUse_2012", ver = "0.1.0")[["Georgia"]]
```

See [Two Region Data](format_specs/TwoRegionData.md#data) for names and details of two-region MRIO data sets that are currently available.

## Disclaimer

The United States Environmental Protection Agency (EPA) GitHub project code is provided on an "as is" basis and the user assumes responsibility for its use.  EPA has relinquished control of the information and no longer has responsibility to protect the integrity , confidentiality, or availability of the information.  Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by EPA.  The EPA seal and logo shall not be used in any manner to imply endorsement of any commercial product or activity by EPA or the United States Government.

 
