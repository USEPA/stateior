This document presents validation results of 2012 summary-level state IO
model.

### Prepare data

#### 0\. Load state and two-region IO data.

2022-03-01 19:30:40 <INFO::State_Summary_Make_2012_0.1.0.rds> not found
in local folder, downloading from Data Commons… 2022-03-01 19:30:43
<INFO::State_Summary_Use_2012_0.1.0.rds> not found in local folder,
downloading from Data Commons… 2022-03-01 19:30:46
<INFO::State_Summary_DomesticUse_2012_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 19:30:49
<INFO::State_Summary_IndustryOutput_2012_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 19:30:52
<INFO::State_Summary_CommodityOutput_2012_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 19:30:55
<INFO::TwoRegion_Summary_DomesticUsewithTrade_2012_0.1.0.rds> not found
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
Use tables There are 45 failures, and they are

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

##### 7.2 State Domestic Use tables

There are no failures.

### Check two-region model results

#### 9\. If SoI commodity output == 0, SoI2SoI ICF ratio == 0

2022-03-01 19:31:00 <INFO::FAF_2012_0.1.0.rds> not found in local
folder, downloading from Data Commons… 2022-03-01 19:31:04
<INFO::State_Employment_2009_2018_0.1.0.rds> not found in local folder,
downloading from Data Commons… 2022-03-01 19:31:06 <INFO::file> not
found, downloading from
<https://edap-ord-data-commons.s3.amazonaws.com/flowsa/FlowBySector>
2022-03-01 19:31:11 <INFO::EIA_SEDS_CodeDescription_0.1.0.rds> not found
in local folder, downloading from Data Commons… 2022-03-01 19:31:14
<INFO::EIA_SEDS_StateElectricityConsumption_2012_0.1.0.rds> not found in
local folder, downloading from Data Commons… 2022-03-01 19:31:16
<INFO::Loading> State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from
local folder … 2022-03-01 19:31:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:21 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:31:22 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:31:26 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:31:26 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:31:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:31 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:31:32 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:31:36 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:31:37 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:31:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:41 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:42 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:31:43 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:31:47 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:31:47 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:31:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:49 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:31:52 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:31:53 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:31:57 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:31:58 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:31:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:02 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:04 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:32:07 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:32:08 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:13 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:14 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:32:18 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:32:19 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:21 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:22 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:23 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:24 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:32:28 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:32:28 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:31 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:32 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:33 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:34 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:32:38 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:32:38 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:41 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:43 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:45 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:32:48 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:32:49 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:32:54 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:32:55 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:32:59 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:33:00 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:02 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:04 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:05 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:33:09 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:33:10 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:14 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:15 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:16 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:33:20 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:33:21 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:22 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:23 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:24 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:25 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:26 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:28 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:33:32 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:33:33 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:37 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:38 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:33:42 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:33:43 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:44 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:44 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:45 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:46 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:47 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:48 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:33:52 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:33:53 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:54 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:33:57 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:33:58 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:34:02 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:34:03 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:05 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:07 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:09 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:34:12 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:34:13 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:14 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:15 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:16 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:17 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:19 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:34:22 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:34:23 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:24 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:25 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:28 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:29 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:34:32 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:34:33 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:38 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:39 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:34:43 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:34:44 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:45 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:46 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:48 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:50 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:34:53 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:34:54 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:34:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:57 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:34:59 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:00 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:35:04 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:35:05 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:07 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:10 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:11 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:35:15 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:35:16 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:16 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:20 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:21 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:35:25 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:35:26 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:31 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:32 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:35:36 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:35:36 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:41 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:42 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:35:46 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:35:47 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:49 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:52 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:53 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:35:57 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:35:57 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:35:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:35:59 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:02 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:03 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:36:07 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:36:07 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:09 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:12 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:13 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:36:17 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:36:18 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:20 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:21 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:22 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:23 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:24 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:36:28 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:36:29 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:30 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:31 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:32 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:34 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:35 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:36:39 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:36:39 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:41 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:42 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:43 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:44 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:46 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:36:49 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:36:50 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:52 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:53 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:54 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:36:55 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:36:56 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:37:00 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:37:01 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:02 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:05 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:06 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:07 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:37:10 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:37:11 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:14 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:14 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:15 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:17 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:37:20 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:37:21 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:22 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:23 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:24 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:25 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:26 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:28 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:37:31 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:37:32 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:37 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:38 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:37:42 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:37:43 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:44 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:45 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:46 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:48 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:49 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:37:53 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:37:54 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:54 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:57 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:37:58 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:37:59 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:38:03 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:38:04 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:05 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:08 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:09 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:10 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:38:14 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:38:15 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:16 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:17 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:18 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:19 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:19 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:21 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:38:24 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:38:25 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:26 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:27 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:28 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:29 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:30 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:32 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:38:35 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:38:36 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:37 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:38 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:39 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:40 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:41 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:42 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:38:46 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:38:47 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:48 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:49 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:50 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:51 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:38:52 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:53 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:38:57 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:38:58 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:38:58 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:00 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:01 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:03 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:04 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:39:08 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:39:09 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:10 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:11 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:12 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:13 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:14 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:15 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:39:19 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:39:20 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:21 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:22 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:24 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:25 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:27 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:28 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:39:31 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:39:32 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:33 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:34 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:35 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:36 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:37 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:38 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:39:41 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:39:43 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:44 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:45 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:46 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:47 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:47 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:49 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:39:52 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:39:53 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:54 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:55 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:56 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:39:57 <INFO::Loading> FAF\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:39:58 <INFO::Loading>
State\_Employment\_2009\_2018\_0.1.0.rds from local folder … 2022-03-01
19:40:02 <INFO::Loading> EIA\_SEDS\_CodeDescription\_0.1.0.rds from
local folder … 2022-03-01 19:40:03 <INFO::Loading>
EIA\_SEDS\_StateElectricityConsumption\_2012\_0.1.0.rds from local
folder … 2022-03-01 19:40:03 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:40:04 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:40:05 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …
2022-03-01 19:40:06 <INFO::Loading>
State\_Summary\_CommodityOutput\_2012\_0.1.0.rds from local folder …

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
