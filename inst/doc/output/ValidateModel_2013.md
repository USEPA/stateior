This document presents validation results of 2013 summary-level state IO
model.

### Prepare data

#### 0\. Load state and two-region IO data.

2022-03-01 19:40:26 <INFO::State_Summary_Make_2013_0.1.0.rds> not found
in local folder, downloading from Data Commons… 2022-03-01 19:40:29
<INFO::State_Summary_Use_2013_0.1.0.rds> not found in local folder,
downloading from Data Commons… 2022-03-01 19:40:31
<INFO::State_Summary_DomesticUse_2013_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 19:40:33
<INFO::State_Summary_IndustryOutput_2013_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 19:40:36
<INFO::State_Summary_CommodityOutput_2013_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 19:40:38
<INFO::TwoRegion_Summary_DomesticUsewithTrade_2013_0.1.0.rds> not found
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

There are 58 failures, and they are

|    | Commodity |                            |
| -- | :-------- | -------------------------- |
| 1  | 111CA     | colSums(US\_Summary\_Make) |
| 2  | 113FF     | colSums(US\_Summary\_Make) |
| 3  | 211       | colSums(US\_Summary\_Make) |
| 4  | 212       | colSums(US\_Summary\_Make) |
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
| 30 | 452       | colSums(US\_Summary\_Make) |
| 31 | 4A0       | colSums(US\_Summary\_Make) |
| 32 | 481       | colSums(US\_Summary\_Make) |
| 33 | 482       | colSums(US\_Summary\_Make) |
| 34 | 483       | colSums(US\_Summary\_Make) |
| 35 | 484       | colSums(US\_Summary\_Make) |
| 36 | 485       | colSums(US\_Summary\_Make) |
| 38 | 487OS     | colSums(US\_Summary\_Make) |
| 39 | 493       | colSums(US\_Summary\_Make) |
| 40 | 511       | colSums(US\_Summary\_Make) |
| 41 | 512       | colSums(US\_Summary\_Make) |
| 42 | 513       | colSums(US\_Summary\_Make) |
| 43 | 514       | colSums(US\_Summary\_Make) |
| 45 | 523       | colSums(US\_Summary\_Make) |
| 46 | 524       | colSums(US\_Summary\_Make) |
| 49 | ORE       | colSums(US\_Summary\_Make) |
| 50 | 532RL     | colSums(US\_Summary\_Make) |
| 51 | 5411      | colSums(US\_Summary\_Make) |
| 52 | 5415      | colSums(US\_Summary\_Make) |
| 53 | 5412OP    | colSums(US\_Summary\_Make) |
| 54 | 55        | colSums(US\_Summary\_Make) |
| 55 | 561       | colSums(US\_Summary\_Make) |
| 57 | 61        | colSums(US\_Summary\_Make) |
| 58 | 621       | colSums(US\_Summary\_Make) |
| 61 | 624       | colSums(US\_Summary\_Make) |
| 63 | 713       | colSums(US\_Summary\_Make) |
| 64 | 721       | colSums(US\_Summary\_Make) |
| 65 | 722       | colSums(US\_Summary\_Make) |
| 66 | 81        | colSums(US\_Summary\_Make) |
| 72 | Used      | colSums(US\_Summary\_Make) |

#### 6\. Sum of each commodity’s output across all states must almost equal (\<= 1.11^7, or $11.1 million by commodity) commodity output in US Use Table minus International Imports (commodity specific). Even if the threshold is met, track the difference for each commodity. Save result as a type of quality control check

There are 8 failures, and they are

|    | Commodity |                                   |
| -- | :-------- | --------------------------------- |
| 4  | 212       | rowSums(US\_Summary\_DomesticUse) |
| 27 | 42        | rowSums(US\_Summary\_DomesticUse) |
| 32 | 481       | rowSums(US\_Summary\_DomesticUse) |
| 33 | 482       | rowSums(US\_Summary\_DomesticUse) |
| 34 | 483       | rowSums(US\_Summary\_DomesticUse) |
| 35 | 484       | rowSums(US\_Summary\_DomesticUse) |
| 38 | 487OS     | rowSums(US\_Summary\_DomesticUse) |
| 46 | 524       | rowSums(US\_Summary\_DomesticUse) |

#### 7\. All cells that are zero in US Make table must remain zero in state Make tables. Find zero values in US Make table.

There are no failures.

#### 8\. Sum of each cell across all state Use tables must almost equal (\<= 0.001) the same cell in US Use table. This validates that Total state demand == Total national demand.

Note: failures associated with ‘F050 - Imports’ are acceptable. Because
state imports are not directly derived from US imports, a gap in imports
between state sum and national total is reasonable. \#\#\#\#\# 7.1 State
Use tables There are 42 failures, and they are

| Commodity | Industry/Final Demand |
| :-------- | :-------------------- |
| 113FF     | F050                  |
| 211       | F050                  |
| 212       | F050                  |
| 22        | F050                  |
| 321       | F050                  |
| 327       | F050                  |
| 332       | F050                  |
| 333       | F050                  |
| 334       | F050                  |
| 335       | F050                  |
| 3361MV    | F050                  |
| 3364OT    | F050                  |
| 337       | F050                  |
| 339       | F050                  |
| 311FT     | F050                  |
| 315AL     | F050                  |
| 322       | F050                  |
| 323       | F050                  |
| 324       | F050                  |
| 325       | F050                  |
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
| 5412OP    | F050                  |
| 561       | F050                  |
| 562       | F050                  |
| 711AS     | F050                  |
| 81        | F050                  |
| GFE       | F050                  |
| Used      | F050                  |
| Other     | F050                  |

##### 7.2 State Domestic Use tables

There are no failures.

### Check two-region model results

#### 9\. If SoI commodity output == 0, SoI2SoI ICF ratio == 0

2022-03-01 19:40:43 <INFO::FAF_2013_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 19:40:45
<INFO::Loading> State\_Employment\_2009\_2018\_0.1.0.rds from local
folder … 2022-03-01 19:40:45 <INFO::file> not found, downloading from
<https://edap-ord-data-commons.s3.amazonaws.com/flowsa/FlowBySector>
2022-03-01 19:40:50 <INFO::Loading>
EIA\_SEDS\_CodeDescription\_0.1.0.rds from local folder … 2022-03-01
19:40:51 <INFO::EIA_SEDS_StateElectricityConsumption_2013_0.1.0.rds> not
found in local folder, downloading from Data Commons… 2022-03-01
19:40:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:40:54 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:40:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:40:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:40:57 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:40:58 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:41:01 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:41:02 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:05 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:06 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:07 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:41:11 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:41:11 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:14 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:15 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:16 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:17 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:41:20 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:41:21 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:21 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:22 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:23 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:24 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:25 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:26 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:41:29 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:41:30 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:31 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:32 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:32 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:34 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:35 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:41:39 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:41:39 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:41 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:44 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:45 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:41:48 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:41:49 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:53 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:54 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:41:57 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:41:58 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:41:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:41:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:02 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:03 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:42:06 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:42:07 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:10 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:11 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:42:15 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:42:16 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:16 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:19 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:20 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:42:24 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:42:24 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:25 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:28 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:29 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:42:32 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:42:32 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:36 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:37 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:42:40 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:42:41 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:44 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:45 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:46 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:42:49 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:42:50 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:42:53 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:54 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:42:58 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:42:58 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:42:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:02 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:03 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:43:06 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:43:07 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:10 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:11 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:43:15 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:43:15 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:16 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:19 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:20 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:43:23 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:43:24 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:25 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:28 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:29 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:43:32 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:43:33 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:36 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:37 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:43:41 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:43:41 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:44 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:44 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:45 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:46 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:43:50 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:43:51 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:54 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:43:56 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:43:57 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:44:01 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:44:02 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:05 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:07 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:08 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:44:11 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:44:12 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:14 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:15 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:16 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:17 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:18 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:44:22 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:44:23 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:24 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:25 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:28 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:29 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:44:33 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:44:34 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:39 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:40 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:44:43 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:44:44 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:45 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:46 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:49 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:50 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:44:54 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:44:55 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:44:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:57 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:44:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:00 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:01 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:45:05 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:45:06 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:07 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:11 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:12 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:45:16 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:45:17 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:21 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:22 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:23 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:45:26 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:45:27 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:31 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:32 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:34 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:45:37 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:45:38 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:41 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:44 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:45 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:45:49 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:45:50 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:54 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:45:55 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:45:56 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:46:00 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:46:01 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:02 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:05 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:06 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:07 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:46:11 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:46:12 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:14 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:15 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:16 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:17 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:46:20 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:46:21 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:22 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:23 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:24 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:24 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:25 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:26 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:46:30 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:46:30 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:31 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:32 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:35 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:36 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:46:39 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:46:40 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:41 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:44 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:45 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:46:49 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:46:49 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:46:54 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:46:55 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:46:58 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:46:59 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:02 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:03 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:04 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:47:08 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:47:08 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:12 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:14 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:47:17 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:47:18 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:21 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:22 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:23 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:47:27 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:47:27 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:31 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:31 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:33 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:47:36 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:47:37 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:41 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:42 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:43 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:47:46 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:47:47 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:49 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:49 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:51 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:52 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:47:56 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:47:57 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:47:57 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:47:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:01 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:02 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:48:05 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:48:06 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:07 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:10 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:12 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:48:15 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:48:16 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:20 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:21 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:48:25 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:48:25 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:30 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:31 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:48:35 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:48:35 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:40 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:41 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:48:44 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:48:45 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:46 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:49 <INFO::Loading> FAF\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:50 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:48:54 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:48:55 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2013\_0.1.0.rds from local
folder … 2022-03-01 19:48:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:57 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …
2022-03-01 19:48:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2013\_0.1.0.rds from local folder …

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
