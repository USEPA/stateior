This document presents validation results of 2016 summary-level state IO
model.

### Prepare data

#### 0\. Load state and two-region IO data.

2022-03-01 20:08:07 <INFO::State_Summary_Make_2016_0.1.0.rds> not found
in local folder, downloading from Data Commons… 2022-03-01 20:08:10
<INFO::State_Summary_Use_2016_0.1.0.rds> not found in local folder,
downloading from Data Commons… 2022-03-01 20:08:12
<INFO::State_Summary_DomesticUse_2016_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 20:08:15
<INFO::State_Summary_IndustryOutput_2016_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 20:08:17
<INFO::State_Summary_CommodityOutput_2016_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 20:08:20
<INFO::TwoRegion_Summary_DomesticUsewithTrade_2016_0.1.0.rds> not found
in local folder, downloading from Data Commons…

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

There are 71 failures, and they are

| Industry |                            |
| :------- | -------------------------- |
| 111CA    | rowSums(US\_Summary\_Make) |
| 113FF    | rowSums(US\_Summary\_Make) |
| 211      | rowSums(US\_Summary\_Make) |
| 212      | rowSums(US\_Summary\_Make) |
| 213      | rowSums(US\_Summary\_Make) |
| 22       | rowSums(US\_Summary\_Make) |
| 23       | rowSums(US\_Summary\_Make) |
| 321      | rowSums(US\_Summary\_Make) |
| 327      | rowSums(US\_Summary\_Make) |
| 331      | rowSums(US\_Summary\_Make) |
| 332      | rowSums(US\_Summary\_Make) |
| 333      | rowSums(US\_Summary\_Make) |
| 334      | rowSums(US\_Summary\_Make) |
| 335      | rowSums(US\_Summary\_Make) |
| 3361MV   | rowSums(US\_Summary\_Make) |
| 3364OT   | rowSums(US\_Summary\_Make) |
| 337      | rowSums(US\_Summary\_Make) |
| 339      | rowSums(US\_Summary\_Make) |
| 311FT    | rowSums(US\_Summary\_Make) |
| 313TT    | rowSums(US\_Summary\_Make) |
| 315AL    | rowSums(US\_Summary\_Make) |
| 322      | rowSums(US\_Summary\_Make) |
| 323      | rowSums(US\_Summary\_Make) |
| 324      | rowSums(US\_Summary\_Make) |
| 325      | rowSums(US\_Summary\_Make) |
| 326      | rowSums(US\_Summary\_Make) |
| 42       | rowSums(US\_Summary\_Make) |
| 441      | rowSums(US\_Summary\_Make) |
| 445      | rowSums(US\_Summary\_Make) |
| 452      | rowSums(US\_Summary\_Make) |
| 4A0      | rowSums(US\_Summary\_Make) |
| 481      | rowSums(US\_Summary\_Make) |
| 482      | rowSums(US\_Summary\_Make) |
| 483      | rowSums(US\_Summary\_Make) |
| 484      | rowSums(US\_Summary\_Make) |
| 485      | rowSums(US\_Summary\_Make) |
| 486      | rowSums(US\_Summary\_Make) |
| 487OS    | rowSums(US\_Summary\_Make) |
| 493      | rowSums(US\_Summary\_Make) |
| 511      | rowSums(US\_Summary\_Make) |
| 512      | rowSums(US\_Summary\_Make) |
| 513      | rowSums(US\_Summary\_Make) |
| 514      | rowSums(US\_Summary\_Make) |
| 521CI    | rowSums(US\_Summary\_Make) |
| 523      | rowSums(US\_Summary\_Make) |
| 524      | rowSums(US\_Summary\_Make) |
| 525      | rowSums(US\_Summary\_Make) |
| HS       | rowSums(US\_Summary\_Make) |
| ORE      | rowSums(US\_Summary\_Make) |
| 532RL    | rowSums(US\_Summary\_Make) |
| 5411     | rowSums(US\_Summary\_Make) |
| 5415     | rowSums(US\_Summary\_Make) |
| 5412OP   | rowSums(US\_Summary\_Make) |
| 55       | rowSums(US\_Summary\_Make) |
| 561      | rowSums(US\_Summary\_Make) |
| 562      | rowSums(US\_Summary\_Make) |
| 61       | rowSums(US\_Summary\_Make) |
| 621      | rowSums(US\_Summary\_Make) |
| 622      | rowSums(US\_Summary\_Make) |
| 623      | rowSums(US\_Summary\_Make) |
| 624      | rowSums(US\_Summary\_Make) |
| 711AS    | rowSums(US\_Summary\_Make) |
| 713      | rowSums(US\_Summary\_Make) |
| 721      | rowSums(US\_Summary\_Make) |
| 722      | rowSums(US\_Summary\_Make) |
| 81       | rowSums(US\_Summary\_Make) |
| GFGD     | rowSums(US\_Summary\_Make) |
| GFGN     | rowSums(US\_Summary\_Make) |
| GFE      | rowSums(US\_Summary\_Make) |
| GSLG     | rowSums(US\_Summary\_Make) |
| GSLE     | rowSums(US\_Summary\_Make) |

#### 5\. Sum of each commodity’s output across all states must almost equal(\<= 0.001) commodity output in US Make Table.

There are 62 failures, and they are

|    | Commodity |                            |
| -- | :-------- | -------------------------- |
| 1  | 111CA     | colSums(US\_Summary\_Make) |
| 2  | 113FF     | colSums(US\_Summary\_Make) |
| 3  | 211       | colSums(US\_Summary\_Make) |
| 4  | 212       | colSums(US\_Summary\_Make) |
| 5  | 213       | colSums(US\_Summary\_Make) |
| 6  | 22        | colSums(US\_Summary\_Make) |
| 7  | 23        | colSums(US\_Summary\_Make) |
| 8  | 321       | colSums(US\_Summary\_Make) |
| 9  | 327       | colSums(US\_Summary\_Make) |
| 10 | 331       | colSums(US\_Summary\_Make) |
| 11 | 332       | colSums(US\_Summary\_Make) |
| 12 | 333       | colSums(US\_Summary\_Make) |
| 13 | 334       | colSums(US\_Summary\_Make) |
| 14 | 335       | colSums(US\_Summary\_Make) |
| 15 | 3361MV    | colSums(US\_Summary\_Make) |
| 16 | 3364OT    | colSums(US\_Summary\_Make) |
| 17 | 337       | colSums(US\_Summary\_Make) |
| 18 | 339       | colSums(US\_Summary\_Make) |
| 19 | 311FT     | colSums(US\_Summary\_Make) |
| 20 | 313TT     | colSums(US\_Summary\_Make) |
| 21 | 315AL     | colSums(US\_Summary\_Make) |
| 22 | 322       | colSums(US\_Summary\_Make) |
| 23 | 323       | colSums(US\_Summary\_Make) |
| 24 | 324       | colSums(US\_Summary\_Make) |
| 25 | 325       | colSums(US\_Summary\_Make) |
| 26 | 326       | colSums(US\_Summary\_Make) |
| 27 | 42        | colSums(US\_Summary\_Make) |
| 28 | 441       | colSums(US\_Summary\_Make) |
| 29 | 445       | colSums(US\_Summary\_Make) |
| 31 | 4A0       | colSums(US\_Summary\_Make) |
| 32 | 481       | colSums(US\_Summary\_Make) |
| 33 | 482       | colSums(US\_Summary\_Make) |
| 34 | 483       | colSums(US\_Summary\_Make) |
| 35 | 484       | colSums(US\_Summary\_Make) |
| 36 | 485       | colSums(US\_Summary\_Make) |
| 37 | 486       | colSums(US\_Summary\_Make) |
| 38 | 487OS     | colSums(US\_Summary\_Make) |
| 39 | 493       | colSums(US\_Summary\_Make) |
| 40 | 511       | colSums(US\_Summary\_Make) |
| 41 | 512       | colSums(US\_Summary\_Make) |
| 42 | 513       | colSums(US\_Summary\_Make) |
| 43 | 514       | colSums(US\_Summary\_Make) |
| 44 | 521CI     | colSums(US\_Summary\_Make) |
| 45 | 523       | colSums(US\_Summary\_Make) |
| 46 | 524       | colSums(US\_Summary\_Make) |
| 49 | ORE       | colSums(US\_Summary\_Make) |
| 50 | 532RL     | colSums(US\_Summary\_Make) |
| 51 | 5411      | colSums(US\_Summary\_Make) |
| 52 | 5415      | colSums(US\_Summary\_Make) |
| 53 | 5412OP    | colSums(US\_Summary\_Make) |
| 54 | 55        | colSums(US\_Summary\_Make) |
| 55 | 561       | colSums(US\_Summary\_Make) |
| 56 | 562       | colSums(US\_Summary\_Make) |
| 57 | 61        | colSums(US\_Summary\_Make) |
| 59 | 622       | colSums(US\_Summary\_Make) |
| 62 | 711AS     | colSums(US\_Summary\_Make) |
| 63 | 713       | colSums(US\_Summary\_Make) |
| 65 | 722       | colSums(US\_Summary\_Make) |
| 66 | 81        | colSums(US\_Summary\_Make) |
| 71 | GSLE      | colSums(US\_Summary\_Make) |
| 72 | Used      | colSums(US\_Summary\_Make) |
| 73 | Other     | colSums(US\_Summary\_Make) |

#### 6\. Sum of each commodity’s output across all states must almost equal (\<= 1.11^7, or $11.1 million by commodity) commodity output in US Use Table minus International Imports (commodity specific). Even if the threshold is met, track the difference for each commodity. Save result as a type of quality control check

There are 43 failures, and they are

|    | Commodity |                                   |
| -- | :-------- | --------------------------------- |
| 1  | 111CA     | rowSums(US\_Summary\_DomesticUse) |
| 2  | 113FF     | rowSums(US\_Summary\_DomesticUse) |
| 3  | 211       | rowSums(US\_Summary\_DomesticUse) |
| 4  | 212       | rowSums(US\_Summary\_DomesticUse) |
| 6  | 22        | rowSums(US\_Summary\_DomesticUse) |
| 8  | 321       | rowSums(US\_Summary\_DomesticUse) |
| 9  | 327       | rowSums(US\_Summary\_DomesticUse) |
| 10 | 331       | rowSums(US\_Summary\_DomesticUse) |
| 11 | 332       | rowSums(US\_Summary\_DomesticUse) |
| 12 | 333       | rowSums(US\_Summary\_DomesticUse) |
| 13 | 334       | rowSums(US\_Summary\_DomesticUse) |
| 14 | 335       | rowSums(US\_Summary\_DomesticUse) |
| 15 | 3361MV    | rowSums(US\_Summary\_DomesticUse) |
| 16 | 3364OT    | rowSums(US\_Summary\_DomesticUse) |
| 17 | 337       | rowSums(US\_Summary\_DomesticUse) |
| 18 | 339       | rowSums(US\_Summary\_DomesticUse) |
| 19 | 311FT     | rowSums(US\_Summary\_DomesticUse) |
| 20 | 313TT     | rowSums(US\_Summary\_DomesticUse) |
| 21 | 315AL     | rowSums(US\_Summary\_DomesticUse) |
| 22 | 322       | rowSums(US\_Summary\_DomesticUse) |
| 23 | 323       | rowSums(US\_Summary\_DomesticUse) |
| 24 | 324       | rowSums(US\_Summary\_DomesticUse) |
| 25 | 325       | rowSums(US\_Summary\_DomesticUse) |
| 26 | 326       | rowSums(US\_Summary\_DomesticUse) |
| 27 | 42        | rowSums(US\_Summary\_DomesticUse) |
| 32 | 481       | rowSums(US\_Summary\_DomesticUse) |
| 33 | 482       | rowSums(US\_Summary\_DomesticUse) |
| 34 | 483       | rowSums(US\_Summary\_DomesticUse) |
| 35 | 484       | rowSums(US\_Summary\_DomesticUse) |
| 38 | 487OS     | rowSums(US\_Summary\_DomesticUse) |
| 40 | 511       | rowSums(US\_Summary\_DomesticUse) |
| 41 | 512       | rowSums(US\_Summary\_DomesticUse) |
| 42 | 513       | rowSums(US\_Summary\_DomesticUse) |
| 43 | 514       | rowSums(US\_Summary\_DomesticUse) |
| 46 | 524       | rowSums(US\_Summary\_DomesticUse) |
| 51 | 5411      | rowSums(US\_Summary\_DomesticUse) |
| 53 | 5412OP    | rowSums(US\_Summary\_DomesticUse) |
| 57 | 61        | rowSums(US\_Summary\_DomesticUse) |
| 59 | 622       | rowSums(US\_Summary\_DomesticUse) |
| 62 | 711AS     | rowSums(US\_Summary\_DomesticUse) |
| 66 | 81        | rowSums(US\_Summary\_DomesticUse) |
| 72 | Used      | rowSums(US\_Summary\_DomesticUse) |
| 73 | Other     | rowSums(US\_Summary\_DomesticUse) |

#### 7\. All cells that are zero in US Make table must remain zero in state Make tables. Find zero values in US Make table.

There are no failures.

#### 8\. Sum of each cell across all state Use tables must almost equal (\<= 0.001) the same cell in US Use table. This validates that Total state demand == Total national demand.

Note: failures associated with ‘F050 - Imports’ are acceptable. Because
state imports are not directly derived from US imports, a gap in imports
between state sum and national total is reasonable. \#\#\#\#\# 7.1 State
Use tables There are 49 failures, and they are

| Commodity | Industry/Final Demand |
| :-------- | :-------------------- |
| 111CA     | F050                  |
| 113FF     | F050                  |
| 211       | F050                  |
| 212       | F050                  |
| 213       | F050                  |
| 22        | F050                  |
| 321       | F050                  |
| 327       | F050                  |
| 331       | F050                  |
| 332       | F050                  |
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
| 562       | F050                  |
| 61        | F050                  |
| 622       | F050                  |
| 711AS     | F050                  |
| 81        | F050                  |
| Used      | F050                  |
| Other     | F050                  |

##### 7.2 State Domestic Use tables

There are 10 failures, and they are

| Commodity | Industry/Final Demand |
| :-------- | :-------------------- |
| 211       | 441                   |
| 211       | 445                   |
| 211       | 5412OP                |
| 211       | 562                   |
| 211       | 621                   |
| 211       | 622                   |
| 211       | 623                   |
| 3364OT    | 624                   |
| 211       | 713                   |
| 211       | 81                    |

### Check two-region model results

#### 9\. If SoI commodity output == 0, SoI2SoI ICF ratio == 0

2022-03-01 20:08:26 <INFO::FAF_2016_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 20:08:29
<INFO::Loading> State\_Employment\_2009\_2018\_0.1.0.rds from local
folder … 2022-03-01 20:08:29 <INFO::file> not found, downloading from
<https://edap-ord-data-commons.s3.amazonaws.com/flowsa/FlowBySector>
2022-03-01 20:08:34 <INFO::Loading>
EIA\_SEDS\_CodeDescription\_0.1.0.rds from local folder … 2022-03-01
20:08:34 <INFO::EIA_SEDS_StateElectricityConsumption_2016_0.1.0.rds> not
found in local folder, downloading from Data Commons… 2022-03-01
20:08:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:08:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:08:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:08:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:08:42 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:08:43 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:08:46 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:08:47 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:08:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:08:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:08:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:08:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:08:53 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:08:54 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:08:57 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:08:58 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:08:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:08:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:02 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:03 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:09:07 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:09:08 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:13 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:14 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:09:18 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:09:18 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:22 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:22 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:23 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:25 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:09:28 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:09:29 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:31 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:32 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:33 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:35 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:09:38 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:09:39 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:41 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:44 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:45 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:09:48 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:09:49 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:52 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:53 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:09:57 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:09:57 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:09:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:09:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:00 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:01 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:10:04 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:10:04 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:05 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:07 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:07 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:08 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:10:11 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:10:11 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:14 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:14 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:15 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:10:18 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:10:19 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:21 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:21 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:22 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:10:25 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:10:26 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:28 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:29 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:10:32 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:10:33 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:36 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:37 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:10:39 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:10:40 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:41 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:43 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:44 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:10:47 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:10:47 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:49 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:49 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:50 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:51 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:10:54 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:10:54 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:57 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:10:57 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:10:58 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:11:01 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:11:02 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:02 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:04 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:05 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:11:09 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:11:09 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:12 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:13 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:11:16 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:11:16 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:19 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:20 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:11:24 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:11:25 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:30 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:31 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:11:34 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:11:35 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:40 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:41 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:11:45 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:11:46 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:49 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:51 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:53 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:11:56 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:11:57 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:11:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:11:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:01 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:03 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:12:06 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:12:07 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:12 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:13 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:12:16 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:12:17 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:21 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:22 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:12:26 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:12:27 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:31 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:32 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:12:35 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:12:36 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:40 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:41 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:12:44 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:12:45 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:46 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:49 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:50 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:12:53 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:12:54 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:57 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:12:58 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:12:59 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:13:02 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:13:03 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:05 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:07 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:08 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:13:12 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:13:13 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:14 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:15 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:16 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:18 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:19 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:13:22 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:13:23 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:24 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:25 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:27 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:28 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:13:32 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:13:32 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:37 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:38 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:13:41 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:13:42 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:44 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:45 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:46 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:47 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:13:50 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:13:51 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:54 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:13:55 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:13:56 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:13:59 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:14:00 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:02 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:03 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:04 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:14:08 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:14:09 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:13 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:14 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:14:17 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:14:18 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:21 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:22 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:23 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:14:27 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:14:27 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:31 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:32 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:14:36 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:14:36 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:40 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:42 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:14:45 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:14:46 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:46 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:49 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:50 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:51 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:14:54 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:14:55 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:14:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:57 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:14:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:00 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:01 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:15:04 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:15:05 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:07 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:09 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:10 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:15:14 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:15:15 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:16 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:16 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:19 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:20 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:15:24 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:15:24 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:25 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:28 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:29 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:15:33 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:15:34 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:38 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:39 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:15:42 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:15:43 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:44 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:45 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:46 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:47 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:48 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:15:51 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:15:52 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:54 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:15:56 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:15:57 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:16:00 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:16:01 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:16:02 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:16:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:16:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:16:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:16:05 <INFO::Loading> FAF\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:16:06 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
20:16:09 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 20:16:10 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2016\_0.1.0.rds from local
folder … 2022-03-01 20:16:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:16:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:16:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …
2022-03-01 20:16:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2016\_0.1.0.rds from local folder …

There are no failures.

#### 10\. SoI and RoUS interregional exports \>= 0, interregional imports \>= 0

There are no failures.

#### 11\. SoI net exports + RoUS net exports == 0

There are no failures.

#### 12\. Check row sum of SoI2SoI \<= state commodity supply. Row sum of RoUS2RoUS \<= national commodity supply.

There are 787 failures, and they are

|       | rownames | variable                    |
| ----- | :------- | :-------------------------- |
| 72    | Used     | Alabama                     |
| 73    | Other    | Alabama                     |
| 75    | 113FF    | Alabama’s RoUS              |
| 76    | 211      | Alabama’s RoUS              |
| 79    | 22       | Alabama’s RoUS              |
| 82    | 327      | Alabama’s RoUS              |
| 85    | 333      | Alabama’s RoUS              |
| 86    | 334      | Alabama’s RoUS              |
| 87    | 335      | Alabama’s RoUS              |
| 89    | 3364OT   | Alabama’s RoUS              |
| 90    | 337      | Alabama’s RoUS              |
| 93    | 313TT    | Alabama’s RoUS              |
| 94    | 315AL    | Alabama’s RoUS              |
| 145   | Used     | Alabama’s RoUS              |
| 146   | Other    | Alabama’s RoUS              |
| 74    | 111CA    | Alaska’s RoUS               |
| 751   | 113FF    | Alaska’s RoUS               |
| 761   | 211      | Alaska’s RoUS               |
| 791   | 22       | Alaska’s RoUS               |
| 81    | 321      | Alaska’s RoUS               |
| 821   | 327      | Alaska’s RoUS               |
| 84    | 332      | Alaska’s RoUS               |
| 851   | 333      | Alaska’s RoUS               |
| 861   | 334      | Alaska’s RoUS               |
| 871   | 335      | Alaska’s RoUS               |
| 88    | 3361MV   | Alaska’s RoUS               |
| 891   | 3364OT   | Alaska’s RoUS               |
| 901   | 337      | Alaska’s RoUS               |
| 931   | 313TT    | Alaska’s RoUS               |
| 941   | 315AL    | Alaska’s RoUS               |
| 96    | 323      | Alaska’s RoUS               |
| 99    | 326      | Alaska’s RoUS               |
| 139   | 81       | Alaska’s RoUS               |
| 1451  | Used     | Alaska’s RoUS               |
| 1461  | Other    | Alaska’s RoUS               |
| 721   | Used     | Arizona                     |
| 731   | Other    | Arizona                     |
| 752   | 113FF    | Arizona’s RoUS              |
| 762   | 211      | Arizona’s RoUS              |
| 792   | 22       | Arizona’s RoUS              |
| 811   | 321      | Arizona’s RoUS              |
| 822   | 327      | Arizona’s RoUS              |
| 852   | 333      | Arizona’s RoUS              |
| 862   | 334      | Arizona’s RoUS              |
| 872   | 335      | Arizona’s RoUS              |
| 881   | 3361MV   | Arizona’s RoUS              |
| 902   | 337      | Arizona’s RoUS              |
| 932   | 313TT    | Arizona’s RoUS              |
| 942   | 315AL    | Arizona’s RoUS              |
| 1452  | Used     | Arizona’s RoUS              |
| 1462  | Other    | Arizona’s RoUS              |
| 722   | Used     | Arkansas                    |
| 732   | Other    | Arkansas                    |
| 741   | 111CA    | Arkansas’s RoUS             |
| 753   | 113FF    | Arkansas’s RoUS             |
| 763   | 211      | Arkansas’s RoUS             |
| 793   | 22       | Arkansas’s RoUS             |
| 812   | 321      | Arkansas’s RoUS             |
| 823   | 327      | Arkansas’s RoUS             |
| 841   | 332      | Arkansas’s RoUS             |
| 853   | 333      | Arkansas’s RoUS             |
| 863   | 334      | Arkansas’s RoUS             |
| 873   | 335      | Arkansas’s RoUS             |
| 882   | 3361MV   | Arkansas’s RoUS             |
| 892   | 3364OT   | Arkansas’s RoUS             |
| 903   | 337      | Arkansas’s RoUS             |
| 933   | 313TT    | Arkansas’s RoUS             |
| 943   | 315AL    | Arkansas’s RoUS             |
| 1391  | 81       | Arkansas’s RoUS             |
| 1453  | Used     | Arkansas’s RoUS             |
| 1463  | Other    | Arkansas’s RoUS             |
| 723   | Used     | California                  |
| 733   | Other    | California                  |
| 944   | 315AL    | California’s RoUS           |
| 1454  | Used     | California’s RoUS           |
| 1464  | Other    | California’s RoUS           |
| 734   | Other    | Colorado                    |
| 754   | 113FF    | Colorado’s RoUS             |
| 764   | 211      | Colorado’s RoUS             |
| 813   | 321      | Colorado’s RoUS             |
| 824   | 327      | Colorado’s RoUS             |
| 854   | 333      | Colorado’s RoUS             |
| 864   | 334      | Colorado’s RoUS             |
| 874   | 335      | Colorado’s RoUS             |
| 883   | 3361MV   | Colorado’s RoUS             |
| 893   | 3364OT   | Colorado’s RoUS             |
| 904   | 337      | Colorado’s RoUS             |
| 934   | 313TT    | Colorado’s RoUS             |
| 945   | 315AL    | Colorado’s RoUS             |
| 1455  | Used     | Colorado’s RoUS             |
| 1465  | Other    | Colorado’s RoUS             |
| 735   | Other    | Connecticut                 |
| 742   | 111CA    | Connecticut’s RoUS          |
| 755   | 113FF    | Connecticut’s RoUS          |
| 765   | 211      | Connecticut’s RoUS          |
| 794   | 22       | Connecticut’s RoUS          |
| 814   | 321      | Connecticut’s RoUS          |
| 825   | 327      | Connecticut’s RoUS          |
| 842   | 332      | Connecticut’s RoUS          |
| 855   | 333      | Connecticut’s RoUS          |
| 865   | 334      | Connecticut’s RoUS          |
| 875   | 335      | Connecticut’s RoUS          |
| 884   | 3361MV   | Connecticut’s RoUS          |
| 905   | 337      | Connecticut’s RoUS          |
| 935   | 313TT    | Connecticut’s RoUS          |
| 946   | 315AL    | Connecticut’s RoUS          |
| 1456  | Used     | Connecticut’s RoUS          |
| 1466  | Other    | Connecticut’s RoUS          |
| 743   | 111CA    | Delaware’s RoUS             |
| 756   | 113FF    | Delaware’s RoUS             |
| 766   | 211      | Delaware’s RoUS             |
| 815   | 321      | Delaware’s RoUS             |
| 826   | 327      | Delaware’s RoUS             |
| 843   | 332      | Delaware’s RoUS             |
| 856   | 333      | Delaware’s RoUS             |
| 866   | 334      | Delaware’s RoUS             |
| 876   | 335      | Delaware’s RoUS             |
| 885   | 3361MV   | Delaware’s RoUS             |
| 894   | 3364OT   | Delaware’s RoUS             |
| 906   | 337      | Delaware’s RoUS             |
| 936   | 313TT    | Delaware’s RoUS             |
| 947   | 315AL    | Delaware’s RoUS             |
| 961   | 323      | Delaware’s RoUS             |
| 991   | 326      | Delaware’s RoUS             |
| 1392  | 81       | Delaware’s RoUS             |
| 1457  | Used     | Delaware’s RoUS             |
| 1467  | Other    | Delaware’s RoUS             |
| 736   | Other    | District of Columbia        |
| 744   | 111CA    | District of Columbia’s RoUS |
| 757   | 113FF    | District of Columbia’s RoUS |
| 767   | 211      | District of Columbia’s RoUS |
| 816   | 321      | District of Columbia’s RoUS |
| 827   | 327      | District of Columbia’s RoUS |
| 844   | 332      | District of Columbia’s RoUS |
| 857   | 333      | District of Columbia’s RoUS |
| 867   | 334      | District of Columbia’s RoUS |
| 877   | 335      | District of Columbia’s RoUS |
| 886   | 3361MV   | District of Columbia’s RoUS |
| 895   | 3364OT   | District of Columbia’s RoUS |
| 907   | 337      | District of Columbia’s RoUS |
| 937   | 313TT    | District of Columbia’s RoUS |
| 948   | 315AL    | District of Columbia’s RoUS |
| 992   | 326      | District of Columbia’s RoUS |
| 1393  | 81       | District of Columbia’s RoUS |
| 1458  | Used     | District of Columbia’s RoUS |
| 1468  | Other    | District of Columbia’s RoUS |
| 724   | Used     | Florida                     |
| 737   | Other    | Florida                     |
| 758   | 113FF    | Florida’s RoUS              |
| 768   | 211      | Florida’s RoUS              |
| 858   | 333      | Florida’s RoUS              |
| 868   | 334      | Florida’s RoUS              |
| 878   | 335      | Florida’s RoUS              |
| 908   | 337      | Florida’s RoUS              |
| 949   | 315AL    | Florida’s RoUS              |
| 1459  | Used     | Florida’s RoUS              |
| 1469  | Other    | Florida’s RoUS              |
| 725   | Used     | Georgia                     |
| 738   | Other    | Georgia                     |
| 759   | 113FF    | Georgia’s RoUS              |
| 769   | 211      | Georgia’s RoUS              |
| 859   | 333      | Georgia’s RoUS              |
| 869   | 334      | Georgia’s RoUS              |
| 879   | 335      | Georgia’s RoUS              |
| 909   | 337      | Georgia’s RoUS              |
| 9410  | 315AL    | Georgia’s RoUS              |
| 14510 | Used     | Georgia’s RoUS              |
| 14610 | Other    | Georgia’s RoUS              |
| 745   | 111CA    | Hawaii’s RoUS               |
| 7510  | 113FF    | Hawaii’s RoUS               |
| 7610  | 211      | Hawaii’s RoUS               |
| 795   | 22       | Hawaii’s RoUS               |
| 817   | 321      | Hawaii’s RoUS               |
| 828   | 327      | Hawaii’s RoUS               |
| 845   | 332      | Hawaii’s RoUS               |
| 8510  | 333      | Hawaii’s RoUS               |
| 8610  | 334      | Hawaii’s RoUS               |
| 8710  | 335      | Hawaii’s RoUS               |
| 887   | 3361MV   | Hawaii’s RoUS               |
| 896   | 3364OT   | Hawaii’s RoUS               |
| 9010  | 337      | Hawaii’s RoUS               |
| 938   | 313TT    | Hawaii’s RoUS               |
| 9411  | 315AL    | Hawaii’s RoUS               |
| 962   | 323      | Hawaii’s RoUS               |
| 993   | 326      | Hawaii’s RoUS               |
| 1394  | 81       | Hawaii’s RoUS               |
| 14511 | Used     | Hawaii’s RoUS               |
| 14611 | Other    | Hawaii’s RoUS               |
| 746   | 111CA    | Idaho’s RoUS                |
| 7511  | 113FF    | Idaho’s RoUS                |
| 7611  | 211      | Idaho’s RoUS                |
| 818   | 321      | Idaho’s RoUS                |
| 829   | 327      | Idaho’s RoUS                |
| 846   | 332      | Idaho’s RoUS                |
| 8511  | 333      | Idaho’s RoUS                |
| 8611  | 334      | Idaho’s RoUS                |
| 8711  | 335      | Idaho’s RoUS                |
| 888   | 3361MV   | Idaho’s RoUS                |
| 897   | 3364OT   | Idaho’s RoUS                |
| 9011  | 337      | Idaho’s RoUS                |
| 939   | 313TT    | Idaho’s RoUS                |
| 9412  | 315AL    | Idaho’s RoUS                |
| 963   | 323      | Idaho’s RoUS                |
| 994   | 326      | Idaho’s RoUS                |
| 1395  | 81       | Idaho’s RoUS                |
| 14512 | Used     | Idaho’s RoUS                |
| 14612 | Other    | Idaho’s RoUS                |
| 726   | Used     | Illinois                    |
| 739   | Other    | Illinois                    |
| 7512  | 113FF    | Illinois’s RoUS             |
| 8612  | 334      | Illinois’s RoUS             |
| 898   | 3364OT   | Illinois’s RoUS             |
| 9012  | 337      | Illinois’s RoUS             |
| 9413  | 315AL    | Illinois’s RoUS             |
| 14513 | Used     | Illinois’s RoUS             |
| 14613 | Other    | Illinois’s RoUS             |
| 727   | Used     | Indiana                     |
| 7310  | Other    | Indiana                     |
| 7513  | 113FF    | Indiana’s RoUS              |
| 8613  | 334      | Indiana’s RoUS              |
| 8712  | 335      | Indiana’s RoUS              |
| 899   | 3364OT   | Indiana’s RoUS              |
| 9013  | 337      | Indiana’s RoUS              |
| 9310  | 313TT    | Indiana’s RoUS              |
| 9414  | 315AL    | Indiana’s RoUS              |
| 14514 | Used     | Indiana’s RoUS              |
| 14614 | Other    | Indiana’s RoUS              |
| 7311  | Other    | Iowa                        |
| 7514  | 113FF    | Iowa’s RoUS                 |
| 7612  | 211      | Iowa’s RoUS                 |
| 796   | 22       | Iowa’s RoUS                 |
| 819   | 321      | Iowa’s RoUS                 |
| 8210  | 327      | Iowa’s RoUS                 |
| 8512  | 333      | Iowa’s RoUS                 |
| 8614  | 334      | Iowa’s RoUS                 |
| 8713  | 335      | Iowa’s RoUS                 |
| 889   | 3361MV   | Iowa’s RoUS                 |
| 8910  | 3364OT   | Iowa’s RoUS                 |
| 9014  | 337      | Iowa’s RoUS                 |
| 9311  | 313TT    | Iowa’s RoUS                 |
| 9415  | 315AL    | Iowa’s RoUS                 |
| 14515 | Used     | Iowa’s RoUS                 |
| 14615 | Other    | Iowa’s RoUS                 |
| 7312  | Other    | Kansas                      |
| 7515  | 113FF    | Kansas’s RoUS               |
| 7613  | 211      | Kansas’s RoUS               |
| 797   | 22       | Kansas’s RoUS               |
| 8110  | 321      | Kansas’s RoUS               |
| 8211  | 327      | Kansas’s RoUS               |
| 847   | 332      | Kansas’s RoUS               |
| 8513  | 333      | Kansas’s RoUS               |
| 8615  | 334      | Kansas’s RoUS               |
| 8714  | 335      | Kansas’s RoUS               |
| 8810  | 3361MV   | Kansas’s RoUS               |
| 9015  | 337      | Kansas’s RoUS               |
| 9312  | 313TT    | Kansas’s RoUS               |
| 9416  | 315AL    | Kansas’s RoUS               |
| 14516 | Used     | Kansas’s RoUS               |
| 14616 | Other    | Kansas’s RoUS               |
| 728   | Used     | Kentucky                    |
| 7313  | Other    | Kentucky                    |
| 7516  | 113FF    | Kentucky’s RoUS             |
| 7614  | 211      | Kentucky’s RoUS             |
| 798   | 22       | Kentucky’s RoUS             |
| 8111  | 321      | Kentucky’s RoUS             |
| 8514  | 333      | Kentucky’s RoUS             |
| 8616  | 334      | Kentucky’s RoUS             |
| 8715  | 335      | Kentucky’s RoUS             |
| 8911  | 3364OT   | Kentucky’s RoUS             |
| 9016  | 337      | Kentucky’s RoUS             |
| 9313  | 313TT    | Kentucky’s RoUS             |
| 9417  | 315AL    | Kentucky’s RoUS             |
| 14517 | Used     | Kentucky’s RoUS             |
| 14617 | Other    | Kentucky’s RoUS             |
| 729   | Used     | Louisiana                   |
| 7314  | Other    | Louisiana                   |
| 7517  | 113FF    | Louisiana’s RoUS            |
| 8112  | 321      | Louisiana’s RoUS            |
| 848   | 332      | Louisiana’s RoUS            |
| 8515  | 333      | Louisiana’s RoUS            |
| 8617  | 334      | Louisiana’s RoUS            |
| 8716  | 335      | Louisiana’s RoUS            |
| 8811  | 3361MV   | Louisiana’s RoUS            |
| 8912  | 3364OT   | Louisiana’s RoUS            |
| 9017  | 337      | Louisiana’s RoUS            |
| 9314  | 313TT    | Louisiana’s RoUS            |
| 9418  | 315AL    | Louisiana’s RoUS            |
| 14518 | Used     | Louisiana’s RoUS            |
| 14618 | Other    | Louisiana’s RoUS            |
| 747   | 111CA    | Maine’s RoUS                |
| 7518  | 113FF    | Maine’s RoUS                |
| 7615  | 211      | Maine’s RoUS                |
| 799   | 22       | Maine’s RoUS                |
| 8113  | 321      | Maine’s RoUS                |
| 8212  | 327      | Maine’s RoUS                |
| 849   | 332      | Maine’s RoUS                |
| 8516  | 333      | Maine’s RoUS                |
| 8618  | 334      | Maine’s RoUS                |
| 8717  | 335      | Maine’s RoUS                |
| 8812  | 3361MV   | Maine’s RoUS                |
| 8913  | 3364OT   | Maine’s RoUS                |
| 9018  | 337      | Maine’s RoUS                |
| 9315  | 313TT    | Maine’s RoUS                |
| 9419  | 315AL    | Maine’s RoUS                |
| 964   | 323      | Maine’s RoUS                |
| 995   | 326      | Maine’s RoUS                |
| 1396  | 81       | Maine’s RoUS                |
| 14519 | Used     | Maine’s RoUS                |
| 14619 | Other    | Maine’s RoUS                |
| 7315  | Other    | Maryland                    |
| 7519  | 113FF    | Maryland’s RoUS             |
| 7616  | 211      | Maryland’s RoUS             |
| 8517  | 333      | Maryland’s RoUS             |
| 8619  | 334      | Maryland’s RoUS             |
| 8718  | 335      | Maryland’s RoUS             |
| 8813  | 3361MV   | Maryland’s RoUS             |
| 8914  | 3364OT   | Maryland’s RoUS             |
| 9019  | 337      | Maryland’s RoUS             |
| 9316  | 313TT    | Maryland’s RoUS             |
| 9420  | 315AL    | Maryland’s RoUS             |
| 14520 | Used     | Maryland’s RoUS             |
| 14620 | Other    | Maryland’s RoUS             |
| 7210  | Used     | Massachusetts               |
| 7316  | Other    | Massachusetts               |
| 7520  | 113FF    | Massachusetts’s RoUS        |
| 7617  | 211      | Massachusetts’s RoUS        |
| 8518  | 333      | Massachusetts’s RoUS        |
| 8620  | 334      | Massachusetts’s RoUS        |
| 8719  | 335      | Massachusetts’s RoUS        |
| 8814  | 3361MV   | Massachusetts’s RoUS        |
| 8915  | 3364OT   | Massachusetts’s RoUS        |
| 9020  | 337      | Massachusetts’s RoUS        |
| 9317  | 313TT    | Massachusetts’s RoUS        |
| 9421  | 315AL    | Massachusetts’s RoUS        |
| 14521 | Used     | Massachusetts’s RoUS        |
| 14621 | Other    | Massachusetts’s RoUS        |
| 7211  | Used     | Michigan                    |
| 7317  | Other    | Michigan                    |
| 7521  | 113FF    | Michigan’s RoUS             |
| 7618  | 211      | Michigan’s RoUS             |
| 7910  | 22       | Michigan’s RoUS             |
| 8621  | 334      | Michigan’s RoUS             |
| 8720  | 335      | Michigan’s RoUS             |
| 8916  | 3364OT   | Michigan’s RoUS             |
| 9021  | 337      | Michigan’s RoUS             |
| 9422  | 315AL    | Michigan’s RoUS             |
| 14522 | Used     | Michigan’s RoUS             |
| 14622 | Other    | Michigan’s RoUS             |
| 7212  | Used     | Minnesota                   |
| 7318  | Other    | Minnesota                   |
| 7522  | 113FF    | Minnesota’s RoUS            |
| 7619  | 211      | Minnesota’s RoUS            |
| 8213  | 327      | Minnesota’s RoUS            |
| 8519  | 333      | Minnesota’s RoUS            |
| 8622  | 334      | Minnesota’s RoUS            |
| 8721  | 335      | Minnesota’s RoUS            |
| 8815  | 3361MV   | Minnesota’s RoUS            |
| 8917  | 3364OT   | Minnesota’s RoUS            |
| 9022  | 337      | Minnesota’s RoUS            |
| 9318  | 313TT    | Minnesota’s RoUS            |
| 9423  | 315AL    | Minnesota’s RoUS            |
| 14523 | Used     | Minnesota’s RoUS            |
| 14623 | Other    | Minnesota’s RoUS            |
| 7319  | Other    | Mississippi                 |
| 748   | 111CA    | Mississippi’s RoUS          |
| 7523  | 113FF    | Mississippi’s RoUS          |
| 7620  | 211      | Mississippi’s RoUS          |
| 7911  | 22       | Mississippi’s RoUS          |
| 8114  | 321      | Mississippi’s RoUS          |
| 8214  | 327      | Mississippi’s RoUS          |
| 8410  | 332      | Mississippi’s RoUS          |
| 8520  | 333      | Mississippi’s RoUS          |
| 8623  | 334      | Mississippi’s RoUS          |
| 8722  | 335      | Mississippi’s RoUS          |
| 8816  | 3361MV   | Mississippi’s RoUS          |
| 8918  | 3364OT   | Mississippi’s RoUS          |
| 9023  | 337      | Mississippi’s RoUS          |
| 9319  | 313TT    | Mississippi’s RoUS          |
| 9424  | 315AL    | Mississippi’s RoUS          |
| 965   | 323      | Mississippi’s RoUS          |
| 1397  | 81       | Mississippi’s RoUS          |
| 14524 | Used     | Mississippi’s RoUS          |
| 14624 | Other    | Mississippi’s RoUS          |
| 7213  | Used     | Missouri                    |
| 7320  | Other    | Missouri                    |
| 7524  | 113FF    | Missouri’s RoUS             |
| 7621  | 211      | Missouri’s RoUS             |
| 8115  | 321      | Missouri’s RoUS             |
| 8521  | 333      | Missouri’s RoUS             |
| 8624  | 334      | Missouri’s RoUS             |
| 8723  | 335      | Missouri’s RoUS             |
| 8919  | 3364OT   | Missouri’s RoUS             |
| 9024  | 337      | Missouri’s RoUS             |
| 9320  | 313TT    | Missouri’s RoUS             |
| 9425  | 315AL    | Missouri’s RoUS             |
| 14525 | Used     | Missouri’s RoUS             |
| 14625 | Other    | Missouri’s RoUS             |
| 749   | 111CA    | Montana’s RoUS              |
| 7525  | 113FF    | Montana’s RoUS              |
| 7622  | 211      | Montana’s RoUS              |
| 7912  | 22       | Montana’s RoUS              |
| 8116  | 321      | Montana’s RoUS              |
| 8215  | 327      | Montana’s RoUS              |
| 8411  | 332      | Montana’s RoUS              |
| 8522  | 333      | Montana’s RoUS              |
| 8625  | 334      | Montana’s RoUS              |
| 8724  | 335      | Montana’s RoUS              |
| 8817  | 3361MV   | Montana’s RoUS              |
| 8920  | 3364OT   | Montana’s RoUS              |
| 9025  | 337      | Montana’s RoUS              |
| 9321  | 313TT    | Montana’s RoUS              |
| 9426  | 315AL    | Montana’s RoUS              |
| 966   | 323      | Montana’s RoUS              |
| 996   | 326      | Montana’s RoUS              |
| 1398  | 81       | Montana’s RoUS              |
| 14526 | Used     | Montana’s RoUS              |
| 14626 | Other    | Montana’s RoUS              |
| 7623  | 211      | Nebraska’s RoUS             |
| 7913  | 22       | Nebraska’s RoUS             |
| 8117  | 321      | Nebraska’s RoUS             |
| 8216  | 327      | Nebraska’s RoUS             |
| 8412  | 332      | Nebraska’s RoUS             |
| 8523  | 333      | Nebraska’s RoUS             |
| 8626  | 334      | Nebraska’s RoUS             |
| 8725  | 335      | Nebraska’s RoUS             |
| 8818  | 3361MV   | Nebraska’s RoUS             |
| 8921  | 3364OT   | Nebraska’s RoUS             |
| 9026  | 337      | Nebraska’s RoUS             |
| 9322  | 313TT    | Nebraska’s RoUS             |
| 9427  | 315AL    | Nebraska’s RoUS             |
| 1399  | 81       | Nebraska’s RoUS             |
| 14527 | Used     | Nebraska’s RoUS             |
| 14627 | Other    | Nebraska’s RoUS             |
| 7321  | Other    | Nevada                      |
| 7410  | 111CA    | Nevada’s RoUS               |
| 7526  | 113FF    | Nevada’s RoUS               |
| 7624  | 211      | Nevada’s RoUS               |
| 7914  | 22       | Nevada’s RoUS               |
| 8118  | 321      | Nevada’s RoUS               |
| 8217  | 327      | Nevada’s RoUS               |
| 8413  | 332      | Nevada’s RoUS               |
| 8524  | 333      | Nevada’s RoUS               |
| 8627  | 334      | Nevada’s RoUS               |
| 8726  | 335      | Nevada’s RoUS               |
| 8819  | 3361MV   | Nevada’s RoUS               |
| 8922  | 3364OT   | Nevada’s RoUS               |
| 9027  | 337      | Nevada’s RoUS               |
| 9323  | 313TT    | Nevada’s RoUS               |
| 9428  | 315AL    | Nevada’s RoUS               |
| 13910 | 81       | Nevada’s RoUS               |
| 14528 | Used     | Nevada’s RoUS               |
| 14628 | Other    | Nevada’s RoUS               |
| 7411  | 111CA    | New Hampshire’s RoUS        |
| 7527  | 113FF    | New Hampshire’s RoUS        |
| 7625  | 211      | New Hampshire’s RoUS        |
| 8119  | 321      | New Hampshire’s RoUS        |
| 8218  | 327      | New Hampshire’s RoUS        |
| 8414  | 332      | New Hampshire’s RoUS        |
| 8525  | 333      | New Hampshire’s RoUS        |
| 8628  | 334      | New Hampshire’s RoUS        |
| 8727  | 335      | New Hampshire’s RoUS        |
| 8820  | 3361MV   | New Hampshire’s RoUS        |
| 8923  | 3364OT   | New Hampshire’s RoUS        |
| 9028  | 337      | New Hampshire’s RoUS        |
| 9324  | 313TT    | New Hampshire’s RoUS        |
| 9429  | 315AL    | New Hampshire’s RoUS        |
| 967   | 323      | New Hampshire’s RoUS        |
| 997   | 326      | New Hampshire’s RoUS        |
| 13911 | 81       | New Hampshire’s RoUS        |
| 14529 | Used     | New Hampshire’s RoUS        |
| 14629 | Other    | New Hampshire’s RoUS        |
| 7214  | Used     | New Jersey                  |
| 7322  | Other    | New Jersey                  |
| 7528  | 113FF    | New Jersey’s RoUS           |
| 7626  | 211      | New Jersey’s RoUS           |
| 8526  | 333      | New Jersey’s RoUS           |
| 8629  | 334      | New Jersey’s RoUS           |
| 8728  | 335      | New Jersey’s RoUS           |
| 8821  | 3361MV   | New Jersey’s RoUS           |
| 8924  | 3364OT   | New Jersey’s RoUS           |
| 9029  | 337      | New Jersey’s RoUS           |
| 9325  | 313TT    | New Jersey’s RoUS           |
| 9430  | 315AL    | New Jersey’s RoUS           |
| 14530 | Used     | New Jersey’s RoUS           |
| 14630 | Other    | New Jersey’s RoUS           |
| 7412  | 111CA    | New Mexico’s RoUS           |
| 7529  | 113FF    | New Mexico’s RoUS           |
| 7627  | 211      | New Mexico’s RoUS           |
| 8120  | 321      | New Mexico’s RoUS           |
| 8219  | 327      | New Mexico’s RoUS           |
| 8415  | 332      | New Mexico’s RoUS           |
| 8527  | 333      | New Mexico’s RoUS           |
| 8630  | 334      | New Mexico’s RoUS           |
| 8729  | 335      | New Mexico’s RoUS           |
| 8822  | 3361MV   | New Mexico’s RoUS           |
| 8925  | 3364OT   | New Mexico’s RoUS           |
| 9030  | 337      | New Mexico’s RoUS           |
| 9326  | 313TT    | New Mexico’s RoUS           |
| 9431  | 315AL    | New Mexico’s RoUS           |
| 968   | 323      | New Mexico’s RoUS           |
| 998   | 326      | New Mexico’s RoUS           |
| 13912 | 81       | New Mexico’s RoUS           |
| 14531 | Used     | New Mexico’s RoUS           |
| 14631 | Other    | New Mexico’s RoUS           |
| 7215  | Used     | New York                    |
| 7323  | Other    | New York                    |
| 7530  | 113FF    | New York’s RoUS             |
| 7628  | 211      | New York’s RoUS             |
| 8631  | 334      | New York’s RoUS             |
| 8730  | 335      | New York’s RoUS             |
| 8926  | 3364OT   | New York’s RoUS             |
| 9031  | 337      | New York’s RoUS             |
| 9432  | 315AL    | New York’s RoUS             |
| 14532 | Used     | New York’s RoUS             |
| 14632 | Other    | New York’s RoUS             |
| 7216  | Used     | North Carolina              |
| 7324  | Other    | North Carolina              |
| 7531  | 113FF    | North Carolina’s RoUS       |
| 7629  | 211      | North Carolina’s RoUS       |
| 8528  | 333      | North Carolina’s RoUS       |
| 8632  | 334      | North Carolina’s RoUS       |
| 8731  | 335      | North Carolina’s RoUS       |
| 9032  | 337      | North Carolina’s RoUS       |
| 9433  | 315AL    | North Carolina’s RoUS       |
| 14533 | Used     | North Carolina’s RoUS       |
| 14633 | Other    | North Carolina’s RoUS       |
| 7413  | 111CA    | North Dakota’s RoUS         |
| 7532  | 113FF    | North Dakota’s RoUS         |
| 7630  | 211      | North Dakota’s RoUS         |
| 8121  | 321      | North Dakota’s RoUS         |
| 8220  | 327      | North Dakota’s RoUS         |
| 8416  | 332      | North Dakota’s RoUS         |
| 8529  | 333      | North Dakota’s RoUS         |
| 8633  | 334      | North Dakota’s RoUS         |
| 8732  | 335      | North Dakota’s RoUS         |
| 8823  | 3361MV   | North Dakota’s RoUS         |
| 8927  | 3364OT   | North Dakota’s RoUS         |
| 9033  | 337      | North Dakota’s RoUS         |
| 9327  | 313TT    | North Dakota’s RoUS         |
| 9434  | 315AL    | North Dakota’s RoUS         |
| 969   | 323      | North Dakota’s RoUS         |
| 999   | 326      | North Dakota’s RoUS         |
| 13913 | 81       | North Dakota’s RoUS         |
| 14534 | Used     | North Dakota’s RoUS         |
| 14634 | Other    | North Dakota’s RoUS         |
| 7217  | Used     | Ohio                        |
| 7325  | Other    | Ohio                        |
| 7533  | 113FF    | Ohio’s RoUS                 |
| 8634  | 334      | Ohio’s RoUS                 |
| 8733  | 335      | Ohio’s RoUS                 |
| 9034  | 337      | Ohio’s RoUS                 |
| 9435  | 315AL    | Ohio’s RoUS                 |
| 14535 | Used     | Ohio’s RoUS                 |
| 14635 | Other    | Ohio’s RoUS                 |
| 7326  | Other    | Oklahoma                    |
| 7414  | 111CA    | Oklahoma’s RoUS             |
| 7534  | 113FF    | Oklahoma’s RoUS             |
| 7631  | 211      | Oklahoma’s RoUS             |
| 7915  | 22       | Oklahoma’s RoUS             |
| 8122  | 321      | Oklahoma’s RoUS             |
| 8221  | 327      | Oklahoma’s RoUS             |
| 8417  | 332      | Oklahoma’s RoUS             |
| 8530  | 333      | Oklahoma’s RoUS             |
| 8635  | 334      | Oklahoma’s RoUS             |
| 8734  | 335      | Oklahoma’s RoUS             |
| 8824  | 3361MV   | Oklahoma’s RoUS             |
| 8928  | 3364OT   | Oklahoma’s RoUS             |
| 9035  | 337      | Oklahoma’s RoUS             |
| 9328  | 313TT    | Oklahoma’s RoUS             |
| 9436  | 315AL    | Oklahoma’s RoUS             |
| 14536 | Used     | Oklahoma’s RoUS             |
| 14636 | Other    | Oklahoma’s RoUS             |
| 7218  | Used     | Oregon                      |
| 7327  | Other    | Oregon                      |
| 7535  | 113FF    | Oregon’s RoUS               |
| 7632  | 211      | Oregon’s RoUS               |
| 7916  | 22       | Oregon’s RoUS               |
| 8123  | 321      | Oregon’s RoUS               |
| 8222  | 327      | Oregon’s RoUS               |
| 8418  | 332      | Oregon’s RoUS               |
| 8531  | 333      | Oregon’s RoUS               |
| 8636  | 334      | Oregon’s RoUS               |
| 8735  | 335      | Oregon’s RoUS               |
| 8825  | 3361MV   | Oregon’s RoUS               |
| 8929  | 3364OT   | Oregon’s RoUS               |
| 9036  | 337      | Oregon’s RoUS               |
| 9329  | 313TT    | Oregon’s RoUS               |
| 9437  | 315AL    | Oregon’s RoUS               |
| 14537 | Used     | Oregon’s RoUS               |
| 14637 | Other    | Oregon’s RoUS               |
| 7219  | Used     | Pennsylvania                |
| 7328  | Other    | Pennsylvania                |
| 7536  | 113FF    | Pennsylvania’s RoUS         |
| 8637  | 334      | Pennsylvania’s RoUS         |
| 8736  | 335      | Pennsylvania’s RoUS         |
| 9037  | 337      | Pennsylvania’s RoUS         |
| 9438  | 315AL    | Pennsylvania’s RoUS         |
| 14538 | Used     | Pennsylvania’s RoUS         |
| 14638 | Other    | Pennsylvania’s RoUS         |
| 7415  | 111CA    | Rhode Island’s RoUS         |
| 7537  | 113FF    | Rhode Island’s RoUS         |
| 7633  | 211      | Rhode Island’s RoUS         |
| 8124  | 321      | Rhode Island’s RoUS         |
| 8223  | 327      | Rhode Island’s RoUS         |
| 8419  | 332      | Rhode Island’s RoUS         |
| 8532  | 333      | Rhode Island’s RoUS         |
| 8638  | 334      | Rhode Island’s RoUS         |
| 8737  | 335      | Rhode Island’s RoUS         |
| 8826  | 3361MV   | Rhode Island’s RoUS         |
| 8930  | 3364OT   | Rhode Island’s RoUS         |
| 9038  | 337      | Rhode Island’s RoUS         |
| 9330  | 313TT    | Rhode Island’s RoUS         |
| 9439  | 315AL    | Rhode Island’s RoUS         |
| 9610  | 323      | Rhode Island’s RoUS         |
| 9910  | 326      | Rhode Island’s RoUS         |
| 13914 | 81       | Rhode Island’s RoUS         |
| 14539 | Used     | Rhode Island’s RoUS         |
| 14639 | Other    | Rhode Island’s RoUS         |
| 7220  | Used     | South Carolina              |
| 7329  | Other    | South Carolina              |
| 7538  | 113FF    | South Carolina’s RoUS       |
| 7634  | 211      | South Carolina’s RoUS       |
| 8224  | 327      | South Carolina’s RoUS       |
| 8533  | 333      | South Carolina’s RoUS       |
| 8639  | 334      | South Carolina’s RoUS       |
| 8738  | 335      | South Carolina’s RoUS       |
| 8931  | 3364OT   | South Carolina’s RoUS       |
| 9039  | 337      | South Carolina’s RoUS       |
| 9331  | 313TT    | South Carolina’s RoUS       |
| 9440  | 315AL    | South Carolina’s RoUS       |
| 14540 | Used     | South Carolina’s RoUS       |
| 14640 | Other    | South Carolina’s RoUS       |
| 7416  | 111CA    | South Dakota’s RoUS         |
| 7539  | 113FF    | South Dakota’s RoUS         |
| 7635  | 211      | South Dakota’s RoUS         |
| 8125  | 321      | South Dakota’s RoUS         |
| 8225  | 327      | South Dakota’s RoUS         |
| 8420  | 332      | South Dakota’s RoUS         |
| 8534  | 333      | South Dakota’s RoUS         |
| 8640  | 334      | South Dakota’s RoUS         |
| 8739  | 335      | South Dakota’s RoUS         |
| 8827  | 3361MV   | South Dakota’s RoUS         |
| 8932  | 3364OT   | South Dakota’s RoUS         |
| 9040  | 337      | South Dakota’s RoUS         |
| 9332  | 313TT    | South Dakota’s RoUS         |
| 9441  | 315AL    | South Dakota’s RoUS         |
| 9611  | 323      | South Dakota’s RoUS         |
| 9911  | 326      | South Dakota’s RoUS         |
| 13915 | 81       | South Dakota’s RoUS         |
| 14541 | Used     | South Dakota’s RoUS         |
| 14641 | Other    | South Dakota’s RoUS         |
| 7221  | Used     | Tennessee                   |
| 7330  | Other    | Tennessee                   |
| 7540  | 113FF    | Tennessee’s RoUS            |
| 7636  | 211      | Tennessee’s RoUS            |
| 8226  | 327      | Tennessee’s RoUS            |
| 8535  | 333      | Tennessee’s RoUS            |
| 8641  | 334      | Tennessee’s RoUS            |
| 8740  | 335      | Tennessee’s RoUS            |
| 8933  | 3364OT   | Tennessee’s RoUS            |
| 9041  | 337      | Tennessee’s RoUS            |
| 9333  | 313TT    | Tennessee’s RoUS            |
| 9442  | 315AL    | Tennessee’s RoUS            |
| 14542 | Used     | Tennessee’s RoUS            |
| 14642 | Other    | Tennessee’s RoUS            |
| 7222  | Used     | Texas                       |
| 7331  | Other    | Texas                       |
| 9443  | 315AL    | Texas’s RoUS                |
| 14543 | Used     | Texas’s RoUS                |
| 14643 | Other    | Texas’s RoUS                |
| 7332  | Other    | Utah                        |
| 7417  | 111CA    | Utah’s RoUS                 |
| 7541  | 113FF    | Utah’s RoUS                 |
| 7637  | 211      | Utah’s RoUS                 |
| 7917  | 22       | Utah’s RoUS                 |
| 8126  | 321      | Utah’s RoUS                 |
| 8227  | 327      | Utah’s RoUS                 |
| 8421  | 332      | Utah’s RoUS                 |
| 8536  | 333      | Utah’s RoUS                 |
| 8642  | 334      | Utah’s RoUS                 |
| 8741  | 335      | Utah’s RoUS                 |
| 8828  | 3361MV   | Utah’s RoUS                 |
| 8934  | 3364OT   | Utah’s RoUS                 |
| 9042  | 337      | Utah’s RoUS                 |
| 9334  | 313TT    | Utah’s RoUS                 |
| 9444  | 315AL    | Utah’s RoUS                 |
| 13916 | 81       | Utah’s RoUS                 |
| 14544 | Used     | Utah’s RoUS                 |
| 14644 | Other    | Utah’s RoUS                 |
| 7418  | 111CA    | Vermont’s RoUS              |
| 7542  | 113FF    | Vermont’s RoUS              |
| 7638  | 211      | Vermont’s RoUS              |
| 7918  | 22       | Vermont’s RoUS              |
| 8127  | 321      | Vermont’s RoUS              |
| 8228  | 327      | Vermont’s RoUS              |
| 8422  | 332      | Vermont’s RoUS              |
| 8537  | 333      | Vermont’s RoUS              |
| 8643  | 334      | Vermont’s RoUS              |
| 8742  | 335      | Vermont’s RoUS              |
| 8829  | 3361MV   | Vermont’s RoUS              |
| 8935  | 3364OT   | Vermont’s RoUS              |
| 9043  | 337      | Vermont’s RoUS              |
| 9335  | 313TT    | Vermont’s RoUS              |
| 9445  | 315AL    | Vermont’s RoUS              |
| 9612  | 323      | Vermont’s RoUS              |
| 9912  | 326      | Vermont’s RoUS              |
| 13917 | 81       | Vermont’s RoUS              |
| 14545 | Used     | Vermont’s RoUS              |
| 14645 | Other    | Vermont’s RoUS              |
| 7223  | Used     | Virginia                    |
| 7333  | Other    | Virginia                    |
| 7543  | 113FF    | Virginia’s RoUS             |
| 7639  | 211      | Virginia’s RoUS             |
| 8538  | 333      | Virginia’s RoUS             |
| 8644  | 334      | Virginia’s RoUS             |
| 8743  | 335      | Virginia’s RoUS             |
| 8830  | 3361MV   | Virginia’s RoUS             |
| 9044  | 337      | Virginia’s RoUS             |
| 9336  | 313TT    | Virginia’s RoUS             |
| 9446  | 315AL    | Virginia’s RoUS             |
| 14546 | Used     | Virginia’s RoUS             |
| 14646 | Other    | Virginia’s RoUS             |
| 7224  | Used     | Washington                  |
| 7334  | Other    | Washington                  |
| 7544  | 113FF    | Washington’s RoUS           |
| 7919  | 22       | Washington’s RoUS           |
| 8229  | 327      | Washington’s RoUS           |
| 8539  | 333      | Washington’s RoUS           |
| 8645  | 334      | Washington’s RoUS           |
| 8744  | 335      | Washington’s RoUS           |
| 8831  | 3361MV   | Washington’s RoUS           |
| 9045  | 337      | Washington’s RoUS           |
| 9337  | 313TT    | Washington’s RoUS           |
| 9447  | 315AL    | Washington’s RoUS           |
| 14547 | Used     | Washington’s RoUS           |
| 14647 | Other    | Washington’s RoUS           |
| 7419  | 111CA    | West Virginia’s RoUS        |
| 7545  | 113FF    | West Virginia’s RoUS        |
| 7640  | 211      | West Virginia’s RoUS        |
| 8128  | 321      | West Virginia’s RoUS        |
| 8230  | 327      | West Virginia’s RoUS        |
| 8423  | 332      | West Virginia’s RoUS        |
| 8540  | 333      | West Virginia’s RoUS        |
| 8646  | 334      | West Virginia’s RoUS        |
| 8745  | 335      | West Virginia’s RoUS        |
| 8832  | 3361MV   | West Virginia’s RoUS        |
| 8936  | 3364OT   | West Virginia’s RoUS        |
| 9046  | 337      | West Virginia’s RoUS        |
| 9338  | 313TT    | West Virginia’s RoUS        |
| 9448  | 315AL    | West Virginia’s RoUS        |
| 9613  | 323      | West Virginia’s RoUS        |
| 9913  | 326      | West Virginia’s RoUS        |
| 13918 | 81       | West Virginia’s RoUS        |
| 14548 | Used     | West Virginia’s RoUS        |
| 14648 | Other    | West Virginia’s RoUS        |
| 7225  | Used     | Wisconsin                   |
| 7335  | Other    | Wisconsin                   |
| 7641  | 211      | Wisconsin’s RoUS            |
| 8647  | 334      | Wisconsin’s RoUS            |
| 8746  | 335      | Wisconsin’s RoUS            |
| 8833  | 3361MV   | Wisconsin’s RoUS            |
| 8937  | 3364OT   | Wisconsin’s RoUS            |
| 9047  | 337      | Wisconsin’s RoUS            |
| 9339  | 313TT    | Wisconsin’s RoUS            |
| 9449  | 315AL    | Wisconsin’s RoUS            |
| 14549 | Used     | Wisconsin’s RoUS            |
| 14649 | Other    | Wisconsin’s RoUS            |
| 7420  | 111CA    | Wyoming’s RoUS              |
| 7546  | 113FF    | Wyoming’s RoUS              |
| 7642  | 211      | Wyoming’s RoUS              |
| 7920  | 22       | Wyoming’s RoUS              |
| 8129  | 321      | Wyoming’s RoUS              |
| 8231  | 327      | Wyoming’s RoUS              |
| 8424  | 332      | Wyoming’s RoUS              |
| 8541  | 333      | Wyoming’s RoUS              |
| 8648  | 334      | Wyoming’s RoUS              |
| 8747  | 335      | Wyoming’s RoUS              |
| 8834  | 3361MV   | Wyoming’s RoUS              |
| 8938  | 3364OT   | Wyoming’s RoUS              |
| 9048  | 337      | Wyoming’s RoUS              |
| 9340  | 313TT    | Wyoming’s RoUS              |
| 9450  | 315AL    | Wyoming’s RoUS              |
| 9614  | 323      | Wyoming’s RoUS              |
| 9914  | 326      | Wyoming’s RoUS              |
| 13919 | 81       | Wyoming’s RoUS              |
| 14550 | Used     | Wyoming’s RoUS              |
| 14650 | Other    | Wyoming’s RoUS              |

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
