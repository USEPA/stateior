This document presents validation results of 2012 summary-level state IO
model.

### Prepare data

#### 0\. Load state and two-region IO data.

State and two-region IO data successfully loaded.

### Check state IO tables

#### 1\. Check if industry output from state Make and Use are almost equal (\<= 0.01).

There are no failures.

### Compare state to US IO tables (negativity in the same cell & state sum == US totals)

#### 2\. Sum of each cell across all state Make tables must almost equal (\<= 0.001) the same cell in US Make table.

There are no failures.

#### 3\. There should not be any negative values in state Make table, unless they are negative in US Make table.

Note: only exception being Overseas, which isn’t used for further
calculations, and if the same cell in US Make table is also negative.
There are no failures.

#### 4\. Sum of each industry’s output across all states must almost equal (\<= 1E7, or $10 million by industry) the industry output in US Make Table.

The threshold is set to 1E7 because there are differences (within +/-
$10 million) between US industry output summed from Make and that summed
from Use, comparing sum of state industry output (summed from state Use)
to US industry output summed from US Make should account for those
inherent differences at the national level. There are no failures.

#### 5\. Sum of each commodity’s output across all states must almost equal (\<= 1E7, or $10 million by commodity) the commodity output in US Make Table.

The threshold is set to 1E7 because there are differences (within +/-
$10 million) between US industry output summed from Make and that summed
from Use, comparing sum of state industry output (summed from state Use)
to US industry output summed from US Make should account for those
inherent differences at the national level. There are no failures.

#### 6\. Sum of each commodity’s output across all states must almost equal (\<= 1E^7, or $10 million by commodity) commodity output in US Use Table.

Note: even if the threshold is met, track the difference for each
commodity. Save result as a type of quality control check.

There are no failures.

|        | q\_state\_sum - q\_US\_use |
| ------ | -------------------------: |
| 111CA  |                  2.000e+06 |
| 113FF  |                \-1.000e+06 |
| 211    |                \-6.100e-05 |
| 212    |                  1.000e+06 |
| 213    |                  1.000e+06 |
| 22     |                  1.000e+06 |
| 23     |                  1.000e+06 |
| 321    |                  1.000e+06 |
| 327    |                  3.000e+06 |
| 331    |                \-5.000e+06 |
| 332    |                  1.221e-04 |
| 333    |                  4.000e+06 |
| 334    |                \-1.000e+06 |
| 335    |                  4.000e+06 |
| 3361MV |                \-2.000e+06 |
| 3364OT |                  3.000e+06 |
| 337    |                \-4.000e+06 |
| 339    |                \-2.000e+06 |
| 311FT  |                \-3.000e+06 |
| 313TT  |                \-2.000e+06 |
| 315AL  |                  1.000e+06 |
| 322    |                \-1.000e+06 |
| 323    |                  1.000e+06 |
| 324    |                  3.000e+06 |
| 325    |                \-3.000e+06 |
| 326    |                  1.000e+06 |
| 42     |                \-2.000e+06 |
| 441    |                  1.000e+06 |
| 445    |                  1.000e+06 |
| 452    |                  1.000e+06 |
| 4A0    |                  2.000e+06 |
| 481    |                \-1.000e+06 |
| 482    |                  3.000e+06 |
| 483    |                  0.000e+00 |
| 484    |                  4.000e+06 |
| 485    |                  5.000e+06 |
| 486    |                  3.000e+06 |
| 487OS  |                \-2.000e+06 |
| 493    |                \-5.000e+06 |
| 511    |                  1.000e+06 |
| 512    |                  1.000e+06 |
| 513    |                  6.000e+06 |
| 514    |                  5.000e+06 |
| 521CI  |                  2.000e+06 |
| 523    |                  1.000e+06 |
| 524    |                  3.000e+06 |
| 525    |                  6.100e-05 |
| HS     |                  1.000e+06 |
| ORE    |                \-1.000e+06 |
| 532RL  |                \-2.000e+06 |
| 5411   |                  3.000e+06 |
| 5415   |                  3.000e+06 |
| 5412OP |                \-2.000e+06 |
| 55     |                  2.000e+06 |
| 561    |                \-3.000e+06 |
| 562    |                  5.000e+06 |
| 61     |                \-2.000e+06 |
| 621    |                  0.000e+00 |
| 622    |                  0.000e+00 |
| 623    |                \-3.050e-05 |
| 624    |                \-1.000e+06 |
| 711AS  |                  3.000e+06 |
| 713    |                  1.000e+06 |
| 721    |                \-1.000e+06 |
| 722    |                  1.000e+06 |
| 81     |                \-3.000e+06 |
| GFGD   |                  0.000e+00 |
| GFGN   |                  1.221e-04 |
| GFE    |                  1.000e+06 |
| GSLG   |                  0.000e+00 |
| GSLE   |                  4.000e+06 |
| Used   |                \-1.000e+06 |
| Other  |                \-1.000e+06 |

#### 7\. All cells that are zero in US Make table must remain zero in state Make tables. Find zero values in US Make table.

There are no failures.

#### 8\. Sum of each cell across all state Use tables must almost equal (\<= 5E6, or $5 million) the same cell in US Use table. This validates that Total state demand == Total national demand.

Note: failures associated with ‘F050 - Imports’ are acceptable. Because
state imports are not directly derived from US imports, a gap in imports
between state sum and national total is reasonable.

##### 8.1 State Use tables (checking absolute differences)

There are 4 failures, and they are

| Commodity | Industry/Final Demand | Absolute Diff | Validation               | AbsDiffPortioninNationalTotals |
| :-------- | :-------------------- | ------------: | :----------------------- | -----------------------------: |
| 212       | F050                  |       5108462 | abs(result) \< tolerance |                      0.0010855 |
| 513       | F050                  |       8000000 | abs(result) \< tolerance |                    \-0.0516129 |
| 561       | F050                  |       6000000 | abs(result) \< tolerance |                    \-0.0058140 |
| 562       | F050                  |       5000000 | abs(result) \< tolerance |                    \-0.0406504 |

##### 8.2 State Domestic Use tables (checking absolute differences)

There are no failures.

##### 8.3 State Use tables (checking relative differences)

There are 10 failures, and they are

| Commodity | Industry/Final Demand | Relative Diff | Validation               |          US |     StateSum |
| :-------- | :-------------------- | ------------: | :----------------------- | ----------: | -----------: |
| 212       | F050                  |         0.001 | abs(result) \< tolerance |   4.706e+09 |   4711108462 |
| 487OS     | F050                  |         0.001 | abs(result) \< tolerance |   3.495e+09 |   3499964805 |
| 513       | F050                  |       \-0.052 | abs(result) \< tolerance | \-1.550e+08 |  \-147000000 |
| 514       | F050                  |       \-0.001 | abs(result) \< tolerance | \-8.980e+08 |  \-897000000 |
| 521CI     | F050                  |       \-0.045 | abs(result) \< tolerance | \-4.400e+07 |   \-42000000 |
| 523       | F050                  |       \-0.054 | abs(result) \< tolerance | \-5.600e+07 |   \-53000000 |
| 561       | F050                  |       \-0.006 | abs(result) \< tolerance | \-1.032e+09 | \-1026000000 |
| 562       | F050                  |       \-0.041 | abs(result) \< tolerance | \-1.230e+08 |  \-118000000 |
| 711AS     | F050                  |       \-0.002 | abs(result) \< tolerance | \-8.450e+08 |  \-843000000 |
| GFE       | F050                  |       \-0.007 | abs(result) \< tolerance | \-4.500e+08 |  \-447000000 |

##### 8.4 State Domestic Use tables (checking relative differences)

There are no failures.

### Check two-region model results

#### 9\. Check if commodity output from two-region Make and Domestic Use are almost equal (relative difference \<= 0.01).

There are no failures.

#### 10\. If SoI commodity output == 0, SoI2SoI ICF ratio == 0

There are no failures.

#### 11\. SoI and RoUS interregional exports \>= 0, interregional imports \>= 0

There are no failures.

#### 12\. SoI net exports + RoUS net exports == 0

There are no failures.

#### 13\. Check row sum of SoI2SoI \<= state commodity supply. Row sum of RoUS2RoUS \<= RoUS commodity supply.

There are no failures.

#### 14\. Value in SoI2SoI and RoUS2RoUS can be negative only when the same cell is negative in national Use table

There are no failures.

#### 15\. SoI interregional imports == RoUS interregional exports, or difference \<= 0.001

There are no failures.

#### 16.1. Total state commodity supply == state demand by intermediate consumption, plus final demand (except imports and international trade adjustment) + Interregional Exports + Export Residual. Difference must be \<= 0.001.

There are no failures.

#### 16.2. Total SoI and RoUS commodity supply (output) == SoI and RoUS demand (domestic intermediate consumption + ITA + Export Residual).

There are no failures.

#### 17\. Number of negative cells in SoI2SoI, SoI2RoUS, RoUS2SoI and RoUS2RoUS \<= Number of negative cells in national Use table

There are no failures.

#### 18\. Non-square model verification. Validate L matrix of two-region model and final demand against SoI and RoUS output.

##### Absolute difference: L\*y - output \<= 1^6, or $1 million.

##### Relative difference: (L\*y - output)/output \<= 1^-2, or 1%.

##### 18.1 Georgia and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.2 Minnesota and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.3 Oregon and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.

##### 18.4 Washington and Rest of the US

Absolute Difference: There are no failures.

Relative Difference: There are no failures.
