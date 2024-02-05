# Two Region IO Data Formats

Two-region (`SoI`, State of Interest, and `RoUS`, Rest of the US) IO data created by `stateior` are saved as `.rds` files and have the following components. Their formats are described below in each section.

## Notes

Each two-region matrix has a four-quadrant structure. In each matrix, `SoI` is represented by`US-ST` where `ST` is the abbreviated state name, e.g. `GA` for `Georgia`. Local consumption of commodities are described as `SoI2SoI` (SoI-to-SoI) and `RoUS2RoUS` (RoUS-to-RoUS), while interactions between the two regions are described as `SoI2RoUS` (SoI-to-RoUS) and `RoUS2SoI` (RoUS-to-SoI).

## Data

| Item                           | Data Name<sup>1</sup>  | Data Structure | Description |
| ------------------------------ | ---------------------- | -------------- | ----------- |
| Make                           | TwoRegion_Summary_Make_`year`_`version` | matrix         | [The two-region Make](#Two-Region-Make) |
| Use                            | TwoRegion_Summary_Use_`year`_`version`  | matrix         | [The two-region Use](#Two-Region-Use) |
| Domestic Use                   | TwoRegion_Summary_DomesticUse_`year`_`version` | matrix         | [The two-region Domestic Use](#Two-Region-Use) |
| Domestic Use with trade        | TwoRegion_Summary_DomesticUsewithTrade_`year`_`version` | list | [The two-region Domestic Use with interregional trade](#Two-Region-Domestic-Use-with-Trade) |
| International Trade Adjustment | TwoRegion_Summary_InternationalTradeAdjustment_`year`_`version` | numeric vector | [The two-region International Trade Adjustment](#Two-Region-International-Trade-Adjustment) |
| Value Added                    | TwoRegion_Summary_ValueAdded_`year`_`version` | matrix         | [The two-region Value Added](#Two-Region-Value-Added) |
| Commodity Output               | TwoRegion_Summary_CommodityOutput_`year`_`version` | numeric vector | [Two-region total output by commodity](#Two-Region-Output-Vectors) |
| Industry Output                | TwoRegion_Summary_IndustryOutput_`year`_`version`  | numeric vector | [Two-region total output by industry](#Two-Region-Output-Vectors) |

<sup>1</sup> Data names on [Data Commons](https://dmap-data-commons-ord.s3.amazonaws.com/index.html?prefix=stateio/). `year` and `version` are subject to change.

### Two Region Make
The two-region Make is an `industry x commodity` matrix with amounts of commodities (in model year USD) being made by industries.
```
                  commodities/US-ST, commodities/RoUS
                  +---------------------------------+
                  |                |                |
 industries/US-ST |                |                |
                  |                |                |
                  |-------------- Make -------------|
                  |                |                |
 industries/RoUS  |                |                |
                  |                |                |
                  +---------------------------------+
```

### Two Region Use
The two-region Use is a `commodity x industry` matrix with amounts of commodities (in model year USD) being used by industries for intermediate production, or being used by final consumers. Use also includes commodity imports, exports and change in inventories as components of final demand, and value added components as inputs to industries.

```
                    industries/US-ST, final demand/US-ST, industries/RoUS, final demand/RoUS
                   +------------------------------------------------------------------------+
                   |                                    |                                   |
 commodities/US-ST |                                    |                                   |
                   |                                    |                                   |
                   |---------------------------------- Use ---------------------------------|
                   |                                    |                                   |
 commodities/RoUS  |                                    |                                   |
                   |                                    |                                   |
                   +------------------------------------------------------------------------+
```

### Two Region Domestic Use with Trade
A named list of matrices, `SoI2SoI`, `SoI2RoUS`, `RoUS2SoI`, `RoUS2RoUS`.

Each matrix is in `commodity x industry` form with total amounts of commodities (in model year USD) being used by industries for intermediate production, or being used by final consumers, in `SoI` that are also produced in `SoI`. Interregional trade columns are `InterregionalImports`, `InterregionalExports`, `NetExports`, and `ExportResidual`.
```
            industries, final demand, interregional trade
            +-------------------------------------------+
            |                                           |
commodities |                   matrix                  |
            |                                           |
            +-------------------------------------------+
```

### Two Region International Trade Adjustment
The two-region international trade adjustment vector `mu` contains value of all transportation and insurance services to import and customs duties in model year USD. 
```
commodities/US-ST, commodities/RoUS +----mu----+
```

### Two Region Value Added
The two-region Value Added is a `value added x industry` matrix with amounts of commodities (in model year USD) being used by final consumers.
```
                    industries/US-ST, industries/RoUS
                   +---------------------------------+
                   |                |                |
 value added/US-ST |                |                |
                   |                |                |
                   |---------- Value Added ----------|
                   |                |                |
 value added/RoUS  |                |                |
                   |                |                |
                   +---------------------------------+
```

### Two Region Output Vectors
The two-region commodity output vector `q` and industry output vector `x` contain economic output in model year USD. 

```
commodities/US-ST, commodities/RoUS +----q----+

industries/US-ST, industries/RoUS +----x----+
```
