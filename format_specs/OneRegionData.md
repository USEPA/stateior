# One Region IO Data Formats

One region IO data created by `stateior` are data for single states saved as `.rds` files and have the following components. The tables use the same formats for the matrices with the same names in [useeior v1.1.0](https://github.com/USEPA/useeior/tree/v1.1.0).

## Data

| Item                           | Data Name<sup>1</sup>  | Data Structure | Description |
| ------------------------------ | ---------------------- | -------------- | ----------- |
| Make                           | State_Summary_Make_`year`_`version` | matrix         | [Make (V)](https://github.com/USEPA/useeior/blob/v1.1.0/format_specs/Model.md#v) |
| Use                            | State_Summary_Use_`year`_`version`  | matrix         | [Use (U)](https://github.com/USEPA/useeior/blob/v1.1.0/format_specs/Model.md#u) <sup>2</sup> |
| Domestic Use                   | State_Summary_DomesticUse_`year`_`version` | matrix         | [Domestic Use (U_d)](https://github.com/USEPA/useeior/blob/v1.1.0/format_specs/Model.md#u) <sup>2</sup> |
| Commodity Output               | State_Summary_CommodityOutput_`year`_`version` | numeric vector | [Output Vectors](https://github.com/USEPA/useeior/blob/v1.1.0/format_specs/Model.md#output-vectors) |
| Industry Output                | State_Summary_IndustryOutput_`year`_`version`  | numeric vector | [Output Vectors](https://github.com/USEPA/useeior/blob/v1.1.0/format_specs/Model.md#output-vectors)|

<sup>1</sup> Data names on [Data Commons](https://dmap-data-commons-ord.s3.amazonaws.com/index.html?prefix=stateio/). `year` and `version` are subject to change.

<sup>2</sup> These Use tables add, as the final column, the international trade adjustment (ITA) containing the value of all transportation and insurance services and customs duties 

