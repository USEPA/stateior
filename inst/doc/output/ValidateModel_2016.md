This document presents validation results of 2016 summary-level state IO
model.

### Prepare data

#### 0. Load data

2016 US IO data for states successfully loaded.

2016 single-region IO data for states successfully loaded.

2016 two region IO data for states successfully loaded.

### Check state IO tables

#### 1. Check if industry output from state Make and Use are almost equal (\<= 0.01).

There are no failures.

### Compare state to US IO tables (negativity in the same cell & state sum == US totals)

#### 2. Sum of each cell across all state Make tables must almost equal (\<= 0.001) the same cell in US Make table.

There are no failures.

#### 3. There should not be any negative values in state Make table, unless they are negative in US Make table.

Note: only exception being Overseas, which isn’t used for further
calculations, and if the same cell in US Make table is also negative.
There are no failures.

#### 4. Sum of each industry’s output across all states must almost equal (\<= 1E7, or \$10 million by industry) the industry output in US Make Table.

The threshold is set to 1E7 because there are differences (within +/-
\$10 million) between US industry output summed from Make and that
summed from Use, comparing sum of state industry output (summed from
state Use) to US industry output summed from US Make should account for
those inherent differences at the national level. There are no failures.

#### 5. Sum of each commodity’s output across all states must almost equal (\<= 1E7, or \$10 million by commodity) the commodity output in US Make Table.

The threshold is set to 1E7 because there are differences (within +/-
\$10 million) between US industry output summed from Make and that
summed from Use, comparing sum of state industry output (summed from
state Use) to US industry output summed from US Make should account for
those inherent differences at the national level. There are no failures.

#### 6. Sum of each commodity’s output across all states must almost equal (\<= 1E^7, or \$10 million by commodity) commodity output in US Use Table.

Note: even if the threshold is met, track the difference for each
commodity. Save result as a type of quality control check.

There are no failures.

|        | q_state_sum - q_US_use |
|--------|-----------------------:|
| 111CA  |              2.000e+06 |
| 113FF  |              7.600e-06 |
| 211    |              1.000e+06 |
| 212    |             -3.000e+06 |
| 213    |              1.530e-05 |
| 22     |              2.000e+06 |
| 23     |             -1.000e+06 |
| 321    |              1.000e+06 |
| 327    |              2.000e+06 |
| 331    |             -2.000e+06 |
| 332    |             -1.000e+06 |
| 333    |              1.000e+06 |
| 334    |              5.000e+06 |
| 335    |             -2.000e+06 |
| 3361MV |              2.000e+06 |
| 3364OT |              6.100e-05 |
| 337    |             -3.000e+06 |
| 339    |              5.000e+06 |
| 311FT  |              3.000e+06 |
| 313TT  |              7.600e-06 |
| 315AL  |             -1.000e+06 |
| 322    |             -2.000e+06 |
| 323    |              0.000e+00 |
| 324    |              1.000e+06 |
| 325    |              1.000e+06 |
| 326    |              3.000e+06 |
| 42     |             -1.000e+06 |
| 441    |              1.000e+06 |
| 445    |             -1.000e+06 |
| 452    |             -3.000e+06 |
| 4A0    |             -3.000e+06 |
| 481    |             -1.000e+06 |
| 482    |             -1.000e+06 |
| 483    |             -3.000e+06 |
| 484    |             -6.100e-05 |
| 485    |             -1.530e-05 |
| 486    |              4.000e+06 |
| 487OS  |             -1.000e+06 |
| 493    |              2.000e+06 |
| 511    |             -3.000e+06 |
| 512    |              1.000e+06 |
| 513    |              3.000e+06 |
| 514    |             -3.000e+06 |
| 521CI  |             -1.000e+06 |
| 523    |              4.000e+06 |
| 524    |              2.000e+06 |
| 525    |             -1.000e+06 |
| HS     |             -2.441e-04 |
| ORE    |              2.441e-04 |
| 532RL  |             -1.221e-04 |
| 5411   |             -1.000e+06 |
| 5415   |              2.000e+06 |
| 5412OP |             -3.000e+06 |
| 55     |             -1.000e+06 |
| 561    |             -4.000e+06 |
| 562    |             -1.000e+06 |
| 61     |             -1.831e-04 |
| 621    |             -2.000e+06 |
| 622    |              1.000e+06 |
| 623    |             -6.100e-05 |
| 624    |             -1.000e+06 |
| 711AS  |              5.000e+06 |
| 713    |              1.000e+06 |
| 721    |              2.000e+06 |
| 722    |              4.000e+06 |
| 81     |             -4.000e+06 |
| GFGD   |              0.000e+00 |
| GFGN   |             -1.221e-04 |
| GFE    |              1.000e+06 |
| GSLG   |              7.324e-04 |
| GSLE   |             -4.000e+06 |
| Used   |              2.000e+06 |
| Other  |              1.000e+06 |

#### 7. All cells that are zero in US Make table must remain zero in state Make tables. Find zero values in US Make table.

There are no failures.

#### 8. Sum of each cell across all state Use tables must almost equal (\<= 5E6, or \$5 million) the same cell in US Use table. This validates that Total state demand == Total national demand.

Note: failures associated with ‘F050 - Imports’ are acceptable. Because
state imports are not directly derived from US imports, a gap in imports
between state sum and national total is reasonable.

##### 8.1 State Use tables (checking absolute differences)

There are 4 failures, and they are

| Commodity | Industry/Final Demand | Absolute Diff | Validation               | AbsDiffPortioninNationalTotals |
|:----------|:----------------------|--------------:|:-------------------------|-------------------------------:|
| 211       | F050                  |         9e+06 | abs(result) \< tolerance |                     -0.0000777 |
| 513       | F050                  |         7e+06 | abs(result) \< tolerance |                     -0.0411765 |
| 5412OP    | F050                  |         6e+06 | abs(result) \< tolerance |                     -0.0000632 |
| 562       | F050                  |         5e+06 | abs(result) \< tolerance |                     -0.0238095 |

##### 8.2 State Domestic Use tables (checking absolute differences)

There are no failures.

##### 8.3 State Use tables (checking relative differences)

There are 9 failures, and they are

| Commodity | Industry/Final Demand | Relative Diff | Validation               |         US |    StateSum |
|:----------|:----------------------|--------------:|:-------------------------|-----------:|------------:|
| 212       | F050                  |         0.001 | abs(result) \< tolerance | -9.950e+08 |  -996133819 |
| 213       | F050                  |        -0.001 | abs(result) \< tolerance | -6.950e+08 |  -694000000 |
| 513       | F050                  |        -0.041 | abs(result) \< tolerance | -1.700e+08 |  -163000000 |
| 521CI     | F050                  |        -0.021 | abs(result) \< tolerance | -4.800e+07 |   -47000000 |
| 523       | F050                  |        -0.033 | abs(result) \< tolerance | -6.100e+07 |   -59000000 |
| 561       | F050                  |        -0.002 | abs(result) \< tolerance | -1.742e+09 | -1739000000 |
| 562       | F050                  |        -0.024 | abs(result) \< tolerance | -2.100e+08 |  -205000000 |
| 711AS     | F050                  |        -0.002 | abs(result) \< tolerance | -1.528e+09 | -1525000000 |
| GFE       | F050                  |        -0.010 | abs(result) \< tolerance | -2.990e+08 |  -296000000 |

##### 8.4 State Domestic Use tables (checking relative differences)

There are 4 failures, and they are

| Commodity | Industry/Final Demand | Relative Diff | Validation               |     US | StateSum |
|:----------|:----------------------|--------------:|:-------------------------|-------:|---------:|
| 211       | 213                   |            -1 | abs(result) \< tolerance | -2e+06 |        0 |
| 211       | 622                   |            -1 | abs(result) \< tolerance | -3e+06 |        0 |
| 211       | 623                   |            -1 | abs(result) \< tolerance | -1e+06 |        0 |
| 211       | 711AS                 |            -1 | abs(result) \< tolerance | -1e+06 |        0 |

### Check two-region model results

#### 9. Check if commodity output from two-region Make and Domestic Use are almost equal (relative difference \<= 0.01).

There are no failures.

#### 10. If SoI commodity output == 0, SoI2SoI ICF ratio == 0

There are no failures.

#### 11. SoI and RoUS interregional exports \>= 0, interregional imports \>= 0

There are no failures.

#### 12. SoI net exports + RoUS net exports == 0

There are no failures.

#### 13. Check row sum of SoI2SoI \<= state commodity supply. Row sum of RoUS2RoUS \<= RoUS commodity supply.

There are no failures.

#### 14. Value in SoI2SoI and RoUS2RoUS can be negative only when the same cell is negative in national Use table

There are no failures.

#### 15. SoI interregional imports == RoUS interregional exports, or difference \<= 0.001

There are no failures.

#### 16.1. Total state commodity supply == state demand by intermediate consumption, plus final demand (except imports and international trade adjustment) + Interregional Exports + Export Residual. Difference must be \<= 0.001.

There are no failures.

#### 16.2. Total SoI and RoUS commodity supply (output) == SoI and RoUS demand (domestic intermediate consumption + ITA + Export Residual).

There are no failures.

#### 17. Number of negative cells in SoI2SoI, SoI2RoUS, RoUS2SoI and RoUS2RoUS \<= Number of negative cells in national Use table

There are no failures.

#### 18. Non-square model verification. Validate L matrix of two-region model and final demand against SoI and RoUS output.

##### Absolute difference: L\*y - output \<= 1^6, or \$1 million.

##### Relative difference: (L\*y - output)/output \<= 1^-2, or 1%.

##### 18.1 Alabama and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.2 Alaska and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.3 Arizona and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.4 Arkansas and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.5 California and Rest of the US

Absolute Difference: There are 2 failures, and they are

|     | rownames                |   result | check       |
|-----|:------------------------|---------:|:------------|
| 189 | California.514.Industry | -1510303 | L\*y-output |
| 260 | RoUS.514.Industry       |  1507202 | L\*y-output |

Relative Difference: There are no failures.

##### 18.6 Colorado and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.7 Connecticut and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.8 Delaware and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.10 Florida and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.11 Georgia and Rest of the US

Absolute Difference: There are 2 failures, and they are

|     | rownames               |   result | check       |
|-----|:-----------------------|---------:|:------------|
| 166 | Georgia.313TT.Industry |  1258288 | L\*y-output |
| 237 | RoUS.313TT.Industry    | -1243393 | L\*y-output |

Relative Difference: There are no failures.

##### 18.12 Hawaii and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.13 Idaho and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.14 Illinois and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.15 Indiana and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.16 Iowa and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.17 Kansas and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.18 Kentucky and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.19 Louisiana and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.20 Maine and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.21 Maryland and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.22 Massachusetts and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.23 Michigan and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.24 Minnesota and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.25 Mississippi and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.26 Missouri and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.27 Montana and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.28 Nebraska and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.29 Nevada and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.30 New Hampshire and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.31 New Jersey and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.32 New Mexico and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.33 New York and Rest of the US

Absolute Difference: There are 2 failures, and they are

|     | rownames              |   result | check       |
|-----|:----------------------|---------:|:------------|
| 191 | New York.523.Industry |  1165470 | L\*y-output |
| 262 | RoUS.523.Industry     | -1161392 | L\*y-output |

Relative Difference: There are no failures.

##### 18.34 North Carolina and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.35 North Dakota and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.36 Ohio and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.37 Oklahoma and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.38 Oregon and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.40 Pennsylvania and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.41 Rhode Island and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.42 South Carolina and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.43 South Dakota and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.44 Tennessee and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.45 Texas and Rest of the US

Absolute Difference: There are 2 failures, and they are

|     | rownames           |   result | check       |
|-----|:-------------------|---------:|:------------|
| 170 | Texas.324.Industry |  1063803 | L\*y-output |
| 241 | RoUS.324.Industry  | -1064121 | L\*y-output |

Relative Difference: There are no failures.

##### 18.46 Utah and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.47 Vermont and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.48 Virginia and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.49 Washington and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.50 West Virginia and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.51 Wisconsin and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.52 Wyoming and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.
