# State IO Data Formats

State IO data created by `stateior` are saved as `.rds` files and have the following components. Their formats are described below in each section.

## Data

| Item                           | Data Name<sup>1</sup>  | Data Structure | Description |
| ------------------------------ | ---------------------- | -------------- | ----------- |
| Make                           | State_Summary_Make_`year`_`version` | matrix         | [The state Make](#State-Make) |
| Use                            | State_Summary_Use_`year`_`version`  | matrix         | [The state Use](#State-Use) |
| Domestic Use                   | State_Summary_DomesticUse_`year`_`version` | matrix         | [The state Domestic Use](#State-Domestic-Use) |
| Commodity Output               | State_Summary_CommodityOutput_`year`_`version` | numeric vector | [State total output by commodity](#State-Output-Vectors) |
| Industry Output                | State_Summary_IndustryOutput_`year`_`version`  | numeric vector | [State total output by industry](#State-Output-Vectors) |

<sup>1</sup> Data names on [Data Commons](https://edap-ord-data-commons.s3.amazonaws.com/index.html?prefix=stateio/). `year` and `version` are subject to change.

### State Make
The state Make matrix is an `industry x commodity` matrix with amounts in commodities (in model year USD) being made by industries.
```
           commodities
            +-------+
 industries |       |
            |  Make |
            +-------+
```

### State Use
The state Use is a `commodity x industry` matrix with total amounts (in model year USD) of commodities being used by industries for intermediate production, or being used by final consumers. 
State Use also includes commodity imports, exports and change in inventories as components of final demand, and value added components as inputs to industries.
The last column in Use is the international trade adjustment (ITA) vector containing value of all transportation and insurance services to import and customs duties in model year USD.
```
                    industries, final demand, ITA
                    +---------------------------+
commodities,        |                           |
value added         |            Use            |
                    +---------------------------+
```
The related `U_d` matrix provides commodity and value added use totals by industries and final demand that are only from the US.

### State output vectors

The state commodity output vector `q` and industry output vector `x` contain economic output in model year USD. 

```
commodities +----q----+

industries +----x----+
```
