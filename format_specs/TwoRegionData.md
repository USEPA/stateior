# Two Region IO Data Formats

Two-region (`SoI`, State of Interest, and `RoUS`, Rest of the US) IO data created by `stateior` are saved as `.rds` files and have the following components. Their formats are described below in each section.

## Notes

Each two-region matrix has a four-quadrant structure. In each matrix, `SoI` is represented by`US-ST` where `ST` is the abbreviated state name, e.g. `GA` for `Georgia`. Local consumption of commodities are described as `SoI2SoI` (SoI-to-SoI) and `RoUS2RoUS` (RoUS-to-RoUS), while interactions between the two regions are described as `SoI2RoUS` (SoI-to-RoUS) and `RoUS2SoI` (RoUS-to-SoI).

## Data

| Item                    | Data Structure | Description |
| ----------------------- | -------------- | ----------- |
| Make                    | matrix         | [The two-region Make Transactions](#Two-Region-Make-Transactions) |
| Use                     | matrix         | [The two-region Use Transactions](#Two-Region-Use-Transactions) |
| Domestic Use            | matrix         | [The two-region Domestic Use Transactions](#Two-Region-Use-Transactions) |
| Final Demand            | matrix         | [The two-region Final Demand](#Two-Region-Final-Demand-Transactions) |
| Domestic Final Demand   | matrix         | [The two-region Domestic Final Demand](#Two-Region-Final-Demand-Transactions) |
| Value Added             | matrix         | [The two-region Value Added](#Two-Region-Value-Added-Transactions) |
| Commodity Output        | numeric vector | [Two-region total output by commodity](#Two-Region-Output-Vectors) |
| Industry Output         | numeric vector | [Two-region total output by industry](#Two-Region-Output-Vectors) |
| Domestic Use with trade | list           | [The two-region Domestic Use with interregional trade](#Two-Region-Domestic-Use-with-Trade) |

### Two Region Make Transactions
The two-region Make Transactions is an `industry x commodity` matrix with amounts of commodities (in model year USD) being made by industries.
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

### Two Region Use Transactions
The two-region Use Transactions is a `commodity x industry` matrix with amounts of commodities (in model year USD) being used by industries for intermediate production.
```
                    industries/US-ST, industries/RoUS
                   +---------------------------------+
                   |                |                |
 commodities/US-ST |                |                |
                   |                |                |
                   |-------------- Use --------------|
                   |                |                |
 commodities/RoUS  |                |                |
                   |                |                |
                   +---------------------------------+
```

### Two Region Final Demand
The two-region Final Demand is a `commodity x final demand` matrix with amounts of commodities (in model year USD) being used by final consumers.
```
                    final demand/US-ST, final demand/RoUS
                   +-------------------------------------+
                   |                  |                  |
 commodities/US-ST |                  |                  |
                   |                  |                  |
                   |------------ Final Demand -----------|
                   |                  |                  |
 commodities/RoUS  |                  |                  |
                   |                  |                  |
                   +-------------------------------------+
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

