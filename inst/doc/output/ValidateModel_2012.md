This document presents validation results of 2012 summary-level state IO
model.

### Prepare data

#### 0\. Load state and two-region IO data.

State and two-region IO data successfully loaded.

### Check state IO tables

#### 1\. Check if industry output from state Make and Use are almost equal (\<= 0.001).

There are no failures.

### Compare state to US IO tables (negativity in the same cell & state sum == US totals)

#### 2\. Sum of each cell across all state Make tables must almost equal (\<= 0.001) the same cell in US Make table.

There are no failures.

#### 3\. There should not be any negative values in state Make table, unless they are negative in US Make table.

Note: only exception being Overseas, which isn’t used for further
calculations, and if the same cell in US Make table is also negative.

There are no failures.

#### 4\. Sum of each industry’s output across all states must almost equal(\<= 0.001) industry output in US Make Table.

There are no failures.

#### 5\. Sum of each commodity’s output across all states must almost equal(\<= 0.001) commodity output in US Make Table.

There are 56 failures, and they are

|    | Commodity |                            |
| -- | :-------- | -------------------------- |
| 1  | 111CA     | colSums(US\_Summary\_Make) |
| 3  | 211       | colSums(US\_Summary\_Make) |
| 4  | 212       | colSums(US\_Summary\_Make) |
| 5  | 213       | colSums(US\_Summary\_Make) |
| 6  | 22        | colSums(US\_Summary\_Make) |
| 7  | 23        | colSums(US\_Summary\_Make) |
| 8  | 321       | colSums(US\_Summary\_Make) |
| 9  | 327       | colSums(US\_Summary\_Make) |
| 10 | 331       | colSums(US\_Summary\_Make) |
| 14 | 335       | colSums(US\_Summary\_Make) |
| 15 | 3361MV    | colSums(US\_Summary\_Make) |
| 16 | 3364OT    | colSums(US\_Summary\_Make) |
| 17 | 337       | colSums(US\_Summary\_Make) |
| 18 | 339       | colSums(US\_Summary\_Make) |
| 19 | 311FT     | colSums(US\_Summary\_Make) |
| 21 | 315AL     | colSums(US\_Summary\_Make) |
| 22 | 322       | colSums(US\_Summary\_Make) |
| 23 | 323       | colSums(US\_Summary\_Make) |
| 24 | 324       | colSums(US\_Summary\_Make) |
| 26 | 326       | colSums(US\_Summary\_Make) |
| 27 | 42        | colSums(US\_Summary\_Make) |
| 28 | 441       | colSums(US\_Summary\_Make) |
| 29 | 445       | colSums(US\_Summary\_Make) |
| 30 | 452       | colSums(US\_Summary\_Make) |
| 31 | 4A0       | colSums(US\_Summary\_Make) |
| 32 | 481       | colSums(US\_Summary\_Make) |
| 33 | 482       | colSums(US\_Summary\_Make) |
| 34 | 483       | colSums(US\_Summary\_Make) |
| 35 | 484       | colSums(US\_Summary\_Make) |
| 36 | 485       | colSums(US\_Summary\_Make) |
| 37 | 486       | colSums(US\_Summary\_Make) |
| 38 | 487OS     | colSums(US\_Summary\_Make) |
| 41 | 512       | colSums(US\_Summary\_Make) |
| 42 | 513       | colSums(US\_Summary\_Make) |
| 44 | 521CI     | colSums(US\_Summary\_Make) |
| 46 | 524       | colSums(US\_Summary\_Make) |
| 47 | 525       | colSums(US\_Summary\_Make) |
| 48 | HS        | colSums(US\_Summary\_Make) |
| 49 | ORE       | colSums(US\_Summary\_Make) |
| 50 | 532RL     | colSums(US\_Summary\_Make) |
| 51 | 5411      | colSums(US\_Summary\_Make) |
| 52 | 5415      | colSums(US\_Summary\_Make) |
| 53 | 5412OP    | colSums(US\_Summary\_Make) |
| 54 | 55        | colSums(US\_Summary\_Make) |
| 55 | 561       | colSums(US\_Summary\_Make) |
| 56 | 562       | colSums(US\_Summary\_Make) |
| 57 | 61        | colSums(US\_Summary\_Make) |
| 58 | 621       | colSums(US\_Summary\_Make) |
| 61 | 624       | colSums(US\_Summary\_Make) |
| 62 | 711AS     | colSums(US\_Summary\_Make) |
| 63 | 713       | colSums(US\_Summary\_Make) |
| 64 | 721       | colSums(US\_Summary\_Make) |
| 65 | 722       | colSums(US\_Summary\_Make) |
| 66 | 81        | colSums(US\_Summary\_Make) |
| 72 | Used      | colSums(US\_Summary\_Make) |
| 73 | Other     | colSums(US\_Summary\_Make) |

#### 6\. Sum of each commodity’s output across all states must almost equal (\<= 1E^7, or $10 million by commodity) commodity output in US Use Table minus International Imports (commodity specific).

Note: even if the threshold is met, track the difference for each
commodity. Save result as a type of quality control check.

There are no failures.

|        | q\_state\_sum - q\_US\_use |
| ------ | -------------------------: |
| 111CA  |                \-6.100e-05 |
| 113FF  |                  1.000e+06 |
| 211    |                \-1.000e+06 |
| 212    |                  3.000e+06 |
| 213    |                \-1.000e+06 |
| 22     |                  0.000e+00 |
| 23     |                  2.441e-04 |
| 321    |                  2.000e+06 |
| 327    |                \-1.000e+06 |
| 331    |                  4.000e+06 |
| 332    |                \-6.100e-05 |
| 333    |                  1.000e+06 |
| 334    |                \-2.000e+06 |
| 335    |                  1.000e+06 |
| 3361MV |                  5.000e+06 |
| 3364OT |                \-1.000e+06 |
| 337    |                  1.000e+06 |
| 339    |                \-3.000e+06 |
| 311FT  |                \-1.000e+06 |
| 313TT  |                  1.000e+06 |
| 315AL  |                \-2.000e+06 |
| 322    |                  4.000e+06 |
| 323    |                  1.000e+06 |
| 324    |                \-1.000e+06 |
| 325    |                \-1.000e+06 |
| 326    |                  1.000e+06 |
| 42     |                  0.000e+00 |
| 441    |                  3.050e-05 |
| 445    |                  0.000e+00 |
| 452    |                  0.000e+00 |
| 4A0    |                  1.221e-04 |
| 481    |                  5.000e+06 |
| 482    |                \-3.050e-05 |
| 483    |                  0.000e+00 |
| 484    |                  0.000e+00 |
| 485    |                \-7.600e-06 |
| 486    |                  7.600e-06 |
| 487OS  |                  5.000e+06 |
| 493    |                  0.000e+00 |
| 511    |                  1.000e+06 |
| 512    |                \-1.000e+06 |
| 513    |                  8.000e+06 |
| 514    |                  4.000e+06 |
| 521CI  |                  2.000e+06 |
| 523    |                  2.000e+06 |
| 524    |                  2.000e+06 |
| 525    |                  0.000e+00 |
| HS     |                \-2.441e-04 |
| ORE    |                \-1.221e-04 |
| 532RL  |                \-6.100e-05 |
| 5411   |                  3.000e+06 |
| 5415   |                  1.000e+06 |
| 5412OP |                \-3.000e+06 |
| 55     |                \-6.100e-05 |
| 561    |                  2.000e+06 |
| 562    |                \-6.100e-05 |
| 61     |                  1.000e+06 |
| 621    |                \-1.221e-04 |
| 622    |                  0.000e+00 |
| 623    |                  3.050e-05 |
| 624    |                  0.000e+00 |
| 711AS  |                  2.000e+06 |
| 713    |                \-3.050e-05 |
| 721    |                \-3.050e-05 |
| 722    |                  0.000e+00 |
| 81     |                  2.000e+06 |
| GFGD   |                \-1.221e-04 |
| GFGN   |                  6.100e-05 |
| GFE    |                  3.000e+06 |
| GSLG   |                \-2.441e-04 |
| GSLE   |                  3.050e-05 |
| Used   |                  2.000e+06 |
| Other  |                  3.000e+06 |

#### 7\. All cells that are zero in US Make table must remain zero in state Make tables. Find zero values in US Make table.

There are no failures.

#### 8\. Sum of each cell across all state Use tables must almost equal (\<= 0.001) the same cell in US Use table. This validates that Total state demand == Total national demand.

Note: failures associated with ‘F050 - Imports’ are acceptable. Because
state imports are not directly derived from US imports, a gap in imports
between state sum and national total is reasonable.

##### 8.1 State Use tables

There are 45 failures, and they are

| Commodity | Industry/Final Demand |
| :-------- | :-------------------- |
| 113FF     | F050                  |
| 211       | F050                  |
| 212       | F050                  |
| 213       | F050                  |
| 321       | F050                  |
| 327       | F050                  |
| 331       | F050                  |
| 333       | F050                  |
| 334       | F050                  |
| 335       | F050                  |
| 3361MV    | F050                  |
| 3364OT    | F050                  |
| 337       | F050                  |
| 339       | F050                  |
| 311FT     | F050                  |
| 313TT     | F050                  |
| 315AL     | F050                  |
| 322       | F050                  |
| 323       | F050                  |
| 324       | F050                  |
| 325       | F050                  |
| 326       | F050                  |
| 42        | F050                  |
| 481       | F050                  |
| 482       | F050                  |
| 483       | F050                  |
| 484       | F050                  |
| 487OS     | F050                  |
| 511       | F050                  |
| 512       | F050                  |
| 513       | F050                  |
| 514       | F050                  |
| 521CI     | F050                  |
| 523       | F050                  |
| 524       | F050                  |
| 5411      | F050                  |
| 5415      | F050                  |
| 5412OP    | F050                  |
| 561       | F050                  |
| 61        | F050                  |
| 711AS     | F050                  |
| 81        | F050                  |
| GFE       | F050                  |
| Used      | F050                  |
| Other     | F050                  |

##### 8.2 State Domestic Use tables

There are no failures.

### Check two-region model results

#### 9\. If SoI commodity output == 0, SoI2SoI ICF ratio == 0

There are no failures.

#### 10\. SoI and RoUS interregional exports \>= 0, interregional imports \>= 0

There are no failures.

#### 11\. SoI net exports + RoUS net exports == 0

There are no failures.

#### 12\. Check row sum of SoI2SoI \<= state commodity supply. Row sum of RoUS2RoUS \<= national commodity supply.

There are no failures.

#### 13\. Value in SoI2SoI and RoUS2RoUS can be negative only when the same cell is negative in national Use table

There are no failures.

#### 14\. SoI interregional imports == RoUS interregional exports, or difference \<= 0.001

There are no failures.

#### 15\. Total state commodity supply == state demand by intermediate consumption, plus final demand (except imports) + Interregional Exports + Export Residual. Difference must be \<= 0.001.

There are no failures.

#### 16\. Number of negative cells in SoI2SoI, SoI2RoUS, RoUS2SoI and RoUS2RoUS \<= Number of negative cells in national Use table

There are no failures.

#### 17\. Non-square model verification. Validate L matrix of two-region model and final demand against SoI and RoUS output. L\*y - output \<= 1^6, or $1 million.

##### 17.1 Georgia and Rest of the US

There are no failures.

##### 17.2 Minnesota and Rest of the US

There are no failures.

##### 17.3 Oregon and Rest of the US

There are no failures.

##### 17.4 Washington and Rest of the US

There are no failures.
