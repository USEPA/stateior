This document presents validation results of 2019 summary-level state IO
model.

### Prepare data

#### 0. Load data

2019 US IO data for states successfully loaded.

2019 single-region IO data for states successfully loaded.

2019 two region IO data for states successfully loaded.

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
| 111CA  |              6.100e-05 |
| 113FF  |             -1.000e+06 |
| 211    |              4.000e+06 |
| 212    |              1.530e-05 |
| 213    |              1.000e+06 |
| 22     |             -1.000e+06 |
| 23     |             -2.000e+06 |
| 321    |             -1.000e+06 |
| 327    |              1.000e+06 |
| 331    |             -2.000e+06 |
| 332    |              5.000e+06 |
| 333    |             -3.000e+06 |
| 334    |             -5.000e+06 |
| 335    |             -1.000e+06 |
| 3361MV |             -3.000e+06 |
| 3364OT |             -1.000e+06 |
| 337    |              2.000e+06 |
| 339    |              1.000e+06 |
| 311FT  |             -1.000e+06 |
| 313TT  |             -1.530e-05 |
| 315AL  |              3.000e+06 |
| 322    |              5.000e+06 |
| 323    |             -1.000e+06 |
| 324    |              2.000e+06 |
| 325    |              4.000e+06 |
| 326    |             -2.000e+06 |
| 42     |             -3.000e+06 |
| 441    |              5.000e+06 |
| 445    |             -1.000e+06 |
| 452    |             -2.000e+06 |
| 4A0    |              1.000e+06 |
| 481    |              1.000e+06 |
| 482    |              1.530e-05 |
| 483    |              1.000e+06 |
| 484    |             -1.000e+06 |
| 485    |             -2.000e+06 |
| 486    |             -2.000e+06 |
| 487OS  |             -2.000e+06 |
| 493    |             -1.000e+06 |
| 511    |              2.000e+06 |
| 512    |              6.100e-05 |
| 513    |             -2.000e+06 |
| 514    |              4.000e+06 |
| 521CI  |             -1.000e+06 |
| 523    |             -2.000e+06 |
| 524    |              1.000e+06 |
| 525    |              1.000e+06 |
| HS     |             -9.766e-04 |
| ORE    |              2.000e+06 |
| 532RL  |             -4.000e+06 |
| 5411   |              0.000e+00 |
| 5415   |              4.000e+06 |
| 5412OP |             -5.000e+06 |
| 55     |              2.000e+06 |
| 561    |             -2.441e-04 |
| 562    |              3.000e+06 |
| 61     |             -1.000e+06 |
| 621    |             -2.000e+06 |
| 622    |              0.000e+00 |
| 623    |              0.000e+00 |
| 624    |             -1.000e+06 |
| 711AS  |             -1.000e+06 |
| 713    |              3.000e+06 |
| 721    |             -3.000e+06 |
| 722    |             -2.000e+06 |
| 81     |             -2.000e+06 |
| GFGD   |              0.000e+00 |
| GFGN   |              6.100e-05 |
| GFE    |              1.000e+06 |
| GSLG   |             -9.766e-04 |
| GSLE   |              1.000e+06 |
| Used   |             -1.900e-06 |
| Other  |              1.000e+06 |

#### 7. All cells that are zero in US Make table must remain zero in state Make tables. Find zero values in US Make table.

There are no failures.

#### 8. Sum of each cell across all state Use tables must almost equal (\<= 5E6, or \$5 million) the same cell in US Use table. This validates that Total state demand == Total national demand.

Note: failures associated with ‘F050 - Imports’ are acceptable. Because
state imports are not directly derived from US imports, a gap in imports
between state sum and national total is reasonable.

##### 8.1 State Use tables (checking absolute differences)

There are 2 failures, and they are

| Commodity | Industry/Final Demand | Absolute Diff | Validation               | AbsDiffPortioninNationalTotals |
|:----------|:----------------------|--------------:|:-------------------------|-------------------------------:|
| 513       | F050                  |         5e+06 | abs(result) \< tolerance |                     -0.0299401 |
| 711AS     | F050                  |         6e+06 | abs(result) \< tolerance |                     -0.0079576 |

##### 8.2 State Domestic Use tables (checking absolute differences)

There are no failures.

##### 8.3 State Use tables (checking relative differences)

There are 10 failures, and they are

| Commodity | Industry/Final Demand | Relative Diff | Validation               |         US |    StateSum |
|:----------|:----------------------|--------------:|:-------------------------|-----------:|------------:|
| 212       | F050                  |         0.002 | abs(result) \< tolerance |  5.430e+08 |   544000000 |
| 213       | F050                  |         0.001 | abs(result) \< tolerance | -7.030e+08 |  -704000000 |
| 22        | F050                  |        -0.001 | abs(result) \< tolerance | -2.084e+09 | -2081000000 |
| 487OS     | F050                  |         0.001 | abs(result) \< tolerance |  3.934e+09 |  3937971396 |
| 513       | F050                  |        -0.030 | abs(result) \< tolerance | -1.670e+08 |  -162000000 |
| 514       | F050                  |        -0.002 | abs(result) \< tolerance | -1.309e+09 | -1306000000 |
| 521CI     | F050                  |        -0.042 | abs(result) \< tolerance | -4.800e+07 |   -46000000 |
| 523       | F050                  |        -0.067 | abs(result) \< tolerance | -6.000e+07 |   -56000000 |
| 711AS     | F050                  |        -0.008 | abs(result) \< tolerance | -7.540e+08 |  -748000000 |
| GFE       | F050                  |         0.008 | abs(result) \< tolerance | -2.630e+08 |  -265000000 |

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
| 159 | California.334.Industry |  1170951 | L\*y-output |
| 230 | RoUS.334.Industry       | -1171015 | L\*y-output |

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

Absolute Difference: There are no failures.

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
| 170 | Texas.324.Industry | -1035147 | L\*y-output |
| 193 | Texas.525.Industry | -1060222 | L\*y-output |
| 241 | RoUS.324.Industry  |  1037275 | L\*y-output |
| 264 | RoUS.525.Industry  |  1049359 | L\*y-output |

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
