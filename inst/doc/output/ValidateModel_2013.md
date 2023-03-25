This document presents validation results of 2013 summary-level state IO
model.

### Prepare data

#### 0. Load data

2013 US IO data for states successfully loaded.

2013 single-region IO data for states successfully loaded.

2013 two region IO data for states successfully loaded.

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
| 111CA  |             -1.000e+06 |
| 113FF  |              3.000e+06 |
| 211    |             -1.000e+06 |
| 212    |              5.000e+06 |
| 213    |              0.000e+00 |
| 22     |             -1.221e-04 |
| 23     |             -2.000e+06 |
| 321    |             -4.000e+06 |
| 327    |              2.000e+06 |
| 331    |              0.000e+00 |
| 332    |             -2.000e+06 |
| 333    |              5.000e+06 |
| 334    |             -1.000e+06 |
| 335    |             -1.000e+06 |
| 3361MV |              1.000e+06 |
| 3364OT |              3.000e+06 |
| 337    |             -5.000e+06 |
| 339    |              1.000e+06 |
| 311FT  |              1.221e-04 |
| 313TT  |             -2.000e+06 |
| 315AL  |              3.800e-06 |
| 322    |              1.000e+06 |
| 323    |             -1.530e-05 |
| 324    |             -3.000e+06 |
| 325    |             -3.000e+06 |
| 326    |              3.000e+06 |
| 42     |              8.000e+06 |
| 441    |             -4.000e+06 |
| 445    |             -2.000e+06 |
| 452    |             -6.100e-05 |
| 4A0    |              4.000e+06 |
| 481    |              3.000e+06 |
| 482    |              7.000e+06 |
| 483    |              1.000e+06 |
| 484    |             -4.000e+06 |
| 485    |             -4.000e+06 |
| 486    |             -2.000e+06 |
| 487OS  |              5.000e+06 |
| 493    |             -1.000e+06 |
| 511    |              3.000e+06 |
| 512    |             -1.000e+06 |
| 513    |             -4.000e+06 |
| 514    |             -1.000e+06 |
| 521CI  |             -5.000e+06 |
| 523    |              2.000e+06 |
| 524    |              3.000e+06 |
| 525    |              3.050e-05 |
| HS     |              7.324e-04 |
| ORE    |             -3.000e+06 |
| 532RL  |              1.000e+06 |
| 5411   |             -2.000e+06 |
| 5415   |             -3.000e+06 |
| 5412OP |              1.000e+06 |
| 55     |             -1.000e+06 |
| 561    |             -1.000e+06 |
| 562    |             -1.000e+06 |
| 61     |             -1.000e+06 |
| 621    |              0.000e+00 |
| 622    |              0.000e+00 |
| 623    |              9.160e-05 |
| 624    |              1.000e+06 |
| 711AS  |              3.000e+06 |
| 713    |              3.000e+06 |
| 721    |             -4.000e+06 |
| 722    |             -3.000e+06 |
| 81     |             -1.000e+06 |
| GFGD   |              0.000e+00 |
| GFGN   |              0.000e+00 |
| GFE    |              5.000e+06 |
| GSLG   |              4.883e-04 |
| GSLE   |              4.000e+06 |
| Used   |             -6.000e+06 |
| Other  |             -2.000e+06 |

#### 7. All cells that are zero in US Make table must remain zero in state Make tables. Find zero values in US Make table.

There are no failures.

#### 8. Sum of each cell across all state Use tables must almost equal (\<= 5E6, or \$5 million) the same cell in US Use table. This validates that Total state demand == Total national demand.

Note: failures associated with ‘F050 - Imports’ are acceptable. Because
state imports are not directly derived from US imports, a gap in imports
between state sum and national total is reasonable.

##### 8.1 State Use tables (checking absolute differences)

There are 1 failures, and they are

| Commodity | Industry/Final Demand | Absolute Diff | Validation               | AbsDiffPortioninNationalTotals |
|:----------|:----------------------|--------------:|:-------------------------|-------------------------------:|
| 487OS     | F050                  |       5067649 | abs(result) \< tolerance |                      0.0018216 |

##### 8.2 State Domestic Use tables (checking absolute differences)

There are no failures.

##### 8.3 State Use tables (checking relative differences)

There are 10 failures, and they are

| Commodity | Industry/Final Demand | Relative Diff | Validation               |         US |    StateSum |
|:----------|:----------------------|--------------:|:-------------------------|-----------:|------------:|
| 212       | F050                  |         0.003 | abs(result) \< tolerance |  5.120e+08 |   513322475 |
| 22        | F050                  |         0.001 | abs(result) \< tolerance | -2.609e+09 | -2612000000 |
| 487OS     | F050                  |         0.002 | abs(result) \< tolerance |  2.782e+09 |  2787067649 |
| 513       | F050                  |        -0.025 | abs(result) \< tolerance | -1.620e+08 |  -158000000 |
| 514       | F050                  |         0.003 | abs(result) \< tolerance | -1.023e+09 | -1026000000 |
| 521CI     | F050                  |        -0.043 | abs(result) \< tolerance | -4.600e+07 |   -44000000 |
| 523       | F050                  |        -0.069 | abs(result) \< tolerance | -5.800e+07 |   -54000000 |
| 561       | F050                  |        -0.002 | abs(result) \< tolerance | -1.149e+09 | -1147000000 |
| 562       | F050                  |        -0.022 | abs(result) \< tolerance | -1.370e+08 |  -134000000 |
| GFE       | F050                  |        -0.004 | abs(result) \< tolerance | -4.550e+08 |  -453000000 |

##### 8.4 State Domestic Use tables (checking relative differences)

There are no failures.

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
| 189 | California.514.Industry | -1028987 | L\*y-output |
| 260 | RoUS.514.Industry       |  1024997 | L\*y-output |

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

Absolute Difference: There are no failures.

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
| 191 | New York.523.Industry | -1031274 | L\*y-output |
| 262 | RoUS.523.Industry     |  1016845 | L\*y-output |

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

Absolute Difference: There are 4 failures, and they are

|     | rownames           |   result | check       |
|-----|:-------------------|---------:|:------------|
| 149 | Texas.211.Industry | -1723828 | L\*y-output |
| 151 | Texas.213.Industry | -1526999 | L\*y-output |
| 220 | RoUS.211.Industry  |  1719356 | L\*y-output |
| 222 | RoUS.213.Industry  |  1523465 | L\*y-output |

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

Absolute Difference: There are 2 failures, and they are

|     | rownames                   |   result | check       |
|-----|:---------------------------|---------:|:------------|
| 162 | Washington.3364OT.Industry | -1118248 | L\*y-output |
| 233 | RoUS.3364OT.Industry       |  1114419 | L\*y-output |

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
