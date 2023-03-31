# stateior <img src="inst/img/logo.png" align="right" width="240" />
<!-- badges: start -->
[![R CI/CD test](https://github.com/USEPA/stateior/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/USEPA/stateior/actions/workflows/R-CMD-check.yaml)
[![v0.1.0](http://img.shields.io/badge/v0.1.0-10.5281/zenodo.6954423-blue.svg)](https://doi.org/10.5281/zenodo.6954423)
[![StateIO paper](http://img.shields.io/badge/StateIO%20paper-10.3390/app12094469-blue.svg)](https://doi.org/10.1177/01600176221145874)
<!-- badges: end -->

`stateior` is an R package for building multi-regional economic input-output (MRIO) tables of states in the United States, refered to as **StateIO** models. 
Currently, `stateior` is capable of creating IO tables for each US state and building two-region MRIO models based on those state IO tables at the [BEA](https://www.bea.gov/) Summary level of resolution in the US for all years from 2012-2020.
The two regions are State of Interest (SoI) and Rest of the US (RoUS).
`stateior` was initially conceived in support of creating state-specific versions of [USEEIO models](https://www.epa.gov/land-research/us-environmentally-extended-input-output-useeio-models), but may be used for other purposes where state input-output tables are used.
The methodology used to build the StateIO models is described in a [paper in International Regional Science Review](https://doi.org/10.1177/01600176221145874).
The package is intended to add transparency and reproducibility to the complex process of generating subnational input-output tables, which are not compiled by any statistical agency.

`stateior` implements a robust commodity-industry modeling framework that models supply, use and trade of commodities by industries and final users in 50 U.S. states plus the District of Columbia and includes international import and export. 
`stateior` offers various functions for building, validating, visualizing, writing, and loading StateIO models.
`stateior` is in a beta development state while the complete methodology and StateIO data products are under external peer-review.

See the [Wiki](https://github.com/USEPA/stateior/wiki) for advanced uses, details about modeling approach, data and metadata, and how to contribute to `stateior`.

## Usage

There are two primary ways to use `stateior`.
1. To access the final data products in an R environment. This usage is the most simple and rapid and all that is required where the intention is only to review and use the two-region Make and Use tables. 
2. To study, run, modify the source code for any or all of the model building steps, from raw data acquisition to final two-region table assembly. This is a developer use. 

### Use for Accessing Final Data Products (usage type #1)

Install the most recent release version of `stateior` and attach it to the current R session. See [Releases](https://github.com/USEPA/stateior/releases) for all previously released versions. Note these steps will automatically install other R packages required by `devtools` and `stateior`. 

```r
install.packages("devtools")
devtools::install_github("USEPA/stateior@v0.2.0")
library(stateior)
```

Load desired StateIO data. See [One Region Data](format_specs/OneRegionData.md#data) and [Two Region Data](format_specs/TwoRegionData.md#data) for names and details of one- and two-region MRIO data sets that are currently available, respectively.

```r
###################
# One-Region Data #
###################
# Load the state one-region (state only) domestic Use tables for 2012 for all states.
# This will download the data product from a remote server and load it into your R session as an R list. 
OneRegionDomesticUse_2012 <- loadStateIODataFile("State_Summary_DomesticUse_2012")

# Select the Georgia Use table.
# This will put this table into a standard R data frame named 'GA_DomesticUse_2012'.
GA_DomesticUse_2012 <- OneRegionDomesticUse_2012[["Georgia"]]

###################
# Two-Region Data #
###################
# Load the two-region domestic Use tables for 2012 for all states.
# This will download the data product from a remote server and load it into your R session as an R list. 
TwoRegionDomesticUse_2012 <- loadStateIODataFile("TwoRegion_Summary_DomesticUse_2012")

# Select the two-region Use table for Georgia and Rest of the US.
# This will put this table into a standard R data frame named 'GA_TwoRegionDomesticUse_2012'.
GA_TwoRegionDomesticUse_2012 <- TwoRegionDomesticUse_2012[["Georgia"]]
```

If viewing either one-region or two-region data of a specific state in Excel spreadsheet is preferred, export it to a csv file in a given `outputfolder`.

```r
# Export 2012 Georgia Use tables to a csv file.
writeStateIODatatoCSV <- ("State_Summary_DomesticUse_2012", "Georgia", outputfolder)
# Export 2012 two-region Use table for Georgia and Rest of the US to a csv file.
writeStateIODatatoCSV <- ("TwoRegion_Summary_DomesticUse_2012", "Georgia", outputfolder)
```

### Use for Developers (usage type #2)

For studying, replicating or modify the code, users will want to clone or copy the source code and review the code in R. See more in [Instructions for Developers](https://github.com/USEPA/stateior/wiki/Instructions-for-developers).

## Disclaimer

The United States Environmental Protection Agency (EPA) GitHub project code is provided on an "as is" basis and the user assumes responsibility for its use.  EPA has relinquished control of the information and no longer has responsibility to protect the integrity , confidentiality, or availability of the information.  Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by EPA.  The EPA seal and logo shall not be used in any manner to imply endorsement of any commercial product or activity by EPA or the United States Government.
 
