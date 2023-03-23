This document presents validation results of 2017 summary-level state IO
model.

### Prepare data

#### 0. Load data

2017 US IO data for states successfully loaded.

2017 single-region IO data for states successfully loaded.

2017 two region IO data for states successfully loaded.

### Check state IO tables

#### 1. Check if industry output from state Make and Use are almost equal (\<= 0.01).

There are no failures.

#### 2. Check commodity output

#### 2.1. Check if commodity output from state Make and Use are almost equal (relative difference \<= 0.01).

There are 3644 failures, and they are

|      | Commodity | Relative Diff | Validation               | State                |
|------|:----------|--------------:|:-------------------------|:---------------------|
| 1    | 111CA     |         -0.19 | abs(result) \< tolerance | Alabama              |
| 2    | 113FF     |          0.37 | abs(result) \< tolerance | Alabama              |
| 3    | 211       |          3.81 | abs(result) \< tolerance | Alabama              |
| 4    | 212       |          0.04 | abs(result) \< tolerance | Alabama              |
| 5    | 213       |          0.04 | abs(result) \< tolerance | Alabama              |
| 6    | 22        |         -0.30 | abs(result) \< tolerance | Alabama              |
| 7    | 23        |          0.07 | abs(result) \< tolerance | Alabama              |
| 8    | 321       |         -0.49 | abs(result) \< tolerance | Alabama              |
| 9    | 327       |         -0.22 | abs(result) \< tolerance | Alabama              |
| 10   | 331       |         -0.53 | abs(result) \< tolerance | Alabama              |
| 11   | 332       |         -0.12 | abs(result) \< tolerance | Alabama              |
| 12   | 333       |          0.23 | abs(result) \< tolerance | Alabama              |
| 13   | 334       |          0.84 | abs(result) \< tolerance | Alabama              |
| 14   | 335       |         -0.05 | abs(result) \< tolerance | Alabama              |
| 15   | 3361MV    |         -0.13 | abs(result) \< tolerance | Alabama              |
| 16   | 3364OT    |         -0.21 | abs(result) \< tolerance | Alabama              |
| 17   | 337       |         -0.47 | abs(result) \< tolerance | Alabama              |
| 18   | 339       |          0.23 | abs(result) \< tolerance | Alabama              |
| 19   | 311FT     |          0.20 | abs(result) \< tolerance | Alabama              |
| 20   | 313TT     |         -0.29 | abs(result) \< tolerance | Alabama              |
| 21   | 315AL     |          0.06 | abs(result) \< tolerance | Alabama              |
| 22   | 322       |         -0.54 | abs(result) \< tolerance | Alabama              |
| 23   | 323       |          0.52 | abs(result) \< tolerance | Alabama              |
| 24   | 324       |          0.05 | abs(result) \< tolerance | Alabama              |
| 25   | 325       |          0.28 | abs(result) \< tolerance | Alabama              |
| 26   | 326       |         -0.18 | abs(result) \< tolerance | Alabama              |
| 27   | 42        |          0.31 | abs(result) \< tolerance | Alabama              |
| 28   | 441       |          0.47 | abs(result) \< tolerance | Alabama              |
| 29   | 445       |          0.15 | abs(result) \< tolerance | Alabama              |
| 30   | 452       |         -0.42 | abs(result) \< tolerance | Alabama              |
| 31   | 4A0       |         -0.05 | abs(result) \< tolerance | Alabama              |
| 32   | 481       |          4.60 | abs(result) \< tolerance | Alabama              |
| 33   | 482       |          0.06 | abs(result) \< tolerance | Alabama              |
| 34   | 483       |          0.23 | abs(result) \< tolerance | Alabama              |
| 35   | 484       |         -0.10 | abs(result) \< tolerance | Alabama              |
| 36   | 485       |          1.91 | abs(result) \< tolerance | Alabama              |
| 37   | 486       |          0.09 | abs(result) \< tolerance | Alabama              |
| 38   | 487OS     |          0.08 | abs(result) \< tolerance | Alabama              |
| 39   | 493       |          0.26 | abs(result) \< tolerance | Alabama              |
| 40   | 511       |          0.68 | abs(result) \< tolerance | Alabama              |
| 41   | 512       |          2.69 | abs(result) \< tolerance | Alabama              |
| 42   | 513       |          0.61 | abs(result) \< tolerance | Alabama              |
| 43   | 514       |          3.96 | abs(result) \< tolerance | Alabama              |
| 44   | 521CI     |         -0.10 | abs(result) \< tolerance | Alabama              |
| 45   | 523       |          1.29 | abs(result) \< tolerance | Alabama              |
| 46   | 524       |          0.26 | abs(result) \< tolerance | Alabama              |
| 47   | 525       |          2.86 | abs(result) \< tolerance | Alabama              |
| 48   | HS        |         -0.04 | abs(result) \< tolerance | Alabama              |
| 49   | ORE       |          0.83 | abs(result) \< tolerance | Alabama              |
| 50   | 532RL     |          0.16 | abs(result) \< tolerance | Alabama              |
| 51   | 5411      |          0.12 | abs(result) \< tolerance | Alabama              |
| 52   | 5415      |          0.05 | abs(result) \< tolerance | Alabama              |
| 53   | 5412OP    |          0.33 | abs(result) \< tolerance | Alabama              |
| 54   | 55        |          0.99 | abs(result) \< tolerance | Alabama              |
| 55   | 561       |          0.06 | abs(result) \< tolerance | Alabama              |
| 56   | 562       |          0.07 | abs(result) \< tolerance | Alabama              |
| 57   | 61        |          0.75 | abs(result) \< tolerance | Alabama              |
| 58   | 621       |         -0.02 | abs(result) \< tolerance | Alabama              |
| 59   | 622       |          0.44 | abs(result) \< tolerance | Alabama              |
| 60   | 623       |          0.19 | abs(result) \< tolerance | Alabama              |
| 61   | 624       |          1.07 | abs(result) \< tolerance | Alabama              |
| 62   | 711AS     |          1.62 | abs(result) \< tolerance | Alabama              |
| 63   | 713       |          0.45 | abs(result) \< tolerance | Alabama              |
| 64   | 721       |          0.75 | abs(result) \< tolerance | Alabama              |
| 65   | 722       |          0.02 | abs(result) \< tolerance | Alabama              |
| 66   | 81        |          0.02 | abs(result) \< tolerance | Alabama              |
| 67   | GFGD      |         -0.61 | abs(result) \< tolerance | Alabama              |
| 68   | GFGN      |         -0.02 | abs(result) \< tolerance | Alabama              |
| 69   | GFE       |         -0.47 | abs(result) \< tolerance | Alabama              |
| 70   | GSLG      |         -0.07 | abs(result) \< tolerance | Alabama              |
| 71   | GSLE      |         -0.03 | abs(result) \< tolerance | Alabama              |
| 72   | Used      |         -3.65 | abs(result) \< tolerance | Alabama              |
| 73   | Other     |         16.17 | abs(result) \< tolerance | Alabama              |
| 74   | 111CA     |         25.78 | abs(result) \< tolerance | Alaska               |
| 75   | 113FF     |         -0.78 | abs(result) \< tolerance | Alaska               |
| 76   | 211       |         -0.69 | abs(result) \< tolerance | Alaska               |
| 77   | 212       |         -0.39 | abs(result) \< tolerance | Alaska               |
| 78   | 213       |          0.09 | abs(result) \< tolerance | Alaska               |
| 79   | 22        |         -0.05 | abs(result) \< tolerance | Alaska               |
| 80   | 23        |          0.17 | abs(result) \< tolerance | Alaska               |
| 81   | 321       |          0.52 | abs(result) \< tolerance | Alaska               |
| 82   | 327       |          1.45 | abs(result) \< tolerance | Alaska               |
| 83   | 331       |         31.80 | abs(result) \< tolerance | Alaska               |
| 84   | 332       |          3.53 | abs(result) \< tolerance | Alaska               |
| 85   | 333       |          8.15 | abs(result) \< tolerance | Alaska               |
| 86   | 334       |         10.43 | abs(result) \< tolerance | Alaska               |
| 87   | 335       |         17.43 | abs(result) \< tolerance | Alaska               |
| 88   | 3361MV    |         28.95 | abs(result) \< tolerance | Alaska               |
| 89   | 3364OT    |          5.12 | abs(result) \< tolerance | Alaska               |
| 90   | 337       |          4.10 | abs(result) \< tolerance | Alaska               |
| 91   | 339       |          0.61 | abs(result) \< tolerance | Alaska               |
| 92   | 311FT     |         -0.14 | abs(result) \< tolerance | Alaska               |
| 93   | 313TT     |          3.63 | abs(result) \< tolerance | Alaska               |
| 94   | 315AL     |          9.91 | abs(result) \< tolerance | Alaska               |
| 95   | 322       |          9.89 | abs(result) \< tolerance | Alaska               |
| 96   | 323       |          2.14 | abs(result) \< tolerance | Alaska               |
| 97   | 324       |         -0.40 | abs(result) \< tolerance | Alaska               |
| 98   | 325       |          4.06 | abs(result) \< tolerance | Alaska               |
| 99   | 326       |         15.85 | abs(result) \< tolerance | Alaska               |
| 100  | 42        |          0.84 | abs(result) \< tolerance | Alaska               |
| 101  | 441       |          0.87 | abs(result) \< tolerance | Alaska               |
| 102  | 445       |          0.36 | abs(result) \< tolerance | Alaska               |
| 103  | 452       |         -0.42 | abs(result) \< tolerance | Alaska               |
| 104  | 4A0       |          0.13 | abs(result) \< tolerance | Alaska               |
| 105  | 481       |         -0.46 | abs(result) \< tolerance | Alaska               |
| 106  | 482       |        427.34 | abs(result) \< tolerance | Alaska               |
| 107  | 483       |         -0.54 | abs(result) \< tolerance | Alaska               |
| 108  | 484       |          0.37 | abs(result) \< tolerance | Alaska               |
| 109  | 485       |         -0.05 | abs(result) \< tolerance | Alaska               |
| 110  | 486       |         -0.86 | abs(result) \< tolerance | Alaska               |
| 111  | 487OS     |         -0.44 | abs(result) \< tolerance | Alaska               |
| 112  | 493       |          1.69 | abs(result) \< tolerance | Alaska               |
| 113  | 511       |          2.18 | abs(result) \< tolerance | Alaska               |
| 114  | 512       |          3.15 | abs(result) \< tolerance | Alaska               |
| 115  | 513       |         -0.11 | abs(result) \< tolerance | Alaska               |
| 116  | 514       |          7.19 | abs(result) \< tolerance | Alaska               |
| 117  | 521CI     |          0.47 | abs(result) \< tolerance | Alaska               |
| 118  | 523       |          4.13 | abs(result) \< tolerance | Alaska               |
| 119  | 524       |          1.82 | abs(result) \< tolerance | Alaska               |
| 120  | 525       |          1.55 | abs(result) \< tolerance | Alaska               |
| 121  | HS        |         -0.06 | abs(result) \< tolerance | Alaska               |
| 122  | ORE       |          0.61 | abs(result) \< tolerance | Alaska               |
| 123  | 532RL     |          0.15 | abs(result) \< tolerance | Alaska               |
| 124  | 5411      |          2.01 | abs(result) \< tolerance | Alaska               |
| 125  | 5415      |          1.45 | abs(result) \< tolerance | Alaska               |
| 126  | 5412OP    |          0.18 | abs(result) \< tolerance | Alaska               |
| 127  | 55        |          1.51 | abs(result) \< tolerance | Alaska               |
| 128  | 561       |          0.48 | abs(result) \< tolerance | Alaska               |
| 129  | 562       |         -0.11 | abs(result) \< tolerance | Alaska               |
| 130  | 61        |          0.40 | abs(result) \< tolerance | Alaska               |
| 131  | 621       |         -0.29 | abs(result) \< tolerance | Alaska               |
| 132  | 622       |         -0.31 | abs(result) \< tolerance | Alaska               |
| 133  | 623       |          0.54 | abs(result) \< tolerance | Alaska               |
| 134  | 624       |         -0.34 | abs(result) \< tolerance | Alaska               |
| 135  | 711AS     |          1.66 | abs(result) \< tolerance | Alaska               |
| 136  | 713       |          0.26 | abs(result) \< tolerance | Alaska               |
| 137  | 721       |         -0.31 | abs(result) \< tolerance | Alaska               |
| 138  | 722       |          0.24 | abs(result) \< tolerance | Alaska               |
| 139  | 81        |          0.10 | abs(result) \< tolerance | Alaska               |
| 140  | GFGD      |         -0.17 | abs(result) \< tolerance | Alaska               |
| 141  | GFGN      |          8.26 | abs(result) \< tolerance | Alaska               |
| 142  | GFE       |         -0.44 | abs(result) \< tolerance | Alaska               |
| 143  | GSLG      |          0.01 | abs(result) \< tolerance | Alaska               |
| 144  | GSLE      |          0.57 | abs(result) \< tolerance | Alaska               |
| 145  | Used      |         -9.93 | abs(result) \< tolerance | Alaska               |
| 146  | Other     |         29.78 | abs(result) \< tolerance | Alaska               |
| 147  | 111CA     |         -0.13 | abs(result) \< tolerance | Arizona              |
| 210  | 113FF     |         -0.31 | abs(result) \< tolerance | Arizona              |
| 310  | 211       |      10247.95 | abs(result) \< tolerance | Arizona              |
| 410  | 212       |         -0.60 | abs(result) \< tolerance | Arizona              |
| 510  | 213       |          0.11 | abs(result) \< tolerance | Arizona              |
| 610  | 22        |         -0.13 | abs(result) \< tolerance | Arizona              |
| 710  | 23        |         -0.02 | abs(result) \< tolerance | Arizona              |
| 810  | 321       |          0.82 | abs(result) \< tolerance | Arizona              |
| 1010 | 331       |         -0.16 | abs(result) \< tolerance | Arizona              |
| 1110 | 332       |          0.31 | abs(result) \< tolerance | Arizona              |
| 1210 | 333       |          0.50 | abs(result) \< tolerance | Arizona              |
| 1310 | 334       |         -0.20 | abs(result) \< tolerance | Arizona              |
| 148  | 335       |          1.08 | abs(result) \< tolerance | Arizona              |
| 151  | 3361MV    |          1.16 | abs(result) \< tolerance | Arizona              |
| 161  | 3364OT    |         -0.22 | abs(result) \< tolerance | Arizona              |
| 171  | 337       |          0.34 | abs(result) \< tolerance | Arizona              |
| 181  | 339       |         -0.02 | abs(result) \< tolerance | Arizona              |
| 191  | 311FT     |          1.16 | abs(result) \< tolerance | Arizona              |
| 201  | 313TT     |          1.48 | abs(result) \< tolerance | Arizona              |
| 211  | 315AL     |          3.03 | abs(result) \< tolerance | Arizona              |
| 221  | 322       |          1.53 | abs(result) \< tolerance | Arizona              |
| 231  | 323       |          0.09 | abs(result) \< tolerance | Arizona              |
| 241  | 324       |         16.33 | abs(result) \< tolerance | Arizona              |
| 251  | 325       |          1.95 | abs(result) \< tolerance | Arizona              |
| 261  | 326       |          1.03 | abs(result) \< tolerance | Arizona              |
| 271  | 42        |          0.03 | abs(result) \< tolerance | Arizona              |
| 281  | 441       |          0.23 | abs(result) \< tolerance | Arizona              |
| 291  | 445       |         -0.16 | abs(result) \< tolerance | Arizona              |
| 301  | 452       |         -0.13 | abs(result) \< tolerance | Arizona              |
| 311  | 4A0       |          0.05 | abs(result) \< tolerance | Arizona              |
| 321  | 481       |         -0.19 | abs(result) \< tolerance | Arizona              |
| 331  | 482       |         -0.16 | abs(result) \< tolerance | Arizona              |
| 341  | 483       |         19.33 | abs(result) \< tolerance | Arizona              |
| 351  | 484       |          0.10 | abs(result) \< tolerance | Arizona              |
| 361  | 485       |          0.21 | abs(result) \< tolerance | Arizona              |
| 371  | 486       |          1.76 | abs(result) \< tolerance | Arizona              |
| 381  | 487OS     |          0.10 | abs(result) \< tolerance | Arizona              |
| 391  | 493       |          0.33 | abs(result) \< tolerance | Arizona              |
| 401  | 511       |          0.41 | abs(result) \< tolerance | Arizona              |
| 411  | 512       |          1.75 | abs(result) \< tolerance | Arizona              |
| 421  | 513       |          0.19 | abs(result) \< tolerance | Arizona              |
| 431  | 514       |          0.19 | abs(result) \< tolerance | Arizona              |
| 441  | 521CI     |         -0.09 | abs(result) \< tolerance | Arizona              |
| 451  | 523       |          0.52 | abs(result) \< tolerance | Arizona              |
| 461  | 524       |          0.20 | abs(result) \< tolerance | Arizona              |
| 471  | 525       |         -0.15 | abs(result) \< tolerance | Arizona              |
| 481  | HS        |         -0.18 | abs(result) \< tolerance | Arizona              |
| 491  | ORE       |          0.55 | abs(result) \< tolerance | Arizona              |
| 501  | 532RL     |         -0.17 | abs(result) \< tolerance | Arizona              |
| 511  | 5411      |          0.54 | abs(result) \< tolerance | Arizona              |
| 531  | 5412OP    |          0.07 | abs(result) \< tolerance | Arizona              |
| 541  | 55        |          0.52 | abs(result) \< tolerance | Arizona              |
| 551  | 561       |         -0.36 | abs(result) \< tolerance | Arizona              |
| 561  | 562       |          0.02 | abs(result) \< tolerance | Arizona              |
| 571  | 61        |          0.12 | abs(result) \< tolerance | Arizona              |
| 581  | 621       |         -0.12 | abs(result) \< tolerance | Arizona              |
| 601  | 623       |          0.16 | abs(result) \< tolerance | Arizona              |
| 611  | 624       |          0.21 | abs(result) \< tolerance | Arizona              |
| 631  | 713       |          0.33 | abs(result) \< tolerance | Arizona              |
| 651  | 722       |          0.04 | abs(result) \< tolerance | Arizona              |
| 661  | 81        |          0.14 | abs(result) \< tolerance | Arizona              |
| 671  | GFGD      |         -0.49 | abs(result) \< tolerance | Arizona              |
| 681  | GFGN      |          0.03 | abs(result) \< tolerance | Arizona              |
| 691  | GFE       |         -0.06 | abs(result) \< tolerance | Arizona              |
| 701  | GSLG      |         -0.18 | abs(result) \< tolerance | Arizona              |
| 711  | GSLE      |          0.02 | abs(result) \< tolerance | Arizona              |
| 721  | Used      |          3.27 | abs(result) \< tolerance | Arizona              |
| 731  | Other     |        -11.82 | abs(result) \< tolerance | Arizona              |
| 149  | 111CA     |         -0.28 | abs(result) \< tolerance | Arkansas             |
| 212  | 113FF     |          0.03 | abs(result) \< tolerance | Arkansas             |
| 312  | 211       |          1.39 | abs(result) \< tolerance | Arkansas             |
| 412  | 212       |          0.61 | abs(result) \< tolerance | Arkansas             |
| 512  | 213       |         -0.07 | abs(result) \< tolerance | Arkansas             |
| 612  | 22        |         -0.24 | abs(result) \< tolerance | Arkansas             |
| 712  | 23        |          0.13 | abs(result) \< tolerance | Arkansas             |
| 811  | 321       |         -0.62 | abs(result) \< tolerance | Arkansas             |
| 910  | 327       |         -0.08 | abs(result) \< tolerance | Arkansas             |
| 1011 | 331       |         -0.59 | abs(result) \< tolerance | Arkansas             |
| 1111 | 332       |         -0.39 | abs(result) \< tolerance | Arkansas             |
| 1211 | 333       |         -0.24 | abs(result) \< tolerance | Arkansas             |
| 1311 | 334       |          0.95 | abs(result) \< tolerance | Arkansas             |
| 1410 | 335       |         -0.18 | abs(result) \< tolerance | Arkansas             |
| 152  | 3361MV    |          0.39 | abs(result) \< tolerance | Arkansas             |
| 162  | 3364OT    |          0.24 | abs(result) \< tolerance | Arkansas             |
| 172  | 337       |         -0.21 | abs(result) \< tolerance | Arkansas             |
| 182  | 339       |          0.28 | abs(result) \< tolerance | Arkansas             |
| 192  | 311FT     |         -0.34 | abs(result) \< tolerance | Arkansas             |
| 202  | 313TT     |          0.93 | abs(result) \< tolerance | Arkansas             |
| 213  | 315AL     |          0.22 | abs(result) \< tolerance | Arkansas             |
| 222  | 322       |         -0.53 | abs(result) \< tolerance | Arkansas             |
| 232  | 323       |         -0.31 | abs(result) \< tolerance | Arkansas             |
| 242  | 324       |          0.96 | abs(result) \< tolerance | Arkansas             |
| 252  | 325       |          1.10 | abs(result) \< tolerance | Arkansas             |
| 262  | 326       |         -0.50 | abs(result) \< tolerance | Arkansas             |
| 272  | 42        |          0.01 | abs(result) \< tolerance | Arkansas             |
| 282  | 441       |          0.37 | abs(result) \< tolerance | Arkansas             |
| 292  | 445       |          0.08 | abs(result) \< tolerance | Arkansas             |
| 302  | 452       |         -0.54 | abs(result) \< tolerance | Arkansas             |
| 313  | 4A0       |         -0.13 | abs(result) \< tolerance | Arkansas             |
| 322  | 481       |          2.84 | abs(result) \< tolerance | Arkansas             |
| 332  | 482       |         -0.31 | abs(result) \< tolerance | Arkansas             |
| 342  | 483       |          7.93 | abs(result) \< tolerance | Arkansas             |
| 352  | 484       |         -0.44 | abs(result) \< tolerance | Arkansas             |
| 362  | 485       |          1.34 | abs(result) \< tolerance | Arkansas             |
| 372  | 486       |          1.05 | abs(result) \< tolerance | Arkansas             |
| 382  | 487OS     |          0.25 | abs(result) \< tolerance | Arkansas             |
| 392  | 493       |          0.24 | abs(result) \< tolerance | Arkansas             |
| 402  | 511       |          2.36 | abs(result) \< tolerance | Arkansas             |
| 413  | 512       |          1.62 | abs(result) \< tolerance | Arkansas             |
| 422  | 513       |          0.57 | abs(result) \< tolerance | Arkansas             |
| 432  | 514       |          2.43 | abs(result) \< tolerance | Arkansas             |
| 442  | 521CI     |          0.45 | abs(result) \< tolerance | Arkansas             |
| 452  | 523       |          2.25 | abs(result) \< tolerance | Arkansas             |
| 462  | 524       |          0.36 | abs(result) \< tolerance | Arkansas             |
| 472  | 525       |          2.82 | abs(result) \< tolerance | Arkansas             |
| 482  | HS        |          0.03 | abs(result) \< tolerance | Arkansas             |
| 492  | ORE       |          1.18 | abs(result) \< tolerance | Arkansas             |
| 502  | 532RL     |          0.40 | abs(result) \< tolerance | Arkansas             |
| 513  | 5411      |          1.03 | abs(result) \< tolerance | Arkansas             |
| 521  | 5415      |          0.23 | abs(result) \< tolerance | Arkansas             |
| 532  | 5412OP    |          0.51 | abs(result) \< tolerance | Arkansas             |
| 542  | 55        |         -0.53 | abs(result) \< tolerance | Arkansas             |
| 552  | 561       |          0.06 | abs(result) \< tolerance | Arkansas             |
| 562  | 562       |         -0.19 | abs(result) \< tolerance | Arkansas             |
| 572  | 61        |          0.54 | abs(result) \< tolerance | Arkansas             |
| 582  | 621       |         -0.11 | abs(result) \< tolerance | Arkansas             |
| 591  | 622       |         -0.03 | abs(result) \< tolerance | Arkansas             |
| 602  | 623       |         -0.17 | abs(result) \< tolerance | Arkansas             |
| 613  | 624       |         -0.28 | abs(result) \< tolerance | Arkansas             |
| 621  | 711AS     |          1.03 | abs(result) \< tolerance | Arkansas             |
| 632  | 713       |          0.24 | abs(result) \< tolerance | Arkansas             |
| 641  | 721       |          0.76 | abs(result) \< tolerance | Arkansas             |
| 652  | 722       |         -0.06 | abs(result) \< tolerance | Arkansas             |
| 662  | 81        |         -0.01 | abs(result) \< tolerance | Arkansas             |
| 672  | GFGD      |         -0.22 | abs(result) \< tolerance | Arkansas             |
| 682  | GFGN      |          0.44 | abs(result) \< tolerance | Arkansas             |
| 692  | GFE       |          0.21 | abs(result) \< tolerance | Arkansas             |
| 702  | GSLG      |          0.01 | abs(result) \< tolerance | Arkansas             |
| 713  | GSLE      |          0.30 | abs(result) \< tolerance | Arkansas             |
| 722  | Used      |         -2.81 | abs(result) \< tolerance | Arkansas             |
| 732  | Other     |        -27.50 | abs(result) \< tolerance | Arkansas             |
| 150  | 111CA     |         -0.27 | abs(result) \< tolerance | California           |
| 214  | 113FF     |         -0.46 | abs(result) \< tolerance | California           |
| 314  | 211       |          1.69 | abs(result) \< tolerance | California           |
| 414  | 212       |          1.22 | abs(result) \< tolerance | California           |
| 514  | 213       |          0.01 | abs(result) \< tolerance | California           |
| 614  | 22        |          0.08 | abs(result) \< tolerance | California           |
| 812  | 321       |          0.72 | abs(result) \< tolerance | California           |
| 911  | 327       |          0.51 | abs(result) \< tolerance | California           |
| 1012 | 331       |          1.10 | abs(result) \< tolerance | California           |
| 1112 | 332       |          0.19 | abs(result) \< tolerance | California           |
| 1212 | 333       |          0.21 | abs(result) \< tolerance | California           |
| 1312 | 334       |         -0.38 | abs(result) \< tolerance | California           |
| 1411 | 335       |          0.52 | abs(result) \< tolerance | California           |
| 153  | 3361MV    |          0.62 | abs(result) \< tolerance | California           |
| 163  | 3364OT    |         -0.26 | abs(result) \< tolerance | California           |
| 173  | 337       |          0.23 | abs(result) \< tolerance | California           |
| 183  | 339       |         -0.03 | abs(result) \< tolerance | California           |
| 193  | 311FT     |          0.18 | abs(result) \< tolerance | California           |
| 203  | 313TT     |          0.63 | abs(result) \< tolerance | California           |
| 215  | 315AL     |         -0.41 | abs(result) \< tolerance | California           |
| 223  | 322       |          0.88 | abs(result) \< tolerance | California           |
| 233  | 323       |          0.71 | abs(result) \< tolerance | California           |
| 243  | 324       |         -0.18 | abs(result) \< tolerance | California           |
| 253  | 325       |         -0.38 | abs(result) \< tolerance | California           |
| 263  | 326       |          0.88 | abs(result) \< tolerance | California           |
| 273  | 42        |         -0.07 | abs(result) \< tolerance | California           |
| 283  | 441       |          0.19 | abs(result) \< tolerance | California           |
| 293  | 445       |         -0.31 | abs(result) \< tolerance | California           |
| 303  | 452       |         -0.07 | abs(result) \< tolerance | California           |
| 315  | 4A0       |         -0.01 | abs(result) \< tolerance | California           |
| 323  | 481       |          0.14 | abs(result) \< tolerance | California           |
| 333  | 482       |          1.53 | abs(result) \< tolerance | California           |
| 343  | 483       |          0.15 | abs(result) \< tolerance | California           |
| 353  | 484       |          0.18 | abs(result) \< tolerance | California           |
| 363  | 485       |         -0.12 | abs(result) \< tolerance | California           |
| 373  | 486       |          3.76 | abs(result) \< tolerance | California           |
| 383  | 487OS     |         -0.06 | abs(result) \< tolerance | California           |
| 393  | 493       |          0.05 | abs(result) \< tolerance | California           |
| 403  | 511       |         -0.14 | abs(result) \< tolerance | California           |
| 415  | 512       |         -0.34 | abs(result) \< tolerance | California           |
| 423  | 513       |         -0.10 | abs(result) \< tolerance | California           |
| 433  | 514       |         -0.60 | abs(result) \< tolerance | California           |
| 443  | 521CI     |          0.23 | abs(result) \< tolerance | California           |
| 453  | 523       |         -0.03 | abs(result) \< tolerance | California           |
| 463  | 524       |          0.49 | abs(result) \< tolerance | California           |
| 473  | 525       |          0.41 | abs(result) \< tolerance | California           |
| 483  | HS        |         -0.26 | abs(result) \< tolerance | California           |
| 493  | ORE       |          0.63 | abs(result) \< tolerance | California           |
| 503  | 532RL     |          0.09 | abs(result) \< tolerance | California           |
| 515  | 5411      |         -0.06 | abs(result) \< tolerance | California           |
| 522  | 5415      |         -0.18 | abs(result) \< tolerance | California           |
| 533  | 5412OP    |         -0.09 | abs(result) \< tolerance | California           |
| 543  | 55        |          0.24 | abs(result) \< tolerance | California           |
| 553  | 561       |         -0.02 | abs(result) \< tolerance | California           |
| 563  | 562       |          0.01 | abs(result) \< tolerance | California           |
| 583  | 621       |          0.05 | abs(result) \< tolerance | California           |
| 592  | 622       |          0.23 | abs(result) \< tolerance | California           |
| 603  | 623       |          0.33 | abs(result) \< tolerance | California           |
| 615  | 624       |         -0.22 | abs(result) \< tolerance | California           |
| 622  | 711AS     |         -0.15 | abs(result) \< tolerance | California           |
| 633  | 713       |          0.30 | abs(result) \< tolerance | California           |
| 642  | 721       |          0.17 | abs(result) \< tolerance | California           |
| 653  | 722       |         -0.05 | abs(result) \< tolerance | California           |
| 663  | 81        |          0.06 | abs(result) \< tolerance | California           |
| 673  | GFGD      |          2.32 | abs(result) \< tolerance | California           |
| 683  | GFGN      |         -0.23 | abs(result) \< tolerance | California           |
| 693  | GFE       |          0.47 | abs(result) \< tolerance | California           |
| 703  | GSLG      |         -0.03 | abs(result) \< tolerance | California           |
| 714  | GSLE      |          0.40 | abs(result) \< tolerance | California           |
| 723  | Used      |          0.43 | abs(result) \< tolerance | California           |
| 733  | Other     |        -12.16 | abs(result) \< tolerance | California           |
| 316  | 211       |         -0.66 | abs(result) \< tolerance | Colorado             |
| 416  | 212       |         -0.38 | abs(result) \< tolerance | Colorado             |
| 516  | 213       |         -0.03 | abs(result) \< tolerance | Colorado             |
| 616  | 22        |          0.36 | abs(result) \< tolerance | Colorado             |
| 715  | 23        |         -0.14 | abs(result) \< tolerance | Colorado             |
| 813  | 321       |          0.88 | abs(result) \< tolerance | Colorado             |
| 912  | 327       |         -0.04 | abs(result) \< tolerance | Colorado             |
| 1013 | 331       |          1.85 | abs(result) \< tolerance | Colorado             |
| 1113 | 332       |          0.35 | abs(result) \< tolerance | Colorado             |
| 1213 | 333       |          0.23 | abs(result) \< tolerance | Colorado             |
| 1313 | 334       |         -0.29 | abs(result) \< tolerance | Colorado             |
| 1412 | 335       |          1.26 | abs(result) \< tolerance | Colorado             |
| 154  | 3361MV    |          5.68 | abs(result) \< tolerance | Colorado             |
| 164  | 3364OT    |         -0.35 | abs(result) \< tolerance | Colorado             |
| 174  | 337       |          0.20 | abs(result) \< tolerance | Colorado             |
| 184  | 339       |         -0.22 | abs(result) \< tolerance | Colorado             |
| 194  | 311FT     |          0.27 | abs(result) \< tolerance | Colorado             |
| 204  | 313TT     |          1.19 | abs(result) \< tolerance | Colorado             |
| 216  | 315AL     |          1.68 | abs(result) \< tolerance | Colorado             |
| 224  | 322       |          3.13 | abs(result) \< tolerance | Colorado             |
| 234  | 323       |          0.63 | abs(result) \< tolerance | Colorado             |
| 244  | 324       |          0.56 | abs(result) \< tolerance | Colorado             |
| 254  | 325       |          1.16 | abs(result) \< tolerance | Colorado             |
| 264  | 326       |          0.62 | abs(result) \< tolerance | Colorado             |
| 274  | 42        |         -0.03 | abs(result) \< tolerance | Colorado             |
| 284  | 441       |          0.43 | abs(result) \< tolerance | Colorado             |
| 294  | 445       |         -0.05 | abs(result) \< tolerance | Colorado             |
| 304  | 452       |         -0.12 | abs(result) \< tolerance | Colorado             |
| 317  | 4A0       |          0.05 | abs(result) \< tolerance | Colorado             |
| 324  | 481       |         -0.31 | abs(result) \< tolerance | Colorado             |
| 334  | 482       |         -0.11 | abs(result) \< tolerance | Colorado             |
| 344  | 483       |          7.56 | abs(result) \< tolerance | Colorado             |
| 354  | 484       |          0.18 | abs(result) \< tolerance | Colorado             |
| 364  | 485       |          0.63 | abs(result) \< tolerance | Colorado             |
| 374  | 486       |         -0.61 | abs(result) \< tolerance | Colorado             |
| 384  | 487OS     |          0.33 | abs(result) \< tolerance | Colorado             |
| 394  | 493       |          0.56 | abs(result) \< tolerance | Colorado             |
| 404  | 511       |         -0.17 | abs(result) \< tolerance | Colorado             |
| 417  | 512       |          1.23 | abs(result) \< tolerance | Colorado             |
| 424  | 513       |          0.01 | abs(result) \< tolerance | Colorado             |
| 434  | 514       |         -0.11 | abs(result) \< tolerance | Colorado             |
| 444  | 521CI     |          0.37 | abs(result) \< tolerance | Colorado             |
| 454  | 523       |          0.18 | abs(result) \< tolerance | Colorado             |
| 464  | 524       |          0.25 | abs(result) \< tolerance | Colorado             |
| 474  | 525       |          0.12 | abs(result) \< tolerance | Colorado             |
| 484  | HS        |         -0.23 | abs(result) \< tolerance | Colorado             |
| 494  | ORE       |          0.47 | abs(result) \< tolerance | Colorado             |
| 504  | 532RL     |          0.15 | abs(result) \< tolerance | Colorado             |
| 517  | 5411      |          0.23 | abs(result) \< tolerance | Colorado             |
| 523  | 5415      |         -0.05 | abs(result) \< tolerance | Colorado             |
| 534  | 5412OP    |         -0.09 | abs(result) \< tolerance | Colorado             |
| 544  | 55        |         -0.17 | abs(result) \< tolerance | Colorado             |
| 554  | 561       |         -0.07 | abs(result) \< tolerance | Colorado             |
| 564  | 562       |         -0.03 | abs(result) \< tolerance | Colorado             |
| 573  | 61        |          0.17 | abs(result) \< tolerance | Colorado             |
| 584  | 621       |         -0.06 | abs(result) \< tolerance | Colorado             |
| 593  | 622       |          0.28 | abs(result) \< tolerance | Colorado             |
| 604  | 623       |          0.23 | abs(result) \< tolerance | Colorado             |
| 617  | 624       |          0.06 | abs(result) \< tolerance | Colorado             |
| 623  | 711AS     |          0.01 | abs(result) \< tolerance | Colorado             |
| 634  | 713       |         -0.25 | abs(result) \< tolerance | Colorado             |
| 664  | 81        |         -0.09 | abs(result) \< tolerance | Colorado             |
| 674  | GFGD      |         -0.25 | abs(result) \< tolerance | Colorado             |
| 684  | GFGN      |         -0.22 | abs(result) \< tolerance | Colorado             |
| 694  | GFE       |         -0.17 | abs(result) \< tolerance | Colorado             |
| 704  | GSLG      |         -0.13 | abs(result) \< tolerance | Colorado             |
| 716  | GSLE      |          0.22 | abs(result) \< tolerance | Colorado             |
| 724  | Used      |          6.93 | abs(result) \< tolerance | Colorado             |
| 734  | Other     |          2.95 | abs(result) \< tolerance | Colorado             |
| 155  | 111CA     |          1.83 | abs(result) \< tolerance | Connecticut          |
| 217  | 113FF     |          0.94 | abs(result) \< tolerance | Connecticut          |
| 318  | 211       |        509.13 | abs(result) \< tolerance | Connecticut          |
| 418  | 212       |          1.26 | abs(result) \< tolerance | Connecticut          |
| 518  | 213       |          0.11 | abs(result) \< tolerance | Connecticut          |
| 618  | 22        |         -0.07 | abs(result) \< tolerance | Connecticut          |
| 717  | 23        |          0.22 | abs(result) \< tolerance | Connecticut          |
| 814  | 321       |          2.23 | abs(result) \< tolerance | Connecticut          |
| 913  | 327       |          1.17 | abs(result) \< tolerance | Connecticut          |
| 1014 | 331       |          0.62 | abs(result) \< tolerance | Connecticut          |
| 1114 | 332       |         -0.42 | abs(result) \< tolerance | Connecticut          |
| 1214 | 333       |         -0.03 | abs(result) \< tolerance | Connecticut          |
| 1314 | 334       |          0.29 | abs(result) \< tolerance | Connecticut          |
| 1413 | 335       |         -0.20 | abs(result) \< tolerance | Connecticut          |
| 156  | 3361MV    |          0.73 | abs(result) \< tolerance | Connecticut          |
| 165  | 3364OT    |         -0.11 | abs(result) \< tolerance | Connecticut          |
| 175  | 337       |          0.52 | abs(result) \< tolerance | Connecticut          |
| 185  | 339       |         -0.44 | abs(result) \< tolerance | Connecticut          |
| 195  | 311FT     |          0.99 | abs(result) \< tolerance | Connecticut          |
| 205  | 313TT     |         -0.05 | abs(result) \< tolerance | Connecticut          |
| 218  | 315AL     |         -0.11 | abs(result) \< tolerance | Connecticut          |
| 225  | 322       |          0.06 | abs(result) \< tolerance | Connecticut          |
| 235  | 323       |          0.13 | abs(result) \< tolerance | Connecticut          |
| 245  | 324       |          4.54 | abs(result) \< tolerance | Connecticut          |
| 255  | 325       |         -0.21 | abs(result) \< tolerance | Connecticut          |
| 265  | 326       |          0.37 | abs(result) \< tolerance | Connecticut          |
| 275  | 42        |         -0.06 | abs(result) \< tolerance | Connecticut          |
| 285  | 441       |          0.35 | abs(result) \< tolerance | Connecticut          |
| 295  | 445       |         -0.36 | abs(result) \< tolerance | Connecticut          |
| 305  | 452       |          0.12 | abs(result) \< tolerance | Connecticut          |
| 319  | 4A0       |          0.09 | abs(result) \< tolerance | Connecticut          |
| 325  | 481       |          2.56 | abs(result) \< tolerance | Connecticut          |
| 335  | 482       |          1.71 | abs(result) \< tolerance | Connecticut          |
| 345  | 483       |         -0.18 | abs(result) \< tolerance | Connecticut          |
| 355  | 484       |          0.85 | abs(result) \< tolerance | Connecticut          |
| 365  | 485       |         -0.20 | abs(result) \< tolerance | Connecticut          |
| 375  | 486       |         -0.65 | abs(result) \< tolerance | Connecticut          |
| 385  | 487OS     |          0.08 | abs(result) \< tolerance | Connecticut          |
| 395  | 493       |          0.04 | abs(result) \< tolerance | Connecticut          |
| 405  | 511       |          0.05 | abs(result) \< tolerance | Connecticut          |
| 419  | 512       |         -0.04 | abs(result) \< tolerance | Connecticut          |
| 425  | 513       |         -0.21 | abs(result) \< tolerance | Connecticut          |
| 435  | 514       |          1.33 | abs(result) \< tolerance | Connecticut          |
| 445  | 521CI     |          0.36 | abs(result) \< tolerance | Connecticut          |
| 455  | 523       |         -0.53 | abs(result) \< tolerance | Connecticut          |
| 465  | 524       |         -0.48 | abs(result) \< tolerance | Connecticut          |
| 475  | 525       |          0.65 | abs(result) \< tolerance | Connecticut          |
| 485  | HS        |         -0.28 | abs(result) \< tolerance | Connecticut          |
| 495  | ORE       |          0.90 | abs(result) \< tolerance | Connecticut          |
| 505  | 532RL     |         -0.14 | abs(result) \< tolerance | Connecticut          |
| 519  | 5411      |          0.45 | abs(result) \< tolerance | Connecticut          |
| 524  | 5415      |         -0.02 | abs(result) \< tolerance | Connecticut          |
| 535  | 5412OP    |          0.05 | abs(result) \< tolerance | Connecticut          |
| 545  | 55        |         -0.29 | abs(result) \< tolerance | Connecticut          |
| 555  | 561       |          0.10 | abs(result) \< tolerance | Connecticut          |
| 565  | 562       |         -0.16 | abs(result) \< tolerance | Connecticut          |
| 574  | 61        |         -0.31 | abs(result) \< tolerance | Connecticut          |
| 585  | 621       |          0.06 | abs(result) \< tolerance | Connecticut          |
| 594  | 622       |          0.15 | abs(result) \< tolerance | Connecticut          |
| 605  | 623       |         -0.34 | abs(result) \< tolerance | Connecticut          |
| 619  | 624       |         -0.12 | abs(result) \< tolerance | Connecticut          |
| 624  | 711AS     |          0.43 | abs(result) \< tolerance | Connecticut          |
| 635  | 713       |          0.11 | abs(result) \< tolerance | Connecticut          |
| 643  | 721       |          0.25 | abs(result) \< tolerance | Connecticut          |
| 654  | 722       |         -0.03 | abs(result) \< tolerance | Connecticut          |
| 665  | 81        |          0.25 | abs(result) \< tolerance | Connecticut          |
| 675  | GFGD      |         -0.74 | abs(result) \< tolerance | Connecticut          |
| 685  | GFGN      |         -0.21 | abs(result) \< tolerance | Connecticut          |
| 695  | GFE       |          1.89 | abs(result) \< tolerance | Connecticut          |
| 705  | GSLG      |         -0.18 | abs(result) \< tolerance | Connecticut          |
| 718  | GSLE      |          1.04 | abs(result) \< tolerance | Connecticut          |
| 725  | Used      |         -2.80 | abs(result) \< tolerance | Connecticut          |
| 735  | Other     |        -53.77 | abs(result) \< tolerance | Connecticut          |
| 157  | 111CA     |         -0.04 | abs(result) \< tolerance | Delaware             |
| 219  | 113FF     |          0.53 | abs(result) \< tolerance | Delaware             |
| 320  | 211       |       2536.80 | abs(result) \< tolerance | Delaware             |
| 420  | 212       |          4.19 | abs(result) \< tolerance | Delaware             |
| 520  | 213       |          0.13 | abs(result) \< tolerance | Delaware             |
| 620  | 22        |         -0.07 | abs(result) \< tolerance | Delaware             |
| 719  | 23        |          0.04 | abs(result) \< tolerance | Delaware             |
| 815  | 321       |          2.08 | abs(result) \< tolerance | Delaware             |
| 914  | 327       |          1.25 | abs(result) \< tolerance | Delaware             |
| 1015 | 331       |          0.63 | abs(result) \< tolerance | Delaware             |
| 1115 | 332       |          0.93 | abs(result) \< tolerance | Delaware             |
| 1215 | 333       |          0.90 | abs(result) \< tolerance | Delaware             |
| 1315 | 334       |          0.19 | abs(result) \< tolerance | Delaware             |
| 1414 | 335       |          0.18 | abs(result) \< tolerance | Delaware             |
| 158  | 3361MV    |         10.74 | abs(result) \< tolerance | Delaware             |
| 166  | 3364OT    |          0.64 | abs(result) \< tolerance | Delaware             |
| 176  | 337       |          1.12 | abs(result) \< tolerance | Delaware             |
| 186  | 339       |          0.28 | abs(result) \< tolerance | Delaware             |
| 196  | 311FT     |         -0.19 | abs(result) \< tolerance | Delaware             |
| 206  | 313TT     |         -0.05 | abs(result) \< tolerance | Delaware             |
| 2110 | 315AL     |          2.56 | abs(result) \< tolerance | Delaware             |
| 226  | 322       |         -0.04 | abs(result) \< tolerance | Delaware             |
| 236  | 323       |          2.17 | abs(result) \< tolerance | Delaware             |
| 246  | 324       |         -0.20 | abs(result) \< tolerance | Delaware             |
| 256  | 325       |          0.18 | abs(result) \< tolerance | Delaware             |
| 266  | 326       |         -0.15 | abs(result) \< tolerance | Delaware             |
| 276  | 42        |          0.55 | abs(result) \< tolerance | Delaware             |
| 286  | 441       |          0.75 | abs(result) \< tolerance | Delaware             |
| 296  | 445       |         -0.04 | abs(result) \< tolerance | Delaware             |
| 306  | 452       |          0.26 | abs(result) \< tolerance | Delaware             |
| 3110 | 4A0       |          0.40 | abs(result) \< tolerance | Delaware             |
| 326  | 481       |          7.33 | abs(result) \< tolerance | Delaware             |
| 336  | 482       |         -0.25 | abs(result) \< tolerance | Delaware             |
| 346  | 483       |          6.37 | abs(result) \< tolerance | Delaware             |
| 356  | 484       |          0.45 | abs(result) \< tolerance | Delaware             |
| 366  | 485       |          0.46 | abs(result) \< tolerance | Delaware             |
| 376  | 486       |          9.19 | abs(result) \< tolerance | Delaware             |
| 386  | 487OS     |         -0.12 | abs(result) \< tolerance | Delaware             |
| 396  | 493       |         -0.44 | abs(result) \< tolerance | Delaware             |
| 406  | 511       |          0.62 | abs(result) \< tolerance | Delaware             |
| 4110 | 512       |          4.00 | abs(result) \< tolerance | Delaware             |
| 426  | 513       |          1.49 | abs(result) \< tolerance | Delaware             |
| 436  | 514       |          2.38 | abs(result) \< tolerance | Delaware             |
| 446  | 521CI     |         -0.71 | abs(result) \< tolerance | Delaware             |
| 456  | 523       |         -0.32 | abs(result) \< tolerance | Delaware             |
| 466  | 524       |         -0.46 | abs(result) \< tolerance | Delaware             |
| 476  | 525       |         -0.03 | abs(result) \< tolerance | Delaware             |
| 486  | HS        |         -0.26 | abs(result) \< tolerance | Delaware             |
| 496  | ORE       |          0.93 | abs(result) \< tolerance | Delaware             |
| 506  | 532RL     |         -0.57 | abs(result) \< tolerance | Delaware             |
| 5110 | 5411      |         -0.40 | abs(result) \< tolerance | Delaware             |
| 525  | 5415      |          0.22 | abs(result) \< tolerance | Delaware             |
| 536  | 5412OP    |          0.33 | abs(result) \< tolerance | Delaware             |
| 546  | 55        |         -0.47 | abs(result) \< tolerance | Delaware             |
| 556  | 561       |          0.16 | abs(result) \< tolerance | Delaware             |
| 566  | 562       |         -0.09 | abs(result) \< tolerance | Delaware             |
| 575  | 61        |          0.51 | abs(result) \< tolerance | Delaware             |
| 586  | 621       |          0.22 | abs(result) \< tolerance | Delaware             |
| 595  | 622       |         -0.29 | abs(result) \< tolerance | Delaware             |
| 606  | 623       |         -0.19 | abs(result) \< tolerance | Delaware             |
| 6110 | 624       |          0.09 | abs(result) \< tolerance | Delaware             |
| 625  | 711AS     |          1.58 | abs(result) \< tolerance | Delaware             |
| 636  | 713       |         -0.24 | abs(result) \< tolerance | Delaware             |
| 644  | 721       |          1.00 | abs(result) \< tolerance | Delaware             |
| 655  | 722       |          0.16 | abs(result) \< tolerance | Delaware             |
| 666  | 81        |          0.52 | abs(result) \< tolerance | Delaware             |
| 676  | GFGD      |         -0.27 | abs(result) \< tolerance | Delaware             |
| 686  | GFGN      |         -0.43 | abs(result) \< tolerance | Delaware             |
| 696  | GFE       |          1.07 | abs(result) \< tolerance | Delaware             |
| 7110 | GSLE      |          0.42 | abs(result) \< tolerance | Delaware             |
| 726  | Used      |          0.65 | abs(result) \< tolerance | Delaware             |
| 736  | Other     |        -46.60 | abs(result) \< tolerance | Delaware             |
| 159  | 111CA     |        172.10 | abs(result) \< tolerance | District of Columbia |
| 220  | 113FF     |          1.60 | abs(result) \< tolerance | District of Columbia |
| 327  | 211       |        749.97 | abs(result) \< tolerance | District of Columbia |
| 427  | 212       |         65.04 | abs(result) \< tolerance | District of Columbia |
| 526  | 213       |        817.66 | abs(result) \< tolerance | District of Columbia |
| 626  | 22        |         -0.33 | abs(result) \< tolerance | District of Columbia |
| 720  | 23        |          1.18 | abs(result) \< tolerance | District of Columbia |
| 816  | 321       |        170.82 | abs(result) \< tolerance | District of Columbia |
| 915  | 327       |          2.90 | abs(result) \< tolerance | District of Columbia |
| 1016 | 331       |          2.24 | abs(result) \< tolerance | District of Columbia |
| 1116 | 332       |         37.83 | abs(result) \< tolerance | District of Columbia |
| 1216 | 333       |         10.23 | abs(result) \< tolerance | District of Columbia |
| 1316 | 334       |          9.94 | abs(result) \< tolerance | District of Columbia |
| 1415 | 335       |         37.60 | abs(result) \< tolerance | District of Columbia |
| 1510 | 3361MV    |       5424.14 | abs(result) \< tolerance | District of Columbia |
| 167  | 3364OT    |         46.21 | abs(result) \< tolerance | District of Columbia |
| 177  | 337       |          8.80 | abs(result) \< tolerance | District of Columbia |
| 187  | 339       |         34.36 | abs(result) \< tolerance | District of Columbia |
| 197  | 311FT     |          9.88 | abs(result) \< tolerance | District of Columbia |
| 207  | 313TT     |          6.43 | abs(result) \< tolerance | District of Columbia |
| 2111 | 315AL     |         15.56 | abs(result) \< tolerance | District of Columbia |
| 227  | 322       |        140.96 | abs(result) \< tolerance | District of Columbia |
| 237  | 323       |          4.12 | abs(result) \< tolerance | District of Columbia |
| 247  | 324       |       1083.26 | abs(result) \< tolerance | District of Columbia |
| 257  | 325       |         66.37 | abs(result) \< tolerance | District of Columbia |
| 267  | 326       |         70.54 | abs(result) \< tolerance | District of Columbia |
| 277  | 42        |          1.71 | abs(result) \< tolerance | District of Columbia |
| 287  | 441       |          7.34 | abs(result) \< tolerance | District of Columbia |
| 297  | 445       |          0.20 | abs(result) \< tolerance | District of Columbia |
| 307  | 452       |          0.26 | abs(result) \< tolerance | District of Columbia |
| 3111 | 4A0       |          0.87 | abs(result) \< tolerance | District of Columbia |
| 328  | 481       |         15.09 | abs(result) \< tolerance | District of Columbia |
| 337  | 482       |         -0.51 | abs(result) \< tolerance | District of Columbia |
| 347  | 483       |         12.33 | abs(result) \< tolerance | District of Columbia |
| 357  | 484       |          8.89 | abs(result) \< tolerance | District of Columbia |
| 367  | 485       |          0.57 | abs(result) \< tolerance | District of Columbia |
| 377  | 486       |          6.71 | abs(result) \< tolerance | District of Columbia |
| 387  | 487OS     |          1.49 | abs(result) \< tolerance | District of Columbia |
| 397  | 493       |         30.05 | abs(result) \< tolerance | District of Columbia |
| 407  | 511       |          0.25 | abs(result) \< tolerance | District of Columbia |
| 4111 | 512       |          1.47 | abs(result) \< tolerance | District of Columbia |
| 428  | 513       |         -0.15 | abs(result) \< tolerance | District of Columbia |
| 437  | 514       |          0.59 | abs(result) \< tolerance | District of Columbia |
| 447  | 521CI     |          0.18 | abs(result) \< tolerance | District of Columbia |
| 457  | 523       |          0.31 | abs(result) \< tolerance | District of Columbia |
| 467  | 524       |          1.99 | abs(result) \< tolerance | District of Columbia |
| 477  | 525       |         -0.72 | abs(result) \< tolerance | District of Columbia |
| 487  | HS        |         -0.51 | abs(result) \< tolerance | District of Columbia |
| 497  | ORE       |          1.29 | abs(result) \< tolerance | District of Columbia |
| 507  | 532RL     |          1.67 | abs(result) \< tolerance | District of Columbia |
| 5111 | 5411      |         -0.84 | abs(result) \< tolerance | District of Columbia |
| 527  | 5415      |          0.79 | abs(result) \< tolerance | District of Columbia |
| 537  | 5412OP    |         -0.16 | abs(result) \< tolerance | District of Columbia |
| 547  | 55        |          1.05 | abs(result) \< tolerance | District of Columbia |
| 557  | 561       |         -0.07 | abs(result) \< tolerance | District of Columbia |
| 567  | 562       |          0.84 | abs(result) \< tolerance | District of Columbia |
| 576  | 61        |         -0.53 | abs(result) \< tolerance | District of Columbia |
| 587  | 621       |          1.47 | abs(result) \< tolerance | District of Columbia |
| 596  | 622       |          0.09 | abs(result) \< tolerance | District of Columbia |
| 607  | 623       |          1.72 | abs(result) \< tolerance | District of Columbia |
| 6111 | 624       |          0.08 | abs(result) \< tolerance | District of Columbia |
| 627  | 711AS     |         -0.38 | abs(result) \< tolerance | District of Columbia |
| 637  | 713       |         -0.32 | abs(result) \< tolerance | District of Columbia |
| 645  | 721       |         -0.63 | abs(result) \< tolerance | District of Columbia |
| 656  | 722       |         -0.30 | abs(result) \< tolerance | District of Columbia |
| 667  | 81        |         -0.66 | abs(result) \< tolerance | District of Columbia |
| 677  | GFGD      |         -0.63 | abs(result) \< tolerance | District of Columbia |
| 687  | GFGN      |          0.05 | abs(result) \< tolerance | District of Columbia |
| 697  | GFE       |         -0.93 | abs(result) \< tolerance | District of Columbia |
| 706  | GSLG      |          1.03 | abs(result) \< tolerance | District of Columbia |
| 7111 | GSLE      |          1.43 | abs(result) \< tolerance | District of Columbia |
| 727  | Used      |         64.83 | abs(result) \< tolerance | District of Columbia |
| 737  | Other     |         57.48 | abs(result) \< tolerance | District of Columbia |
| 160  | 111CA     |          0.03 | abs(result) \< tolerance | Florida              |
| 228  | 113FF     |         -0.24 | abs(result) \< tolerance | Florida              |
| 329  | 211       |         34.76 | abs(result) \< tolerance | Florida              |
| 429  | 212       |          0.54 | abs(result) \< tolerance | Florida              |
| 528  | 213       |          0.07 | abs(result) \< tolerance | Florida              |
| 628  | 22        |          0.13 | abs(result) \< tolerance | Florida              |
| 817  | 321       |          0.49 | abs(result) \< tolerance | Florida              |
| 916  | 327       |         -0.02 | abs(result) \< tolerance | Florida              |
| 1017 | 331       |         -0.03 | abs(result) \< tolerance | Florida              |
| 1117 | 332       |          0.71 | abs(result) \< tolerance | Florida              |
| 1217 | 333       |          0.35 | abs(result) \< tolerance | Florida              |
| 1317 | 334       |          0.49 | abs(result) \< tolerance | Florida              |
| 1416 | 335       |          1.22 | abs(result) \< tolerance | Florida              |
| 1511 | 3361MV    |          5.11 | abs(result) \< tolerance | Florida              |
| 168  | 3364OT    |          0.52 | abs(result) \< tolerance | Florida              |
| 178  | 337       |          1.17 | abs(result) \< tolerance | Florida              |
| 188  | 339       |          0.20 | abs(result) \< tolerance | Florida              |
| 198  | 311FT     |          1.17 | abs(result) \< tolerance | Florida              |
| 208  | 313TT     |          1.10 | abs(result) \< tolerance | Florida              |
| 2112 | 315AL     |          1.07 | abs(result) \< tolerance | Florida              |
| 229  | 322       |          0.67 | abs(result) \< tolerance | Florida              |
| 238  | 323       |          0.37 | abs(result) \< tolerance | Florida              |
| 248  | 324       |          2.50 | abs(result) \< tolerance | Florida              |
| 258  | 325       |          0.83 | abs(result) \< tolerance | Florida              |
| 268  | 326       |          1.55 | abs(result) \< tolerance | Florida              |
| 278  | 42        |         -0.09 | abs(result) \< tolerance | Florida              |
| 288  | 441       |          0.25 | abs(result) \< tolerance | Florida              |
| 298  | 445       |         -0.19 | abs(result) \< tolerance | Florida              |
| 308  | 452       |         -0.07 | abs(result) \< tolerance | Florida              |
| 3112 | 4A0       |          0.15 | abs(result) \< tolerance | Florida              |
| 3210 | 481       |         -0.25 | abs(result) \< tolerance | Florida              |
| 338  | 482       |          0.53 | abs(result) \< tolerance | Florida              |
| 348  | 483       |         -0.47 | abs(result) \< tolerance | Florida              |
| 358  | 484       |          0.25 | abs(result) \< tolerance | Florida              |
| 368  | 485       |          0.81 | abs(result) \< tolerance | Florida              |
| 378  | 486       |          3.83 | abs(result) \< tolerance | Florida              |
| 388  | 487OS     |         -0.14 | abs(result) \< tolerance | Florida              |
| 398  | 493       |          0.39 | abs(result) \< tolerance | Florida              |
| 408  | 511       |          0.29 | abs(result) \< tolerance | Florida              |
| 4112 | 512       |          0.69 | abs(result) \< tolerance | Florida              |
| 4210 | 513       |          0.05 | abs(result) \< tolerance | Florida              |
| 438  | 514       |          0.67 | abs(result) \< tolerance | Florida              |
| 448  | 521CI     |          1.16 | abs(result) \< tolerance | Florida              |
| 458  | 523       |          0.64 | abs(result) \< tolerance | Florida              |
| 478  | 525       |          1.74 | abs(result) \< tolerance | Florida              |
| 488  | HS        |         -0.19 | abs(result) \< tolerance | Florida              |
| 498  | ORE       |          0.42 | abs(result) \< tolerance | Florida              |
| 508  | 532RL     |         -0.10 | abs(result) \< tolerance | Florida              |
| 5112 | 5411      |         -0.16 | abs(result) \< tolerance | Florida              |
| 529  | 5415      |          0.11 | abs(result) \< tolerance | Florida              |
| 538  | 5412OP    |          0.03 | abs(result) \< tolerance | Florida              |
| 548  | 55        |          0.20 | abs(result) \< tolerance | Florida              |
| 558  | 561       |         -0.24 | abs(result) \< tolerance | Florida              |
| 568  | 562       |          0.14 | abs(result) \< tolerance | Florida              |
| 577  | 61        |          0.36 | abs(result) \< tolerance | Florida              |
| 588  | 621       |         -0.07 | abs(result) \< tolerance | Florida              |
| 597  | 622       |          0.17 | abs(result) \< tolerance | Florida              |
| 608  | 623       |          0.06 | abs(result) \< tolerance | Florida              |
| 6112 | 624       |          0.55 | abs(result) \< tolerance | Florida              |
| 629  | 711AS     |          0.06 | abs(result) \< tolerance | Florida              |
| 638  | 713       |         -0.33 | abs(result) \< tolerance | Florida              |
| 646  | 721       |         -0.26 | abs(result) \< tolerance | Florida              |
| 657  | 722       |          0.03 | abs(result) \< tolerance | Florida              |
| 668  | 81        |         -0.05 | abs(result) \< tolerance | Florida              |
| 678  | GFGD      |         -0.35 | abs(result) \< tolerance | Florida              |
| 688  | GFGN      |          0.33 | abs(result) \< tolerance | Florida              |
| 698  | GFE       |          0.53 | abs(result) \< tolerance | Florida              |
| 707  | GSLG      |         -0.04 | abs(result) \< tolerance | Florida              |
| 7112 | GSLE      |         -0.30 | abs(result) \< tolerance | Florida              |
| 728  | Used      |          9.07 | abs(result) \< tolerance | Florida              |
| 738  | Other     |        -37.84 | abs(result) \< tolerance | Florida              |
| 169  | 111CA     |          0.66 | abs(result) \< tolerance | Georgia              |
| 230  | 113FF     |          0.47 | abs(result) \< tolerance | Georgia              |
| 330  | 211       |        218.20 | abs(result) \< tolerance | Georgia              |
| 430  | 212       |          0.12 | abs(result) \< tolerance | Georgia              |
| 530  | 213       |          0.05 | abs(result) \< tolerance | Georgia              |
| 630  | 22        |         -0.10 | abs(result) \< tolerance | Georgia              |
| 729  | 23        |         -0.07 | abs(result) \< tolerance | Georgia              |
| 818  | 321       |         -0.37 | abs(result) \< tolerance | Georgia              |
| 917  | 327       |         -0.16 | abs(result) \< tolerance | Georgia              |
| 1018 | 331       |          0.45 | abs(result) \< tolerance | Georgia              |
| 1118 | 332       |          0.37 | abs(result) \< tolerance | Georgia              |
| 1218 | 333       |          0.09 | abs(result) \< tolerance | Georgia              |
| 1318 | 334       |          1.19 | abs(result) \< tolerance | Georgia              |
| 1417 | 335       |         -0.25 | abs(result) \< tolerance | Georgia              |
| 1512 | 3361MV    |          0.14 | abs(result) \< tolerance | Georgia              |
| 1610 | 3364OT    |          0.08 | abs(result) \< tolerance | Georgia              |
| 179  | 337       |         -0.09 | abs(result) \< tolerance | Georgia              |
| 189  | 339       |          0.36 | abs(result) \< tolerance | Georgia              |
| 199  | 311FT     |         -0.30 | abs(result) \< tolerance | Georgia              |
| 209  | 313TT     |         -0.64 | abs(result) \< tolerance | Georgia              |
| 2113 | 315AL     |          0.14 | abs(result) \< tolerance | Georgia              |
| 2210 | 322       |         -0.23 | abs(result) \< tolerance | Georgia              |
| 239  | 323       |         -0.07 | abs(result) \< tolerance | Georgia              |
| 249  | 324       |          4.52 | abs(result) \< tolerance | Georgia              |
| 259  | 325       |          0.38 | abs(result) \< tolerance | Georgia              |
| 269  | 326       |         -0.17 | abs(result) \< tolerance | Georgia              |
| 279  | 42        |         -0.14 | abs(result) \< tolerance | Georgia              |
| 289  | 441       |          0.45 | abs(result) \< tolerance | Georgia              |
| 299  | 445       |         -0.04 | abs(result) \< tolerance | Georgia              |
| 309  | 452       |         -0.22 | abs(result) \< tolerance | Georgia              |
| 3113 | 4A0       |          0.10 | abs(result) \< tolerance | Georgia              |
| 3211 | 481       |         -0.49 | abs(result) \< tolerance | Georgia              |
| 339  | 482       |          0.04 | abs(result) \< tolerance | Georgia              |
| 349  | 483       |          4.29 | abs(result) \< tolerance | Georgia              |
| 359  | 484       |          0.04 | abs(result) \< tolerance | Georgia              |
| 369  | 485       |          1.91 | abs(result) \< tolerance | Georgia              |
| 379  | 486       |          0.56 | abs(result) \< tolerance | Georgia              |
| 389  | 487OS     |          0.03 | abs(result) \< tolerance | Georgia              |
| 399  | 493       |         -0.14 | abs(result) \< tolerance | Georgia              |
| 409  | 511       |         -0.03 | abs(result) \< tolerance | Georgia              |
| 4113 | 512       |          0.08 | abs(result) \< tolerance | Georgia              |
| 4211 | 513       |         -0.46 | abs(result) \< tolerance | Georgia              |
| 439  | 514       |          0.39 | abs(result) \< tolerance | Georgia              |
| 449  | 521CI     |         -0.32 | abs(result) \< tolerance | Georgia              |
| 459  | 523       |          0.52 | abs(result) \< tolerance | Georgia              |
| 468  | 524       |          0.10 | abs(result) \< tolerance | Georgia              |
| 479  | 525       |          0.30 | abs(result) \< tolerance | Georgia              |
| 489  | HS        |         -0.19 | abs(result) \< tolerance | Georgia              |
| 499  | ORE       |          0.83 | abs(result) \< tolerance | Georgia              |
| 509  | 532RL     |         -0.30 | abs(result) \< tolerance | Georgia              |
| 5113 | 5411      |          0.08 | abs(result) \< tolerance | Georgia              |
| 5210 | 5415      |         -0.05 | abs(result) \< tolerance | Georgia              |
| 539  | 5412OP    |          0.03 | abs(result) \< tolerance | Georgia              |
| 549  | 55        |          0.02 | abs(result) \< tolerance | Georgia              |
| 559  | 561       |         -0.16 | abs(result) \< tolerance | Georgia              |
| 569  | 562       |          0.33 | abs(result) \< tolerance | Georgia              |
| 578  | 61        |          0.10 | abs(result) \< tolerance | Georgia              |
| 589  | 621       |          0.07 | abs(result) \< tolerance | Georgia              |
| 598  | 622       |          0.06 | abs(result) \< tolerance | Georgia              |
| 609  | 623       |          0.77 | abs(result) \< tolerance | Georgia              |
| 6113 | 624       |          0.49 | abs(result) \< tolerance | Georgia              |
| 6210 | 711AS     |          1.23 | abs(result) \< tolerance | Georgia              |
| 639  | 713       |          0.81 | abs(result) \< tolerance | Georgia              |
| 647  | 721       |          0.54 | abs(result) \< tolerance | Georgia              |
| 658  | 722       |          0.06 | abs(result) \< tolerance | Georgia              |
| 669  | 81        |          0.12 | abs(result) \< tolerance | Georgia              |
| 679  | GFGD      |         -0.21 | abs(result) \< tolerance | Georgia              |
| 689  | GFGN      |         -0.36 | abs(result) \< tolerance | Georgia              |
| 699  | GFE       |         -0.07 | abs(result) \< tolerance | Georgia              |
| 708  | GSLG      |         -0.18 | abs(result) \< tolerance | Georgia              |
| 7113 | GSLE      |         -0.12 | abs(result) \< tolerance | Georgia              |
| 7210 | Used      |          3.99 | abs(result) \< tolerance | Georgia              |
| 739  | Other     |          0.65 | abs(result) \< tolerance | Georgia              |
| 170  | 111CA     |          0.03 | abs(result) \< tolerance | Hawaii               |
| 240  | 113FF     |         -0.68 | abs(result) \< tolerance | Hawaii               |
| 340  | 211       |        603.11 | abs(result) \< tolerance | Hawaii               |
| 440  | 212       |          1.53 | abs(result) \< tolerance | Hawaii               |
| 540  | 213       |          0.12 | abs(result) \< tolerance | Hawaii               |
| 640  | 22        |         -0.15 | abs(result) \< tolerance | Hawaii               |
| 730  | 23        |         -0.07 | abs(result) \< tolerance | Hawaii               |
| 819  | 321       |          6.92 | abs(result) \< tolerance | Hawaii               |
| 918  | 327       |          0.75 | abs(result) \< tolerance | Hawaii               |
| 1019 | 331       |         13.61 | abs(result) \< tolerance | Hawaii               |
| 1119 | 332       |          9.72 | abs(result) \< tolerance | Hawaii               |
| 1219 | 333       |          5.93 | abs(result) \< tolerance | Hawaii               |
| 1319 | 334       |          8.15 | abs(result) \< tolerance | Hawaii               |
| 1418 | 335       |         21.68 | abs(result) \< tolerance | Hawaii               |
| 1513 | 3361MV    |         52.02 | abs(result) \< tolerance | Hawaii               |
| 1611 | 3364OT    |          3.65 | abs(result) \< tolerance | Hawaii               |
| 1710 | 337       |          3.09 | abs(result) \< tolerance | Hawaii               |
| 1810 | 339       |          1.72 | abs(result) \< tolerance | Hawaii               |
| 1910 | 311FT     |          1.69 | abs(result) \< tolerance | Hawaii               |
| 2010 | 313TT     |          1.74 | abs(result) \< tolerance | Hawaii               |
| 2114 | 315AL     |          0.71 | abs(result) \< tolerance | Hawaii               |
| 2211 | 322       |          8.69 | abs(result) \< tolerance | Hawaii               |
| 2310 | 323       |          1.13 | abs(result) \< tolerance | Hawaii               |
| 2410 | 324       |          0.14 | abs(result) \< tolerance | Hawaii               |
| 2510 | 325       |          3.48 | abs(result) \< tolerance | Hawaii               |
| 2610 | 326       |          5.97 | abs(result) \< tolerance | Hawaii               |
| 2710 | 42        |          0.42 | abs(result) \< tolerance | Hawaii               |
| 2810 | 441       |          0.39 | abs(result) \< tolerance | Hawaii               |
| 2910 | 445       |         -0.21 | abs(result) \< tolerance | Hawaii               |
| 3010 | 452       |         -0.38 | abs(result) \< tolerance | Hawaii               |
| 3114 | 4A0       |         -0.22 | abs(result) \< tolerance | Hawaii               |
| 3212 | 481       |         -0.65 | abs(result) \< tolerance | Hawaii               |
| 3310 | 482       |        371.13 | abs(result) \< tolerance | Hawaii               |
| 3410 | 483       |         -0.48 | abs(result) \< tolerance | Hawaii               |
| 3510 | 484       |          0.79 | abs(result) \< tolerance | Hawaii               |
| 3610 | 485       |         -0.20 | abs(result) \< tolerance | Hawaii               |
| 3710 | 486       |          9.63 | abs(result) \< tolerance | Hawaii               |
| 3810 | 487OS     |         -0.20 | abs(result) \< tolerance | Hawaii               |
| 3910 | 493       |          3.28 | abs(result) \< tolerance | Hawaii               |
| 4010 | 511       |          1.46 | abs(result) \< tolerance | Hawaii               |
| 4114 | 512       |          0.05 | abs(result) \< tolerance | Hawaii               |
| 4212 | 513       |          0.37 | abs(result) \< tolerance | Hawaii               |
| 4310 | 514       |          4.93 | abs(result) \< tolerance | Hawaii               |
| 4410 | 521CI     |          1.36 | abs(result) \< tolerance | Hawaii               |
| 4510 | 523       |          2.70 | abs(result) \< tolerance | Hawaii               |
| 469  | 524       |          0.29 | abs(result) \< tolerance | Hawaii               |
| 4710 | 525       |          2.90 | abs(result) \< tolerance | Hawaii               |
| 4810 | HS        |         -0.30 | abs(result) \< tolerance | Hawaii               |
| 4910 | ORE       |          0.27 | abs(result) \< tolerance | Hawaii               |
| 5010 | 532RL     |         -0.26 | abs(result) \< tolerance | Hawaii               |
| 5114 | 5411      |          0.24 | abs(result) \< tolerance | Hawaii               |
| 5211 | 5415      |          0.47 | abs(result) \< tolerance | Hawaii               |
| 5310 | 5412OP    |          0.37 | abs(result) \< tolerance | Hawaii               |
| 5410 | 55        |          0.45 | abs(result) \< tolerance | Hawaii               |
| 5510 | 561       |         -0.17 | abs(result) \< tolerance | Hawaii               |
| 5610 | 562       |         -0.02 | abs(result) \< tolerance | Hawaii               |
| 579  | 61        |          0.06 | abs(result) \< tolerance | Hawaii               |
| 5810 | 621       |         -0.01 | abs(result) \< tolerance | Hawaii               |
| 599  | 622       |          0.04 | abs(result) \< tolerance | Hawaii               |
| 6010 | 623       |          0.40 | abs(result) \< tolerance | Hawaii               |
| 6114 | 624       |         -0.13 | abs(result) \< tolerance | Hawaii               |
| 6211 | 711AS     |          0.03 | abs(result) \< tolerance | Hawaii               |
| 6310 | 713       |         -0.50 | abs(result) \< tolerance | Hawaii               |
| 648  | 721       |         -0.81 | abs(result) \< tolerance | Hawaii               |
| 659  | 722       |         -0.35 | abs(result) \< tolerance | Hawaii               |
| 6610 | 81        |         -0.05 | abs(result) \< tolerance | Hawaii               |
| 6710 | GFGD      |          0.76 | abs(result) \< tolerance | Hawaii               |
| 6810 | GFGN      |         -0.34 | abs(result) \< tolerance | Hawaii               |
| 6910 | GFE       |         -0.56 | abs(result) \< tolerance | Hawaii               |
| 709  | GSLG      |         -0.11 | abs(result) \< tolerance | Hawaii               |
| 7114 | GSLE      |          0.89 | abs(result) \< tolerance | Hawaii               |
| 7211 | Used      |          1.96 | abs(result) \< tolerance | Hawaii               |
| 7310 | Other     |         33.86 | abs(result) \< tolerance | Hawaii               |
| 180  | 111CA     |         -0.56 | abs(result) \< tolerance | Idaho                |
| 250  | 113FF     |         -0.11 | abs(result) \< tolerance | Idaho                |
| 350  | 211       |          9.65 | abs(result) \< tolerance | Idaho                |
| 450  | 212       |         -0.37 | abs(result) \< tolerance | Idaho                |
| 550  | 213       |         -0.04 | abs(result) \< tolerance | Idaho                |
| 649  | 22        |         -0.04 | abs(result) \< tolerance | Idaho                |
| 740  | 23        |         -0.12 | abs(result) \< tolerance | Idaho                |
| 820  | 321       |         -0.65 | abs(result) \< tolerance | Idaho                |
| 919  | 327       |          0.47 | abs(result) \< tolerance | Idaho                |
| 1020 | 331       |          0.07 | abs(result) \< tolerance | Idaho                |
| 1120 | 332       |          0.02 | abs(result) \< tolerance | Idaho                |
| 1220 | 333       |          0.11 | abs(result) \< tolerance | Idaho                |
| 1320 | 334       |         -0.19 | abs(result) \< tolerance | Idaho                |
| 1419 | 335       |          0.24 | abs(result) \< tolerance | Idaho                |
| 1514 | 3361MV    |          1.78 | abs(result) \< tolerance | Idaho                |
| 1612 | 3364OT    |          0.32 | abs(result) \< tolerance | Idaho                |
| 1711 | 337       |          0.30 | abs(result) \< tolerance | Idaho                |
| 1811 | 339       |          0.38 | abs(result) \< tolerance | Idaho                |
| 1911 | 311FT     |         -0.21 | abs(result) \< tolerance | Idaho                |
| 2011 | 313TT     |          1.28 | abs(result) \< tolerance | Idaho                |
| 2115 | 315AL     |          1.09 | abs(result) \< tolerance | Idaho                |
| 2212 | 322       |         -0.06 | abs(result) \< tolerance | Idaho                |
| 2311 | 323       |          0.03 | abs(result) \< tolerance | Idaho                |
| 2411 | 324       |         12.32 | abs(result) \< tolerance | Idaho                |
| 2511 | 325       |          1.41 | abs(result) \< tolerance | Idaho                |
| 2611 | 326       |          0.37 | abs(result) \< tolerance | Idaho                |
| 2711 | 42        |          0.11 | abs(result) \< tolerance | Idaho                |
| 2811 | 441       |          0.18 | abs(result) \< tolerance | Idaho                |
| 2911 | 445       |          0.02 | abs(result) \< tolerance | Idaho                |
| 3011 | 452       |         -0.28 | abs(result) \< tolerance | Idaho                |
| 3115 | 4A0       |         -0.17 | abs(result) \< tolerance | Idaho                |
| 3213 | 481       |          0.69 | abs(result) \< tolerance | Idaho                |
| 3311 | 482       |         -0.37 | abs(result) \< tolerance | Idaho                |
| 3411 | 483       |          3.28 | abs(result) \< tolerance | Idaho                |
| 3511 | 484       |         -0.22 | abs(result) \< tolerance | Idaho                |
| 3611 | 485       |          0.88 | abs(result) \< tolerance | Idaho                |
| 3711 | 486       |          2.73 | abs(result) \< tolerance | Idaho                |
| 3811 | 487OS     |          0.36 | abs(result) \< tolerance | Idaho                |
| 3911 | 493       |          1.43 | abs(result) \< tolerance | Idaho                |
| 4011 | 511       |          0.55 | abs(result) \< tolerance | Idaho                |
| 4115 | 512       |          1.87 | abs(result) \< tolerance | Idaho                |
| 4213 | 513       |          0.60 | abs(result) \< tolerance | Idaho                |
| 4311 | 514       |          0.78 | abs(result) \< tolerance | Idaho                |
| 4411 | 521CI     |          0.60 | abs(result) \< tolerance | Idaho                |
| 4511 | 523       |          1.91 | abs(result) \< tolerance | Idaho                |
| 4610 | 524       |          0.30 | abs(result) \< tolerance | Idaho                |
| 4711 | 525       |          0.19 | abs(result) \< tolerance | Idaho                |
| 4811 | HS        |         -0.15 | abs(result) \< tolerance | Idaho                |
| 4911 | ORE       |          0.74 | abs(result) \< tolerance | Idaho                |
| 5011 | 532RL     |          0.51 | abs(result) \< tolerance | Idaho                |
| 5115 | 5411      |          1.07 | abs(result) \< tolerance | Idaho                |
| 5212 | 5415      |          0.21 | abs(result) \< tolerance | Idaho                |
| 5311 | 5412OP    |         -0.03 | abs(result) \< tolerance | Idaho                |
| 5411 | 55        |          1.03 | abs(result) \< tolerance | Idaho                |
| 5511 | 561       |         -0.19 | abs(result) \< tolerance | Idaho                |
| 5611 | 562       |         -0.51 | abs(result) \< tolerance | Idaho                |
| 5710 | 61        |          0.15 | abs(result) \< tolerance | Idaho                |
| 5811 | 621       |         -0.18 | abs(result) \< tolerance | Idaho                |
| 5910 | 622       |         -0.32 | abs(result) \< tolerance | Idaho                |
| 6011 | 623       |         -0.16 | abs(result) \< tolerance | Idaho                |
| 6115 | 624       |         -0.07 | abs(result) \< tolerance | Idaho                |
| 6212 | 711AS     |          0.93 | abs(result) \< tolerance | Idaho                |
| 6311 | 713       |         -0.18 | abs(result) \< tolerance | Idaho                |
| 6410 | 721       |         -0.02 | abs(result) \< tolerance | Idaho                |
| 6611 | 81        |         -0.07 | abs(result) \< tolerance | Idaho                |
| 6711 | GFGD      |         -0.22 | abs(result) \< tolerance | Idaho                |
| 6811 | GFGN      |         -0.21 | abs(result) \< tolerance | Idaho                |
| 6911 | GFE       |         -0.18 | abs(result) \< tolerance | Idaho                |
| 7010 | GSLG      |         -0.16 | abs(result) \< tolerance | Idaho                |
| 7115 | GSLE      |         -0.16 | abs(result) \< tolerance | Idaho                |
| 7212 | Used      |         -4.03 | abs(result) \< tolerance | Idaho                |
| 7311 | Other     |         -8.52 | abs(result) \< tolerance | Idaho                |
| 190  | 111CA     |          0.15 | abs(result) \< tolerance | Illinois             |
| 260  | 113FF     |          0.64 | abs(result) \< tolerance | Illinois             |
| 360  | 211       |         36.05 | abs(result) \< tolerance | Illinois             |
| 460  | 212       |          0.07 | abs(result) \< tolerance | Illinois             |
| 560  | 213       |          0.10 | abs(result) \< tolerance | Illinois             |
| 650  | 22        |         -0.01 | abs(result) \< tolerance | Illinois             |
| 741  | 23        |          0.03 | abs(result) \< tolerance | Illinois             |
| 821  | 321       |          1.41 | abs(result) \< tolerance | Illinois             |
| 920  | 327       |          0.04 | abs(result) \< tolerance | Illinois             |
| 1021 | 331       |          0.23 | abs(result) \< tolerance | Illinois             |
| 1121 | 332       |         -0.30 | abs(result) \< tolerance | Illinois             |
| 1221 | 333       |         -0.14 | abs(result) \< tolerance | Illinois             |
| 1321 | 334       |          0.44 | abs(result) \< tolerance | Illinois             |
| 1420 | 335       |         -0.17 | abs(result) \< tolerance | Illinois             |
| 1515 | 3361MV    |          0.20 | abs(result) \< tolerance | Illinois             |
| 1613 | 3364OT    |          0.82 | abs(result) \< tolerance | Illinois             |
| 1712 | 337       |          0.02 | abs(result) \< tolerance | Illinois             |
| 1812 | 339       |         -0.23 | abs(result) \< tolerance | Illinois             |
| 1912 | 311FT     |         -0.12 | abs(result) \< tolerance | Illinois             |
| 2012 | 313TT     |          1.17 | abs(result) \< tolerance | Illinois             |
| 2116 | 315AL     |          0.08 | abs(result) \< tolerance | Illinois             |
| 2213 | 322       |          0.13 | abs(result) \< tolerance | Illinois             |
| 2312 | 323       |         -0.32 | abs(result) \< tolerance | Illinois             |
| 2412 | 324       |         -0.17 | abs(result) \< tolerance | Illinois             |
| 2512 | 325       |         -0.26 | abs(result) \< tolerance | Illinois             |
| 2612 | 326       |         -0.36 | abs(result) \< tolerance | Illinois             |
| 2712 | 42        |         -0.17 | abs(result) \< tolerance | Illinois             |
| 2812 | 441       |          0.45 | abs(result) \< tolerance | Illinois             |
| 2912 | 445       |         -0.24 | abs(result) \< tolerance | Illinois             |
| 3012 | 452       |         -0.20 | abs(result) \< tolerance | Illinois             |
| 3116 | 4A0       |          0.11 | abs(result) \< tolerance | Illinois             |
| 3214 | 481       |         -0.27 | abs(result) \< tolerance | Illinois             |
| 3312 | 482       |         -0.25 | abs(result) \< tolerance | Illinois             |
| 3412 | 483       |          0.57 | abs(result) \< tolerance | Illinois             |
| 3512 | 484       |         -0.13 | abs(result) \< tolerance | Illinois             |
| 3612 | 485       |          0.08 | abs(result) \< tolerance | Illinois             |
| 3712 | 486       |          1.96 | abs(result) \< tolerance | Illinois             |
| 3812 | 487OS     |          0.17 | abs(result) \< tolerance | Illinois             |
| 3912 | 493       |         -0.18 | abs(result) \< tolerance | Illinois             |
| 4012 | 511       |          0.07 | abs(result) \< tolerance | Illinois             |
| 4116 | 512       |          0.75 | abs(result) \< tolerance | Illinois             |
| 4214 | 513       |          0.38 | abs(result) \< tolerance | Illinois             |
| 4312 | 514       |          0.46 | abs(result) \< tolerance | Illinois             |
| 4412 | 521CI     |         -0.02 | abs(result) \< tolerance | Illinois             |
| 4512 | 523       |         -0.12 | abs(result) \< tolerance | Illinois             |
| 4611 | 524       |         -0.26 | abs(result) \< tolerance | Illinois             |
| 4712 | 525       |          0.14 | abs(result) \< tolerance | Illinois             |
| 4812 | HS        |         -0.29 | abs(result) \< tolerance | Illinois             |
| 4912 | ORE       |          0.79 | abs(result) \< tolerance | Illinois             |
| 5012 | 532RL     |         -0.05 | abs(result) \< tolerance | Illinois             |
| 5116 | 5411      |         -0.28 | abs(result) \< tolerance | Illinois             |
| 5213 | 5415      |         -0.05 | abs(result) \< tolerance | Illinois             |
| 5312 | 5412OP    |         -0.02 | abs(result) \< tolerance | Illinois             |
| 5512 | 561       |         -0.12 | abs(result) \< tolerance | Illinois             |
| 5612 | 562       |         -0.07 | abs(result) \< tolerance | Illinois             |
| 5711 | 61        |         -0.06 | abs(result) \< tolerance | Illinois             |
| 5812 | 621       |          0.26 | abs(result) \< tolerance | Illinois             |
| 5911 | 622       |         -0.06 | abs(result) \< tolerance | Illinois             |
| 6012 | 623       |          0.02 | abs(result) \< tolerance | Illinois             |
| 6116 | 624       |          0.21 | abs(result) \< tolerance | Illinois             |
| 6213 | 711AS     |         -0.06 | abs(result) \< tolerance | Illinois             |
| 6312 | 713       |         -0.12 | abs(result) \< tolerance | Illinois             |
| 6411 | 721       |         -0.05 | abs(result) \< tolerance | Illinois             |
| 6510 | 722       |         -0.05 | abs(result) \< tolerance | Illinois             |
| 6612 | 81        |          0.02 | abs(result) \< tolerance | Illinois             |
| 6712 | GFGD      |         -0.32 | abs(result) \< tolerance | Illinois             |
| 6812 | GFGN      |          0.29 | abs(result) \< tolerance | Illinois             |
| 6912 | GFE       |          0.77 | abs(result) \< tolerance | Illinois             |
| 7011 | GSLG      |         -0.07 | abs(result) \< tolerance | Illinois             |
| 7116 | GSLE      |          1.13 | abs(result) \< tolerance | Illinois             |
| 7213 | Used      |          0.97 | abs(result) \< tolerance | Illinois             |
| 7312 | Other     |        -23.86 | abs(result) \< tolerance | Illinois             |
| 1100 | 111CA     |         -0.12 | abs(result) \< tolerance | Indiana              |
| 270  | 113FF     |          0.51 | abs(result) \< tolerance | Indiana              |
| 370  | 211       |         50.03 | abs(result) \< tolerance | Indiana              |
| 470  | 212       |          0.25 | abs(result) \< tolerance | Indiana              |
| 570  | 213       |          0.13 | abs(result) \< tolerance | Indiana              |
| 660  | 22        |          0.04 | abs(result) \< tolerance | Indiana              |
| 742  | 23        |         -0.12 | abs(result) \< tolerance | Indiana              |
| 822  | 321       |         -0.13 | abs(result) \< tolerance | Indiana              |
| 921  | 327       |         -0.18 | abs(result) \< tolerance | Indiana              |
| 1022 | 331       |         -0.52 | abs(result) \< tolerance | Indiana              |
| 1122 | 332       |         -0.18 | abs(result) \< tolerance | Indiana              |
| 1222 | 333       |         -0.05 | abs(result) \< tolerance | Indiana              |
| 1322 | 334       |          0.67 | abs(result) \< tolerance | Indiana              |
| 1421 | 335       |          0.35 | abs(result) \< tolerance | Indiana              |
| 1516 | 3361MV    |         -0.36 | abs(result) \< tolerance | Indiana              |
| 1614 | 3364OT    |         -0.02 | abs(result) \< tolerance | Indiana              |
| 1713 | 337       |         -0.55 | abs(result) \< tolerance | Indiana              |
| 1813 | 339       |         -0.34 | abs(result) \< tolerance | Indiana              |
| 1913 | 311FT     |         -0.17 | abs(result) \< tolerance | Indiana              |
| 2013 | 313TT     |          0.77 | abs(result) \< tolerance | Indiana              |
| 2117 | 315AL     |          0.53 | abs(result) \< tolerance | Indiana              |
| 2214 | 322       |          0.15 | abs(result) \< tolerance | Indiana              |
| 2313 | 323       |         -0.45 | abs(result) \< tolerance | Indiana              |
| 2413 | 324       |         -0.44 | abs(result) \< tolerance | Indiana              |
| 2513 | 325       |         -0.41 | abs(result) \< tolerance | Indiana              |
| 2613 | 326       |         -0.26 | abs(result) \< tolerance | Indiana              |
| 2713 | 42        |          0.47 | abs(result) \< tolerance | Indiana              |
| 2813 | 441       |          0.59 | abs(result) \< tolerance | Indiana              |
| 2913 | 445       |          0.23 | abs(result) \< tolerance | Indiana              |
| 3013 | 452       |         -0.30 | abs(result) \< tolerance | Indiana              |
| 3117 | 4A0       |          0.05 | abs(result) \< tolerance | Indiana              |
| 3215 | 481       |          1.70 | abs(result) \< tolerance | Indiana              |
| 3313 | 482       |          0.08 | abs(result) \< tolerance | Indiana              |
| 3413 | 483       |          0.02 | abs(result) \< tolerance | Indiana              |
| 3513 | 484       |         -0.18 | abs(result) \< tolerance | Indiana              |
| 3613 | 485       |          0.80 | abs(result) \< tolerance | Indiana              |
| 3713 | 486       |          2.43 | abs(result) \< tolerance | Indiana              |
| 3813 | 487OS     |          0.14 | abs(result) \< tolerance | Indiana              |
| 3913 | 493       |         -0.32 | abs(result) \< tolerance | Indiana              |
| 4013 | 511       |          0.28 | abs(result) \< tolerance | Indiana              |
| 4117 | 512       |          1.01 | abs(result) \< tolerance | Indiana              |
| 4215 | 513       |          0.59 | abs(result) \< tolerance | Indiana              |
| 4313 | 514       |          2.58 | abs(result) \< tolerance | Indiana              |
| 4413 | 521CI     |          0.97 | abs(result) \< tolerance | Indiana              |
| 4513 | 523       |          1.60 | abs(result) \< tolerance | Indiana              |
| 4612 | 524       |         -0.24 | abs(result) \< tolerance | Indiana              |
| 4713 | 525       |         -0.08 | abs(result) \< tolerance | Indiana              |
| 4813 | HS        |         -0.07 | abs(result) \< tolerance | Indiana              |
| 4913 | ORE       |          1.03 | abs(result) \< tolerance | Indiana              |
| 5013 | 532RL     |          0.53 | abs(result) \< tolerance | Indiana              |
| 5117 | 5411      |          0.76 | abs(result) \< tolerance | Indiana              |
| 5214 | 5415      |          0.16 | abs(result) \< tolerance | Indiana              |
| 5313 | 5412OP    |          0.22 | abs(result) \< tolerance | Indiana              |
| 5412 | 55        |          0.85 | abs(result) \< tolerance | Indiana              |
| 5513 | 561       |         -0.03 | abs(result) \< tolerance | Indiana              |
| 5613 | 562       |         -0.17 | abs(result) \< tolerance | Indiana              |
| 5712 | 61        |         -0.04 | abs(result) \< tolerance | Indiana              |
| 5813 | 621       |         -0.27 | abs(result) \< tolerance | Indiana              |
| 5912 | 622       |         -0.29 | abs(result) \< tolerance | Indiana              |
| 6013 | 623       |         -0.35 | abs(result) \< tolerance | Indiana              |
| 6117 | 624       |         -0.09 | abs(result) \< tolerance | Indiana              |
| 6214 | 711AS     |         -0.07 | abs(result) \< tolerance | Indiana              |
| 6313 | 713       |         -0.36 | abs(result) \< tolerance | Indiana              |
| 6412 | 721       |          0.36 | abs(result) \< tolerance | Indiana              |
| 6511 | 722       |         -0.01 | abs(result) \< tolerance | Indiana              |
| 6613 | 81        |         -0.11 | abs(result) \< tolerance | Indiana              |
| 6713 | GFGD      |         -0.44 | abs(result) \< tolerance | Indiana              |
| 6813 | GFGN      |         -0.14 | abs(result) \< tolerance | Indiana              |
| 6913 | GFE       |          0.49 | abs(result) \< tolerance | Indiana              |
| 7012 | GSLG      |          0.01 | abs(result) \< tolerance | Indiana              |
| 7117 | GSLE      |          0.82 | abs(result) \< tolerance | Indiana              |
| 7214 | Used      |         -6.85 | abs(result) \< tolerance | Indiana              |
| 7313 | Other     |        -49.95 | abs(result) \< tolerance | Indiana              |
| 1101 | 111CA     |         -0.52 | abs(result) \< tolerance | Iowa                 |
| 280  | 113FF     |          0.55 | abs(result) \< tolerance | Iowa                 |
| 380  | 211       |        710.83 | abs(result) \< tolerance | Iowa                 |
| 480  | 212       |          0.53 | abs(result) \< tolerance | Iowa                 |
| 580  | 213       |          0.12 | abs(result) \< tolerance | Iowa                 |
| 670  | 22        |         -0.05 | abs(result) \< tolerance | Iowa                 |
| 743  | 23        |         -0.04 | abs(result) \< tolerance | Iowa                 |
| 823  | 321       |         -0.47 | abs(result) \< tolerance | Iowa                 |
| 922  | 327       |         -0.47 | abs(result) \< tolerance | Iowa                 |
| 1023 | 331       |         -0.19 | abs(result) \< tolerance | Iowa                 |
| 1123 | 332       |         -0.14 | abs(result) \< tolerance | Iowa                 |
| 1223 | 333       |         -0.31 | abs(result) \< tolerance | Iowa                 |
| 1323 | 334       |         -0.02 | abs(result) \< tolerance | Iowa                 |
| 1422 | 335       |         -0.26 | abs(result) \< tolerance | Iowa                 |
| 1517 | 3361MV    |          0.30 | abs(result) \< tolerance | Iowa                 |
| 1615 | 3364OT    |          0.13 | abs(result) \< tolerance | Iowa                 |
| 1714 | 337       |         -0.49 | abs(result) \< tolerance | Iowa                 |
| 1814 | 339       |          0.14 | abs(result) \< tolerance | Iowa                 |
| 1914 | 311FT     |         -0.36 | abs(result) \< tolerance | Iowa                 |
| 2014 | 313TT     |          0.50 | abs(result) \< tolerance | Iowa                 |
| 2118 | 315AL     |          0.05 | abs(result) \< tolerance | Iowa                 |
| 2215 | 322       |         -0.07 | abs(result) \< tolerance | Iowa                 |
| 2314 | 323       |         -0.27 | abs(result) \< tolerance | Iowa                 |
| 2414 | 324       |          5.46 | abs(result) \< tolerance | Iowa                 |
| 2514 | 325       |         -0.26 | abs(result) \< tolerance | Iowa                 |
| 2614 | 326       |         -0.23 | abs(result) \< tolerance | Iowa                 |
| 2714 | 42        |          0.19 | abs(result) \< tolerance | Iowa                 |
| 2814 | 441       |          0.88 | abs(result) \< tolerance | Iowa                 |
| 2914 | 445       |         -0.25 | abs(result) \< tolerance | Iowa                 |
| 3014 | 452       |         -0.24 | abs(result) \< tolerance | Iowa                 |
| 3118 | 4A0       |         -0.04 | abs(result) \< tolerance | Iowa                 |
| 3216 | 481       |          5.12 | abs(result) \< tolerance | Iowa                 |
| 3314 | 482       |         -0.31 | abs(result) \< tolerance | Iowa                 |
| 3414 | 483       |          3.33 | abs(result) \< tolerance | Iowa                 |
| 3514 | 484       |         -0.29 | abs(result) \< tolerance | Iowa                 |
| 3614 | 485       |          1.04 | abs(result) \< tolerance | Iowa                 |
| 3714 | 486       |          0.82 | abs(result) \< tolerance | Iowa                 |
| 3814 | 487OS     |          0.50 | abs(result) \< tolerance | Iowa                 |
| 3914 | 493       |         -0.12 | abs(result) \< tolerance | Iowa                 |
| 4118 | 512       |          1.20 | abs(result) \< tolerance | Iowa                 |
| 4216 | 513       |          0.56 | abs(result) \< tolerance | Iowa                 |
| 4314 | 514       |          0.96 | abs(result) \< tolerance | Iowa                 |
| 4414 | 521CI     |         -0.21 | abs(result) \< tolerance | Iowa                 |
| 4514 | 523       |          1.12 | abs(result) \< tolerance | Iowa                 |
| 4613 | 524       |         -0.50 | abs(result) \< tolerance | Iowa                 |
| 4714 | 525       |          0.96 | abs(result) \< tolerance | Iowa                 |
| 4814 | HS        |         -0.15 | abs(result) \< tolerance | Iowa                 |
| 4914 | ORE       |          1.22 | abs(result) \< tolerance | Iowa                 |
| 5014 | 532RL     |          0.34 | abs(result) \< tolerance | Iowa                 |
| 5118 | 5411      |          1.20 | abs(result) \< tolerance | Iowa                 |
| 5215 | 5415      |          0.19 | abs(result) \< tolerance | Iowa                 |
| 5314 | 5412OP    |          0.43 | abs(result) \< tolerance | Iowa                 |
| 5413 | 55        |          0.70 | abs(result) \< tolerance | Iowa                 |
| 5514 | 561       |          0.26 | abs(result) \< tolerance | Iowa                 |
| 5814 | 621       |         -0.02 | abs(result) \< tolerance | Iowa                 |
| 5913 | 622       |          0.03 | abs(result) \< tolerance | Iowa                 |
| 6014 | 623       |         -0.45 | abs(result) \< tolerance | Iowa                 |
| 6118 | 624       |         -0.12 | abs(result) \< tolerance | Iowa                 |
| 6215 | 711AS     |          0.68 | abs(result) \< tolerance | Iowa                 |
| 6314 | 713       |         -0.20 | abs(result) \< tolerance | Iowa                 |
| 6413 | 721       |          0.01 | abs(result) \< tolerance | Iowa                 |
| 6512 | 722       |          0.09 | abs(result) \< tolerance | Iowa                 |
| 6614 | 81        |         -0.01 | abs(result) \< tolerance | Iowa                 |
| 6714 | GFGD      |         -0.58 | abs(result) \< tolerance | Iowa                 |
| 6814 | GFGN      |         -0.23 | abs(result) \< tolerance | Iowa                 |
| 6914 | GFE       |          0.79 | abs(result) \< tolerance | Iowa                 |
| 7013 | GSLG      |         -0.16 | abs(result) \< tolerance | Iowa                 |
| 7118 | GSLE      |          0.47 | abs(result) \< tolerance | Iowa                 |
| 7215 | Used      |         -2.18 | abs(result) \< tolerance | Iowa                 |
| 7314 | Other     |        -62.67 | abs(result) \< tolerance | Iowa                 |
| 1102 | 111CA     |         -0.31 | abs(result) \< tolerance | Kansas               |
| 290  | 113FF     |          0.12 | abs(result) \< tolerance | Kansas               |
| 390  | 211       |          1.83 | abs(result) \< tolerance | Kansas               |
| 490  | 212       |          0.29 | abs(result) \< tolerance | Kansas               |
| 590  | 213       |         -0.02 | abs(result) \< tolerance | Kansas               |
| 680  | 22        |         -0.10 | abs(result) \< tolerance | Kansas               |
| 744  | 23        |          0.09 | abs(result) \< tolerance | Kansas               |
| 824  | 321       |          0.81 | abs(result) \< tolerance | Kansas               |
| 923  | 327       |         -0.19 | abs(result) \< tolerance | Kansas               |
| 1024 | 331       |          1.98 | abs(result) \< tolerance | Kansas               |
| 1124 | 332       |          0.09 | abs(result) \< tolerance | Kansas               |
| 1224 | 333       |         -0.18 | abs(result) \< tolerance | Kansas               |
| 1324 | 334       |          1.10 | abs(result) \< tolerance | Kansas               |
| 1423 | 335       |          0.06 | abs(result) \< tolerance | Kansas               |
| 1518 | 3361MV    |          0.10 | abs(result) \< tolerance | Kansas               |
| 1616 | 3364OT    |         -0.44 | abs(result) \< tolerance | Kansas               |
| 1715 | 337       |          0.21 | abs(result) \< tolerance | Kansas               |
| 1815 | 339       |          0.13 | abs(result) \< tolerance | Kansas               |
| 1915 | 311FT     |         -0.24 | abs(result) \< tolerance | Kansas               |
| 2015 | 313TT     |          0.48 | abs(result) \< tolerance | Kansas               |
| 2119 | 315AL     |          0.48 | abs(result) \< tolerance | Kansas               |
| 2216 | 322       |          0.86 | abs(result) \< tolerance | Kansas               |
| 2315 | 323       |         -0.61 | abs(result) \< tolerance | Kansas               |
| 2415 | 324       |         -0.53 | abs(result) \< tolerance | Kansas               |
| 2515 | 325       |          0.07 | abs(result) \< tolerance | Kansas               |
| 2615 | 326       |         -0.25 | abs(result) \< tolerance | Kansas               |
| 2715 | 42        |          0.02 | abs(result) \< tolerance | Kansas               |
| 2815 | 441       |          0.48 | abs(result) \< tolerance | Kansas               |
| 2915 | 445       |         -0.13 | abs(result) \< tolerance | Kansas               |
| 3015 | 452       |         -0.33 | abs(result) \< tolerance | Kansas               |
| 3119 | 4A0       |         -0.13 | abs(result) \< tolerance | Kansas               |
| 3217 | 481       |          5.89 | abs(result) \< tolerance | Kansas               |
| 3315 | 482       |         -0.60 | abs(result) \< tolerance | Kansas               |
| 3415 | 483       |          9.60 | abs(result) \< tolerance | Kansas               |
| 3515 | 484       |         -0.16 | abs(result) \< tolerance | Kansas               |
| 3615 | 485       |          0.70 | abs(result) \< tolerance | Kansas               |
| 3715 | 486       |         -0.57 | abs(result) \< tolerance | Kansas               |
| 3815 | 487OS     |          0.03 | abs(result) \< tolerance | Kansas               |
| 3915 | 493       |         -0.21 | abs(result) \< tolerance | Kansas               |
| 4014 | 511       |          0.14 | abs(result) \< tolerance | Kansas               |
| 4119 | 512       |          3.17 | abs(result) \< tolerance | Kansas               |
| 4217 | 513       |         -0.16 | abs(result) \< tolerance | Kansas               |
| 4315 | 514       |          2.27 | abs(result) \< tolerance | Kansas               |
| 4415 | 521CI     |          0.69 | abs(result) \< tolerance | Kansas               |
| 4515 | 523       |          0.85 | abs(result) \< tolerance | Kansas               |
| 4614 | 524       |         -0.09 | abs(result) \< tolerance | Kansas               |
| 4715 | 525       |         -0.05 | abs(result) \< tolerance | Kansas               |
| 4815 | HS        |         -0.09 | abs(result) \< tolerance | Kansas               |
| 4915 | ORE       |          1.18 | abs(result) \< tolerance | Kansas               |
| 5015 | 532RL     |         -0.47 | abs(result) \< tolerance | Kansas               |
| 5119 | 5411      |          1.20 | abs(result) \< tolerance | Kansas               |
| 5216 | 5415      |          0.03 | abs(result) \< tolerance | Kansas               |
| 5315 | 5412OP    |          0.05 | abs(result) \< tolerance | Kansas               |
| 5414 | 55        |         -0.07 | abs(result) \< tolerance | Kansas               |
| 5515 | 561       |         -0.02 | abs(result) \< tolerance | Kansas               |
| 5614 | 562       |          0.26 | abs(result) \< tolerance | Kansas               |
| 5713 | 61        |          0.63 | abs(result) \< tolerance | Kansas               |
| 5815 | 621       |          0.24 | abs(result) \< tolerance | Kansas               |
| 5914 | 622       |          0.04 | abs(result) \< tolerance | Kansas               |
| 6015 | 623       |         -0.08 | abs(result) \< tolerance | Kansas               |
| 6119 | 624       |          0.13 | abs(result) \< tolerance | Kansas               |
| 6216 | 711AS     |          3.75 | abs(result) \< tolerance | Kansas               |
| 6315 | 713       |         -0.09 | abs(result) \< tolerance | Kansas               |
| 6414 | 721       |          0.77 | abs(result) \< tolerance | Kansas               |
| 6513 | 722       |         -0.09 | abs(result) \< tolerance | Kansas               |
| 6615 | 81        |          0.09 | abs(result) \< tolerance | Kansas               |
| 6715 | GFGD      |         -0.18 | abs(result) \< tolerance | Kansas               |
| 6815 | GFGN      |         -0.17 | abs(result) \< tolerance | Kansas               |
| 6915 | GFE       |          0.26 | abs(result) \< tolerance | Kansas               |
| 7014 | GSLG      |         -0.12 | abs(result) \< tolerance | Kansas               |
| 7119 | GSLE      |          0.30 | abs(result) \< tolerance | Kansas               |
| 7216 | Used      |          1.21 | abs(result) \< tolerance | Kansas               |
| 7315 | Other     |        -18.78 | abs(result) \< tolerance | Kansas               |
| 1103 | 111CA     |          0.18 | abs(result) \< tolerance | Kentucky             |
| 2100 | 113FF     |          0.11 | abs(result) \< tolerance | Kentucky             |
| 3100 | 211       |          8.34 | abs(result) \< tolerance | Kentucky             |
| 4100 | 212       |         -0.52 | abs(result) \< tolerance | Kentucky             |
| 5100 | 213       |         -0.02 | abs(result) \< tolerance | Kentucky             |
| 690  | 22        |          0.04 | abs(result) \< tolerance | Kentucky             |
| 745  | 23        |          0.09 | abs(result) \< tolerance | Kentucky             |
| 825  | 321       |         -0.25 | abs(result) \< tolerance | Kentucky             |
| 924  | 327       |         -0.19 | abs(result) \< tolerance | Kentucky             |
| 1025 | 331       |         -0.41 | abs(result) \< tolerance | Kentucky             |
| 1125 | 332       |          0.21 | abs(result) \< tolerance | Kentucky             |
| 1225 | 333       |         -0.02 | abs(result) \< tolerance | Kentucky             |
| 1325 | 334       |          1.09 | abs(result) \< tolerance | Kentucky             |
| 1424 | 335       |         -0.38 | abs(result) \< tolerance | Kentucky             |
| 1519 | 3361MV    |         -0.30 | abs(result) \< tolerance | Kentucky             |
| 1617 | 3364OT    |          0.32 | abs(result) \< tolerance | Kentucky             |
| 1816 | 339       |          0.92 | abs(result) \< tolerance | Kentucky             |
| 1916 | 311FT     |         -0.41 | abs(result) \< tolerance | Kentucky             |
| 2016 | 313TT     |          0.13 | abs(result) \< tolerance | Kentucky             |
| 2120 | 315AL     |          0.65 | abs(result) \< tolerance | Kentucky             |
| 2217 | 322       |         -0.25 | abs(result) \< tolerance | Kentucky             |
| 2316 | 323       |         -0.37 | abs(result) \< tolerance | Kentucky             |
| 2416 | 324       |          0.05 | abs(result) \< tolerance | Kentucky             |
| 2516 | 325       |          0.67 | abs(result) \< tolerance | Kentucky             |
| 2616 | 326       |         -0.17 | abs(result) \< tolerance | Kentucky             |
| 2716 | 42        |          0.18 | abs(result) \< tolerance | Kentucky             |
| 2816 | 441       |          0.64 | abs(result) \< tolerance | Kentucky             |
| 2916 | 445       |          0.26 | abs(result) \< tolerance | Kentucky             |
| 3016 | 452       |         -0.32 | abs(result) \< tolerance | Kentucky             |
| 3120 | 4A0       |          0.05 | abs(result) \< tolerance | Kentucky             |
| 3218 | 481       |          0.98 | abs(result) \< tolerance | Kentucky             |
| 3316 | 482       |          0.06 | abs(result) \< tolerance | Kentucky             |
| 3416 | 483       |         -0.49 | abs(result) \< tolerance | Kentucky             |
| 3616 | 485       |          0.96 | abs(result) \< tolerance | Kentucky             |
| 3716 | 486       |          0.61 | abs(result) \< tolerance | Kentucky             |
| 3816 | 487OS     |         -0.49 | abs(result) \< tolerance | Kentucky             |
| 3916 | 493       |         -0.43 | abs(result) \< tolerance | Kentucky             |
| 4015 | 511       |          0.20 | abs(result) \< tolerance | Kentucky             |
| 4120 | 512       |          2.33 | abs(result) \< tolerance | Kentucky             |
| 4218 | 513       |          0.21 | abs(result) \< tolerance | Kentucky             |
| 4316 | 514       |          3.83 | abs(result) \< tolerance | Kentucky             |
| 4416 | 521CI     |          0.47 | abs(result) \< tolerance | Kentucky             |
| 4516 | 523       |          1.10 | abs(result) \< tolerance | Kentucky             |
| 4615 | 524       |         -0.07 | abs(result) \< tolerance | Kentucky             |
| 4716 | 525       |          1.30 | abs(result) \< tolerance | Kentucky             |
| 4816 | HS        |         -0.06 | abs(result) \< tolerance | Kentucky             |
| 4916 | ORE       |          1.01 | abs(result) \< tolerance | Kentucky             |
| 5016 | 532RL     |          0.50 | abs(result) \< tolerance | Kentucky             |
| 5120 | 5411      |          0.52 | abs(result) \< tolerance | Kentucky             |
| 5217 | 5415      |          0.34 | abs(result) \< tolerance | Kentucky             |
| 5316 | 5412OP    |          0.33 | abs(result) \< tolerance | Kentucky             |
| 5415 | 55        |          0.69 | abs(result) \< tolerance | Kentucky             |
| 5516 | 561       |         -0.04 | abs(result) \< tolerance | Kentucky             |
| 5615 | 562       |         -0.12 | abs(result) \< tolerance | Kentucky             |
| 5714 | 61        |          0.40 | abs(result) \< tolerance | Kentucky             |
| 5816 | 621       |         -0.17 | abs(result) \< tolerance | Kentucky             |
| 5915 | 622       |         -0.27 | abs(result) \< tolerance | Kentucky             |
| 6016 | 623       |         -0.21 | abs(result) \< tolerance | Kentucky             |
| 6120 | 624       |          0.03 | abs(result) \< tolerance | Kentucky             |
| 6217 | 711AS     |          0.58 | abs(result) \< tolerance | Kentucky             |
| 6316 | 713       |          0.44 | abs(result) \< tolerance | Kentucky             |
| 6415 | 721       |          0.36 | abs(result) \< tolerance | Kentucky             |
| 6514 | 722       |         -0.10 | abs(result) \< tolerance | Kentucky             |
| 6616 | 81        |         -0.02 | abs(result) \< tolerance | Kentucky             |
| 6716 | GFGD      |         -0.20 | abs(result) \< tolerance | Kentucky             |
| 6816 | GFGN      |          1.19 | abs(result) \< tolerance | Kentucky             |
| 6916 | GFE       |          0.13 | abs(result) \< tolerance | Kentucky             |
| 7015 | GSLG      |          0.10 | abs(result) \< tolerance | Kentucky             |
| 7120 | GSLE      |          0.62 | abs(result) \< tolerance | Kentucky             |
| 7217 | Used      |         -0.49 | abs(result) \< tolerance | Kentucky             |
| 7316 | Other     |        -15.83 | abs(result) \< tolerance | Kentucky             |
| 1104 | 111CA     |          0.28 | abs(result) \< tolerance | Louisiana            |
| 2101 | 113FF     |         -0.25 | abs(result) \< tolerance | Louisiana            |
| 3101 | 211       |          1.74 | abs(result) \< tolerance | Louisiana            |
| 4101 | 212       |          1.66 | abs(result) \< tolerance | Louisiana            |
| 5101 | 213       |         -0.02 | abs(result) \< tolerance | Louisiana            |
| 6100 | 22        |         -0.06 | abs(result) \< tolerance | Louisiana            |
| 746  | 23        |         -0.24 | abs(result) \< tolerance | Louisiana            |
| 826  | 321       |         -0.30 | abs(result) \< tolerance | Louisiana            |
| 925  | 327       |          0.38 | abs(result) \< tolerance | Louisiana            |
| 1026 | 331       |          0.07 | abs(result) \< tolerance | Louisiana            |
| 1126 | 332       |          0.11 | abs(result) \< tolerance | Louisiana            |
| 1226 | 333       |         -0.02 | abs(result) \< tolerance | Louisiana            |
| 1326 | 334       |          2.05 | abs(result) \< tolerance | Louisiana            |
| 1425 | 335       |          2.29 | abs(result) \< tolerance | Louisiana            |
| 1520 | 3361MV    |          6.28 | abs(result) \< tolerance | Louisiana            |
| 1618 | 3364OT    |          0.03 | abs(result) \< tolerance | Louisiana            |
| 1716 | 337       |          2.98 | abs(result) \< tolerance | Louisiana            |
| 1817 | 339       |          0.67 | abs(result) \< tolerance | Louisiana            |
| 1917 | 311FT     |          0.75 | abs(result) \< tolerance | Louisiana            |
| 2017 | 313TT     |          1.07 | abs(result) \< tolerance | Louisiana            |
| 2121 | 315AL     |          2.83 | abs(result) \< tolerance | Louisiana            |
| 2218 | 322       |         -0.49 | abs(result) \< tolerance | Louisiana            |
| 2317 | 323       |          0.61 | abs(result) \< tolerance | Louisiana            |
| 2417 | 324       |         -0.62 | abs(result) \< tolerance | Louisiana            |
| 2517 | 325       |         -0.40 | abs(result) \< tolerance | Louisiana            |
| 2617 | 326       |          0.56 | abs(result) \< tolerance | Louisiana            |
| 2717 | 42        |          0.29 | abs(result) \< tolerance | Louisiana            |
| 2817 | 441       |          0.47 | abs(result) \< tolerance | Louisiana            |
| 2917 | 445       |         -0.14 | abs(result) \< tolerance | Louisiana            |
| 3017 | 452       |         -0.49 | abs(result) \< tolerance | Louisiana            |
| 3121 | 4A0       |         -0.17 | abs(result) \< tolerance | Louisiana            |
| 3219 | 481       |          0.42 | abs(result) \< tolerance | Louisiana            |
| 3317 | 482       |          0.20 | abs(result) \< tolerance | Louisiana            |
| 3417 | 483       |         -0.56 | abs(result) \< tolerance | Louisiana            |
| 3516 | 484       |          0.30 | abs(result) \< tolerance | Louisiana            |
| 3617 | 485       |          0.26 | abs(result) \< tolerance | Louisiana            |
| 3717 | 486       |          2.12 | abs(result) \< tolerance | Louisiana            |
| 3817 | 487OS     |         -0.30 | abs(result) \< tolerance | Louisiana            |
| 3917 | 493       |          0.38 | abs(result) \< tolerance | Louisiana            |
| 4016 | 511       |          1.36 | abs(result) \< tolerance | Louisiana            |
| 4121 | 512       |         -0.10 | abs(result) \< tolerance | Louisiana            |
| 4219 | 513       |          0.43 | abs(result) \< tolerance | Louisiana            |
| 4317 | 514       |          3.31 | abs(result) \< tolerance | Louisiana            |
| 4417 | 521CI     |          0.53 | abs(result) \< tolerance | Louisiana            |
| 4517 | 523       |          3.12 | abs(result) \< tolerance | Louisiana            |
| 4616 | 524       |          0.06 | abs(result) \< tolerance | Louisiana            |
| 4717 | 525       |          0.53 | abs(result) \< tolerance | Louisiana            |
| 4817 | HS        |         -0.04 | abs(result) \< tolerance | Louisiana            |
| 4917 | ORE       |          1.03 | abs(result) \< tolerance | Louisiana            |
| 5017 | 532RL     |         -0.21 | abs(result) \< tolerance | Louisiana            |
| 5121 | 5411      |         -0.16 | abs(result) \< tolerance | Louisiana            |
| 5218 | 5415      |          0.63 | abs(result) \< tolerance | Louisiana            |
| 5317 | 5412OP    |          0.30 | abs(result) \< tolerance | Louisiana            |
| 5416 | 55        |          1.00 | abs(result) \< tolerance | Louisiana            |
| 5517 | 561       |          0.14 | abs(result) \< tolerance | Louisiana            |
| 5616 | 562       |         -0.25 | abs(result) \< tolerance | Louisiana            |
| 5715 | 61        |         -0.02 | abs(result) \< tolerance | Louisiana            |
| 5817 | 621       |         -0.18 | abs(result) \< tolerance | Louisiana            |
| 5916 | 622       |         -0.22 | abs(result) \< tolerance | Louisiana            |
| 6017 | 623       |         -0.06 | abs(result) \< tolerance | Louisiana            |
| 6121 | 624       |         -0.07 | abs(result) \< tolerance | Louisiana            |
| 6218 | 711AS     |         -0.09 | abs(result) \< tolerance | Louisiana            |
| 6317 | 713       |         -0.22 | abs(result) \< tolerance | Louisiana            |
| 6416 | 721       |         -0.36 | abs(result) \< tolerance | Louisiana            |
| 6515 | 722       |         -0.02 | abs(result) \< tolerance | Louisiana            |
| 6617 | 81        |         -0.08 | abs(result) \< tolerance | Louisiana            |
| 6717 | GFGD      |         -0.20 | abs(result) \< tolerance | Louisiana            |
| 6817 | GFGN      |         -0.15 | abs(result) \< tolerance | Louisiana            |
| 6917 | GFE       |          0.63 | abs(result) \< tolerance | Louisiana            |
| 7016 | GSLG      |          0.04 | abs(result) \< tolerance | Louisiana            |
| 7121 | GSLE      |          0.24 | abs(result) \< tolerance | Louisiana            |
| 7218 | Used      |          1.70 | abs(result) \< tolerance | Louisiana            |
| 7317 | Other     |        -36.22 | abs(result) \< tolerance | Louisiana            |
| 1105 | 111CA     |          0.50 | abs(result) \< tolerance | Maine                |
| 2102 | 113FF     |         -0.07 | abs(result) \< tolerance | Maine                |
| 3102 | 211       |        419.33 | abs(result) \< tolerance | Maine                |
| 4102 | 212       |          0.85 | abs(result) \< tolerance | Maine                |
| 5102 | 213       |          0.68 | abs(result) \< tolerance | Maine                |
| 6101 | 22        |          0.23 | abs(result) \< tolerance | Maine                |
| 747  | 23        |          0.26 | abs(result) \< tolerance | Maine                |
| 827  | 321       |         -0.55 | abs(result) \< tolerance | Maine                |
| 1027 | 331       |          2.62 | abs(result) \< tolerance | Maine                |
| 1127 | 332       |         -0.06 | abs(result) \< tolerance | Maine                |
| 1227 | 333       |         -0.03 | abs(result) \< tolerance | Maine                |
| 1327 | 334       |          0.25 | abs(result) \< tolerance | Maine                |
| 1426 | 335       |          1.99 | abs(result) \< tolerance | Maine                |
| 1521 | 3361MV    |          1.61 | abs(result) \< tolerance | Maine                |
| 1619 | 3364OT    |         -0.23 | abs(result) \< tolerance | Maine                |
| 1717 | 337       |          0.11 | abs(result) \< tolerance | Maine                |
| 1818 | 339       |          0.19 | abs(result) \< tolerance | Maine                |
| 1918 | 311FT     |          0.45 | abs(result) \< tolerance | Maine                |
| 2018 | 313TT     |         -0.39 | abs(result) \< tolerance | Maine                |
| 2122 | 315AL     |         -0.74 | abs(result) \< tolerance | Maine                |
| 2219 | 322       |         -0.54 | abs(result) \< tolerance | Maine                |
| 2318 | 323       |          0.15 | abs(result) \< tolerance | Maine                |
| 2418 | 324       |          3.21 | abs(result) \< tolerance | Maine                |
| 2518 | 325       |          0.26 | abs(result) \< tolerance | Maine                |
| 2718 | 42        |          0.18 | abs(result) \< tolerance | Maine                |
| 2818 | 441       |          0.32 | abs(result) \< tolerance | Maine                |
| 2918 | 445       |         -0.25 | abs(result) \< tolerance | Maine                |
| 3018 | 452       |         -0.23 | abs(result) \< tolerance | Maine                |
| 3122 | 4A0       |         -0.23 | abs(result) \< tolerance | Maine                |
| 3220 | 481       |          2.94 | abs(result) \< tolerance | Maine                |
| 3318 | 482       |          0.88 | abs(result) \< tolerance | Maine                |
| 3418 | 483       |          2.34 | abs(result) \< tolerance | Maine                |
| 3517 | 484       |         -0.07 | abs(result) \< tolerance | Maine                |
| 3618 | 485       |          0.27 | abs(result) \< tolerance | Maine                |
| 3718 | 486       |          1.52 | abs(result) \< tolerance | Maine                |
| 3818 | 487OS     |          0.23 | abs(result) \< tolerance | Maine                |
| 3918 | 493       |         -0.03 | abs(result) \< tolerance | Maine                |
| 4017 | 511       |          0.45 | abs(result) \< tolerance | Maine                |
| 4122 | 512       |          1.40 | abs(result) \< tolerance | Maine                |
| 4220 | 513       |          1.19 | abs(result) \< tolerance | Maine                |
| 4318 | 514       |          2.32 | abs(result) \< tolerance | Maine                |
| 4418 | 521CI     |          0.31 | abs(result) \< tolerance | Maine                |
| 4518 | 523       |          1.19 | abs(result) \< tolerance | Maine                |
| 4617 | 524       |         -0.07 | abs(result) \< tolerance | Maine                |
| 4718 | 525       |          2.93 | abs(result) \< tolerance | Maine                |
| 4818 | HS        |         -0.12 | abs(result) \< tolerance | Maine                |
| 4918 | ORE       |          0.66 | abs(result) \< tolerance | Maine                |
| 5018 | 532RL     |          0.28 | abs(result) \< tolerance | Maine                |
| 5122 | 5411      |          0.36 | abs(result) \< tolerance | Maine                |
| 5219 | 5415      |          0.08 | abs(result) \< tolerance | Maine                |
| 5318 | 5412OP    |          0.13 | abs(result) \< tolerance | Maine                |
| 5417 | 55        |          0.01 | abs(result) \< tolerance | Maine                |
| 5617 | 562       |         -0.09 | abs(result) \< tolerance | Maine                |
| 5716 | 61        |         -0.10 | abs(result) \< tolerance | Maine                |
| 5818 | 621       |         -0.05 | abs(result) \< tolerance | Maine                |
| 5917 | 622       |         -0.41 | abs(result) \< tolerance | Maine                |
| 6018 | 623       |         -0.46 | abs(result) \< tolerance | Maine                |
| 6122 | 624       |         -0.36 | abs(result) \< tolerance | Maine                |
| 6219 | 711AS     |          0.35 | abs(result) \< tolerance | Maine                |
| 6318 | 713       |          0.03 | abs(result) \< tolerance | Maine                |
| 6417 | 721       |         -0.28 | abs(result) \< tolerance | Maine                |
| 6516 | 722       |         -0.04 | abs(result) \< tolerance | Maine                |
| 6618 | 81        |          0.07 | abs(result) \< tolerance | Maine                |
| 6718 | GFGD      |         -0.39 | abs(result) \< tolerance | Maine                |
| 6818 | GFGN      |          0.20 | abs(result) \< tolerance | Maine                |
| 6918 | GFE       |         -0.33 | abs(result) \< tolerance | Maine                |
| 7017 | GSLG      |          0.08 | abs(result) \< tolerance | Maine                |
| 7122 | GSLE      |          1.57 | abs(result) \< tolerance | Maine                |
| 7219 | Used      |         -1.47 | abs(result) \< tolerance | Maine                |
| 7318 | Other     |         -0.54 | abs(result) \< tolerance | Maine                |
| 1106 | 111CA     |          0.62 | abs(result) \< tolerance | Maryland             |
| 3103 | 211       |        517.95 | abs(result) \< tolerance | Maryland             |
| 4103 | 212       |          2.45 | abs(result) \< tolerance | Maryland             |
| 5103 | 213       |          0.05 | abs(result) \< tolerance | Maryland             |
| 6102 | 22        |         -0.17 | abs(result) \< tolerance | Maryland             |
| 748  | 23        |         -0.19 | abs(result) \< tolerance | Maryland             |
| 828  | 321       |          1.33 | abs(result) \< tolerance | Maryland             |
| 926  | 327       |          0.82 | abs(result) \< tolerance | Maryland             |
| 1028 | 331       |          1.22 | abs(result) \< tolerance | Maryland             |
| 1128 | 332       |          1.32 | abs(result) \< tolerance | Maryland             |
| 1228 | 333       |          0.21 | abs(result) \< tolerance | Maryland             |
| 1328 | 334       |         -0.15 | abs(result) \< tolerance | Maryland             |
| 1427 | 335       |          2.49 | abs(result) \< tolerance | Maryland             |
| 1522 | 3361MV    |          6.68 | abs(result) \< tolerance | Maryland             |
| 1620 | 3364OT    |          1.38 | abs(result) \< tolerance | Maryland             |
| 1718 | 337       |          0.62 | abs(result) \< tolerance | Maryland             |
| 1819 | 339       |          0.24 | abs(result) \< tolerance | Maryland             |
| 1919 | 311FT     |          0.46 | abs(result) \< tolerance | Maryland             |
| 2019 | 313TT     |          0.38 | abs(result) \< tolerance | Maryland             |
| 2123 | 315AL     |         -0.01 | abs(result) \< tolerance | Maryland             |
| 2220 | 322       |          1.76 | abs(result) \< tolerance | Maryland             |
| 2319 | 323       |          0.18 | abs(result) \< tolerance | Maryland             |
| 2419 | 324       |          2.31 | abs(result) \< tolerance | Maryland             |
| 2519 | 325       |         -0.17 | abs(result) \< tolerance | Maryland             |
| 2618 | 326       |          0.36 | abs(result) \< tolerance | Maryland             |
| 2719 | 42        |          0.13 | abs(result) \< tolerance | Maryland             |
| 2819 | 441       |          0.34 | abs(result) \< tolerance | Maryland             |
| 2919 | 445       |         -0.34 | abs(result) \< tolerance | Maryland             |
| 3019 | 452       |         -0.06 | abs(result) \< tolerance | Maryland             |
| 3123 | 4A0       |          0.18 | abs(result) \< tolerance | Maryland             |
| 3221 | 481       |          0.39 | abs(result) \< tolerance | Maryland             |
| 3319 | 482       |          0.22 | abs(result) \< tolerance | Maryland             |
| 3419 | 483       |          0.28 | abs(result) \< tolerance | Maryland             |
| 3518 | 484       |          0.45 | abs(result) \< tolerance | Maryland             |
| 3619 | 485       |         -0.06 | abs(result) \< tolerance | Maryland             |
| 3719 | 486       |          4.42 | abs(result) \< tolerance | Maryland             |
| 3819 | 487OS     |         -0.05 | abs(result) \< tolerance | Maryland             |
| 3919 | 493       |         -0.19 | abs(result) \< tolerance | Maryland             |
| 4018 | 511       |          0.29 | abs(result) \< tolerance | Maryland             |
| 4123 | 512       |          1.70 | abs(result) \< tolerance | Maryland             |
| 4221 | 513       |         -0.14 | abs(result) \< tolerance | Maryland             |
| 4319 | 514       |          0.92 | abs(result) \< tolerance | Maryland             |
| 4419 | 521CI     |          0.87 | abs(result) \< tolerance | Maryland             |
| 4519 | 523       |          0.46 | abs(result) \< tolerance | Maryland             |
| 4618 | 524       |          0.36 | abs(result) \< tolerance | Maryland             |
| 4719 | 525       |         -0.57 | abs(result) \< tolerance | Maryland             |
| 4819 | HS        |         -0.28 | abs(result) \< tolerance | Maryland             |
| 4919 | ORE       |          0.46 | abs(result) \< tolerance | Maryland             |
| 5019 | 532RL     |         -0.42 | abs(result) \< tolerance | Maryland             |
| 5123 | 5411      |          0.18 | abs(result) \< tolerance | Maryland             |
| 5220 | 5415      |          0.28 | abs(result) \< tolerance | Maryland             |
| 5319 | 5412OP    |          0.11 | abs(result) \< tolerance | Maryland             |
| 5418 | 55        |          0.43 | abs(result) \< tolerance | Maryland             |
| 5518 | 561       |         -0.06 | abs(result) \< tolerance | Maryland             |
| 5618 | 562       |         -0.05 | abs(result) \< tolerance | Maryland             |
| 5717 | 61        |         -0.03 | abs(result) \< tolerance | Maryland             |
| 5819 | 621       |          0.14 | abs(result) \< tolerance | Maryland             |
| 5918 | 622       |          0.15 | abs(result) \< tolerance | Maryland             |
| 6019 | 623       |          0.04 | abs(result) \< tolerance | Maryland             |
| 6123 | 624       |          0.34 | abs(result) \< tolerance | Maryland             |
| 6220 | 711AS     |          0.14 | abs(result) \< tolerance | Maryland             |
| 6319 | 713       |         -0.07 | abs(result) \< tolerance | Maryland             |
| 6418 | 721       |          0.21 | abs(result) \< tolerance | Maryland             |
| 6619 | 81        |          0.09 | abs(result) \< tolerance | Maryland             |
| 6719 | GFGD      |          4.63 | abs(result) \< tolerance | Maryland             |
| 6819 | GFGN      |         -0.38 | abs(result) \< tolerance | Maryland             |
| 6919 | GFE       |         -0.79 | abs(result) \< tolerance | Maryland             |
| 7018 | GSLG      |          0.04 | abs(result) \< tolerance | Maryland             |
| 7123 | GSLE      |          0.68 | abs(result) \< tolerance | Maryland             |
| 7220 | Used      |          6.77 | abs(result) \< tolerance | Maryland             |
| 7319 | Other     |         46.96 | abs(result) \< tolerance | Maryland             |
| 1107 | 111CA     |          8.26 | abs(result) \< tolerance | Massachusetts        |
| 2103 | 113FF     |         -0.32 | abs(result) \< tolerance | Massachusetts        |
| 3104 | 211       |       3025.17 | abs(result) \< tolerance | Massachusetts        |
| 4104 | 212       |          2.43 | abs(result) \< tolerance | Massachusetts        |
| 5104 | 213       |          0.01 | abs(result) \< tolerance | Massachusetts        |
| 6103 | 22        |          0.11 | abs(result) \< tolerance | Massachusetts        |
| 749  | 23        |         -0.04 | abs(result) \< tolerance | Massachusetts        |
| 829  | 321       |          1.80 | abs(result) \< tolerance | Massachusetts        |
| 927  | 327       |          0.64 | abs(result) \< tolerance | Massachusetts        |
| 1029 | 331       |          1.84 | abs(result) \< tolerance | Massachusetts        |
| 1129 | 332       |         -0.30 | abs(result) \< tolerance | Massachusetts        |
| 1229 | 333       |          0.24 | abs(result) \< tolerance | Massachusetts        |
| 1329 | 334       |         -0.28 | abs(result) \< tolerance | Massachusetts        |
| 1428 | 335       |          0.06 | abs(result) \< tolerance | Massachusetts        |
| 1523 | 3361MV    |          3.62 | abs(result) \< tolerance | Massachusetts        |
| 1621 | 3364OT    |          0.08 | abs(result) \< tolerance | Massachusetts        |
| 1719 | 337       |          0.63 | abs(result) \< tolerance | Massachusetts        |
| 1820 | 339       |         -0.21 | abs(result) \< tolerance | Massachusetts        |
| 1920 | 311FT     |          1.00 | abs(result) \< tolerance | Massachusetts        |
| 2020 | 313TT     |         -0.12 | abs(result) \< tolerance | Massachusetts        |
| 2124 | 315AL     |         -0.44 | abs(result) \< tolerance | Massachusetts        |
| 2221 | 322       |          0.39 | abs(result) \< tolerance | Massachusetts        |
| 2420 | 324       |          3.81 | abs(result) \< tolerance | Massachusetts        |
| 2520 | 325       |         -0.20 | abs(result) \< tolerance | Massachusetts        |
| 2619 | 326       |          0.22 | abs(result) \< tolerance | Massachusetts        |
| 2720 | 42        |         -0.06 | abs(result) \< tolerance | Massachusetts        |
| 2820 | 441       |          0.61 | abs(result) \< tolerance | Massachusetts        |
| 2920 | 445       |         -0.28 | abs(result) \< tolerance | Massachusetts        |
| 3020 | 452       |          0.47 | abs(result) \< tolerance | Massachusetts        |
| 3124 | 4A0       |          0.31 | abs(result) \< tolerance | Massachusetts        |
| 3222 | 481       |          0.65 | abs(result) \< tolerance | Massachusetts        |
| 3320 | 482       |          0.30 | abs(result) \< tolerance | Massachusetts        |
| 3420 | 483       |          0.57 | abs(result) \< tolerance | Massachusetts        |
| 3519 | 484       |          0.76 | abs(result) \< tolerance | Massachusetts        |
| 3620 | 485       |         -0.28 | abs(result) \< tolerance | Massachusetts        |
| 3720 | 486       |          3.64 | abs(result) \< tolerance | Massachusetts        |
| 3820 | 487OS     |          0.51 | abs(result) \< tolerance | Massachusetts        |
| 3920 | 493       |          0.36 | abs(result) \< tolerance | Massachusetts        |
| 4019 | 511       |         -0.19 | abs(result) \< tolerance | Massachusetts        |
| 4124 | 512       |          0.75 | abs(result) \< tolerance | Massachusetts        |
| 4222 | 513       |          0.67 | abs(result) \< tolerance | Massachusetts        |
| 4320 | 514       |         -0.07 | abs(result) \< tolerance | Massachusetts        |
| 4420 | 521CI     |          0.14 | abs(result) \< tolerance | Massachusetts        |
| 4520 | 523       |         -0.39 | abs(result) \< tolerance | Massachusetts        |
| 4619 | 524       |         -0.02 | abs(result) \< tolerance | Massachusetts        |
| 4720 | 525       |         -0.22 | abs(result) \< tolerance | Massachusetts        |
| 4820 | HS        |         -0.32 | abs(result) \< tolerance | Massachusetts        |
| 4920 | ORE       |          0.73 | abs(result) \< tolerance | Massachusetts        |
| 5020 | 532RL     |          0.48 | abs(result) \< tolerance | Massachusetts        |
| 5124 | 5411      |         -0.02 | abs(result) \< tolerance | Massachusetts        |
| 5221 | 5415      |         -0.22 | abs(result) \< tolerance | Massachusetts        |
| 5320 | 5412OP    |         -0.23 | abs(result) \< tolerance | Massachusetts        |
| 5419 | 55        |         -0.20 | abs(result) \< tolerance | Massachusetts        |
| 5519 | 561       |          0.16 | abs(result) \< tolerance | Massachusetts        |
| 5619 | 562       |         -0.18 | abs(result) \< tolerance | Massachusetts        |
| 5718 | 61        |         -0.49 | abs(result) \< tolerance | Massachusetts        |
| 5820 | 621       |          0.02 | abs(result) \< tolerance | Massachusetts        |
| 5919 | 622       |         -0.29 | abs(result) \< tolerance | Massachusetts        |
| 6020 | 623       |         -0.19 | abs(result) \< tolerance | Massachusetts        |
| 6124 | 624       |         -0.31 | abs(result) \< tolerance | Massachusetts        |
| 6221 | 711AS     |         -0.14 | abs(result) \< tolerance | Massachusetts        |
| 6320 | 713       |          0.13 | abs(result) \< tolerance | Massachusetts        |
| 6419 | 721       |         -0.07 | abs(result) \< tolerance | Massachusetts        |
| 6517 | 722       |         -0.03 | abs(result) \< tolerance | Massachusetts        |
| 6620 | 81        |          0.21 | abs(result) \< tolerance | Massachusetts        |
| 6720 | GFGD      |         -0.87 | abs(result) \< tolerance | Massachusetts        |
| 6920 | GFE       |          0.69 | abs(result) \< tolerance | Massachusetts        |
| 7019 | GSLG      |          0.08 | abs(result) \< tolerance | Massachusetts        |
| 7124 | GSLE      |          1.16 | abs(result) \< tolerance | Massachusetts        |
| 7221 | Used      |         -1.91 | abs(result) \< tolerance | Massachusetts        |
| 7320 | Other     |        -14.16 | abs(result) \< tolerance | Massachusetts        |
| 1108 | 111CA     |          0.10 | abs(result) \< tolerance | Michigan             |
| 2104 | 113FF     |          0.57 | abs(result) \< tolerance | Michigan             |
| 3105 | 211       |         11.34 | abs(result) \< tolerance | Michigan             |
| 4105 | 212       |          0.20 | abs(result) \< tolerance | Michigan             |
| 5105 | 213       |         -0.02 | abs(result) \< tolerance | Michigan             |
| 6104 | 22        |         -0.05 | abs(result) \< tolerance | Michigan             |
| 750  | 23        |          0.05 | abs(result) \< tolerance | Michigan             |
| 830  | 321       |          0.30 | abs(result) \< tolerance | Michigan             |
| 928  | 327       |          0.49 | abs(result) \< tolerance | Michigan             |
| 1030 | 331       |          0.97 | abs(result) \< tolerance | Michigan             |
| 1130 | 332       |          0.10 | abs(result) \< tolerance | Michigan             |
| 1230 | 333       |         -0.08 | abs(result) \< tolerance | Michigan             |
| 1330 | 334       |          1.17 | abs(result) \< tolerance | Michigan             |
| 1429 | 335       |          0.11 | abs(result) \< tolerance | Michigan             |
| 1524 | 3361MV    |         -0.31 | abs(result) \< tolerance | Michigan             |
| 1622 | 3364OT    |          0.26 | abs(result) \< tolerance | Michigan             |
| 1720 | 337       |         -0.45 | abs(result) \< tolerance | Michigan             |
| 1821 | 339       |         -0.26 | abs(result) \< tolerance | Michigan             |
| 1921 | 311FT     |          0.30 | abs(result) \< tolerance | Michigan             |
| 2021 | 313TT     |          2.77 | abs(result) \< tolerance | Michigan             |
| 2125 | 315AL     |          0.86 | abs(result) \< tolerance | Michigan             |
| 2222 | 322       |          0.06 | abs(result) \< tolerance | Michigan             |
| 2320 | 323       |         -0.27 | abs(result) \< tolerance | Michigan             |
| 2421 | 324       |          1.39 | abs(result) \< tolerance | Michigan             |
| 2521 | 325       |          0.31 | abs(result) \< tolerance | Michigan             |
| 2721 | 42        |          0.20 | abs(result) \< tolerance | Michigan             |
| 2821 | 441       |          0.50 | abs(result) \< tolerance | Michigan             |
| 2921 | 445       |          0.06 | abs(result) \< tolerance | Michigan             |
| 3021 | 452       |         -0.22 | abs(result) \< tolerance | Michigan             |
| 3125 | 4A0       |          0.14 | abs(result) \< tolerance | Michigan             |
| 3223 | 481       |         -0.08 | abs(result) \< tolerance | Michigan             |
| 3321 | 482       |          1.63 | abs(result) \< tolerance | Michigan             |
| 3421 | 483       |          1.26 | abs(result) \< tolerance | Michigan             |
| 3520 | 484       |          0.09 | abs(result) \< tolerance | Michigan             |
| 3621 | 485       |          0.90 | abs(result) \< tolerance | Michigan             |
| 3721 | 486       |          0.44 | abs(result) \< tolerance | Michigan             |
| 3821 | 487OS     |          0.29 | abs(result) \< tolerance | Michigan             |
| 3921 | 493       |          0.28 | abs(result) \< tolerance | Michigan             |
| 4020 | 511       |          0.19 | abs(result) \< tolerance | Michigan             |
| 4125 | 512       |          0.96 | abs(result) \< tolerance | Michigan             |
| 4223 | 513       |          0.64 | abs(result) \< tolerance | Michigan             |
| 4321 | 514       |          0.96 | abs(result) \< tolerance | Michigan             |
| 4421 | 521CI     |          0.92 | abs(result) \< tolerance | Michigan             |
| 4521 | 523       |          1.95 | abs(result) \< tolerance | Michigan             |
| 4620 | 524       |          0.05 | abs(result) \< tolerance | Michigan             |
| 4721 | 525       |          1.57 | abs(result) \< tolerance | Michigan             |
| 4821 | HS        |         -0.06 | abs(result) \< tolerance | Michigan             |
| 4921 | ORE       |          0.79 | abs(result) \< tolerance | Michigan             |
| 5021 | 532RL     |         -0.08 | abs(result) \< tolerance | Michigan             |
| 5125 | 5411      |          0.32 | abs(result) \< tolerance | Michigan             |
| 5222 | 5415      |         -0.02 | abs(result) \< tolerance | Michigan             |
| 5321 | 5412OP    |         -0.13 | abs(result) \< tolerance | Michigan             |
| 5420 | 55        |          0.03 | abs(result) \< tolerance | Michigan             |
| 5520 | 561       |         -0.10 | abs(result) \< tolerance | Michigan             |
| 5620 | 562       |         -0.14 | abs(result) \< tolerance | Michigan             |
| 5719 | 61        |          0.32 | abs(result) \< tolerance | Michigan             |
| 5821 | 621       |         -0.03 | abs(result) \< tolerance | Michigan             |
| 5920 | 622       |         -0.28 | abs(result) \< tolerance | Michigan             |
| 6021 | 623       |         -0.10 | abs(result) \< tolerance | Michigan             |
| 6125 | 624       |          0.27 | abs(result) \< tolerance | Michigan             |
| 6222 | 711AS     |          0.16 | abs(result) \< tolerance | Michigan             |
| 6321 | 713       |          0.22 | abs(result) \< tolerance | Michigan             |
| 6420 | 721       |          0.13 | abs(result) \< tolerance | Michigan             |
| 6518 | 722       |          0.07 | abs(result) \< tolerance | Michigan             |
| 6621 | 81        |         -0.03 | abs(result) \< tolerance | Michigan             |
| 6721 | GFGD      |         -0.62 | abs(result) \< tolerance | Michigan             |
| 6921 | GFE       |          0.36 | abs(result) \< tolerance | Michigan             |
| 7020 | GSLG      |          0.05 | abs(result) \< tolerance | Michigan             |
| 7125 | GSLE      |          1.54 | abs(result) \< tolerance | Michigan             |
| 7222 | Used      |         -8.85 | abs(result) \< tolerance | Michigan             |
| 7321 | Other     |        -41.77 | abs(result) \< tolerance | Michigan             |
| 1109 | 111CA     |         -0.46 | abs(result) \< tolerance | Minnesota            |
| 2105 | 113FF     |          2.61 | abs(result) \< tolerance | Minnesota            |
| 3106 | 211       |     155316.94 | abs(result) \< tolerance | Minnesota            |
| 4106 | 212       |         -0.31 | abs(result) \< tolerance | Minnesota            |
| 5106 | 213       |          0.13 | abs(result) \< tolerance | Minnesota            |
| 6105 | 22        |          0.08 | abs(result) \< tolerance | Minnesota            |
| 751  | 23        |         -0.06 | abs(result) \< tolerance | Minnesota            |
| 831  | 321       |         -0.41 | abs(result) \< tolerance | Minnesota            |
| 929  | 327       |         -0.11 | abs(result) \< tolerance | Minnesota            |
| 1031 | 331       |          0.45 | abs(result) \< tolerance | Minnesota            |
| 1131 | 332       |         -0.33 | abs(result) \< tolerance | Minnesota            |
| 1231 | 333       |         -0.19 | abs(result) \< tolerance | Minnesota            |
| 1331 | 334       |         -0.32 | abs(result) \< tolerance | Minnesota            |
| 1430 | 335       |         -0.12 | abs(result) \< tolerance | Minnesota            |
| 1525 | 3361MV    |          1.08 | abs(result) \< tolerance | Minnesota            |
| 1623 | 3364OT    |         -0.12 | abs(result) \< tolerance | Minnesota            |
| 1721 | 337       |         -0.29 | abs(result) \< tolerance | Minnesota            |
| 1822 | 339       |         -0.41 | abs(result) \< tolerance | Minnesota            |
| 1922 | 311FT     |         -0.08 | abs(result) \< tolerance | Minnesota            |
| 2022 | 313TT     |          0.67 | abs(result) \< tolerance | Minnesota            |
| 2126 | 315AL     |          0.41 | abs(result) \< tolerance | Minnesota            |
| 2223 | 322       |         -0.21 | abs(result) \< tolerance | Minnesota            |
| 2321 | 323       |         -0.65 | abs(result) \< tolerance | Minnesota            |
| 2422 | 324       |         -0.19 | abs(result) \< tolerance | Minnesota            |
| 2522 | 325       |          0.33 | abs(result) \< tolerance | Minnesota            |
| 2620 | 326       |         -0.08 | abs(result) \< tolerance | Minnesota            |
| 2722 | 42        |         -0.13 | abs(result) \< tolerance | Minnesota            |
| 2822 | 441       |          0.65 | abs(result) \< tolerance | Minnesota            |
| 2922 | 445       |         -0.21 | abs(result) \< tolerance | Minnesota            |
| 3022 | 452       |         -0.28 | abs(result) \< tolerance | Minnesota            |
| 3126 | 4A0       |         -0.09 | abs(result) \< tolerance | Minnesota            |
| 3224 | 481       |         -0.26 | abs(result) \< tolerance | Minnesota            |
| 3322 | 482       |         -0.25 | abs(result) \< tolerance | Minnesota            |
| 3422 | 483       |         -0.23 | abs(result) \< tolerance | Minnesota            |
| 3521 | 484       |         -0.07 | abs(result) \< tolerance | Minnesota            |
| 3622 | 485       |         -0.03 | abs(result) \< tolerance | Minnesota            |
| 3722 | 486       |          0.69 | abs(result) \< tolerance | Minnesota            |
| 3822 | 487OS     |          0.39 | abs(result) \< tolerance | Minnesota            |
| 3922 | 493       |          0.65 | abs(result) \< tolerance | Minnesota            |
| 4021 | 511       |         -0.11 | abs(result) \< tolerance | Minnesota            |
| 4126 | 512       |          1.64 | abs(result) \< tolerance | Minnesota            |
| 4224 | 513       |          0.65 | abs(result) \< tolerance | Minnesota            |
| 4322 | 514       |          0.71 | abs(result) \< tolerance | Minnesota            |
| 4422 | 521CI     |         -0.10 | abs(result) \< tolerance | Minnesota            |
| 4522 | 523       |          0.43 | abs(result) \< tolerance | Minnesota            |
| 4621 | 524       |         -0.13 | abs(result) \< tolerance | Minnesota            |
| 4722 | 525       |         -0.12 | abs(result) \< tolerance | Minnesota            |
| 4822 | HS        |         -0.19 | abs(result) \< tolerance | Minnesota            |
| 4922 | ORE       |          0.93 | abs(result) \< tolerance | Minnesota            |
| 5022 | 532RL     |          0.54 | abs(result) \< tolerance | Minnesota            |
| 5126 | 5411      |          0.27 | abs(result) \< tolerance | Minnesota            |
| 5223 | 5415      |         -0.03 | abs(result) \< tolerance | Minnesota            |
| 5322 | 5412OP    |          0.01 | abs(result) \< tolerance | Minnesota            |
| 5421 | 55        |         -0.48 | abs(result) \< tolerance | Minnesota            |
| 5521 | 561       |          0.14 | abs(result) \< tolerance | Minnesota            |
| 5621 | 562       |          0.14 | abs(result) \< tolerance | Minnesota            |
| 5720 | 61        |          0.27 | abs(result) \< tolerance | Minnesota            |
| 5822 | 621       |         -0.07 | abs(result) \< tolerance | Minnesota            |
| 5921 | 622       |         -0.04 | abs(result) \< tolerance | Minnesota            |
| 6022 | 623       |         -0.34 | abs(result) \< tolerance | Minnesota            |
| 6126 | 624       |         -0.18 | abs(result) \< tolerance | Minnesota            |
| 6223 | 711AS     |         -0.08 | abs(result) \< tolerance | Minnesota            |
| 6322 | 713       |          0.12 | abs(result) \< tolerance | Minnesota            |
| 6421 | 721       |          0.37 | abs(result) \< tolerance | Minnesota            |
| 6519 | 722       |          0.02 | abs(result) \< tolerance | Minnesota            |
| 6622 | 81        |          0.12 | abs(result) \< tolerance | Minnesota            |
| 6722 | GFGD      |         -0.58 | abs(result) \< tolerance | Minnesota            |
| 6820 | GFGN      |         -0.38 | abs(result) \< tolerance | Minnesota            |
| 6922 | GFE       |          1.12 | abs(result) \< tolerance | Minnesota            |
| 7021 | GSLG      |          0.04 | abs(result) \< tolerance | Minnesota            |
| 7126 | GSLE      |          0.97 | abs(result) \< tolerance | Minnesota            |
| 7223 | Used      |         -2.20 | abs(result) \< tolerance | Minnesota            |
| 7322 | Other     |        -53.04 | abs(result) \< tolerance | Minnesota            |
| 1132 | 111CA     |         -0.43 | abs(result) \< tolerance | Mississippi          |
| 3107 | 211       |          3.45 | abs(result) \< tolerance | Mississippi          |
| 4107 | 212       |          0.61 | abs(result) \< tolerance | Mississippi          |
| 5107 | 213       |         -0.05 | abs(result) \< tolerance | Mississippi          |
| 6106 | 22        |         -0.29 | abs(result) \< tolerance | Mississippi          |
| 752  | 23        |          0.35 | abs(result) \< tolerance | Mississippi          |
| 832  | 321       |         -0.57 | abs(result) \< tolerance | Mississippi          |
| 930  | 327       |         -0.14 | abs(result) \< tolerance | Mississippi          |
| 1032 | 331       |         -0.15 | abs(result) \< tolerance | Mississippi          |
| 1133 | 332       |          0.26 | abs(result) \< tolerance | Mississippi          |
| 1232 | 333       |         -0.17 | abs(result) \< tolerance | Mississippi          |
| 1332 | 334       |          1.51 | abs(result) \< tolerance | Mississippi          |
| 1431 | 335       |         -0.43 | abs(result) \< tolerance | Mississippi          |
| 1526 | 3361MV    |         -0.20 | abs(result) \< tolerance | Mississippi          |
| 1624 | 3364OT    |         -0.31 | abs(result) \< tolerance | Mississippi          |
| 1722 | 337       |         -0.59 | abs(result) \< tolerance | Mississippi          |
| 1823 | 339       |          0.75 | abs(result) \< tolerance | Mississippi          |
| 1923 | 311FT     |          0.24 | abs(result) \< tolerance | Mississippi          |
| 2023 | 313TT     |         -0.46 | abs(result) \< tolerance | Mississippi          |
| 2127 | 315AL     |         -0.48 | abs(result) \< tolerance | Mississippi          |
| 2224 | 322       |         -0.16 | abs(result) \< tolerance | Mississippi          |
| 2322 | 323       |          0.37 | abs(result) \< tolerance | Mississippi          |
| 2423 | 324       |         -0.22 | abs(result) \< tolerance | Mississippi          |
| 2523 | 325       |          0.51 | abs(result) \< tolerance | Mississippi          |
| 2621 | 326       |         -0.31 | abs(result) \< tolerance | Mississippi          |
| 2723 | 42        |          0.41 | abs(result) \< tolerance | Mississippi          |
| 2823 | 441       |          0.39 | abs(result) \< tolerance | Mississippi          |
| 2923 | 445       |          0.17 | abs(result) \< tolerance | Mississippi          |
| 3023 | 452       |         -0.46 | abs(result) \< tolerance | Mississippi          |
| 3127 | 4A0       |         -0.10 | abs(result) \< tolerance | Mississippi          |
| 3225 | 481       |          6.21 | abs(result) \< tolerance | Mississippi          |
| 3323 | 482       |         -0.06 | abs(result) \< tolerance | Mississippi          |
| 3423 | 483       |         -0.39 | abs(result) \< tolerance | Mississippi          |
| 3522 | 484       |         -0.28 | abs(result) \< tolerance | Mississippi          |
| 3623 | 485       |          1.33 | abs(result) \< tolerance | Mississippi          |
| 3723 | 486       |          0.85 | abs(result) \< tolerance | Mississippi          |
| 3823 | 487OS     |          0.06 | abs(result) \< tolerance | Mississippi          |
| 3923 | 493       |         -0.28 | abs(result) \< tolerance | Mississippi          |
| 4022 | 511       |          1.18 | abs(result) \< tolerance | Mississippi          |
| 4127 | 512       |          2.65 | abs(result) \< tolerance | Mississippi          |
| 4225 | 513       |          0.27 | abs(result) \< tolerance | Mississippi          |
| 4323 | 514       |          4.57 | abs(result) \< tolerance | Mississippi          |
| 4423 | 521CI     |          0.06 | abs(result) \< tolerance | Mississippi          |
| 4523 | 523       |          3.34 | abs(result) \< tolerance | Mississippi          |
| 4622 | 524       |          0.26 | abs(result) \< tolerance | Mississippi          |
| 4723 | 525       |          1.10 | abs(result) \< tolerance | Mississippi          |
| 4823 | HS        |          0.10 | abs(result) \< tolerance | Mississippi          |
| 4923 | ORE       |          1.07 | abs(result) \< tolerance | Mississippi          |
| 5023 | 532RL     |          0.04 | abs(result) \< tolerance | Mississippi          |
| 5127 | 5411      |          0.31 | abs(result) \< tolerance | Mississippi          |
| 5224 | 5415      |          0.62 | abs(result) \< tolerance | Mississippi          |
| 5323 | 5412OP    |          0.54 | abs(result) \< tolerance | Mississippi          |
| 5422 | 55        |          0.74 | abs(result) \< tolerance | Mississippi          |
| 5522 | 561       |          0.02 | abs(result) \< tolerance | Mississippi          |
| 5721 | 61        |          0.24 | abs(result) \< tolerance | Mississippi          |
| 5823 | 621       |         -0.16 | abs(result) \< tolerance | Mississippi          |
| 5922 | 622       |          0.05 | abs(result) \< tolerance | Mississippi          |
| 6023 | 623       |         -0.16 | abs(result) \< tolerance | Mississippi          |
| 6127 | 624       |         -0.09 | abs(result) \< tolerance | Mississippi          |
| 6224 | 711AS     |          2.30 | abs(result) \< tolerance | Mississippi          |
| 6323 | 713       |         -0.19 | abs(result) \< tolerance | Mississippi          |
| 6422 | 721       |         -0.34 | abs(result) \< tolerance | Mississippi          |
| 6520 | 722       |         -0.03 | abs(result) \< tolerance | Mississippi          |
| 6623 | 81        |         -0.06 | abs(result) \< tolerance | Mississippi          |
| 6723 | GFGD      |         -0.28 | abs(result) \< tolerance | Mississippi          |
| 6821 | GFGN      |         -0.41 | abs(result) \< tolerance | Mississippi          |
| 6923 | GFE       |         -0.27 | abs(result) \< tolerance | Mississippi          |
| 7127 | GSLE      |          0.04 | abs(result) \< tolerance | Mississippi          |
| 7224 | Used      |         -2.35 | abs(result) \< tolerance | Mississippi          |
| 7323 | Other     |         -0.80 | abs(result) \< tolerance | Mississippi          |
| 1134 | 111CA     |         -0.01 | abs(result) \< tolerance | Missouri             |
| 2106 | 113FF     |          0.40 | abs(result) \< tolerance | Missouri             |
| 3108 | 211       |        536.73 | abs(result) \< tolerance | Missouri             |
| 4108 | 212       |         -0.01 | abs(result) \< tolerance | Missouri             |
| 5108 | 213       |          0.09 | abs(result) \< tolerance | Missouri             |
| 6107 | 22        |         -0.04 | abs(result) \< tolerance | Missouri             |
| 753  | 23        |         -0.08 | abs(result) \< tolerance | Missouri             |
| 833  | 321       |          0.09 | abs(result) \< tolerance | Missouri             |
| 931  | 327       |         -0.14 | abs(result) \< tolerance | Missouri             |
| 1033 | 331       |          0.32 | abs(result) \< tolerance | Missouri             |
| 1135 | 332       |         -0.08 | abs(result) \< tolerance | Missouri             |
| 1233 | 333       |         -0.16 | abs(result) \< tolerance | Missouri             |
| 1333 | 334       |          0.35 | abs(result) \< tolerance | Missouri             |
| 1432 | 335       |         -0.30 | abs(result) \< tolerance | Missouri             |
| 1527 | 3361MV    |         -0.15 | abs(result) \< tolerance | Missouri             |
| 1625 | 3364OT    |          0.57 | abs(result) \< tolerance | Missouri             |
| 1824 | 339       |          0.06 | abs(result) \< tolerance | Missouri             |
| 1924 | 311FT     |         -0.27 | abs(result) \< tolerance | Missouri             |
| 2024 | 313TT     |          0.65 | abs(result) \< tolerance | Missouri             |
| 2128 | 315AL     |          0.16 | abs(result) \< tolerance | Missouri             |
| 2225 | 322       |         -0.13 | abs(result) \< tolerance | Missouri             |
| 2323 | 323       |         -0.44 | abs(result) \< tolerance | Missouri             |
| 2424 | 324       |          2.85 | abs(result) \< tolerance | Missouri             |
| 2524 | 325       |         -0.10 | abs(result) \< tolerance | Missouri             |
| 2622 | 326       |         -0.09 | abs(result) \< tolerance | Missouri             |
| 2724 | 42        |          0.01 | abs(result) \< tolerance | Missouri             |
| 2824 | 441       |          0.55 | abs(result) \< tolerance | Missouri             |
| 2924 | 445       |          0.03 | abs(result) \< tolerance | Missouri             |
| 3024 | 452       |         -0.29 | abs(result) \< tolerance | Missouri             |
| 3128 | 4A0       |         -0.04 | abs(result) \< tolerance | Missouri             |
| 3226 | 481       |          0.42 | abs(result) \< tolerance | Missouri             |
| 3324 | 482       |         -0.40 | abs(result) \< tolerance | Missouri             |
| 3424 | 483       |          0.70 | abs(result) \< tolerance | Missouri             |
| 3523 | 484       |         -0.24 | abs(result) \< tolerance | Missouri             |
| 3624 | 485       |          0.50 | abs(result) \< tolerance | Missouri             |
| 3724 | 486       |          1.97 | abs(result) \< tolerance | Missouri             |
| 3824 | 487OS     |          0.12 | abs(result) \< tolerance | Missouri             |
| 3924 | 493       |          0.07 | abs(result) \< tolerance | Missouri             |
| 4023 | 511       |          0.09 | abs(result) \< tolerance | Missouri             |
| 4128 | 512       |          1.57 | abs(result) \< tolerance | Missouri             |
| 4226 | 513       |          0.27 | abs(result) \< tolerance | Missouri             |
| 4324 | 514       |          0.23 | abs(result) \< tolerance | Missouri             |
| 4424 | 521CI     |          0.10 | abs(result) \< tolerance | Missouri             |
| 4524 | 523       |         -0.07 | abs(result) \< tolerance | Missouri             |
| 4724 | 525       |          1.90 | abs(result) \< tolerance | Missouri             |
| 4824 | HS        |         -0.09 | abs(result) \< tolerance | Missouri             |
| 4924 | ORE       |          1.08 | abs(result) \< tolerance | Missouri             |
| 5024 | 532RL     |         -0.01 | abs(result) \< tolerance | Missouri             |
| 5225 | 5415      |         -0.05 | abs(result) \< tolerance | Missouri             |
| 5324 | 5412OP    |          0.08 | abs(result) \< tolerance | Missouri             |
| 5423 | 55        |         -0.32 | abs(result) \< tolerance | Missouri             |
| 5622 | 562       |          0.01 | abs(result) \< tolerance | Missouri             |
| 5722 | 61        |          0.12 | abs(result) \< tolerance | Missouri             |
| 5824 | 621       |          0.16 | abs(result) \< tolerance | Missouri             |
| 5923 | 622       |         -0.16 | abs(result) \< tolerance | Missouri             |
| 6024 | 623       |         -0.07 | abs(result) \< tolerance | Missouri             |
| 6128 | 624       |         -0.05 | abs(result) \< tolerance | Missouri             |
| 6225 | 711AS     |         -0.08 | abs(result) \< tolerance | Missouri             |
| 6324 | 713       |          0.33 | abs(result) \< tolerance | Missouri             |
| 6423 | 721       |          0.24 | abs(result) \< tolerance | Missouri             |
| 6624 | 81        |          0.08 | abs(result) \< tolerance | Missouri             |
| 6724 | GFGD      |         -0.32 | abs(result) \< tolerance | Missouri             |
| 6822 | GFGN      |          0.57 | abs(result) \< tolerance | Missouri             |
| 6924 | GFE       |          0.07 | abs(result) \< tolerance | Missouri             |
| 7022 | GSLG      |         -0.06 | abs(result) \< tolerance | Missouri             |
| 7128 | GSLE      |          0.66 | abs(result) \< tolerance | Missouri             |
| 7225 | Used      |          1.69 | abs(result) \< tolerance | Missouri             |
| 7324 | Other     |         -5.69 | abs(result) \< tolerance | Missouri             |
| 1136 | 111CA     |         -0.63 | abs(result) \< tolerance | Montana              |
| 2107 | 113FF     |         -0.17 | abs(result) \< tolerance | Montana              |
| 3109 | 211       |          2.57 | abs(result) \< tolerance | Montana              |
| 4109 | 212       |         -0.68 | abs(result) \< tolerance | Montana              |
| 5109 | 213       |          0.02 | abs(result) \< tolerance | Montana              |
| 6108 | 22        |         -0.16 | abs(result) \< tolerance | Montana              |
| 754  | 23        |         -0.02 | abs(result) \< tolerance | Montana              |
| 834  | 321       |         -0.59 | abs(result) \< tolerance | Montana              |
| 932  | 327       |          0.14 | abs(result) \< tolerance | Montana              |
| 1034 | 331       |          1.59 | abs(result) \< tolerance | Montana              |
| 1137 | 332       |          0.45 | abs(result) \< tolerance | Montana              |
| 1234 | 333       |          0.85 | abs(result) \< tolerance | Montana              |
| 1334 | 334       |          1.53 | abs(result) \< tolerance | Montana              |
| 1433 | 335       |          4.31 | abs(result) \< tolerance | Montana              |
| 1528 | 3361MV    |          5.99 | abs(result) \< tolerance | Montana              |
| 1626 | 3364OT    |          5.19 | abs(result) \< tolerance | Montana              |
| 1723 | 337       |          1.01 | abs(result) \< tolerance | Montana              |
| 1825 | 339       |          0.18 | abs(result) \< tolerance | Montana              |
| 1925 | 311FT     |          2.04 | abs(result) \< tolerance | Montana              |
| 2025 | 313TT     |          1.95 | abs(result) \< tolerance | Montana              |
| 2129 | 315AL     |          1.82 | abs(result) \< tolerance | Montana              |
| 2226 | 322       |          8.52 | abs(result) \< tolerance | Montana              |
| 2324 | 323       |          0.31 | abs(result) \< tolerance | Montana              |
| 2425 | 324       |         -0.75 | abs(result) \< tolerance | Montana              |
| 2525 | 325       |          0.55 | abs(result) \< tolerance | Montana              |
| 2623 | 326       |          3.88 | abs(result) \< tolerance | Montana              |
| 2725 | 42        |          0.20 | abs(result) \< tolerance | Montana              |
| 2825 | 441       |          0.72 | abs(result) \< tolerance | Montana              |
| 2925 | 445       |          0.15 | abs(result) \< tolerance | Montana              |
| 3025 | 452       |         -0.05 | abs(result) \< tolerance | Montana              |
| 3227 | 481       |          0.93 | abs(result) \< tolerance | Montana              |
| 3325 | 482       |         -0.68 | abs(result) \< tolerance | Montana              |
| 3425 | 483       |         10.78 | abs(result) \< tolerance | Montana              |
| 3524 | 484       |         -0.09 | abs(result) \< tolerance | Montana              |
| 3625 | 485       |          0.97 | abs(result) \< tolerance | Montana              |
| 3725 | 486       |          1.31 | abs(result) \< tolerance | Montana              |
| 3825 | 487OS     |          0.14 | abs(result) \< tolerance | Montana              |
| 3925 | 493       |          6.62 | abs(result) \< tolerance | Montana              |
| 4024 | 511       |          0.57 | abs(result) \< tolerance | Montana              |
| 4129 | 512       |          0.47 | abs(result) \< tolerance | Montana              |
| 4227 | 513       |          0.42 | abs(result) \< tolerance | Montana              |
| 4325 | 514       |          2.38 | abs(result) \< tolerance | Montana              |
| 4425 | 521CI     |          0.22 | abs(result) \< tolerance | Montana              |
| 4525 | 523       |          1.33 | abs(result) \< tolerance | Montana              |
| 4623 | 524       |          0.55 | abs(result) \< tolerance | Montana              |
| 4725 | 525       |          2.81 | abs(result) \< tolerance | Montana              |
| 4825 | HS        |         -0.15 | abs(result) \< tolerance | Montana              |
| 4925 | ORE       |          0.60 | abs(result) \< tolerance | Montana              |
| 5025 | 532RL     |          0.01 | abs(result) \< tolerance | Montana              |
| 5128 | 5411      |          0.41 | abs(result) \< tolerance | Montana              |
| 5226 | 5415      |          0.18 | abs(result) \< tolerance | Montana              |
| 5325 | 5412OP    |          0.23 | abs(result) \< tolerance | Montana              |
| 5424 | 55        |          2.84 | abs(result) \< tolerance | Montana              |
| 5523 | 561       |          0.37 | abs(result) \< tolerance | Montana              |
| 5623 | 562       |         -0.02 | abs(result) \< tolerance | Montana              |
| 5723 | 61        |          0.62 | abs(result) \< tolerance | Montana              |
| 5825 | 621       |         -0.06 | abs(result) \< tolerance | Montana              |
| 5924 | 622       |         -0.42 | abs(result) \< tolerance | Montana              |
| 6025 | 623       |         -0.23 | abs(result) \< tolerance | Montana              |
| 6129 | 624       |          0.05 | abs(result) \< tolerance | Montana              |
| 6226 | 711AS     |          0.69 | abs(result) \< tolerance | Montana              |
| 6325 | 713       |         -0.27 | abs(result) \< tolerance | Montana              |
| 6424 | 721       |         -0.26 | abs(result) \< tolerance | Montana              |
| 6521 | 722       |          0.05 | abs(result) \< tolerance | Montana              |
| 6625 | 81        |          0.02 | abs(result) \< tolerance | Montana              |
| 6725 | GFGD      |         -0.23 | abs(result) \< tolerance | Montana              |
| 6823 | GFGN      |          0.04 | abs(result) \< tolerance | Montana              |
| 6925 | GFE       |         -0.41 | abs(result) \< tolerance | Montana              |
| 7023 | GSLG      |         -0.03 | abs(result) \< tolerance | Montana              |
| 7129 | GSLE      |          0.71 | abs(result) \< tolerance | Montana              |
| 7226 | Used      |          7.50 | abs(result) \< tolerance | Montana              |
| 7325 | Other     |          6.95 | abs(result) \< tolerance | Montana              |
| 1138 | 111CA     |         -0.56 | abs(result) \< tolerance | Nebraska             |
| 2108 | 113FF     |          0.45 | abs(result) \< tolerance | Nebraska             |
| 3129 | 211       |         14.92 | abs(result) \< tolerance | Nebraska             |
| 4130 | 212       |          1.40 | abs(result) \< tolerance | Nebraska             |
| 5129 | 213       |         -0.01 | abs(result) \< tolerance | Nebraska             |
| 6109 | 22        |         -0.42 | abs(result) \< tolerance | Nebraska             |
| 755  | 23        |          0.04 | abs(result) \< tolerance | Nebraska             |
| 835  | 321       |          0.55 | abs(result) \< tolerance | Nebraska             |
| 933  | 327       |         -0.12 | abs(result) \< tolerance | Nebraska             |
| 1035 | 331       |          0.54 | abs(result) \< tolerance | Nebraska             |
| 1235 | 333       |         -0.05 | abs(result) \< tolerance | Nebraska             |
| 1335 | 334       |          0.26 | abs(result) \< tolerance | Nebraska             |
| 1434 | 335       |          0.32 | abs(result) \< tolerance | Nebraska             |
| 1529 | 3361MV    |          0.33 | abs(result) \< tolerance | Nebraska             |
| 1627 | 3364OT    |          1.07 | abs(result) \< tolerance | Nebraska             |
| 1724 | 337       |          0.41 | abs(result) \< tolerance | Nebraska             |
| 1826 | 339       |         -0.43 | abs(result) \< tolerance | Nebraska             |
| 1926 | 311FT     |         -0.28 | abs(result) \< tolerance | Nebraska             |
| 2026 | 313TT     |          0.19 | abs(result) \< tolerance | Nebraska             |
| 2130 | 315AL     |          0.21 | abs(result) \< tolerance | Nebraska             |
| 2227 | 322       |          1.32 | abs(result) \< tolerance | Nebraska             |
| 2325 | 323       |         -0.06 | abs(result) \< tolerance | Nebraska             |
| 2426 | 324       |         21.20 | abs(result) \< tolerance | Nebraska             |
| 2526 | 325       |          0.05 | abs(result) \< tolerance | Nebraska             |
| 2624 | 326       |          0.17 | abs(result) \< tolerance | Nebraska             |
| 2726 | 42        |          0.09 | abs(result) \< tolerance | Nebraska             |
| 2826 | 441       |          0.71 | abs(result) \< tolerance | Nebraska             |
| 2926 | 445       |         -0.17 | abs(result) \< tolerance | Nebraska             |
| 3026 | 452       |         -0.04 | abs(result) \< tolerance | Nebraska             |
| 3130 | 4A0       |          0.11 | abs(result) \< tolerance | Nebraska             |
| 3228 | 481       |          2.31 | abs(result) \< tolerance | Nebraska             |
| 3326 | 482       |         -0.73 | abs(result) \< tolerance | Nebraska             |
| 3426 | 483       |         18.19 | abs(result) \< tolerance | Nebraska             |
| 3525 | 484       |         -0.44 | abs(result) \< tolerance | Nebraska             |
| 3626 | 485       |          1.37 | abs(result) \< tolerance | Nebraska             |
| 3726 | 486       |         -0.84 | abs(result) \< tolerance | Nebraska             |
| 3826 | 487OS     |          0.52 | abs(result) \< tolerance | Nebraska             |
| 3926 | 493       |          0.16 | abs(result) \< tolerance | Nebraska             |
| 4025 | 511       |         -0.03 | abs(result) \< tolerance | Nebraska             |
| 4131 | 512       |          3.39 | abs(result) \< tolerance | Nebraska             |
| 4228 | 513       |          0.39 | abs(result) \< tolerance | Nebraska             |
| 4326 | 514       |          0.05 | abs(result) \< tolerance | Nebraska             |
| 4426 | 521CI     |          0.34 | abs(result) \< tolerance | Nebraska             |
| 4526 | 523       |          0.68 | abs(result) \< tolerance | Nebraska             |
| 4624 | 524       |         -0.49 | abs(result) \< tolerance | Nebraska             |
| 4726 | 525       |          2.26 | abs(result) \< tolerance | Nebraska             |
| 4826 | HS        |         -0.16 | abs(result) \< tolerance | Nebraska             |
| 4926 | ORE       |          1.33 | abs(result) \< tolerance | Nebraska             |
| 5026 | 532RL     |          0.59 | abs(result) \< tolerance | Nebraska             |
| 5130 | 5411      |          0.66 | abs(result) \< tolerance | Nebraska             |
| 5227 | 5415      |          0.11 | abs(result) \< tolerance | Nebraska             |
| 5326 | 5412OP    |          0.37 | abs(result) \< tolerance | Nebraska             |
| 5425 | 55        |         -0.28 | abs(result) \< tolerance | Nebraska             |
| 5524 | 561       |          0.02 | abs(result) \< tolerance | Nebraska             |
| 5624 | 562       |         -0.04 | abs(result) \< tolerance | Nebraska             |
| 5724 | 61        |          0.09 | abs(result) \< tolerance | Nebraska             |
| 5826 | 621       |         -0.10 | abs(result) \< tolerance | Nebraska             |
| 5925 | 622       |         -0.19 | abs(result) \< tolerance | Nebraska             |
| 6026 | 623       |         -0.38 | abs(result) \< tolerance | Nebraska             |
| 6130 | 624       |         -0.14 | abs(result) \< tolerance | Nebraska             |
| 6227 | 711AS     |          0.62 | abs(result) \< tolerance | Nebraska             |
| 6326 | 713       |         -0.08 | abs(result) \< tolerance | Nebraska             |
| 6425 | 721       |          0.67 | abs(result) \< tolerance | Nebraska             |
| 6726 | GFGD      |         -0.21 | abs(result) \< tolerance | Nebraska             |
| 6824 | GFGN      |          1.66 | abs(result) \< tolerance | Nebraska             |
| 6926 | GFE       |          0.42 | abs(result) \< tolerance | Nebraska             |
| 7024 | GSLG      |         -0.28 | abs(result) \< tolerance | Nebraska             |
| 7130 | GSLE      |          0.30 | abs(result) \< tolerance | Nebraska             |
| 7227 | Used      |          2.85 | abs(result) \< tolerance | Nebraska             |
| 7326 | Other     |        -24.81 | abs(result) \< tolerance | Nebraska             |
| 1139 | 111CA     |          0.97 | abs(result) \< tolerance | Nevada               |
| 2109 | 113FF     |          0.73 | abs(result) \< tolerance | Nevada               |
| 3131 | 211       |        194.29 | abs(result) \< tolerance | Nevada               |
| 4132 | 212       |         -0.60 | abs(result) \< tolerance | Nevada               |
| 5131 | 213       |         -0.06 | abs(result) \< tolerance | Nevada               |
| 6131 | 22        |          0.24 | abs(result) \< tolerance | Nevada               |
| 756  | 23        |         -0.27 | abs(result) \< tolerance | Nevada               |
| 836  | 321       |          1.80 | abs(result) \< tolerance | Nevada               |
| 934  | 327       |          0.02 | abs(result) \< tolerance | Nevada               |
| 1036 | 331       |          0.36 | abs(result) \< tolerance | Nevada               |
| 1140 | 332       |          0.58 | abs(result) \< tolerance | Nevada               |
| 1236 | 333       |          1.17 | abs(result) \< tolerance | Nevada               |
| 1336 | 334       |          0.89 | abs(result) \< tolerance | Nevada               |
| 1435 | 335       |          0.11 | abs(result) \< tolerance | Nevada               |
| 1530 | 3361MV    |          6.64 | abs(result) \< tolerance | Nevada               |
| 1628 | 3364OT    |          1.26 | abs(result) \< tolerance | Nevada               |
| 1725 | 337       |          1.11 | abs(result) \< tolerance | Nevada               |
| 1827 | 339       |         -0.30 | abs(result) \< tolerance | Nevada               |
| 1927 | 311FT     |          1.98 | abs(result) \< tolerance | Nevada               |
| 2027 | 313TT     |          0.24 | abs(result) \< tolerance | Nevada               |
| 2131 | 315AL     |         -0.43 | abs(result) \< tolerance | Nevada               |
| 2228 | 322       |          2.09 | abs(result) \< tolerance | Nevada               |
| 2326 | 323       |          0.05 | abs(result) \< tolerance | Nevada               |
| 2427 | 324       |          7.74 | abs(result) \< tolerance | Nevada               |
| 2527 | 325       |          1.03 | abs(result) \< tolerance | Nevada               |
| 2625 | 326       |          0.53 | abs(result) \< tolerance | Nevada               |
| 2727 | 42        |          0.21 | abs(result) \< tolerance | Nevada               |
| 2827 | 441       |          0.32 | abs(result) \< tolerance | Nevada               |
| 2927 | 445       |         -0.05 | abs(result) \< tolerance | Nevada               |
| 3027 | 452       |         -0.21 | abs(result) \< tolerance | Nevada               |
| 3132 | 4A0       |         -0.13 | abs(result) \< tolerance | Nevada               |
| 3229 | 481       |         -0.51 | abs(result) \< tolerance | Nevada               |
| 3327 | 482       |          0.30 | abs(result) \< tolerance | Nevada               |
| 3427 | 483       |          5.14 | abs(result) \< tolerance | Nevada               |
| 3526 | 484       |          0.14 | abs(result) \< tolerance | Nevada               |
| 3627 | 485       |         -0.62 | abs(result) \< tolerance | Nevada               |
| 3727 | 486       |          5.07 | abs(result) \< tolerance | Nevada               |
| 3827 | 487OS     |         -0.08 | abs(result) \< tolerance | Nevada               |
| 3927 | 493       |         -0.46 | abs(result) \< tolerance | Nevada               |
| 4026 | 511       |          0.39 | abs(result) \< tolerance | Nevada               |
| 4133 | 512       |          0.36 | abs(result) \< tolerance | Nevada               |
| 4229 | 513       |          0.38 | abs(result) \< tolerance | Nevada               |
| 4327 | 514       |          1.03 | abs(result) \< tolerance | Nevada               |
| 4427 | 521CI     |          0.19 | abs(result) \< tolerance | Nevada               |
| 4527 | 523       |          2.69 | abs(result) \< tolerance | Nevada               |
| 4625 | 524       |          0.13 | abs(result) \< tolerance | Nevada               |
| 4727 | 525       |          0.56 | abs(result) \< tolerance | Nevada               |
| 4827 | HS        |         -0.21 | abs(result) \< tolerance | Nevada               |
| 4927 | ORE       |          0.67 | abs(result) \< tolerance | Nevada               |
| 5027 | 532RL     |         -0.18 | abs(result) \< tolerance | Nevada               |
| 5132 | 5411      |          0.18 | abs(result) \< tolerance | Nevada               |
| 5228 | 5415      |          0.36 | abs(result) \< tolerance | Nevada               |
| 5327 | 5412OP    |          0.25 | abs(result) \< tolerance | Nevada               |
| 5426 | 55        |         -0.09 | abs(result) \< tolerance | Nevada               |
| 5525 | 561       |         -0.14 | abs(result) \< tolerance | Nevada               |
| 5625 | 562       |          0.21 | abs(result) \< tolerance | Nevada               |
| 5725 | 61        |          0.64 | abs(result) \< tolerance | Nevada               |
| 5827 | 621       |         -0.06 | abs(result) \< tolerance | Nevada               |
| 5926 | 622       |          0.09 | abs(result) \< tolerance | Nevada               |
| 6027 | 623       |          0.68 | abs(result) \< tolerance | Nevada               |
| 6132 | 624       |          0.41 | abs(result) \< tolerance | Nevada               |
| 6228 | 711AS     |         -0.49 | abs(result) \< tolerance | Nevada               |
| 6327 | 713       |         -0.74 | abs(result) \< tolerance | Nevada               |
| 6426 | 721       |         -0.90 | abs(result) \< tolerance | Nevada               |
| 6522 | 722       |         -0.44 | abs(result) \< tolerance | Nevada               |
| 6626 | 81        |          0.09 | abs(result) \< tolerance | Nevada               |
| 6727 | GFGD      |         -0.18 | abs(result) \< tolerance | Nevada               |
| 6825 | GFGN      |          0.64 | abs(result) \< tolerance | Nevada               |
| 6927 | GFE       |          0.40 | abs(result) \< tolerance | Nevada               |
| 7025 | GSLG      |         -0.17 | abs(result) \< tolerance | Nevada               |
| 7131 | GSLE      |          0.62 | abs(result) \< tolerance | Nevada               |
| 7228 | Used      |          4.56 | abs(result) \< tolerance | Nevada               |
| 7327 | Other     |        -39.51 | abs(result) \< tolerance | Nevada               |
| 1141 | 111CA     |          1.80 | abs(result) \< tolerance | New Hampshire        |
| 2132 | 113FF     |          0.07 | abs(result) \< tolerance | New Hampshire        |
| 3133 | 211       |        317.28 | abs(result) \< tolerance | New Hampshire        |
| 4134 | 212       |          0.64 | abs(result) \< tolerance | New Hampshire        |
| 5133 | 213       |         -0.04 | abs(result) \< tolerance | New Hampshire        |
| 6133 | 22        |          0.09 | abs(result) \< tolerance | New Hampshire        |
| 757  | 23        |          0.18 | abs(result) \< tolerance | New Hampshire        |
| 837  | 321       |         -0.26 | abs(result) \< tolerance | New Hampshire        |
| 935  | 327       |         -0.32 | abs(result) \< tolerance | New Hampshire        |
| 1037 | 331       |          0.26 | abs(result) \< tolerance | New Hampshire        |
| 1142 | 332       |         -0.52 | abs(result) \< tolerance | New Hampshire        |
| 1237 | 333       |         -0.20 | abs(result) \< tolerance | New Hampshire        |
| 1337 | 334       |         -0.02 | abs(result) \< tolerance | New Hampshire        |
| 1436 | 335       |         -0.38 | abs(result) \< tolerance | New Hampshire        |
| 1531 | 3361MV    |          1.92 | abs(result) \< tolerance | New Hampshire        |
| 1629 | 3364OT    |          0.61 | abs(result) \< tolerance | New Hampshire        |
| 1726 | 337       |          0.79 | abs(result) \< tolerance | New Hampshire        |
| 1828 | 339       |          1.14 | abs(result) \< tolerance | New Hampshire        |
| 1928 | 311FT     |          0.78 | abs(result) \< tolerance | New Hampshire        |
| 2028 | 313TT     |         -0.54 | abs(result) \< tolerance | New Hampshire        |
| 2133 | 315AL     |         -0.27 | abs(result) \< tolerance | New Hampshire        |
| 2229 | 322       |          1.08 | abs(result) \< tolerance | New Hampshire        |
| 2327 | 323       |          0.04 | abs(result) \< tolerance | New Hampshire        |
| 2428 | 324       |          3.42 | abs(result) \< tolerance | New Hampshire        |
| 2528 | 325       |         10.06 | abs(result) \< tolerance | New Hampshire        |
| 2626 | 326       |         -0.40 | abs(result) \< tolerance | New Hampshire        |
| 2728 | 42        |         -0.11 | abs(result) \< tolerance | New Hampshire        |
| 2828 | 441       |          0.42 | abs(result) \< tolerance | New Hampshire        |
| 2928 | 445       |         -0.27 | abs(result) \< tolerance | New Hampshire        |
| 3028 | 452       |         -0.04 | abs(result) \< tolerance | New Hampshire        |
| 3134 | 4A0       |         -0.03 | abs(result) \< tolerance | New Hampshire        |
| 3230 | 481       |          2.72 | abs(result) \< tolerance | New Hampshire        |
| 3328 | 482       |          9.65 | abs(result) \< tolerance | New Hampshire        |
| 3428 | 483       |          3.35 | abs(result) \< tolerance | New Hampshire        |
| 3527 | 484       |          0.56 | abs(result) \< tolerance | New Hampshire        |
| 3628 | 485       |          0.14 | abs(result) \< tolerance | New Hampshire        |
| 3728 | 486       |          5.10 | abs(result) \< tolerance | New Hampshire        |
| 3828 | 487OS     |          0.23 | abs(result) \< tolerance | New Hampshire        |
| 3928 | 493       |          0.44 | abs(result) \< tolerance | New Hampshire        |
| 4027 | 511       |         -0.13 | abs(result) \< tolerance | New Hampshire        |
| 4135 | 512       |          1.10 | abs(result) \< tolerance | New Hampshire        |
| 4230 | 513       |          0.57 | abs(result) \< tolerance | New Hampshire        |
| 4328 | 514       |          0.69 | abs(result) \< tolerance | New Hampshire        |
| 4428 | 521CI     |          1.41 | abs(result) \< tolerance | New Hampshire        |
| 4528 | 523       |         -0.14 | abs(result) \< tolerance | New Hampshire        |
| 4626 | 524       |         -0.24 | abs(result) \< tolerance | New Hampshire        |
| 4728 | 525       |          4.61 | abs(result) \< tolerance | New Hampshire        |
| 4828 | HS        |         -0.24 | abs(result) \< tolerance | New Hampshire        |
| 4928 | ORE       |          0.57 | abs(result) \< tolerance | New Hampshire        |
| 5028 | 532RL     |          0.27 | abs(result) \< tolerance | New Hampshire        |
| 5134 | 5411      |          0.54 | abs(result) \< tolerance | New Hampshire        |
| 5229 | 5415      |         -0.17 | abs(result) \< tolerance | New Hampshire        |
| 5328 | 5412OP    |         -0.06 | abs(result) \< tolerance | New Hampshire        |
| 5427 | 55        |          0.19 | abs(result) \< tolerance | New Hampshire        |
| 5526 | 561       |         -0.12 | abs(result) \< tolerance | New Hampshire        |
| 5626 | 562       |         -0.16 | abs(result) \< tolerance | New Hampshire        |
| 5726 | 61        |         -0.26 | abs(result) \< tolerance | New Hampshire        |
| 5828 | 621       |         -0.04 | abs(result) \< tolerance | New Hampshire        |
| 5927 | 622       |         -0.05 | abs(result) \< tolerance | New Hampshire        |
| 6028 | 623       |          0.03 | abs(result) \< tolerance | New Hampshire        |
| 6134 | 624       |          0.27 | abs(result) \< tolerance | New Hampshire        |
| 6229 | 711AS     |          0.36 | abs(result) \< tolerance | New Hampshire        |
| 6328 | 713       |         -0.32 | abs(result) \< tolerance | New Hampshire        |
| 6427 | 721       |         -0.28 | abs(result) \< tolerance | New Hampshire        |
| 6523 | 722       |         -0.08 | abs(result) \< tolerance | New Hampshire        |
| 6627 | 81        |          0.13 | abs(result) \< tolerance | New Hampshire        |
| 6728 | GFGD      |         -0.85 | abs(result) \< tolerance | New Hampshire        |
| 6826 | GFGN      |         -0.50 | abs(result) \< tolerance | New Hampshire        |
| 6928 | GFE       |          0.48 | abs(result) \< tolerance | New Hampshire        |
| 7026 | GSLG      |         -0.07 | abs(result) \< tolerance | New Hampshire        |
| 7132 | GSLE      |          1.39 | abs(result) \< tolerance | New Hampshire        |
| 7229 | Used      |         -0.45 | abs(result) \< tolerance | New Hampshire        |
| 7328 | Other     |        -36.97 | abs(result) \< tolerance | New Hampshire        |
| 1143 | 111CA     |          3.46 | abs(result) \< tolerance | New Jersey           |
| 2134 | 113FF     |         -0.19 | abs(result) \< tolerance | New Jersey           |
| 3135 | 211       |         95.23 | abs(result) \< tolerance | New Jersey           |
| 4136 | 212       |          2.05 | abs(result) \< tolerance | New Jersey           |
| 6135 | 22        |          0.06 | abs(result) \< tolerance | New Jersey           |
| 758  | 23        |          0.11 | abs(result) \< tolerance | New Jersey           |
| 838  | 321       |          2.83 | abs(result) \< tolerance | New Jersey           |
| 936  | 327       |          0.08 | abs(result) \< tolerance | New Jersey           |
| 1038 | 331       |          0.52 | abs(result) \< tolerance | New Jersey           |
| 1144 | 332       |          0.32 | abs(result) \< tolerance | New Jersey           |
| 1238 | 333       |          0.08 | abs(result) \< tolerance | New Jersey           |
| 1338 | 334       |          0.18 | abs(result) \< tolerance | New Jersey           |
| 1437 | 335       |          0.26 | abs(result) \< tolerance | New Jersey           |
| 1532 | 3361MV    |          6.74 | abs(result) \< tolerance | New Jersey           |
| 1630 | 3364OT    |          0.74 | abs(result) \< tolerance | New Jersey           |
| 1727 | 337       |          0.60 | abs(result) \< tolerance | New Jersey           |
| 1829 | 339       |          0.57 | abs(result) \< tolerance | New Jersey           |
| 1929 | 311FT     |          0.13 | abs(result) \< tolerance | New Jersey           |
| 2029 | 313TT     |          0.20 | abs(result) \< tolerance | New Jersey           |
| 2135 | 315AL     |          0.28 | abs(result) \< tolerance | New Jersey           |
| 2230 | 322       |          0.17 | abs(result) \< tolerance | New Jersey           |
| 2328 | 323       |         -0.08 | abs(result) \< tolerance | New Jersey           |
| 2429 | 324       |          0.35 | abs(result) \< tolerance | New Jersey           |
| 2529 | 325       |          1.50 | abs(result) \< tolerance | New Jersey           |
| 2627 | 326       |         -0.02 | abs(result) \< tolerance | New Jersey           |
| 2729 | 42        |         -0.28 | abs(result) \< tolerance | New Jersey           |
| 2829 | 441       |          0.34 | abs(result) \< tolerance | New Jersey           |
| 2929 | 445       |         -0.40 | abs(result) \< tolerance | New Jersey           |
| 3029 | 452       |          0.05 | abs(result) \< tolerance | New Jersey           |
| 3136 | 4A0       |          0.09 | abs(result) \< tolerance | New Jersey           |
| 3231 | 481       |         -0.24 | abs(result) \< tolerance | New Jersey           |
| 3329 | 482       |          1.62 | abs(result) \< tolerance | New Jersey           |
| 3429 | 483       |         -0.19 | abs(result) \< tolerance | New Jersey           |
| 3528 | 484       |         -0.12 | abs(result) \< tolerance | New Jersey           |
| 3629 | 485       |         -0.27 | abs(result) \< tolerance | New Jersey           |
| 3729 | 486       |          2.42 | abs(result) \< tolerance | New Jersey           |
| 3829 | 487OS     |         -0.17 | abs(result) \< tolerance | New Jersey           |
| 3929 | 493       |         -0.34 | abs(result) \< tolerance | New Jersey           |
| 4028 | 511       |          0.03 | abs(result) \< tolerance | New Jersey           |
| 4137 | 512       |          0.57 | abs(result) \< tolerance | New Jersey           |
| 4231 | 513       |          0.14 | abs(result) \< tolerance | New Jersey           |
| 4329 | 514       |          0.24 | abs(result) \< tolerance | New Jersey           |
| 4429 | 521CI     |          0.93 | abs(result) \< tolerance | New Jersey           |
| 4529 | 523       |         -0.20 | abs(result) \< tolerance | New Jersey           |
| 4627 | 524       |         -0.06 | abs(result) \< tolerance | New Jersey           |
| 4729 | 525       |          1.35 | abs(result) \< tolerance | New Jersey           |
| 4829 | HS        |         -0.32 | abs(result) \< tolerance | New Jersey           |
| 4929 | ORE       |          0.45 | abs(result) \< tolerance | New Jersey           |
| 5029 | 532RL     |          0.15 | abs(result) \< tolerance | New Jersey           |
| 5135 | 5411      |          0.02 | abs(result) \< tolerance | New Jersey           |
| 5230 | 5415      |         -0.02 | abs(result) \< tolerance | New Jersey           |
| 5329 | 5412OP    |         -0.27 | abs(result) \< tolerance | New Jersey           |
| 5428 | 55        |         -0.40 | abs(result) \< tolerance | New Jersey           |
| 5527 | 561       |         -0.20 | abs(result) \< tolerance | New Jersey           |
| 5627 | 562       |         -0.21 | abs(result) \< tolerance | New Jersey           |
| 5727 | 61        |          0.03 | abs(result) \< tolerance | New Jersey           |
| 5829 | 621       |         -0.09 | abs(result) \< tolerance | New Jersey           |
| 5928 | 622       |          0.02 | abs(result) \< tolerance | New Jersey           |
| 6029 | 623       |         -0.03 | abs(result) \< tolerance | New Jersey           |
| 6136 | 624       |          0.09 | abs(result) \< tolerance | New Jersey           |
| 6230 | 711AS     |          0.18 | abs(result) \< tolerance | New Jersey           |
| 6329 | 713       |          0.09 | abs(result) \< tolerance | New Jersey           |
| 6428 | 721       |          0.22 | abs(result) \< tolerance | New Jersey           |
| 6524 | 722       |          0.15 | abs(result) \< tolerance | New Jersey           |
| 6628 | 81        |          0.12 | abs(result) \< tolerance | New Jersey           |
| 6729 | GFGD      |         -0.54 | abs(result) \< tolerance | New Jersey           |
| 6827 | GFGN      |          2.91 | abs(result) \< tolerance | New Jersey           |
| 6929 | GFE       |          1.26 | abs(result) \< tolerance | New Jersey           |
| 7027 | GSLG      |         -0.07 | abs(result) \< tolerance | New Jersey           |
| 7133 | GSLE      |          1.47 | abs(result) \< tolerance | New Jersey           |
| 7230 | Used      |          4.50 | abs(result) \< tolerance | New Jersey           |
| 7329 | Other     |        -58.47 | abs(result) \< tolerance | New Jersey           |
| 1145 | 111CA     |         -0.56 | abs(result) \< tolerance | New Mexico           |
| 2136 | 113FF     |         -0.05 | abs(result) \< tolerance | New Mexico           |
| 3137 | 211       |         -0.62 | abs(result) \< tolerance | New Mexico           |
| 4138 | 212       |         -0.70 | abs(result) \< tolerance | New Mexico           |
| 5136 | 213       |         -0.05 | abs(result) \< tolerance | New Mexico           |
| 6137 | 22        |         -0.14 | abs(result) \< tolerance | New Mexico           |
| 759  | 23        |          0.13 | abs(result) \< tolerance | New Mexico           |
| 839  | 321       |          1.26 | abs(result) \< tolerance | New Mexico           |
| 937  | 327       |          0.05 | abs(result) \< tolerance | New Mexico           |
| 1039 | 331       |          1.36 | abs(result) \< tolerance | New Mexico           |
| 1146 | 332       |          1.79 | abs(result) \< tolerance | New Mexico           |
| 1239 | 333       |          1.50 | abs(result) \< tolerance | New Mexico           |
| 1339 | 334       |          0.72 | abs(result) \< tolerance | New Mexico           |
| 1438 | 335       |          2.29 | abs(result) \< tolerance | New Mexico           |
| 1533 | 3361MV    |         19.96 | abs(result) \< tolerance | New Mexico           |
| 1631 | 3364OT    |          3.15 | abs(result) \< tolerance | New Mexico           |
| 1728 | 337       |          3.45 | abs(result) \< tolerance | New Mexico           |
| 1830 | 339       |          2.62 | abs(result) \< tolerance | New Mexico           |
| 1930 | 311FT     |          1.07 | abs(result) \< tolerance | New Mexico           |
| 2030 | 313TT     |          3.95 | abs(result) \< tolerance | New Mexico           |
| 2137 | 315AL     |          3.92 | abs(result) \< tolerance | New Mexico           |
| 2231 | 322       |          0.89 | abs(result) \< tolerance | New Mexico           |
| 2329 | 323       |          1.38 | abs(result) \< tolerance | New Mexico           |
| 2430 | 324       |          0.05 | abs(result) \< tolerance | New Mexico           |
| 2530 | 325       |          2.75 | abs(result) \< tolerance | New Mexico           |
| 2628 | 326       |          1.53 | abs(result) \< tolerance | New Mexico           |
| 2730 | 42        |          0.53 | abs(result) \< tolerance | New Mexico           |
| 2830 | 441       |          0.48 | abs(result) \< tolerance | New Mexico           |
| 2930 | 445       |          0.26 | abs(result) \< tolerance | New Mexico           |
| 3030 | 452       |         -0.14 | abs(result) \< tolerance | New Mexico           |
| 3138 | 4A0       |          0.29 | abs(result) \< tolerance | New Mexico           |
| 3232 | 481       |          0.95 | abs(result) \< tolerance | New Mexico           |
| 3330 | 482       |         -0.59 | abs(result) \< tolerance | New Mexico           |
| 3430 | 483       |          3.78 | abs(result) \< tolerance | New Mexico           |
| 3529 | 484       |         -0.19 | abs(result) \< tolerance | New Mexico           |
| 3630 | 485       |          0.60 | abs(result) \< tolerance | New Mexico           |
| 3730 | 486       |          3.60 | abs(result) \< tolerance | New Mexico           |
| 3830 | 487OS     |          0.24 | abs(result) \< tolerance | New Mexico           |
| 3930 | 493       |          1.41 | abs(result) \< tolerance | New Mexico           |
| 4029 | 511       |          0.92 | abs(result) \< tolerance | New Mexico           |
| 4139 | 512       |         -0.21 | abs(result) \< tolerance | New Mexico           |
| 4232 | 513       |          0.22 | abs(result) \< tolerance | New Mexico           |
| 4330 | 514       |          3.83 | abs(result) \< tolerance | New Mexico           |
| 4430 | 521CI     |          1.25 | abs(result) \< tolerance | New Mexico           |
| 4530 | 523       |          2.10 | abs(result) \< tolerance | New Mexico           |
| 4628 | 524       |          0.52 | abs(result) \< tolerance | New Mexico           |
| 4730 | 525       |          2.15 | abs(result) \< tolerance | New Mexico           |
| 4830 | HS        |         -0.12 | abs(result) \< tolerance | New Mexico           |
| 4930 | ORE       |          0.59 | abs(result) \< tolerance | New Mexico           |
| 5030 | 532RL     |          0.35 | abs(result) \< tolerance | New Mexico           |
| 5137 | 5411      |          0.54 | abs(result) \< tolerance | New Mexico           |
| 5231 | 5415      |          0.60 | abs(result) \< tolerance | New Mexico           |
| 5330 | 5412OP    |         -0.11 | abs(result) \< tolerance | New Mexico           |
| 5429 | 55        |          1.87 | abs(result) \< tolerance | New Mexico           |
| 5528 | 561       |         -0.01 | abs(result) \< tolerance | New Mexico           |
| 5628 | 562       |         -0.22 | abs(result) \< tolerance | New Mexico           |
| 5728 | 61        |          0.17 | abs(result) \< tolerance | New Mexico           |
| 5830 | 621       |         -0.26 | abs(result) \< tolerance | New Mexico           |
| 5929 | 622       |         -0.22 | abs(result) \< tolerance | New Mexico           |
| 6138 | 624       |         -0.47 | abs(result) \< tolerance | New Mexico           |
| 6231 | 711AS     |          0.53 | abs(result) \< tolerance | New Mexico           |
| 6330 | 713       |         -0.09 | abs(result) \< tolerance | New Mexico           |
| 6429 | 721       |          0.13 | abs(result) \< tolerance | New Mexico           |
| 6525 | 722       |          0.01 | abs(result) \< tolerance | New Mexico           |
| 6629 | 81        |         -0.14 | abs(result) \< tolerance | New Mexico           |
| 6730 | GFGD      |         -0.67 | abs(result) \< tolerance | New Mexico           |
| 6828 | GFGN      |         -0.67 | abs(result) \< tolerance | New Mexico           |
| 6930 | GFE       |         -0.77 | abs(result) \< tolerance | New Mexico           |
| 7028 | GSLG      |         -0.04 | abs(result) \< tolerance | New Mexico           |
| 7134 | GSLE      |          0.22 | abs(result) \< tolerance | New Mexico           |
| 7231 | Used      |          0.81 | abs(result) \< tolerance | New Mexico           |
| 7330 | Other     |         38.36 | abs(result) \< tolerance | New Mexico           |
| 1147 | 111CA     |          1.14 | abs(result) \< tolerance | New York             |
| 2138 | 113FF     |          1.13 | abs(result) \< tolerance | New York             |
| 3139 | 211       |         23.65 | abs(result) \< tolerance | New York             |
| 4140 | 212       |          1.90 | abs(result) \< tolerance | New York             |
| 5138 | 213       |          0.07 | abs(result) \< tolerance | New York             |
| 6139 | 22        |         -0.04 | abs(result) \< tolerance | New York             |
| 760  | 23        |          0.14 | abs(result) \< tolerance | New York             |
| 840  | 321       |          2.45 | abs(result) \< tolerance | New York             |
| 938  | 327       |          0.16 | abs(result) \< tolerance | New York             |
| 1040 | 331       |          0.43 | abs(result) \< tolerance | New York             |
| 1148 | 332       |          0.37 | abs(result) \< tolerance | New York             |
| 1240 | 333       |          0.03 | abs(result) \< tolerance | New York             |
| 1340 | 334       |          0.13 | abs(result) \< tolerance | New York             |
| 1439 | 335       |          1.02 | abs(result) \< tolerance | New York             |
| 1534 | 3361MV    |          1.41 | abs(result) \< tolerance | New York             |
| 1632 | 3364OT    |          0.73 | abs(result) \< tolerance | New York             |
| 1729 | 337       |          0.97 | abs(result) \< tolerance | New York             |
| 1831 | 339       |          0.82 | abs(result) \< tolerance | New York             |
| 1931 | 311FT     |          0.31 | abs(result) \< tolerance | New York             |
| 2031 | 313TT     |          0.22 | abs(result) \< tolerance | New York             |
| 2139 | 315AL     |         -0.50 | abs(result) \< tolerance | New York             |
| 2232 | 322       |          0.63 | abs(result) \< tolerance | New York             |
| 2330 | 323       |          0.66 | abs(result) \< tolerance | New York             |
| 2431 | 324       |          6.90 | abs(result) \< tolerance | New York             |
| 2531 | 325       |          1.57 | abs(result) \< tolerance | New York             |
| 2629 | 326       |          0.14 | abs(result) \< tolerance | New York             |
| 2731 | 42        |         -0.08 | abs(result) \< tolerance | New York             |
| 2831 | 441       |          0.36 | abs(result) \< tolerance | New York             |
| 2931 | 445       |         -0.42 | abs(result) \< tolerance | New York             |
| 3031 | 452       |          0.02 | abs(result) \< tolerance | New York             |
| 3140 | 4A0       |         -0.02 | abs(result) \< tolerance | New York             |
| 3233 | 481       |          0.16 | abs(result) \< tolerance | New York             |
| 3331 | 482       |          0.84 | abs(result) \< tolerance | New York             |
| 3431 | 483       |          0.20 | abs(result) \< tolerance | New York             |
| 3530 | 484       |          0.90 | abs(result) \< tolerance | New York             |
| 3631 | 485       |         -0.53 | abs(result) \< tolerance | New York             |
| 3731 | 486       |          1.16 | abs(result) \< tolerance | New York             |
| 3831 | 487OS     |          0.27 | abs(result) \< tolerance | New York             |
| 3931 | 493       |          1.23 | abs(result) \< tolerance | New York             |
| 4030 | 511       |         -0.12 | abs(result) \< tolerance | New York             |
| 4141 | 512       |         -0.22 | abs(result) \< tolerance | New York             |
| 4233 | 513       |         -0.29 | abs(result) \< tolerance | New York             |
| 4331 | 514       |         -0.16 | abs(result) \< tolerance | New York             |
| 4431 | 521CI     |         -0.54 | abs(result) \< tolerance | New York             |
| 4531 | 523       |         -0.59 | abs(result) \< tolerance | New York             |
| 4629 | 524       |         -0.16 | abs(result) \< tolerance | New York             |
| 4731 | 525       |         -0.20 | abs(result) \< tolerance | New York             |
| 4831 | HS        |         -0.39 | abs(result) \< tolerance | New York             |
| 4931 | ORE       |          0.73 | abs(result) \< tolerance | New York             |
| 5031 | 532RL     |         -0.12 | abs(result) \< tolerance | New York             |
| 5139 | 5411      |         -0.45 | abs(result) \< tolerance | New York             |
| 5232 | 5415      |          0.07 | abs(result) \< tolerance | New York             |
| 5331 | 5412OP    |         -0.09 | abs(result) \< tolerance | New York             |
| 5430 | 55        |         -0.09 | abs(result) \< tolerance | New York             |
| 5529 | 561       |          0.18 | abs(result) \< tolerance | New York             |
| 5629 | 562       |          0.22 | abs(result) \< tolerance | New York             |
| 5729 | 61        |         -0.35 | abs(result) \< tolerance | New York             |
| 5831 | 621       |          0.16 | abs(result) \< tolerance | New York             |
| 5930 | 622       |         -0.08 | abs(result) \< tolerance | New York             |
| 6030 | 623       |         -0.09 | abs(result) \< tolerance | New York             |
| 6140 | 624       |         -0.26 | abs(result) \< tolerance | New York             |
| 6232 | 711AS     |         -0.40 | abs(result) \< tolerance | New York             |
| 6331 | 713       |          0.07 | abs(result) \< tolerance | New York             |
| 6430 | 721       |         -0.04 | abs(result) \< tolerance | New York             |
| 6526 | 722       |          0.01 | abs(result) \< tolerance | New York             |
| 6630 | 81        |          0.14 | abs(result) \< tolerance | New York             |
| 6731 | GFGD      |         -0.47 | abs(result) \< tolerance | New York             |
| 6829 | GFGN      |         -0.25 | abs(result) \< tolerance | New York             |
| 6931 | GFE       |          2.06 | abs(result) \< tolerance | New York             |
| 7029 | GSLG      |          0.07 | abs(result) \< tolerance | New York             |
| 7135 | GSLE      |          0.63 | abs(result) \< tolerance | New York             |
| 7232 | Used      |          0.70 | abs(result) \< tolerance | New York             |
| 7331 | Other     |        -28.13 | abs(result) \< tolerance | New York             |
| 1149 | 111CA     |          0.93 | abs(result) \< tolerance | North Carolina       |
| 2140 | 113FF     |          0.38 | abs(result) \< tolerance | North Carolina       |
| 3141 | 211       |        586.47 | abs(result) \< tolerance | North Carolina       |
| 4142 | 212       |          0.56 | abs(result) \< tolerance | North Carolina       |
| 5140 | 213       |          0.06 | abs(result) \< tolerance | North Carolina       |
| 6141 | 22        |          0.09 | abs(result) \< tolerance | North Carolina       |
| 761  | 23        |         -0.03 | abs(result) \< tolerance | North Carolina       |
| 841  | 321       |         -0.32 | abs(result) \< tolerance | North Carolina       |
| 939  | 327       |         -0.07 | abs(result) \< tolerance | North Carolina       |
| 1041 | 331       |          0.56 | abs(result) \< tolerance | North Carolina       |
| 1150 | 332       |          0.15 | abs(result) \< tolerance | North Carolina       |
| 1241 | 333       |         -0.16 | abs(result) \< tolerance | North Carolina       |
| 1341 | 334       |         -0.26 | abs(result) \< tolerance | North Carolina       |
| 1440 | 335       |         -0.45 | abs(result) \< tolerance | North Carolina       |
| 1535 | 3361MV    |          0.07 | abs(result) \< tolerance | North Carolina       |
| 1633 | 3364OT    |         -0.31 | abs(result) \< tolerance | North Carolina       |
| 1730 | 337       |         -0.48 | abs(result) \< tolerance | North Carolina       |
| 1832 | 339       |          0.42 | abs(result) \< tolerance | North Carolina       |
| 1932 | 311FT     |         -0.54 | abs(result) \< tolerance | North Carolina       |
| 2032 | 313TT     |         -0.50 | abs(result) \< tolerance | North Carolina       |
| 2141 | 315AL     |          0.06 | abs(result) \< tolerance | North Carolina       |
| 2233 | 322       |          0.14 | abs(result) \< tolerance | North Carolina       |
| 2331 | 323       |          0.02 | abs(result) \< tolerance | North Carolina       |
| 2432 | 324       |          9.53 | abs(result) \< tolerance | North Carolina       |
| 2532 | 325       |         -0.07 | abs(result) \< tolerance | North Carolina       |
| 2630 | 326       |         -0.26 | abs(result) \< tolerance | North Carolina       |
| 2732 | 42        |          0.10 | abs(result) \< tolerance | North Carolina       |
| 2832 | 441       |          0.58 | abs(result) \< tolerance | North Carolina       |
| 2932 | 445       |         -0.03 | abs(result) \< tolerance | North Carolina       |
| 3032 | 452       |         -0.16 | abs(result) \< tolerance | North Carolina       |
| 3142 | 4A0       |          0.12 | abs(result) \< tolerance | North Carolina       |
| 3234 | 481       |         -0.01 | abs(result) \< tolerance | North Carolina       |
| 3332 | 482       |          2.12 | abs(result) \< tolerance | North Carolina       |
| 3432 | 483       |          7.58 | abs(result) \< tolerance | North Carolina       |
| 3531 | 484       |          0.18 | abs(result) \< tolerance | North Carolina       |
| 3632 | 485       |          1.18 | abs(result) \< tolerance | North Carolina       |
| 3732 | 486       |          2.72 | abs(result) \< tolerance | North Carolina       |
| 3832 | 487OS     |          0.12 | abs(result) \< tolerance | North Carolina       |
| 3932 | 493       |          0.23 | abs(result) \< tolerance | North Carolina       |
| 4031 | 511       |         -0.02 | abs(result) \< tolerance | North Carolina       |
| 4143 | 512       |          2.02 | abs(result) \< tolerance | North Carolina       |
| 4234 | 513       |          0.40 | abs(result) \< tolerance | North Carolina       |
| 4332 | 514       |          0.42 | abs(result) \< tolerance | North Carolina       |
| 4432 | 521CI     |         -0.47 | abs(result) \< tolerance | North Carolina       |
| 4532 | 523       |          0.14 | abs(result) \< tolerance | North Carolina       |
| 4630 | 524       |          0.26 | abs(result) \< tolerance | North Carolina       |
| 4732 | 525       |          1.38 | abs(result) \< tolerance | North Carolina       |
| 4832 | HS        |         -0.17 | abs(result) \< tolerance | North Carolina       |
| 4932 | ORE       |          0.78 | abs(result) \< tolerance | North Carolina       |
| 5032 | 532RL     |          0.02 | abs(result) \< tolerance | North Carolina       |
| 5141 | 5411      |          0.72 | abs(result) \< tolerance | North Carolina       |
| 5332 | 5412OP    |         -0.06 | abs(result) \< tolerance | North Carolina       |
| 5431 | 55        |         -0.11 | abs(result) \< tolerance | North Carolina       |
| 5530 | 561       |         -0.14 | abs(result) \< tolerance | North Carolina       |
| 5630 | 562       |          0.18 | abs(result) \< tolerance | North Carolina       |
| 5730 | 61        |          0.03 | abs(result) \< tolerance | North Carolina       |
| 5832 | 621       |          0.09 | abs(result) \< tolerance | North Carolina       |
| 5931 | 622       |          0.28 | abs(result) \< tolerance | North Carolina       |
| 6031 | 623       |          0.16 | abs(result) \< tolerance | North Carolina       |
| 6142 | 624       |          0.28 | abs(result) \< tolerance | North Carolina       |
| 6233 | 711AS     |          0.02 | abs(result) \< tolerance | North Carolina       |
| 6332 | 713       |          0.32 | abs(result) \< tolerance | North Carolina       |
| 6431 | 721       |          0.31 | abs(result) \< tolerance | North Carolina       |
| 6527 | 722       |         -0.02 | abs(result) \< tolerance | North Carolina       |
| 6631 | 81        |          0.15 | abs(result) \< tolerance | North Carolina       |
| 6732 | GFGD      |         -0.18 | abs(result) \< tolerance | North Carolina       |
| 6830 | GFGN      |         -0.24 | abs(result) \< tolerance | North Carolina       |
| 6932 | GFE       |          0.14 | abs(result) \< tolerance | North Carolina       |
| 7030 | GSLG      |         -0.17 | abs(result) \< tolerance | North Carolina       |
| 7136 | GSLE      |         -0.42 | abs(result) \< tolerance | North Carolina       |
| 7233 | Used      |          0.30 | abs(result) \< tolerance | North Carolina       |
| 7332 | Other     |        -19.43 | abs(result) \< tolerance | North Carolina       |
| 1151 | 111CA     |         -0.69 | abs(result) \< tolerance | North Dakota         |
| 2142 | 113FF     |          0.34 | abs(result) \< tolerance | North Dakota         |
| 3143 | 211       |         -0.75 | abs(result) \< tolerance | North Dakota         |
| 4144 | 212       |         -0.62 | abs(result) \< tolerance | North Dakota         |
| 5142 | 213       |         -0.03 | abs(result) \< tolerance | North Dakota         |
| 6143 | 22        |         -0.37 | abs(result) \< tolerance | North Dakota         |
| 762  | 23        |         -0.07 | abs(result) \< tolerance | North Dakota         |
| 842  | 321       |         -0.28 | abs(result) \< tolerance | North Dakota         |
| 940  | 327       |          0.15 | abs(result) \< tolerance | North Dakota         |
| 1042 | 331       |          0.68 | abs(result) \< tolerance | North Dakota         |
| 1152 | 332       |          1.47 | abs(result) \< tolerance | North Dakota         |
| 1242 | 333       |         -0.08 | abs(result) \< tolerance | North Dakota         |
| 1342 | 334       |          1.00 | abs(result) \< tolerance | North Dakota         |
| 1441 | 335       |          6.40 | abs(result) \< tolerance | North Dakota         |
| 1536 | 3361MV    |          1.27 | abs(result) \< tolerance | North Dakota         |
| 1634 | 3364OT    |          0.11 | abs(result) \< tolerance | North Dakota         |
| 1731 | 337       |          0.86 | abs(result) \< tolerance | North Dakota         |
| 1833 | 339       |          2.37 | abs(result) \< tolerance | North Dakota         |
| 1933 | 311FT     |          0.10 | abs(result) \< tolerance | North Dakota         |
| 2033 | 313TT     |          0.44 | abs(result) \< tolerance | North Dakota         |
| 2143 | 315AL     |          2.33 | abs(result) \< tolerance | North Dakota         |
| 2234 | 322       |          6.24 | abs(result) \< tolerance | North Dakota         |
| 2332 | 323       |          1.27 | abs(result) \< tolerance | North Dakota         |
| 2433 | 324       |          0.95 | abs(result) \< tolerance | North Dakota         |
| 2533 | 325       |          4.17 | abs(result) \< tolerance | North Dakota         |
| 2631 | 326       |          0.39 | abs(result) \< tolerance | North Dakota         |
| 2733 | 42        |         -0.12 | abs(result) \< tolerance | North Dakota         |
| 2833 | 441       |          0.35 | abs(result) \< tolerance | North Dakota         |
| 2933 | 445       |         -0.09 | abs(result) \< tolerance | North Dakota         |
| 3033 | 452       |         -0.26 | abs(result) \< tolerance | North Dakota         |
| 3144 | 4A0       |         -0.14 | abs(result) \< tolerance | North Dakota         |
| 3235 | 481       |          3.97 | abs(result) \< tolerance | North Dakota         |
| 3333 | 482       |         -0.59 | abs(result) \< tolerance | North Dakota         |
| 3433 | 483       |          0.66 | abs(result) \< tolerance | North Dakota         |
| 3532 | 484       |         -0.49 | abs(result) \< tolerance | North Dakota         |
| 3633 | 485       |          0.44 | abs(result) \< tolerance | North Dakota         |
| 3733 | 486       |         -0.07 | abs(result) \< tolerance | North Dakota         |
| 3833 | 487OS     |          0.38 | abs(result) \< tolerance | North Dakota         |
| 3933 | 493       |          2.69 | abs(result) \< tolerance | North Dakota         |
| 4032 | 511       |         -0.06 | abs(result) \< tolerance | North Dakota         |
| 4145 | 512       |          2.60 | abs(result) \< tolerance | North Dakota         |
| 4235 | 513       |          0.45 | abs(result) \< tolerance | North Dakota         |
| 4333 | 514       |          2.27 | abs(result) \< tolerance | North Dakota         |
| 4433 | 521CI     |          0.30 | abs(result) \< tolerance | North Dakota         |
| 4533 | 523       |          2.56 | abs(result) \< tolerance | North Dakota         |
| 4631 | 524       |          0.27 | abs(result) \< tolerance | North Dakota         |
| 4733 | 525       |          2.18 | abs(result) \< tolerance | North Dakota         |
| 4833 | HS        |         -0.20 | abs(result) \< tolerance | North Dakota         |
| 4933 | ORE       |          1.15 | abs(result) \< tolerance | North Dakota         |
| 5033 | 532RL     |         -0.15 | abs(result) \< tolerance | North Dakota         |
| 5143 | 5411      |          1.97 | abs(result) \< tolerance | North Dakota         |
| 5233 | 5415      |          0.67 | abs(result) \< tolerance | North Dakota         |
| 5333 | 5412OP    |          0.53 | abs(result) \< tolerance | North Dakota         |
| 5432 | 55        |          0.88 | abs(result) \< tolerance | North Dakota         |
| 5531 | 561       |          0.70 | abs(result) \< tolerance | North Dakota         |
| 5631 | 562       |          0.73 | abs(result) \< tolerance | North Dakota         |
| 5731 | 61        |          0.81 | abs(result) \< tolerance | North Dakota         |
| 5833 | 621       |         -0.04 | abs(result) \< tolerance | North Dakota         |
| 5932 | 622       |         -0.32 | abs(result) \< tolerance | North Dakota         |
| 6032 | 623       |         -0.51 | abs(result) \< tolerance | North Dakota         |
| 6234 | 711AS     |          2.40 | abs(result) \< tolerance | North Dakota         |
| 6333 | 713       |          0.06 | abs(result) \< tolerance | North Dakota         |
| 6432 | 721       |          0.17 | abs(result) \< tolerance | North Dakota         |
| 6528 | 722       |          0.17 | abs(result) \< tolerance | North Dakota         |
| 6733 | GFGD      |         -0.18 | abs(result) \< tolerance | North Dakota         |
| 6831 | GFGN      |          0.30 | abs(result) \< tolerance | North Dakota         |
| 6933 | GFE       |          1.30 | abs(result) \< tolerance | North Dakota         |
| 7031 | GSLG      |         -0.05 | abs(result) \< tolerance | North Dakota         |
| 7137 | GSLE      |          0.64 | abs(result) \< tolerance | North Dakota         |
| 7234 | Used      |          2.76 | abs(result) \< tolerance | North Dakota         |
| 7333 | Other     |        -58.82 | abs(result) \< tolerance | North Dakota         |
| 1153 | 111CA     |          0.78 | abs(result) \< tolerance | Ohio                 |
| 2144 | 113FF     |          0.99 | abs(result) \< tolerance | Ohio                 |
| 3145 | 211       |         65.44 | abs(result) \< tolerance | Ohio                 |
| 4146 | 212       |          0.62 | abs(result) \< tolerance | Ohio                 |
| 5144 | 213       |         -0.08 | abs(result) \< tolerance | Ohio                 |
| 6144 | 22        |          0.03 | abs(result) \< tolerance | Ohio                 |
| 843  | 321       |          0.08 | abs(result) \< tolerance | Ohio                 |
| 941  | 327       |         -0.33 | abs(result) \< tolerance | Ohio                 |
| 1043 | 331       |         -0.28 | abs(result) \< tolerance | Ohio                 |
| 1154 | 332       |         -0.36 | abs(result) \< tolerance | Ohio                 |
| 1243 | 333       |         -0.17 | abs(result) \< tolerance | Ohio                 |
| 1343 | 334       |          0.82 | abs(result) \< tolerance | Ohio                 |
| 1442 | 335       |         -0.35 | abs(result) \< tolerance | Ohio                 |
| 1537 | 3361MV    |         -0.19 | abs(result) \< tolerance | Ohio                 |
| 1635 | 3364OT    |         -0.23 | abs(result) \< tolerance | Ohio                 |
| 1732 | 337       |         -0.08 | abs(result) \< tolerance | Ohio                 |
| 1934 | 311FT     |         -0.18 | abs(result) \< tolerance | Ohio                 |
| 2034 | 313TT     |          0.46 | abs(result) \< tolerance | Ohio                 |
| 2145 | 315AL     |          1.32 | abs(result) \< tolerance | Ohio                 |
| 2235 | 322       |          0.06 | abs(result) \< tolerance | Ohio                 |
| 2333 | 323       |         -0.34 | abs(result) \< tolerance | Ohio                 |
| 2434 | 324       |         -0.31 | abs(result) \< tolerance | Ohio                 |
| 2534 | 325       |         -0.21 | abs(result) \< tolerance | Ohio                 |
| 2632 | 326       |         -0.35 | abs(result) \< tolerance | Ohio                 |
| 2734 | 42        |          0.08 | abs(result) \< tolerance | Ohio                 |
| 2834 | 441       |          0.33 | abs(result) \< tolerance | Ohio                 |
| 2934 | 445       |         -0.07 | abs(result) \< tolerance | Ohio                 |
| 3034 | 452       |         -0.28 | abs(result) \< tolerance | Ohio                 |
| 3146 | 4A0       |         -0.07 | abs(result) \< tolerance | Ohio                 |
| 3236 | 481       |          0.37 | abs(result) \< tolerance | Ohio                 |
| 3334 | 482       |          0.16 | abs(result) \< tolerance | Ohio                 |
| 3434 | 483       |          1.17 | abs(result) \< tolerance | Ohio                 |
| 3533 | 484       |         -0.21 | abs(result) \< tolerance | Ohio                 |
| 3634 | 485       |          0.77 | abs(result) \< tolerance | Ohio                 |
| 3934 | 493       |         -0.13 | abs(result) \< tolerance | Ohio                 |
| 4033 | 511       |          0.03 | abs(result) \< tolerance | Ohio                 |
| 4147 | 512       |          1.58 | abs(result) \< tolerance | Ohio                 |
| 4236 | 513       |          0.50 | abs(result) \< tolerance | Ohio                 |
| 4334 | 514       |          1.39 | abs(result) \< tolerance | Ohio                 |
| 4434 | 521CI     |         -0.26 | abs(result) \< tolerance | Ohio                 |
| 4534 | 523       |          0.61 | abs(result) \< tolerance | Ohio                 |
| 4632 | 524       |         -0.24 | abs(result) \< tolerance | Ohio                 |
| 4734 | 525       |          1.14 | abs(result) \< tolerance | Ohio                 |
| 4834 | HS        |         -0.19 | abs(result) \< tolerance | Ohio                 |
| 4934 | ORE       |          0.95 | abs(result) \< tolerance | Ohio                 |
| 5034 | 532RL     |          0.04 | abs(result) \< tolerance | Ohio                 |
| 5145 | 5411      |          0.49 | abs(result) \< tolerance | Ohio                 |
| 5234 | 5415      |          0.07 | abs(result) \< tolerance | Ohio                 |
| 5334 | 5412OP    |          0.26 | abs(result) \< tolerance | Ohio                 |
| 5433 | 55        |         -0.36 | abs(result) \< tolerance | Ohio                 |
| 5532 | 561       |         -0.05 | abs(result) \< tolerance | Ohio                 |
| 5632 | 562       |         -0.27 | abs(result) \< tolerance | Ohio                 |
| 5732 | 61        |          0.17 | abs(result) \< tolerance | Ohio                 |
| 5834 | 621       |         -0.11 | abs(result) \< tolerance | Ohio                 |
| 5933 | 622       |         -0.27 | abs(result) \< tolerance | Ohio                 |
| 6033 | 623       |         -0.32 | abs(result) \< tolerance | Ohio                 |
| 6145 | 624       |         -0.03 | abs(result) \< tolerance | Ohio                 |
| 6235 | 711AS     |          0.05 | abs(result) \< tolerance | Ohio                 |
| 6334 | 713       |         -0.17 | abs(result) \< tolerance | Ohio                 |
| 6433 | 721       |          0.86 | abs(result) \< tolerance | Ohio                 |
| 6529 | 722       |         -0.07 | abs(result) \< tolerance | Ohio                 |
| 6734 | GFGD      |         -0.61 | abs(result) \< tolerance | Ohio                 |
| 6832 | GFGN      |         -0.23 | abs(result) \< tolerance | Ohio                 |
| 6934 | GFE       |          0.23 | abs(result) \< tolerance | Ohio                 |
| 7032 | GSLG      |          0.03 | abs(result) \< tolerance | Ohio                 |
| 7138 | GSLE      |          1.13 | abs(result) \< tolerance | Ohio                 |
| 7235 | Used      |         -2.22 | abs(result) \< tolerance | Ohio                 |
| 7334 | Other     |        -23.10 | abs(result) \< tolerance | Ohio                 |
| 1155 | 111CA     |         -0.50 | abs(result) \< tolerance | Oklahoma             |
| 2146 | 113FF     |          0.34 | abs(result) \< tolerance | Oklahoma             |
| 3147 | 211       |         -0.67 | abs(result) \< tolerance | Oklahoma             |
| 4148 | 212       |          0.01 | abs(result) \< tolerance | Oklahoma             |
| 5146 | 213       |         -0.01 | abs(result) \< tolerance | Oklahoma             |
| 6146 | 22        |         -0.19 | abs(result) \< tolerance | Oklahoma             |
| 763  | 23        |          0.11 | abs(result) \< tolerance | Oklahoma             |
| 942  | 327       |         -0.39 | abs(result) \< tolerance | Oklahoma             |
| 1044 | 331       |          0.90 | abs(result) \< tolerance | Oklahoma             |
| 1156 | 332       |         -0.30 | abs(result) \< tolerance | Oklahoma             |
| 1244 | 333       |         -0.20 | abs(result) \< tolerance | Oklahoma             |
| 1344 | 334       |          0.86 | abs(result) \< tolerance | Oklahoma             |
| 1443 | 335       |          0.84 | abs(result) \< tolerance | Oklahoma             |
| 1538 | 3361MV    |          0.56 | abs(result) \< tolerance | Oklahoma             |
| 1636 | 3364OT    |          0.01 | abs(result) \< tolerance | Oklahoma             |
| 1733 | 337       |          1.06 | abs(result) \< tolerance | Oklahoma             |
| 1834 | 339       |          0.69 | abs(result) \< tolerance | Oklahoma             |
| 1935 | 311FT     |          0.21 | abs(result) \< tolerance | Oklahoma             |
| 2035 | 313TT     |          1.67 | abs(result) \< tolerance | Oklahoma             |
| 2147 | 315AL     |          0.42 | abs(result) \< tolerance | Oklahoma             |
| 2236 | 322       |         -0.44 | abs(result) \< tolerance | Oklahoma             |
| 2334 | 323       |          0.85 | abs(result) \< tolerance | Oklahoma             |
| 2435 | 324       |         -0.50 | abs(result) \< tolerance | Oklahoma             |
| 2535 | 325       |          2.05 | abs(result) \< tolerance | Oklahoma             |
| 2633 | 326       |         -0.38 | abs(result) \< tolerance | Oklahoma             |
| 2735 | 42        |          0.20 | abs(result) \< tolerance | Oklahoma             |
| 2835 | 441       |          0.70 | abs(result) \< tolerance | Oklahoma             |
| 2935 | 445       |          0.15 | abs(result) \< tolerance | Oklahoma             |
| 3035 | 452       |         -0.28 | abs(result) \< tolerance | Oklahoma             |
| 3237 | 481       |         -0.03 | abs(result) \< tolerance | Oklahoma             |
| 3335 | 482       |         -0.35 | abs(result) \< tolerance | Oklahoma             |
| 3435 | 483       |         16.19 | abs(result) \< tolerance | Oklahoma             |
| 3534 | 484       |         -0.25 | abs(result) \< tolerance | Oklahoma             |
| 3635 | 485       |          2.18 | abs(result) \< tolerance | Oklahoma             |
| 3734 | 486       |         -0.76 | abs(result) \< tolerance | Oklahoma             |
| 3834 | 487OS     |          0.13 | abs(result) \< tolerance | Oklahoma             |
| 3935 | 493       |         -0.03 | abs(result) \< tolerance | Oklahoma             |
| 4034 | 511       |          0.39 | abs(result) \< tolerance | Oklahoma             |
| 4149 | 512       |          2.49 | abs(result) \< tolerance | Oklahoma             |
| 4237 | 513       |          0.10 | abs(result) \< tolerance | Oklahoma             |
| 4335 | 514       |          2.20 | abs(result) \< tolerance | Oklahoma             |
| 4435 | 521CI     |          0.49 | abs(result) \< tolerance | Oklahoma             |
| 4535 | 523       |          2.43 | abs(result) \< tolerance | Oklahoma             |
| 4633 | 524       |          0.40 | abs(result) \< tolerance | Oklahoma             |
| 4735 | 525       |         -0.07 | abs(result) \< tolerance | Oklahoma             |
| 4935 | ORE       |          0.99 | abs(result) \< tolerance | Oklahoma             |
| 5035 | 532RL     |          0.12 | abs(result) \< tolerance | Oklahoma             |
| 5147 | 5411      |          0.40 | abs(result) \< tolerance | Oklahoma             |
| 5235 | 5415      |          1.80 | abs(result) \< tolerance | Oklahoma             |
| 5335 | 5412OP    |          0.25 | abs(result) \< tolerance | Oklahoma             |
| 5434 | 55        |          0.72 | abs(result) \< tolerance | Oklahoma             |
| 5533 | 561       |         -0.18 | abs(result) \< tolerance | Oklahoma             |
| 5633 | 562       |          0.55 | abs(result) \< tolerance | Oklahoma             |
| 5733 | 61        |          0.35 | abs(result) \< tolerance | Oklahoma             |
| 5835 | 621       |         -0.08 | abs(result) \< tolerance | Oklahoma             |
| 5934 | 622       |         -0.12 | abs(result) \< tolerance | Oklahoma             |
| 6034 | 623       |          0.01 | abs(result) \< tolerance | Oklahoma             |
| 6147 | 624       |          0.06 | abs(result) \< tolerance | Oklahoma             |
| 6236 | 711AS     |          0.53 | abs(result) \< tolerance | Oklahoma             |
| 6434 | 721       |          0.65 | abs(result) \< tolerance | Oklahoma             |
| 6632 | 81        |         -0.02 | abs(result) \< tolerance | Oklahoma             |
| 6735 | GFGD      |         -0.20 | abs(result) \< tolerance | Oklahoma             |
| 6833 | GFGN      |         -0.25 | abs(result) \< tolerance | Oklahoma             |
| 6935 | GFE       |         -0.41 | abs(result) \< tolerance | Oklahoma             |
| 7033 | GSLG      |         -0.31 | abs(result) \< tolerance | Oklahoma             |
| 7139 | GSLE      |         -0.21 | abs(result) \< tolerance | Oklahoma             |
| 7236 | Used      |         -0.20 | abs(result) \< tolerance | Oklahoma             |
| 7335 | Other     |         11.12 | abs(result) \< tolerance | Oklahoma             |
| 1157 | 111CA     |          0.01 | abs(result) \< tolerance | Oregon               |
| 2148 | 113FF     |         -0.28 | abs(result) \< tolerance | Oregon               |
| 3148 | 211       |     333918.77 | abs(result) \< tolerance | Oregon               |
| 4150 | 212       |          0.98 | abs(result) \< tolerance | Oregon               |
| 5148 | 213       |          0.02 | abs(result) \< tolerance | Oregon               |
| 6148 | 22        |          0.20 | abs(result) \< tolerance | Oregon               |
| 764  | 23        |          0.05 | abs(result) \< tolerance | Oregon               |
| 844  | 321       |         -0.67 | abs(result) \< tolerance | Oregon               |
| 943  | 327       |          0.07 | abs(result) \< tolerance | Oregon               |
| 1045 | 331       |         -0.48 | abs(result) \< tolerance | Oregon               |
| 1158 | 332       |         -0.06 | abs(result) \< tolerance | Oregon               |
| 1245 | 333       |          0.38 | abs(result) \< tolerance | Oregon               |
| 1345 | 334       |         -0.27 | abs(result) \< tolerance | Oregon               |
| 1444 | 335       |          0.18 | abs(result) \< tolerance | Oregon               |
| 1539 | 3361MV    |          0.71 | abs(result) \< tolerance | Oregon               |
| 1637 | 3364OT    |         -0.23 | abs(result) \< tolerance | Oregon               |
| 1734 | 337       |         -0.07 | abs(result) \< tolerance | Oregon               |
| 1835 | 339       |         -0.02 | abs(result) \< tolerance | Oregon               |
| 1936 | 311FT     |          0.02 | abs(result) \< tolerance | Oregon               |
| 2036 | 313TT     |          0.96 | abs(result) \< tolerance | Oregon               |
| 2149 | 315AL     |          0.83 | abs(result) \< tolerance | Oregon               |
| 2237 | 322       |         -0.17 | abs(result) \< tolerance | Oregon               |
| 2335 | 323       |          0.17 | abs(result) \< tolerance | Oregon               |
| 2436 | 324       |          4.16 | abs(result) \< tolerance | Oregon               |
| 2536 | 325       |          2.66 | abs(result) \< tolerance | Oregon               |
| 2634 | 326       |          0.47 | abs(result) \< tolerance | Oregon               |
| 2736 | 42        |          0.08 | abs(result) \< tolerance | Oregon               |
| 2836 | 441       |          0.61 | abs(result) \< tolerance | Oregon               |
| 2936 | 445       |          0.02 | abs(result) \< tolerance | Oregon               |
| 3036 | 452       |         -0.13 | abs(result) \< tolerance | Oregon               |
| 3149 | 4A0       |          0.07 | abs(result) \< tolerance | Oregon               |
| 3238 | 481       |          0.05 | abs(result) \< tolerance | Oregon               |
| 3336 | 482       |          0.15 | abs(result) \< tolerance | Oregon               |
| 3436 | 483       |          0.45 | abs(result) \< tolerance | Oregon               |
| 3535 | 484       |         -0.06 | abs(result) \< tolerance | Oregon               |
| 3636 | 485       |          0.02 | abs(result) \< tolerance | Oregon               |
| 3735 | 486       |          3.63 | abs(result) \< tolerance | Oregon               |
| 3936 | 493       |          0.43 | abs(result) \< tolerance | Oregon               |
| 4035 | 511       |         -0.19 | abs(result) \< tolerance | Oregon               |
| 4151 | 512       |          0.08 | abs(result) \< tolerance | Oregon               |
| 4238 | 513       |          0.82 | abs(result) \< tolerance | Oregon               |
| 4336 | 514       |          0.19 | abs(result) \< tolerance | Oregon               |
| 4436 | 521CI     |          0.65 | abs(result) \< tolerance | Oregon               |
| 4536 | 523       |          0.92 | abs(result) \< tolerance | Oregon               |
| 4634 | 524       |          0.06 | abs(result) \< tolerance | Oregon               |
| 4736 | 525       |          2.63 | abs(result) \< tolerance | Oregon               |
| 4835 | HS        |         -0.20 | abs(result) \< tolerance | Oregon               |
| 4936 | ORE       |          0.55 | abs(result) \< tolerance | Oregon               |
| 5036 | 532RL     |         -0.15 | abs(result) \< tolerance | Oregon               |
| 5149 | 5411      |          0.35 | abs(result) \< tolerance | Oregon               |
| 5336 | 5412OP    |         -0.11 | abs(result) \< tolerance | Oregon               |
| 5435 | 55        |         -0.45 | abs(result) \< tolerance | Oregon               |
| 5534 | 561       |         -0.02 | abs(result) \< tolerance | Oregon               |
| 5634 | 562       |         -0.15 | abs(result) \< tolerance | Oregon               |
| 5734 | 61        |         -0.04 | abs(result) \< tolerance | Oregon               |
| 5836 | 621       |         -0.30 | abs(result) \< tolerance | Oregon               |
| 5935 | 622       |         -0.29 | abs(result) \< tolerance | Oregon               |
| 6035 | 623       |         -0.37 | abs(result) \< tolerance | Oregon               |
| 6149 | 624       |         -0.39 | abs(result) \< tolerance | Oregon               |
| 6237 | 711AS     |          0.05 | abs(result) \< tolerance | Oregon               |
| 6335 | 713       |          0.10 | abs(result) \< tolerance | Oregon               |
| 6435 | 721       |          0.05 | abs(result) \< tolerance | Oregon               |
| 6530 | 722       |         -0.04 | abs(result) \< tolerance | Oregon               |
| 6633 | 81        |         -0.12 | abs(result) \< tolerance | Oregon               |
| 6736 | GFGD      |         -0.34 | abs(result) \< tolerance | Oregon               |
| 6834 | GFGN      |         -0.35 | abs(result) \< tolerance | Oregon               |
| 6936 | GFE       |          0.03 | abs(result) \< tolerance | Oregon               |
| 7034 | GSLG      |         -0.02 | abs(result) \< tolerance | Oregon               |
| 7140 | GSLE      |          0.40 | abs(result) \< tolerance | Oregon               |
| 7237 | Used      |         -3.00 | abs(result) \< tolerance | Oregon               |
| 7336 | Other     |        -18.24 | abs(result) \< tolerance | Oregon               |
| 1159 | 111CA     |          0.51 | abs(result) \< tolerance | Pennsylvania         |
| 2150 | 113FF     |          1.99 | abs(result) \< tolerance | Pennsylvania         |
| 3150 | 211       |          1.15 | abs(result) \< tolerance | Pennsylvania         |
| 4152 | 212       |          0.24 | abs(result) \< tolerance | Pennsylvania         |
| 5150 | 213       |         -0.05 | abs(result) \< tolerance | Pennsylvania         |
| 6150 | 22        |          0.07 | abs(result) \< tolerance | Pennsylvania         |
| 765  | 23        |          0.01 | abs(result) \< tolerance | Pennsylvania         |
| 845  | 321       |         -0.13 | abs(result) \< tolerance | Pennsylvania         |
| 944  | 327       |         -0.19 | abs(result) \< tolerance | Pennsylvania         |
| 1046 | 331       |         -0.53 | abs(result) \< tolerance | Pennsylvania         |
| 1160 | 332       |         -0.23 | abs(result) \< tolerance | Pennsylvania         |
| 1246 | 333       |         -0.10 | abs(result) \< tolerance | Pennsylvania         |
| 1346 | 334       |          0.11 | abs(result) \< tolerance | Pennsylvania         |
| 1445 | 335       |         -0.31 | abs(result) \< tolerance | Pennsylvania         |
| 1540 | 3361MV    |          0.82 | abs(result) \< tolerance | Pennsylvania         |
| 1638 | 3364OT    |         -0.11 | abs(result) \< tolerance | Pennsylvania         |
| 1735 | 337       |         -0.13 | abs(result) \< tolerance | Pennsylvania         |
| 1836 | 339       |         -0.06 | abs(result) \< tolerance | Pennsylvania         |
| 1937 | 311FT     |         -0.02 | abs(result) \< tolerance | Pennsylvania         |
| 2037 | 313TT     |          0.16 | abs(result) \< tolerance | Pennsylvania         |
| 2151 | 315AL     |          0.33 | abs(result) \< tolerance | Pennsylvania         |
| 2238 | 322       |         -0.38 | abs(result) \< tolerance | Pennsylvania         |
| 2336 | 323       |         -0.36 | abs(result) \< tolerance | Pennsylvania         |
| 2437 | 324       |         -0.19 | abs(result) \< tolerance | Pennsylvania         |
| 2537 | 325       |         -0.21 | abs(result) \< tolerance | Pennsylvania         |
| 2635 | 326       |         -0.26 | abs(result) \< tolerance | Pennsylvania         |
| 2737 | 42        |          0.05 | abs(result) \< tolerance | Pennsylvania         |
| 2837 | 441       |          0.56 | abs(result) \< tolerance | Pennsylvania         |
| 2937 | 445       |         -0.19 | abs(result) \< tolerance | Pennsylvania         |
| 3151 | 4A0       |          0.15 | abs(result) \< tolerance | Pennsylvania         |
| 3239 | 481       |          0.36 | abs(result) \< tolerance | Pennsylvania         |
| 3337 | 482       |          0.23 | abs(result) \< tolerance | Pennsylvania         |
| 3437 | 483       |          2.15 | abs(result) \< tolerance | Pennsylvania         |
| 3536 | 484       |         -0.13 | abs(result) \< tolerance | Pennsylvania         |
| 3637 | 485       |         -0.05 | abs(result) \< tolerance | Pennsylvania         |
| 3736 | 486       |         -0.69 | abs(result) \< tolerance | Pennsylvania         |
| 3835 | 487OS     |          0.23 | abs(result) \< tolerance | Pennsylvania         |
| 3937 | 493       |         -0.46 | abs(result) \< tolerance | Pennsylvania         |
| 4036 | 511       |          0.25 | abs(result) \< tolerance | Pennsylvania         |
| 4153 | 512       |          1.81 | abs(result) \< tolerance | Pennsylvania         |
| 4239 | 513       |         -0.33 | abs(result) \< tolerance | Pennsylvania         |
| 4337 | 514       |          1.45 | abs(result) \< tolerance | Pennsylvania         |
| 4437 | 521CI     |          0.74 | abs(result) \< tolerance | Pennsylvania         |
| 4537 | 523       |          0.28 | abs(result) \< tolerance | Pennsylvania         |
| 4635 | 524       |         -0.03 | abs(result) \< tolerance | Pennsylvania         |
| 4737 | 525       |          1.49 | abs(result) \< tolerance | Pennsylvania         |
| 4836 | HS        |         -0.21 | abs(result) \< tolerance | Pennsylvania         |
| 4937 | ORE       |          0.83 | abs(result) \< tolerance | Pennsylvania         |
| 5037 | 532RL     |          0.24 | abs(result) \< tolerance | Pennsylvania         |
| 5151 | 5411      |         -0.07 | abs(result) \< tolerance | Pennsylvania         |
| 5236 | 5415      |          0.01 | abs(result) \< tolerance | Pennsylvania         |
| 5436 | 55        |         -0.42 | abs(result) \< tolerance | Pennsylvania         |
| 5535 | 561       |          0.20 | abs(result) \< tolerance | Pennsylvania         |
| 5635 | 562       |         -0.18 | abs(result) \< tolerance | Pennsylvania         |
| 5735 | 61        |         -0.17 | abs(result) \< tolerance | Pennsylvania         |
| 5837 | 621       |          0.16 | abs(result) \< tolerance | Pennsylvania         |
| 5936 | 622       |          0.11 | abs(result) \< tolerance | Pennsylvania         |
| 6036 | 623       |         -0.15 | abs(result) \< tolerance | Pennsylvania         |
| 6151 | 624       |         -0.02 | abs(result) \< tolerance | Pennsylvania         |
| 6238 | 711AS     |          0.05 | abs(result) \< tolerance | Pennsylvania         |
| 6336 | 713       |          0.11 | abs(result) \< tolerance | Pennsylvania         |
| 6436 | 721       |          0.24 | abs(result) \< tolerance | Pennsylvania         |
| 6531 | 722       |          0.07 | abs(result) \< tolerance | Pennsylvania         |
| 6634 | 81        |          0.31 | abs(result) \< tolerance | Pennsylvania         |
| 6737 | GFGD      |         -0.57 | abs(result) \< tolerance | Pennsylvania         |
| 6835 | GFGN      |          1.78 | abs(result) \< tolerance | Pennsylvania         |
| 6937 | GFE       |          0.16 | abs(result) \< tolerance | Pennsylvania         |
| 7035 | GSLG      |          0.24 | abs(result) \< tolerance | Pennsylvania         |
| 7141 | GSLE      |          1.35 | abs(result) \< tolerance | Pennsylvania         |
| 7238 | Used      |          2.91 | abs(result) \< tolerance | Pennsylvania         |
| 7337 | Other     |        -15.34 | abs(result) \< tolerance | Pennsylvania         |
| 1161 | 111CA     |          4.01 | abs(result) \< tolerance | Rhode Island         |
| 2152 | 113FF     |         -0.50 | abs(result) \< tolerance | Rhode Island         |
| 3152 | 211       |        668.11 | abs(result) \< tolerance | Rhode Island         |
| 4154 | 212       |          0.76 | abs(result) \< tolerance | Rhode Island         |
| 5152 | 213       |          0.02 | abs(result) \< tolerance | Rhode Island         |
| 6152 | 22        |          0.09 | abs(result) \< tolerance | Rhode Island         |
| 766  | 23        |          0.09 | abs(result) \< tolerance | Rhode Island         |
| 846  | 321       |          0.71 | abs(result) \< tolerance | Rhode Island         |
| 945  | 327       |          0.89 | abs(result) \< tolerance | Rhode Island         |
| 1047 | 331       |         -0.14 | abs(result) \< tolerance | Rhode Island         |
| 1162 | 332       |         -0.15 | abs(result) \< tolerance | Rhode Island         |
| 1247 | 333       |         -0.08 | abs(result) \< tolerance | Rhode Island         |
| 1446 | 335       |         -0.11 | abs(result) \< tolerance | Rhode Island         |
| 1541 | 3361MV    |          5.39 | abs(result) \< tolerance | Rhode Island         |
| 1639 | 3364OT    |         -0.43 | abs(result) \< tolerance | Rhode Island         |
| 1736 | 337       |          0.05 | abs(result) \< tolerance | Rhode Island         |
| 1837 | 339       |          0.08 | abs(result) \< tolerance | Rhode Island         |
| 1938 | 311FT     |          1.33 | abs(result) \< tolerance | Rhode Island         |
| 2038 | 313TT     |         -0.58 | abs(result) \< tolerance | Rhode Island         |
| 2153 | 315AL     |          1.70 | abs(result) \< tolerance | Rhode Island         |
| 2239 | 322       |          0.14 | abs(result) \< tolerance | Rhode Island         |
| 2337 | 323       |         -0.13 | abs(result) \< tolerance | Rhode Island         |
| 2438 | 324       |          2.35 | abs(result) \< tolerance | Rhode Island         |
| 2538 | 325       |          3.75 | abs(result) \< tolerance | Rhode Island         |
| 2636 | 326       |         -0.26 | abs(result) \< tolerance | Rhode Island         |
| 2738 | 42        |         -0.09 | abs(result) \< tolerance | Rhode Island         |
| 2838 | 441       |          0.42 | abs(result) \< tolerance | Rhode Island         |
| 2938 | 445       |         -0.21 | abs(result) \< tolerance | Rhode Island         |
| 3037 | 452       |          0.12 | abs(result) \< tolerance | Rhode Island         |
| 3153 | 4A0       |          0.11 | abs(result) \< tolerance | Rhode Island         |
| 3240 | 481       |          1.79 | abs(result) \< tolerance | Rhode Island         |
| 3338 | 482       |          0.70 | abs(result) \< tolerance | Rhode Island         |
| 3438 | 483       |          0.26 | abs(result) \< tolerance | Rhode Island         |
| 3537 | 484       |          0.56 | abs(result) \< tolerance | Rhode Island         |
| 3638 | 485       |          0.14 | abs(result) \< tolerance | Rhode Island         |
| 3737 | 486       |          4.13 | abs(result) \< tolerance | Rhode Island         |
| 3836 | 487OS     |          0.15 | abs(result) \< tolerance | Rhode Island         |
| 3938 | 493       |          1.03 | abs(result) \< tolerance | Rhode Island         |
| 4037 | 511       |          0.38 | abs(result) \< tolerance | Rhode Island         |
| 4155 | 512       |          1.15 | abs(result) \< tolerance | Rhode Island         |
| 4240 | 513       |          0.53 | abs(result) \< tolerance | Rhode Island         |
| 4338 | 514       |          1.79 | abs(result) \< tolerance | Rhode Island         |
| 4438 | 521CI     |          0.13 | abs(result) \< tolerance | Rhode Island         |
| 4538 | 523       |         -0.30 | abs(result) \< tolerance | Rhode Island         |
| 4636 | 524       |         -0.25 | abs(result) \< tolerance | Rhode Island         |
| 4738 | 525       |          2.47 | abs(result) \< tolerance | Rhode Island         |
| 4837 | HS        |         -0.23 | abs(result) \< tolerance | Rhode Island         |
| 4938 | ORE       |          0.72 | abs(result) \< tolerance | Rhode Island         |
| 5038 | 532RL     |          0.30 | abs(result) \< tolerance | Rhode Island         |
| 5153 | 5411      |          0.12 | abs(result) \< tolerance | Rhode Island         |
| 5337 | 5412OP    |         -0.02 | abs(result) \< tolerance | Rhode Island         |
| 5437 | 55        |         -0.55 | abs(result) \< tolerance | Rhode Island         |
| 5536 | 561       |         -0.03 | abs(result) \< tolerance | Rhode Island         |
| 5636 | 562       |         -0.35 | abs(result) \< tolerance | Rhode Island         |
| 5736 | 61        |         -0.51 | abs(result) \< tolerance | Rhode Island         |
| 5838 | 621       |         -0.06 | abs(result) \< tolerance | Rhode Island         |
| 5937 | 622       |         -0.30 | abs(result) \< tolerance | Rhode Island         |
| 6037 | 623       |         -0.50 | abs(result) \< tolerance | Rhode Island         |
| 6153 | 624       |         -0.15 | abs(result) \< tolerance | Rhode Island         |
| 6239 | 711AS     |          0.19 | abs(result) \< tolerance | Rhode Island         |
| 6337 | 713       |         -0.20 | abs(result) \< tolerance | Rhode Island         |
| 6437 | 721       |         -0.06 | abs(result) \< tolerance | Rhode Island         |
| 6532 | 722       |         -0.07 | abs(result) \< tolerance | Rhode Island         |
| 6635 | 81        |          0.06 | abs(result) \< tolerance | Rhode Island         |
| 6738 | GFGD      |         -0.53 | abs(result) \< tolerance | Rhode Island         |
| 6836 | GFGN      |         -0.23 | abs(result) \< tolerance | Rhode Island         |
| 6938 | GFE       |         -0.15 | abs(result) \< tolerance | Rhode Island         |
| 7036 | GSLG      |          0.16 | abs(result) \< tolerance | Rhode Island         |
| 7142 | GSLE      |          1.05 | abs(result) \< tolerance | Rhode Island         |
| 7239 | Used      |          3.08 | abs(result) \< tolerance | Rhode Island         |
| 7338 | Other     |         11.13 | abs(result) \< tolerance | Rhode Island         |
| 1163 | 111CA     |          0.61 | abs(result) \< tolerance | South Carolina       |
| 2154 | 113FF     |          0.41 | abs(result) \< tolerance | South Carolina       |
| 3154 | 211       |        186.55 | abs(result) \< tolerance | South Carolina       |
| 4156 | 212       |          0.57 | abs(result) \< tolerance | South Carolina       |
| 5154 | 213       |         -0.02 | abs(result) \< tolerance | South Carolina       |
| 6154 | 22        |         -0.21 | abs(result) \< tolerance | South Carolina       |
| 767  | 23        |         -0.01 | abs(result) \< tolerance | South Carolina       |
| 847  | 321       |         -0.39 | abs(result) \< tolerance | South Carolina       |
| 946  | 327       |         -0.21 | abs(result) \< tolerance | South Carolina       |
| 1048 | 331       |          0.06 | abs(result) \< tolerance | South Carolina       |
| 1164 | 332       |         -0.10 | abs(result) \< tolerance | South Carolina       |
| 1248 | 333       |         -0.10 | abs(result) \< tolerance | South Carolina       |
| 1347 | 334       |          0.43 | abs(result) \< tolerance | South Carolina       |
| 1447 | 335       |         -0.42 | abs(result) \< tolerance | South Carolina       |
| 1542 | 3361MV    |          0.16 | abs(result) \< tolerance | South Carolina       |
| 1640 | 3364OT    |         -0.04 | abs(result) \< tolerance | South Carolina       |
| 1737 | 337       |         -0.10 | abs(result) \< tolerance | South Carolina       |
| 1838 | 339       |          0.74 | abs(result) \< tolerance | South Carolina       |
| 1939 | 311FT     |          0.59 | abs(result) \< tolerance | South Carolina       |
| 2039 | 313TT     |         -0.59 | abs(result) \< tolerance | South Carolina       |
| 2155 | 315AL     |          0.02 | abs(result) \< tolerance | South Carolina       |
| 2240 | 322       |         -0.48 | abs(result) \< tolerance | South Carolina       |
| 2338 | 323       |         -0.06 | abs(result) \< tolerance | South Carolina       |
| 2439 | 324       |          4.89 | abs(result) \< tolerance | South Carolina       |
| 2539 | 325       |          1.44 | abs(result) \< tolerance | South Carolina       |
| 2637 | 326       |         -0.46 | abs(result) \< tolerance | South Carolina       |
| 2739 | 42        |          0.19 | abs(result) \< tolerance | South Carolina       |
| 2839 | 441       |          0.55 | abs(result) \< tolerance | South Carolina       |
| 2939 | 445       |         -0.03 | abs(result) \< tolerance | South Carolina       |
| 3038 | 452       |         -0.22 | abs(result) \< tolerance | South Carolina       |
| 3155 | 4A0       |          0.12 | abs(result) \< tolerance | South Carolina       |
| 3241 | 481       |          3.01 | abs(result) \< tolerance | South Carolina       |
| 3339 | 482       |          0.83 | abs(result) \< tolerance | South Carolina       |
| 3439 | 483       |          1.03 | abs(result) \< tolerance | South Carolina       |
| 3538 | 484       |         -0.02 | abs(result) \< tolerance | South Carolina       |
| 3639 | 485       |          1.47 | abs(result) \< tolerance | South Carolina       |
| 3738 | 486       |          3.89 | abs(result) \< tolerance | South Carolina       |
| 3939 | 493       |         -0.14 | abs(result) \< tolerance | South Carolina       |
| 4038 | 511       |          0.61 | abs(result) \< tolerance | South Carolina       |
| 4157 | 512       |          1.48 | abs(result) \< tolerance | South Carolina       |
| 4241 | 513       |          0.19 | abs(result) \< tolerance | South Carolina       |
| 4339 | 514       |          2.08 | abs(result) \< tolerance | South Carolina       |
| 4439 | 521CI     |          0.70 | abs(result) \< tolerance | South Carolina       |
| 4539 | 523       |          1.40 | abs(result) \< tolerance | South Carolina       |
| 4637 | 524       |          0.10 | abs(result) \< tolerance | South Carolina       |
| 4739 | 525       |          2.13 | abs(result) \< tolerance | South Carolina       |
| 4838 | HS        |         -0.07 | abs(result) \< tolerance | South Carolina       |
| 4939 | ORE       |          0.63 | abs(result) \< tolerance | South Carolina       |
| 5039 | 532RL     |          0.12 | abs(result) \< tolerance | South Carolina       |
| 5155 | 5411      |          0.30 | abs(result) \< tolerance | South Carolina       |
| 5237 | 5415      |          0.17 | abs(result) \< tolerance | South Carolina       |
| 5338 | 5412OP    |         -0.06 | abs(result) \< tolerance | South Carolina       |
| 5438 | 55        |          1.02 | abs(result) \< tolerance | South Carolina       |
| 5537 | 561       |         -0.24 | abs(result) \< tolerance | South Carolina       |
| 5637 | 562       |         -0.50 | abs(result) \< tolerance | South Carolina       |
| 5737 | 61        |          0.42 | abs(result) \< tolerance | South Carolina       |
| 5839 | 621       |          0.06 | abs(result) \< tolerance | South Carolina       |
| 5938 | 622       |          0.51 | abs(result) \< tolerance | South Carolina       |
| 6038 | 623       |          0.14 | abs(result) \< tolerance | South Carolina       |
| 6155 | 624       |          0.67 | abs(result) \< tolerance | South Carolina       |
| 6240 | 711AS     |          1.13 | abs(result) \< tolerance | South Carolina       |
| 6338 | 713       |          0.17 | abs(result) \< tolerance | South Carolina       |
| 6438 | 721       |         -0.21 | abs(result) \< tolerance | South Carolina       |
| 6533 | 722       |         -0.02 | abs(result) \< tolerance | South Carolina       |
| 6636 | 81        |          0.06 | abs(result) \< tolerance | South Carolina       |
| 6739 | GFGD      |         -0.22 | abs(result) \< tolerance | South Carolina       |
| 6837 | GFGN      |         -0.42 | abs(result) \< tolerance | South Carolina       |
| 6939 | GFE       |          0.08 | abs(result) \< tolerance | South Carolina       |
| 7037 | GSLG      |         -0.15 | abs(result) \< tolerance | South Carolina       |
| 7143 | GSLE      |         -0.06 | abs(result) \< tolerance | South Carolina       |
| 7240 | Used      |         -4.16 | abs(result) \< tolerance | South Carolina       |
| 7339 | Other     |        -33.02 | abs(result) \< tolerance | South Carolina       |
| 1165 | 111CA     |         -0.74 | abs(result) \< tolerance | South Dakota         |
| 2156 | 113FF     |          0.45 | abs(result) \< tolerance | South Dakota         |
| 3156 | 211       |       5030.78 | abs(result) \< tolerance | South Dakota         |
| 4158 | 212       |          0.15 | abs(result) \< tolerance | South Dakota         |
| 5156 | 213       |          0.10 | abs(result) \< tolerance | South Dakota         |
| 6156 | 22        |         -0.11 | abs(result) \< tolerance | South Dakota         |
| 768  | 23        |          0.04 | abs(result) \< tolerance | South Dakota         |
| 848  | 321       |         -0.44 | abs(result) \< tolerance | South Dakota         |
| 947  | 327       |         -0.36 | abs(result) \< tolerance | South Dakota         |
| 1049 | 331       |          1.59 | abs(result) \< tolerance | South Dakota         |
| 1166 | 332       |          0.10 | abs(result) \< tolerance | South Dakota         |
| 1249 | 333       |         -0.29 | abs(result) \< tolerance | South Dakota         |
| 1348 | 334       |          0.55 | abs(result) \< tolerance | South Dakota         |
| 1448 | 335       |          0.31 | abs(result) \< tolerance | South Dakota         |
| 1543 | 3361MV    |          0.16 | abs(result) \< tolerance | South Dakota         |
| 1641 | 3364OT    |          1.52 | abs(result) \< tolerance | South Dakota         |
| 1738 | 337       |         -0.42 | abs(result) \< tolerance | South Dakota         |
| 1839 | 339       |          0.83 | abs(result) \< tolerance | South Dakota         |
| 1940 | 311FT     |          0.02 | abs(result) \< tolerance | South Dakota         |
| 2040 | 313TT     |          0.08 | abs(result) \< tolerance | South Dakota         |
| 2157 | 315AL     |          5.14 | abs(result) \< tolerance | South Dakota         |
| 2241 | 322       |          0.71 | abs(result) \< tolerance | South Dakota         |
| 2339 | 323       |         -0.17 | abs(result) \< tolerance | South Dakota         |
| 2440 | 324       |         15.78 | abs(result) \< tolerance | South Dakota         |
| 2540 | 325       |          1.14 | abs(result) \< tolerance | South Dakota         |
| 2638 | 326       |          0.08 | abs(result) \< tolerance | South Dakota         |
| 2740 | 42        |         -0.03 | abs(result) \< tolerance | South Dakota         |
| 2840 | 441       |          0.10 | abs(result) \< tolerance | South Dakota         |
| 2940 | 445       |         -0.26 | abs(result) \< tolerance | South Dakota         |
| 3039 | 452       |         -0.41 | abs(result) \< tolerance | South Dakota         |
| 3157 | 4A0       |         -0.35 | abs(result) \< tolerance | South Dakota         |
| 3242 | 481       |          1.78 | abs(result) \< tolerance | South Dakota         |
| 3340 | 482       |         -0.13 | abs(result) \< tolerance | South Dakota         |
| 3440 | 483       |         17.76 | abs(result) \< tolerance | South Dakota         |
| 3539 | 484       |         -0.20 | abs(result) \< tolerance | South Dakota         |
| 3640 | 485       |          0.53 | abs(result) \< tolerance | South Dakota         |
| 3739 | 486       |          0.83 | abs(result) \< tolerance | South Dakota         |
| 3837 | 487OS     |          0.34 | abs(result) \< tolerance | South Dakota         |
| 3940 | 493       |          2.31 | abs(result) \< tolerance | South Dakota         |
| 4039 | 511       |          1.00 | abs(result) \< tolerance | South Dakota         |
| 4159 | 512       |          2.06 | abs(result) \< tolerance | South Dakota         |
| 4242 | 513       |          0.09 | abs(result) \< tolerance | South Dakota         |
| 4340 | 514       |          5.74 | abs(result) \< tolerance | South Dakota         |
| 4440 | 521CI     |         -0.70 | abs(result) \< tolerance | South Dakota         |
| 4540 | 523       |          0.99 | abs(result) \< tolerance | South Dakota         |
| 4638 | 524       |          0.03 | abs(result) \< tolerance | South Dakota         |
| 4740 | 525       |         -0.20 | abs(result) \< tolerance | South Dakota         |
| 4839 | HS        |         -0.13 | abs(result) \< tolerance | South Dakota         |
| 4940 | ORE       |          1.57 | abs(result) \< tolerance | South Dakota         |
| 5040 | 532RL     |         -0.09 | abs(result) \< tolerance | South Dakota         |
| 5157 | 5411      |          1.32 | abs(result) \< tolerance | South Dakota         |
| 5238 | 5415      |          0.50 | abs(result) \< tolerance | South Dakota         |
| 5339 | 5412OP    |          0.32 | abs(result) \< tolerance | South Dakota         |
| 5439 | 55        |          0.30 | abs(result) \< tolerance | South Dakota         |
| 5538 | 561       |          0.84 | abs(result) \< tolerance | South Dakota         |
| 5638 | 562       |          0.42 | abs(result) \< tolerance | South Dakota         |
| 5738 | 61        |          0.38 | abs(result) \< tolerance | South Dakota         |
| 5840 | 621       |         -0.18 | abs(result) \< tolerance | South Dakota         |
| 5939 | 622       |         -0.43 | abs(result) \< tolerance | South Dakota         |
| 6039 | 623       |         -0.33 | abs(result) \< tolerance | South Dakota         |
| 6157 | 624       |          0.08 | abs(result) \< tolerance | South Dakota         |
| 6241 | 711AS     |          1.21 | abs(result) \< tolerance | South Dakota         |
| 6339 | 713       |         -0.12 | abs(result) \< tolerance | South Dakota         |
| 6439 | 721       |         -0.44 | abs(result) \< tolerance | South Dakota         |
| 6534 | 722       |          0.09 | abs(result) \< tolerance | South Dakota         |
| 6637 | 81        |         -0.06 | abs(result) \< tolerance | South Dakota         |
| 6740 | GFGD      |         -0.22 | abs(result) \< tolerance | South Dakota         |
| 6838 | GFGN      |         -0.09 | abs(result) \< tolerance | South Dakota         |
| 6940 | GFE       |          0.32 | abs(result) \< tolerance | South Dakota         |
| 7038 | GSLG      |         -0.15 | abs(result) \< tolerance | South Dakota         |
| 7144 | GSLE      |          0.96 | abs(result) \< tolerance | South Dakota         |
| 7241 | Used      |          1.50 | abs(result) \< tolerance | South Dakota         |
| 7340 | Other     |        -11.08 | abs(result) \< tolerance | South Dakota         |
| 1167 | 111CA     |          2.25 | abs(result) \< tolerance | Tennessee            |
| 2158 | 113FF     |          0.81 | abs(result) \< tolerance | Tennessee            |
| 3158 | 211       |        134.02 | abs(result) \< tolerance | Tennessee            |
| 4160 | 212       |         -0.04 | abs(result) \< tolerance | Tennessee            |
| 5158 | 213       |          0.07 | abs(result) \< tolerance | Tennessee            |
| 6158 | 22        |          1.33 | abs(result) \< tolerance | Tennessee            |
| 769  | 23        |          0.07 | abs(result) \< tolerance | Tennessee            |
| 849  | 321       |         -0.21 | abs(result) \< tolerance | Tennessee            |
| 948  | 327       |         -0.28 | abs(result) \< tolerance | Tennessee            |
| 1050 | 331       |          0.31 | abs(result) \< tolerance | Tennessee            |
| 1168 | 332       |          0.02 | abs(result) \< tolerance | Tennessee            |
| 1250 | 333       |          0.05 | abs(result) \< tolerance | Tennessee            |
| 1349 | 334       |          1.04 | abs(result) \< tolerance | Tennessee            |
| 1449 | 335       |         -0.49 | abs(result) \< tolerance | Tennessee            |
| 1544 | 3361MV    |         -0.31 | abs(result) \< tolerance | Tennessee            |
| 1642 | 3364OT    |          0.75 | abs(result) \< tolerance | Tennessee            |
| 1739 | 337       |         -0.09 | abs(result) \< tolerance | Tennessee            |
| 1840 | 339       |          0.08 | abs(result) \< tolerance | Tennessee            |
| 1941 | 311FT     |         -0.44 | abs(result) \< tolerance | Tennessee            |
| 2041 | 313TT     |         -0.02 | abs(result) \< tolerance | Tennessee            |
| 2242 | 322       |         -0.34 | abs(result) \< tolerance | Tennessee            |
| 2340 | 323       |         -0.22 | abs(result) \< tolerance | Tennessee            |
| 2441 | 324       |          0.75 | abs(result) \< tolerance | Tennessee            |
| 2541 | 325       |          0.17 | abs(result) \< tolerance | Tennessee            |
| 2639 | 326       |         -0.15 | abs(result) \< tolerance | Tennessee            |
| 2741 | 42        |          0.09 | abs(result) \< tolerance | Tennessee            |
| 2841 | 441       |          0.31 | abs(result) \< tolerance | Tennessee            |
| 2941 | 445       |         -0.21 | abs(result) \< tolerance | Tennessee            |
| 3040 | 452       |         -0.38 | abs(result) \< tolerance | Tennessee            |
| 3159 | 4A0       |         -0.18 | abs(result) \< tolerance | Tennessee            |
| 3243 | 481       |          1.24 | abs(result) \< tolerance | Tennessee            |
| 3341 | 482       |          0.15 | abs(result) \< tolerance | Tennessee            |
| 3441 | 483       |         -0.27 | abs(result) \< tolerance | Tennessee            |
| 3540 | 484       |         -0.29 | abs(result) \< tolerance | Tennessee            |
| 3641 | 485       |          0.49 | abs(result) \< tolerance | Tennessee            |
| 3740 | 486       |         -0.30 | abs(result) \< tolerance | Tennessee            |
| 3838 | 487OS     |         -0.43 | abs(result) \< tolerance | Tennessee            |
| 3941 | 493       |         -0.24 | abs(result) \< tolerance | Tennessee            |
| 4040 | 511       |          0.25 | abs(result) \< tolerance | Tennessee            |
| 4161 | 512       |         -0.13 | abs(result) \< tolerance | Tennessee            |
| 4243 | 513       |          0.43 | abs(result) \< tolerance | Tennessee            |
| 4341 | 514       |          1.30 | abs(result) \< tolerance | Tennessee            |
| 4441 | 521CI     |          0.39 | abs(result) \< tolerance | Tennessee            |
| 4541 | 523       |          0.93 | abs(result) \< tolerance | Tennessee            |
| 4639 | 524       |          0.05 | abs(result) \< tolerance | Tennessee            |
| 4741 | 525       |          0.26 | abs(result) \< tolerance | Tennessee            |
| 4840 | HS        |         -0.15 | abs(result) \< tolerance | Tennessee            |
| 4941 | ORE       |          0.94 | abs(result) \< tolerance | Tennessee            |
| 5041 | 532RL     |          0.24 | abs(result) \< tolerance | Tennessee            |
| 5159 | 5411      |          0.58 | abs(result) \< tolerance | Tennessee            |
| 5239 | 5415      |          0.24 | abs(result) \< tolerance | Tennessee            |
| 5340 | 5412OP    |          0.05 | abs(result) \< tolerance | Tennessee            |
| 5440 | 55        |          0.32 | abs(result) \< tolerance | Tennessee            |
| 5539 | 561       |         -0.24 | abs(result) \< tolerance | Tennessee            |
| 5639 | 562       |         -0.14 | abs(result) \< tolerance | Tennessee            |
| 5739 | 61        |          0.17 | abs(result) \< tolerance | Tennessee            |
| 5841 | 621       |         -0.23 | abs(result) \< tolerance | Tennessee            |
| 5940 | 622       |         -0.33 | abs(result) \< tolerance | Tennessee            |
| 6040 | 623       |         -0.02 | abs(result) \< tolerance | Tennessee            |
| 6159 | 624       |          0.48 | abs(result) \< tolerance | Tennessee            |
| 6242 | 711AS     |         -0.53 | abs(result) \< tolerance | Tennessee            |
| 6340 | 713       |          0.08 | abs(result) \< tolerance | Tennessee            |
| 6440 | 721       |         -0.14 | abs(result) \< tolerance | Tennessee            |
| 6535 | 722       |         -0.11 | abs(result) \< tolerance | Tennessee            |
| 6638 | 81        |         -0.07 | abs(result) \< tolerance | Tennessee            |
| 6741 | GFGD      |         -0.39 | abs(result) \< tolerance | Tennessee            |
| 6839 | GFGN      |         -0.41 | abs(result) \< tolerance | Tennessee            |
| 6941 | GFE       |         -0.10 | abs(result) \< tolerance | Tennessee            |
| 7039 | GSLG      |         -0.11 | abs(result) \< tolerance | Tennessee            |
| 7145 | GSLE      |          0.14 | abs(result) \< tolerance | Tennessee            |
| 7242 | Used      |         -6.51 | abs(result) \< tolerance | Tennessee            |
| 7341 | Other     |          7.89 | abs(result) \< tolerance | Tennessee            |
| 1169 | 111CA     |          0.11 | abs(result) \< tolerance | Texas                |
| 2159 | 113FF     |          0.11 | abs(result) \< tolerance | Texas                |
| 3160 | 211       |         -0.51 | abs(result) \< tolerance | Texas                |
| 4162 | 212       |          0.19 | abs(result) \< tolerance | Texas                |
| 5160 | 213       |          0.02 | abs(result) \< tolerance | Texas                |
| 6160 | 22        |         -0.03 | abs(result) \< tolerance | Texas                |
| 770  | 23        |         -0.15 | abs(result) \< tolerance | Texas                |
| 850  | 321       |          0.50 | abs(result) \< tolerance | Texas                |
| 949  | 327       |         -0.06 | abs(result) \< tolerance | Texas                |
| 1051 | 331       |          0.93 | abs(result) \< tolerance | Texas                |
| 1170 | 332       |          0.14 | abs(result) \< tolerance | Texas                |
| 1251 | 333       |          0.25 | abs(result) \< tolerance | Texas                |
| 1350 | 334       |          0.32 | abs(result) \< tolerance | Texas                |
| 1450 | 335       |          0.49 | abs(result) \< tolerance | Texas                |
| 1643 | 3364OT    |          0.03 | abs(result) \< tolerance | Texas                |
| 1740 | 337       |          0.63 | abs(result) \< tolerance | Texas                |
| 1841 | 339       |          0.50 | abs(result) \< tolerance | Texas                |
| 1942 | 311FT     |          0.43 | abs(result) \< tolerance | Texas                |
| 2042 | 313TT     |          1.89 | abs(result) \< tolerance | Texas                |
| 2160 | 315AL     |          1.09 | abs(result) \< tolerance | Texas                |
| 2243 | 322       |          0.74 | abs(result) \< tolerance | Texas                |
| 2341 | 323       |          0.48 | abs(result) \< tolerance | Texas                |
| 2442 | 324       |         -0.37 | abs(result) \< tolerance | Texas                |
| 2542 | 325       |         -0.18 | abs(result) \< tolerance | Texas                |
| 2640 | 326       |          0.46 | abs(result) \< tolerance | Texas                |
| 2742 | 42        |         -0.14 | abs(result) \< tolerance | Texas                |
| 2842 | 441       |          0.49 | abs(result) \< tolerance | Texas                |
| 2942 | 445       |         -0.12 | abs(result) \< tolerance | Texas                |
| 3041 | 452       |         -0.22 | abs(result) \< tolerance | Texas                |
| 3161 | 4A0       |          0.07 | abs(result) \< tolerance | Texas                |
| 3244 | 481       |         -0.25 | abs(result) \< tolerance | Texas                |
| 3342 | 482       |          0.03 | abs(result) \< tolerance | Texas                |
| 3442 | 483       |          0.13 | abs(result) \< tolerance | Texas                |
| 3541 | 484       |         -0.11 | abs(result) \< tolerance | Texas                |
| 3642 | 485       |          1.14 | abs(result) \< tolerance | Texas                |
| 3741 | 486       |          0.01 | abs(result) \< tolerance | Texas                |
| 3839 | 487OS     |          0.01 | abs(result) \< tolerance | Texas                |
| 3942 | 493       |          0.05 | abs(result) \< tolerance | Texas                |
| 4041 | 511       |          0.15 | abs(result) \< tolerance | Texas                |
| 4163 | 512       |          1.31 | abs(result) \< tolerance | Texas                |
| 4244 | 513       |         -0.15 | abs(result) \< tolerance | Texas                |
| 4342 | 514       |          0.75 | abs(result) \< tolerance | Texas                |
| 4442 | 521CI     |          0.35 | abs(result) \< tolerance | Texas                |
| 4542 | 523       |          1.50 | abs(result) \< tolerance | Texas                |
| 4640 | 524       |          0.14 | abs(result) \< tolerance | Texas                |
| 4742 | 525       |         -0.70 | abs(result) \< tolerance | Texas                |
| 4841 | HS        |         -0.08 | abs(result) \< tolerance | Texas                |
| 4942 | ORE       |          1.00 | abs(result) \< tolerance | Texas                |
| 5042 | 532RL     |         -0.04 | abs(result) \< tolerance | Texas                |
| 5161 | 5411      |          0.12 | abs(result) \< tolerance | Texas                |
| 5240 | 5415      |          0.02 | abs(result) \< tolerance | Texas                |
| 5341 | 5412OP    |          0.02 | abs(result) \< tolerance | Texas                |
| 5441 | 55        |          0.66 | abs(result) \< tolerance | Texas                |
| 5540 | 561       |         -0.16 | abs(result) \< tolerance | Texas                |
| 5640 | 562       |         -0.08 | abs(result) \< tolerance | Texas                |
| 5740 | 61        |          0.28 | abs(result) \< tolerance | Texas                |
| 5842 | 621       |         -0.09 | abs(result) \< tolerance | Texas                |
| 5941 | 622       |          0.11 | abs(result) \< tolerance | Texas                |
| 6041 | 623       |          0.46 | abs(result) \< tolerance | Texas                |
| 6161 | 624       |          0.50 | abs(result) \< tolerance | Texas                |
| 6243 | 711AS     |          0.38 | abs(result) \< tolerance | Texas                |
| 6341 | 713       |          0.60 | abs(result) \< tolerance | Texas                |
| 6441 | 721       |          0.39 | abs(result) \< tolerance | Texas                |
| 6536 | 722       |         -0.05 | abs(result) \< tolerance | Texas                |
| 6639 | 81        |         -0.04 | abs(result) \< tolerance | Texas                |
| 6742 | GFGD      |         -0.26 | abs(result) \< tolerance | Texas                |
| 6840 | GFGN      |         -0.27 | abs(result) \< tolerance | Texas                |
| 6942 | GFE       |          0.37 | abs(result) \< tolerance | Texas                |
| 7040 | GSLG      |         -0.18 | abs(result) \< tolerance | Texas                |
| 7146 | GSLE      |          0.19 | abs(result) \< tolerance | Texas                |
| 7243 | Used      |          3.87 | abs(result) \< tolerance | Texas                |
| 7342 | Other     |        -24.58 | abs(result) \< tolerance | Texas                |
| 1171 | 111CA     |          0.19 | abs(result) \< tolerance | Utah                 |
| 2161 | 113FF     |          0.49 | abs(result) \< tolerance | Utah                 |
| 3162 | 211       |          1.27 | abs(result) \< tolerance | Utah                 |
| 4164 | 212       |         -0.58 | abs(result) \< tolerance | Utah                 |
| 5162 | 213       |         -0.03 | abs(result) \< tolerance | Utah                 |
| 6162 | 22        |          0.15 | abs(result) \< tolerance | Utah                 |
| 771  | 23        |         -0.27 | abs(result) \< tolerance | Utah                 |
| 851  | 321       |          1.01 | abs(result) \< tolerance | Utah                 |
| 950  | 327       |         -0.10 | abs(result) \< tolerance | Utah                 |
| 1052 | 331       |         -0.05 | abs(result) \< tolerance | Utah                 |
| 1172 | 332       |          0.01 | abs(result) \< tolerance | Utah                 |
| 1252 | 333       |          0.28 | abs(result) \< tolerance | Utah                 |
| 1351 | 334       |          0.11 | abs(result) \< tolerance | Utah                 |
| 1451 | 335       |          0.49 | abs(result) \< tolerance | Utah                 |
| 1545 | 3361MV    |          0.25 | abs(result) \< tolerance | Utah                 |
| 1644 | 3364OT    |         -0.30 | abs(result) \< tolerance | Utah                 |
| 1741 | 337       |         -0.31 | abs(result) \< tolerance | Utah                 |
| 1842 | 339       |         -0.48 | abs(result) \< tolerance | Utah                 |
| 1943 | 311FT     |          0.15 | abs(result) \< tolerance | Utah                 |
| 2043 | 313TT     |          0.15 | abs(result) \< tolerance | Utah                 |
| 2244 | 322       |         -0.10 | abs(result) \< tolerance | Utah                 |
| 2342 | 323       |         -0.21 | abs(result) \< tolerance | Utah                 |
| 2443 | 324       |         -0.23 | abs(result) \< tolerance | Utah                 |
| 2543 | 325       |          0.19 | abs(result) \< tolerance | Utah                 |
| 2641 | 326       |          0.17 | abs(result) \< tolerance | Utah                 |
| 2743 | 42        |          0.13 | abs(result) \< tolerance | Utah                 |
| 2843 | 441       |          0.33 | abs(result) \< tolerance | Utah                 |
| 2943 | 445       |         -0.15 | abs(result) \< tolerance | Utah                 |
| 3042 | 452       |         -0.18 | abs(result) \< tolerance | Utah                 |
| 3163 | 4A0       |         -0.15 | abs(result) \< tolerance | Utah                 |
| 3245 | 481       |         -0.31 | abs(result) \< tolerance | Utah                 |
| 3343 | 482       |          0.20 | abs(result) \< tolerance | Utah                 |
| 3443 | 483       |         11.71 | abs(result) \< tolerance | Utah                 |
| 3542 | 484       |         -0.20 | abs(result) \< tolerance | Utah                 |
| 3643 | 485       |          0.65 | abs(result) \< tolerance | Utah                 |
| 3742 | 486       |          2.07 | abs(result) \< tolerance | Utah                 |
| 3840 | 487OS     |          0.05 | abs(result) \< tolerance | Utah                 |
| 3943 | 493       |         -0.08 | abs(result) \< tolerance | Utah                 |
| 4042 | 511       |         -0.22 | abs(result) \< tolerance | Utah                 |
| 4165 | 512       |          0.13 | abs(result) \< tolerance | Utah                 |
| 4245 | 513       |          0.22 | abs(result) \< tolerance | Utah                 |
| 4343 | 514       |         -0.02 | abs(result) \< tolerance | Utah                 |
| 4443 | 521CI     |         -0.44 | abs(result) \< tolerance | Utah                 |
| 4543 | 523       |          1.12 | abs(result) \< tolerance | Utah                 |
| 4641 | 524       |          0.25 | abs(result) \< tolerance | Utah                 |
| 4743 | 525       |         -0.49 | abs(result) \< tolerance | Utah                 |
| 4842 | HS        |         -0.21 | abs(result) \< tolerance | Utah                 |
| 4943 | ORE       |          0.82 | abs(result) \< tolerance | Utah                 |
| 5043 | 532RL     |         -0.29 | abs(result) \< tolerance | Utah                 |
| 5163 | 5411      |          0.40 | abs(result) \< tolerance | Utah                 |
| 5241 | 5415      |         -0.10 | abs(result) \< tolerance | Utah                 |
| 5342 | 5412OP    |          0.05 | abs(result) \< tolerance | Utah                 |
| 5442 | 55        |          0.33 | abs(result) \< tolerance | Utah                 |
| 5541 | 561       |         -0.09 | abs(result) \< tolerance | Utah                 |
| 5641 | 562       |          0.12 | abs(result) \< tolerance | Utah                 |
| 5741 | 61        |         -0.34 | abs(result) \< tolerance | Utah                 |
| 5843 | 621       |         -0.10 | abs(result) \< tolerance | Utah                 |
| 5942 | 622       |         -0.12 | abs(result) \< tolerance | Utah                 |
| 6042 | 623       |         -0.10 | abs(result) \< tolerance | Utah                 |
| 6163 | 624       |          0.11 | abs(result) \< tolerance | Utah                 |
| 6244 | 711AS     |          0.22 | abs(result) \< tolerance | Utah                 |
| 6342 | 713       |          0.02 | abs(result) \< tolerance | Utah                 |
| 6442 | 721       |         -0.03 | abs(result) \< tolerance | Utah                 |
| 6537 | 722       |          0.08 | abs(result) \< tolerance | Utah                 |
| 6640 | 81        |         -0.33 | abs(result) \< tolerance | Utah                 |
| 6743 | GFGD      |         -0.51 | abs(result) \< tolerance | Utah                 |
| 6841 | GFGN      |         -0.44 | abs(result) \< tolerance | Utah                 |
| 6943 | GFE       |         -0.26 | abs(result) \< tolerance | Utah                 |
| 7041 | GSLG      |         -0.12 | abs(result) \< tolerance | Utah                 |
| 7147 | GSLE      |          0.10 | abs(result) \< tolerance | Utah                 |
| 7244 | Used      |          3.69 | abs(result) \< tolerance | Utah                 |
| 7343 | Other     |          8.20 | abs(result) \< tolerance | Utah                 |
| 1173 | 111CA     |         -0.19 | abs(result) \< tolerance | Vermont              |
| 2162 | 113FF     |          0.21 | abs(result) \< tolerance | Vermont              |
| 3164 | 211       |        113.22 | abs(result) \< tolerance | Vermont              |
| 4166 | 212       |         -0.53 | abs(result) \< tolerance | Vermont              |
| 5164 | 213       |          0.14 | abs(result) \< tolerance | Vermont              |
| 772  | 23        |          0.22 | abs(result) \< tolerance | Vermont              |
| 852  | 321       |         -0.46 | abs(result) \< tolerance | Vermont              |
| 951  | 327       |         -0.28 | abs(result) \< tolerance | Vermont              |
| 1053 | 331       |          1.69 | abs(result) \< tolerance | Vermont              |
| 1174 | 332       |          0.38 | abs(result) \< tolerance | Vermont              |
| 1253 | 333       |         -0.22 | abs(result) \< tolerance | Vermont              |
| 1352 | 334       |         -0.16 | abs(result) \< tolerance | Vermont              |
| 1452 | 335       |         -0.21 | abs(result) \< tolerance | Vermont              |
| 1546 | 3361MV    |          2.06 | abs(result) \< tolerance | Vermont              |
| 1645 | 3364OT    |         -0.13 | abs(result) \< tolerance | Vermont              |
| 1742 | 337       |         -0.23 | abs(result) \< tolerance | Vermont              |
| 1843 | 339       |          0.09 | abs(result) \< tolerance | Vermont              |
| 2044 | 313TT     |          0.18 | abs(result) \< tolerance | Vermont              |
| 2163 | 315AL     |         -0.43 | abs(result) \< tolerance | Vermont              |
| 2245 | 322       |          0.41 | abs(result) \< tolerance | Vermont              |
| 2343 | 323       |         -0.03 | abs(result) \< tolerance | Vermont              |
| 2444 | 324       |          5.29 | abs(result) \< tolerance | Vermont              |
| 2544 | 325       |          1.70 | abs(result) \< tolerance | Vermont              |
| 2642 | 326       |          0.17 | abs(result) \< tolerance | Vermont              |
| 2744 | 42        |          0.21 | abs(result) \< tolerance | Vermont              |
| 2844 | 441       |          0.42 | abs(result) \< tolerance | Vermont              |
| 2944 | 445       |         -0.28 | abs(result) \< tolerance | Vermont              |
| 3043 | 452       |          0.16 | abs(result) \< tolerance | Vermont              |
| 3165 | 4A0       |         -0.34 | abs(result) \< tolerance | Vermont              |
| 3246 | 481       |          5.47 | abs(result) \< tolerance | Vermont              |
| 3344 | 482       |          2.29 | abs(result) \< tolerance | Vermont              |
| 3444 | 483       |          0.60 | abs(result) \< tolerance | Vermont              |
| 3543 | 484       |          0.14 | abs(result) \< tolerance | Vermont              |
| 3644 | 485       |          0.18 | abs(result) \< tolerance | Vermont              |
| 3743 | 486       |          6.26 | abs(result) \< tolerance | Vermont              |
| 3841 | 487OS     |          0.19 | abs(result) \< tolerance | Vermont              |
| 3944 | 493       |          0.75 | abs(result) \< tolerance | Vermont              |
| 4043 | 511       |          0.06 | abs(result) \< tolerance | Vermont              |
| 4167 | 512       |          2.37 | abs(result) \< tolerance | Vermont              |
| 4246 | 513       |          1.06 | abs(result) \< tolerance | Vermont              |
| 4344 | 514       |          1.46 | abs(result) \< tolerance | Vermont              |
| 4444 | 521CI     |          0.90 | abs(result) \< tolerance | Vermont              |
| 4544 | 523       |          0.79 | abs(result) \< tolerance | Vermont              |
| 4642 | 524       |          0.03 | abs(result) \< tolerance | Vermont              |
| 4744 | 525       |          2.22 | abs(result) \< tolerance | Vermont              |
| 4843 | HS        |         -0.13 | abs(result) \< tolerance | Vermont              |
| 4944 | ORE       |          0.65 | abs(result) \< tolerance | Vermont              |
| 5044 | 532RL     |          0.67 | abs(result) \< tolerance | Vermont              |
| 5165 | 5411      |          0.38 | abs(result) \< tolerance | Vermont              |
| 5242 | 5415      |         -0.12 | abs(result) \< tolerance | Vermont              |
| 5343 | 5412OP    |          0.04 | abs(result) \< tolerance | Vermont              |
| 5443 | 55        |          1.39 | abs(result) \< tolerance | Vermont              |
| 5542 | 561       |          0.11 | abs(result) \< tolerance | Vermont              |
| 5642 | 562       |         -0.01 | abs(result) \< tolerance | Vermont              |
| 5742 | 61        |         -0.40 | abs(result) \< tolerance | Vermont              |
| 5844 | 621       |         -0.07 | abs(result) \< tolerance | Vermont              |
| 5943 | 622       |         -0.21 | abs(result) \< tolerance | Vermont              |
| 6043 | 623       |         -0.15 | abs(result) \< tolerance | Vermont              |
| 6164 | 624       |         -0.37 | abs(result) \< tolerance | Vermont              |
| 6245 | 711AS     |         -0.02 | abs(result) \< tolerance | Vermont              |
| 6343 | 713       |         -0.17 | abs(result) \< tolerance | Vermont              |
| 6443 | 721       |         -0.64 | abs(result) \< tolerance | Vermont              |
| 6538 | 722       |          0.01 | abs(result) \< tolerance | Vermont              |
| 6641 | 81        |          0.11 | abs(result) \< tolerance | Vermont              |
| 6744 | GFGD      |         -0.33 | abs(result) \< tolerance | Vermont              |
| 6842 | GFGN      |         -0.21 | abs(result) \< tolerance | Vermont              |
| 6944 | GFE       |         -0.29 | abs(result) \< tolerance | Vermont              |
| 7042 | GSLG      |          0.13 | abs(result) \< tolerance | Vermont              |
| 7148 | GSLE      |          1.65 | abs(result) \< tolerance | Vermont              |
| 7245 | Used      |         -2.85 | abs(result) \< tolerance | Vermont              |
| 7344 | Other     |          2.72 | abs(result) \< tolerance | Vermont              |
| 1175 | 111CA     |          3.47 | abs(result) \< tolerance | Virginia             |
| 2164 | 113FF     |          0.15 | abs(result) \< tolerance | Virginia             |
| 3166 | 211       |         97.17 | abs(result) \< tolerance | Virginia             |
| 5166 | 213       |          0.05 | abs(result) \< tolerance | Virginia             |
| 6165 | 22        |          0.03 | abs(result) \< tolerance | Virginia             |
| 853  | 321       |         -0.24 | abs(result) \< tolerance | Virginia             |
| 952  | 327       |          0.12 | abs(result) \< tolerance | Virginia             |
| 1054 | 331       |          0.50 | abs(result) \< tolerance | Virginia             |
| 1176 | 332       |          0.40 | abs(result) \< tolerance | Virginia             |
| 1254 | 333       |          0.16 | abs(result) \< tolerance | Virginia             |
| 1353 | 334       |          0.95 | abs(result) \< tolerance | Virginia             |
| 1453 | 335       |          0.18 | abs(result) \< tolerance | Virginia             |
| 1547 | 3361MV    |          0.55 | abs(result) \< tolerance | Virginia             |
| 1646 | 3364OT    |          0.11 | abs(result) \< tolerance | Virginia             |
| 1743 | 337       |          0.10 | abs(result) \< tolerance | Virginia             |
| 1844 | 339       |          0.56 | abs(result) \< tolerance | Virginia             |
| 1944 | 311FT     |         -0.49 | abs(result) \< tolerance | Virginia             |
| 2045 | 313TT     |         -0.10 | abs(result) \< tolerance | Virginia             |
| 2165 | 315AL     |          0.58 | abs(result) \< tolerance | Virginia             |
| 2246 | 322       |          0.56 | abs(result) \< tolerance | Virginia             |
| 2344 | 323       |          0.26 | abs(result) \< tolerance | Virginia             |
| 2445 | 324       |         11.86 | abs(result) \< tolerance | Virginia             |
| 2545 | 325       |          0.90 | abs(result) \< tolerance | Virginia             |
| 2643 | 326       |         -0.09 | abs(result) \< tolerance | Virginia             |
| 2745 | 42        |          0.37 | abs(result) \< tolerance | Virginia             |
| 2845 | 441       |          0.49 | abs(result) \< tolerance | Virginia             |
| 2945 | 445       |         -0.09 | abs(result) \< tolerance | Virginia             |
| 3044 | 452       |         -0.12 | abs(result) \< tolerance | Virginia             |
| 3167 | 4A0       |          0.22 | abs(result) \< tolerance | Virginia             |
| 3247 | 481       |         -0.05 | abs(result) \< tolerance | Virginia             |
| 3345 | 482       |          0.05 | abs(result) \< tolerance | Virginia             |
| 3445 | 483       |         -0.07 | abs(result) \< tolerance | Virginia             |
| 3544 | 484       |          0.31 | abs(result) \< tolerance | Virginia             |
| 3645 | 485       |          0.07 | abs(result) \< tolerance | Virginia             |
| 3744 | 486       |          1.64 | abs(result) \< tolerance | Virginia             |
| 3842 | 487OS     |          0.04 | abs(result) \< tolerance | Virginia             |
| 3945 | 493       |         -0.09 | abs(result) \< tolerance | Virginia             |
| 4044 | 511       |          0.23 | abs(result) \< tolerance | Virginia             |
| 4168 | 512       |          1.22 | abs(result) \< tolerance | Virginia             |
| 4247 | 513       |          0.36 | abs(result) \< tolerance | Virginia             |
| 4345 | 514       |          0.18 | abs(result) \< tolerance | Virginia             |
| 4445 | 521CI     |          0.06 | abs(result) \< tolerance | Virginia             |
| 4545 | 523       |          0.55 | abs(result) \< tolerance | Virginia             |
| 4643 | 524       |          0.69 | abs(result) \< tolerance | Virginia             |
| 4745 | 525       |          0.67 | abs(result) \< tolerance | Virginia             |
| 4844 | HS        |         -0.23 | abs(result) \< tolerance | Virginia             |
| 4945 | ORE       |          0.50 | abs(result) \< tolerance | Virginia             |
| 5045 | 532RL     |          0.33 | abs(result) \< tolerance | Virginia             |
| 5167 | 5411      |          0.24 | abs(result) \< tolerance | Virginia             |
| 5243 | 5415      |         -0.21 | abs(result) \< tolerance | Virginia             |
| 5344 | 5412OP    |         -0.05 | abs(result) \< tolerance | Virginia             |
| 5444 | 55        |         -0.29 | abs(result) \< tolerance | Virginia             |
| 5543 | 561       |         -0.19 | abs(result) \< tolerance | Virginia             |
| 5643 | 562       |          0.25 | abs(result) \< tolerance | Virginia             |
| 5743 | 61        |          0.36 | abs(result) \< tolerance | Virginia             |
| 5845 | 621       |          0.21 | abs(result) \< tolerance | Virginia             |
| 5944 | 622       |          0.48 | abs(result) \< tolerance | Virginia             |
| 6044 | 623       |          0.33 | abs(result) \< tolerance | Virginia             |
| 6166 | 624       |          0.38 | abs(result) \< tolerance | Virginia             |
| 6246 | 711AS     |          0.68 | abs(result) \< tolerance | Virginia             |
| 6344 | 713       |          0.90 | abs(result) \< tolerance | Virginia             |
| 6444 | 721       |          0.37 | abs(result) \< tolerance | Virginia             |
| 6539 | 722       |          0.08 | abs(result) \< tolerance | Virginia             |
| 6745 | GFGD      |          1.19 | abs(result) \< tolerance | Virginia             |
| 6843 | GFGN      |         -0.32 | abs(result) \< tolerance | Virginia             |
| 6945 | GFE       |         -0.67 | abs(result) \< tolerance | Virginia             |
| 7043 | GSLG      |         -0.10 | abs(result) \< tolerance | Virginia             |
| 7149 | GSLE      |          0.19 | abs(result) \< tolerance | Virginia             |
| 7246 | Used      |          4.91 | abs(result) \< tolerance | Virginia             |
| 7345 | Other     |         36.96 | abs(result) \< tolerance | Virginia             |
| 1177 | 111CA     |          0.24 | abs(result) \< tolerance | Washington           |
| 2166 | 113FF     |          0.07 | abs(result) \< tolerance | Washington           |
| 3168 | 211       |        364.80 | abs(result) \< tolerance | Washington           |
| 4169 | 212       |          0.82 | abs(result) \< tolerance | Washington           |
| 5168 | 213       |          0.03 | abs(result) \< tolerance | Washington           |
| 6167 | 22        |          0.49 | abs(result) \< tolerance | Washington           |
| 773  | 23        |         -0.01 | abs(result) \< tolerance | Washington           |
| 854  | 321       |         -0.27 | abs(result) \< tolerance | Washington           |
| 953  | 327       |          0.05 | abs(result) \< tolerance | Washington           |
| 1055 | 331       |          0.78 | abs(result) \< tolerance | Washington           |
| 1178 | 332       |          0.83 | abs(result) \< tolerance | Washington           |
| 1255 | 333       |          0.33 | abs(result) \< tolerance | Washington           |
| 1354 | 334       |          0.65 | abs(result) \< tolerance | Washington           |
| 1454 | 335       |          0.46 | abs(result) \< tolerance | Washington           |
| 1548 | 3361MV    |          1.84 | abs(result) \< tolerance | Washington           |
| 1744 | 337       |          0.76 | abs(result) \< tolerance | Washington           |
| 1845 | 339       |          0.11 | abs(result) \< tolerance | Washington           |
| 1945 | 311FT     |          0.46 | abs(result) \< tolerance | Washington           |
| 2046 | 313TT     |          0.93 | abs(result) \< tolerance | Washington           |
| 2167 | 315AL     |          0.50 | abs(result) \< tolerance | Washington           |
| 2247 | 322       |          0.36 | abs(result) \< tolerance | Washington           |
| 2345 | 323       |          0.97 | abs(result) \< tolerance | Washington           |
| 2446 | 324       |         -0.16 | abs(result) \< tolerance | Washington           |
| 2546 | 325       |          1.01 | abs(result) \< tolerance | Washington           |
| 2644 | 326       |          1.20 | abs(result) \< tolerance | Washington           |
| 2746 | 42        |         -0.05 | abs(result) \< tolerance | Washington           |
| 2846 | 441       |         -0.04 | abs(result) \< tolerance | Washington           |
| 2946 | 445       |         -0.44 | abs(result) \< tolerance | Washington           |
| 3045 | 452       |         -0.54 | abs(result) \< tolerance | Washington           |
| 3169 | 4A0       |         -0.45 | abs(result) \< tolerance | Washington           |
| 3248 | 481       |         -0.09 | abs(result) \< tolerance | Washington           |
| 3346 | 482       |         -0.08 | abs(result) \< tolerance | Washington           |
| 3446 | 483       |         -0.29 | abs(result) \< tolerance | Washington           |
| 3545 | 484       |          0.29 | abs(result) \< tolerance | Washington           |
| 3646 | 485       |          0.46 | abs(result) \< tolerance | Washington           |
| 3745 | 486       |          4.29 | abs(result) \< tolerance | Washington           |
| 3843 | 487OS     |         -0.10 | abs(result) \< tolerance | Washington           |
| 3946 | 493       |          0.98 | abs(result) \< tolerance | Washington           |
| 4045 | 511       |         -0.21 | abs(result) \< tolerance | Washington           |
| 4170 | 512       |          1.52 | abs(result) \< tolerance | Washington           |
| 4248 | 513       |          0.05 | abs(result) \< tolerance | Washington           |
| 4346 | 514       |         -0.58 | abs(result) \< tolerance | Washington           |
| 4446 | 521CI     |          0.52 | abs(result) \< tolerance | Washington           |
| 4546 | 523       |          0.75 | abs(result) \< tolerance | Washington           |
| 4644 | 524       |          0.42 | abs(result) \< tolerance | Washington           |
| 4746 | 525       |          1.36 | abs(result) \< tolerance | Washington           |
| 4845 | HS        |         -0.23 | abs(result) \< tolerance | Washington           |
| 4946 | ORE       |          0.71 | abs(result) \< tolerance | Washington           |
| 5046 | 532RL     |          0.36 | abs(result) \< tolerance | Washington           |
| 5169 | 5411      |          0.12 | abs(result) \< tolerance | Washington           |
| 5244 | 5415      |         -0.16 | abs(result) \< tolerance | Washington           |
| 5345 | 5412OP    |         -0.23 | abs(result) \< tolerance | Washington           |
| 5445 | 55        |          0.46 | abs(result) \< tolerance | Washington           |
| 5544 | 561       |          0.25 | abs(result) \< tolerance | Washington           |
| 5644 | 562       |         -0.44 | abs(result) \< tolerance | Washington           |
| 5945 | 622       |          0.10 | abs(result) \< tolerance | Washington           |
| 6045 | 623       |          0.25 | abs(result) \< tolerance | Washington           |
| 6168 | 624       |         -0.17 | abs(result) \< tolerance | Washington           |
| 6247 | 711AS     |          0.43 | abs(result) \< tolerance | Washington           |
| 6345 | 713       |          0.24 | abs(result) \< tolerance | Washington           |
| 6445 | 721       |         -0.05 | abs(result) \< tolerance | Washington           |
| 6540 | 722       |         -0.13 | abs(result) \< tolerance | Washington           |
| 6642 | 81        |         -0.03 | abs(result) \< tolerance | Washington           |
| 6746 | GFGD      |         -0.28 | abs(result) \< tolerance | Washington           |
| 6844 | GFGN      |         -0.31 | abs(result) \< tolerance | Washington           |
| 6946 | GFE       |         -0.05 | abs(result) \< tolerance | Washington           |
| 7044 | GSLG      |         -0.21 | abs(result) \< tolerance | Washington           |
| 7150 | GSLE      |          0.49 | abs(result) \< tolerance | Washington           |
| 7247 | Used      |         -3.97 | abs(result) \< tolerance | Washington           |
| 7346 | Other     |         10.48 | abs(result) \< tolerance | Washington           |
| 1179 | 111CA     |          0.13 | abs(result) \< tolerance | West Virginia        |
| 2168 | 113FF     |          0.30 | abs(result) \< tolerance | West Virginia        |
| 3170 | 211       |         -0.37 | abs(result) \< tolerance | West Virginia        |
| 4171 | 212       |         -0.55 | abs(result) \< tolerance | West Virginia        |
| 6169 | 22        |         -0.30 | abs(result) \< tolerance | West Virginia        |
| 774  | 23        |         -0.05 | abs(result) \< tolerance | West Virginia        |
| 855  | 321       |         -0.45 | abs(result) \< tolerance | West Virginia        |
| 954  | 327       |         -0.28 | abs(result) \< tolerance | West Virginia        |
| 1056 | 331       |         -0.59 | abs(result) \< tolerance | West Virginia        |
| 1180 | 332       |          0.14 | abs(result) \< tolerance | West Virginia        |
| 1256 | 333       |          1.38 | abs(result) \< tolerance | West Virginia        |
| 1355 | 334       |          1.42 | abs(result) \< tolerance | West Virginia        |
| 1455 | 335       |          1.61 | abs(result) \< tolerance | West Virginia        |
| 1549 | 3361MV    |          0.12 | abs(result) \< tolerance | West Virginia        |
| 1647 | 3364OT    |          0.30 | abs(result) \< tolerance | West Virginia        |
| 1745 | 337       |          0.63 | abs(result) \< tolerance | West Virginia        |
| 1846 | 339       |          1.34 | abs(result) \< tolerance | West Virginia        |
| 1946 | 311FT     |          1.66 | abs(result) \< tolerance | West Virginia        |
| 2047 | 313TT     |          2.85 | abs(result) \< tolerance | West Virginia        |
| 2169 | 315AL     |          1.95 | abs(result) \< tolerance | West Virginia        |
| 2248 | 322       |          2.09 | abs(result) \< tolerance | West Virginia        |
| 2346 | 323       |          0.75 | abs(result) \< tolerance | West Virginia        |
| 2447 | 324       |          0.11 | abs(result) \< tolerance | West Virginia        |
| 2547 | 325       |          4.48 | abs(result) \< tolerance | West Virginia        |
| 2645 | 326       |         -0.20 | abs(result) \< tolerance | West Virginia        |
| 2747 | 42        |          0.16 | abs(result) \< tolerance | West Virginia        |
| 2847 | 441       |          0.40 | abs(result) \< tolerance | West Virginia        |
| 2947 | 445       |          0.23 | abs(result) \< tolerance | West Virginia        |
| 3046 | 452       |         -0.52 | abs(result) \< tolerance | West Virginia        |
| 3171 | 4A0       |         -0.24 | abs(result) \< tolerance | West Virginia        |
| 3249 | 481       |         15.38 | abs(result) \< tolerance | West Virginia        |
| 3347 | 482       |         -0.36 | abs(result) \< tolerance | West Virginia        |
| 3546 | 484       |         -0.17 | abs(result) \< tolerance | West Virginia        |
| 3647 | 485       |          2.18 | abs(result) \< tolerance | West Virginia        |
| 3746 | 486       |         -0.30 | abs(result) \< tolerance | West Virginia        |
| 3844 | 487OS     |          0.23 | abs(result) \< tolerance | West Virginia        |
| 3947 | 493       |          0.39 | abs(result) \< tolerance | West Virginia        |
| 4046 | 511       |          0.72 | abs(result) \< tolerance | West Virginia        |
| 4172 | 512       |          3.63 | abs(result) \< tolerance | West Virginia        |
| 4249 | 513       |          0.64 | abs(result) \< tolerance | West Virginia        |
| 4347 | 514       |          2.85 | abs(result) \< tolerance | West Virginia        |
| 4447 | 521CI     |          1.15 | abs(result) \< tolerance | West Virginia        |
| 4547 | 523       |          3.48 | abs(result) \< tolerance | West Virginia        |
| 4645 | 524       |          0.56 | abs(result) \< tolerance | West Virginia        |
| 4747 | 525       |          2.30 | abs(result) \< tolerance | West Virginia        |
| 4846 | HS        |          0.06 | abs(result) \< tolerance | West Virginia        |
| 4947 | ORE       |          0.89 | abs(result) \< tolerance | West Virginia        |
| 5047 | 532RL     |          0.42 | abs(result) \< tolerance | West Virginia        |
| 5170 | 5411      |         -0.24 | abs(result) \< tolerance | West Virginia        |
| 5245 | 5415      |          0.97 | abs(result) \< tolerance | West Virginia        |
| 5346 | 5412OP    |         -0.17 | abs(result) \< tolerance | West Virginia        |
| 5446 | 55        |          1.21 | abs(result) \< tolerance | West Virginia        |
| 5545 | 561       |          0.09 | abs(result) \< tolerance | West Virginia        |
| 5645 | 562       |          0.06 | abs(result) \< tolerance | West Virginia        |
| 5744 | 61        |          0.55 | abs(result) \< tolerance | West Virginia        |
| 5846 | 621       |         -0.17 | abs(result) \< tolerance | West Virginia        |
| 5946 | 622       |         -0.38 | abs(result) \< tolerance | West Virginia        |
| 6046 | 623       |         -0.21 | abs(result) \< tolerance | West Virginia        |
| 6248 | 711AS     |          1.34 | abs(result) \< tolerance | West Virginia        |
| 6346 | 713       |         -0.13 | abs(result) \< tolerance | West Virginia        |
| 6446 | 721       |         -0.10 | abs(result) \< tolerance | West Virginia        |
| 6541 | 722       |          0.04 | abs(result) \< tolerance | West Virginia        |
| 6643 | 81        |          0.10 | abs(result) \< tolerance | West Virginia        |
| 6747 | GFGD      |         -0.33 | abs(result) \< tolerance | West Virginia        |
| 6845 | GFGN      |         -0.27 | abs(result) \< tolerance | West Virginia        |
| 6947 | GFE       |         -0.55 | abs(result) \< tolerance | West Virginia        |
| 7045 | GSLG      |          0.05 | abs(result) \< tolerance | West Virginia        |
| 7151 | GSLE      |          1.04 | abs(result) \< tolerance | West Virginia        |
| 7248 | Used      |          1.17 | abs(result) \< tolerance | West Virginia        |
| 7347 | Other     |         19.70 | abs(result) \< tolerance | West Virginia        |
| 1181 | 111CA     |         -0.13 | abs(result) \< tolerance | Wisconsin            |
| 2170 | 113FF     |          1.11 | abs(result) \< tolerance | Wisconsin            |
| 3172 | 211       |        171.86 | abs(result) \< tolerance | Wisconsin            |
| 4173 | 212       |          0.35 | abs(result) \< tolerance | Wisconsin            |
| 5171 | 213       |          0.16 | abs(result) \< tolerance | Wisconsin            |
| 6170 | 22        |          0.03 | abs(result) \< tolerance | Wisconsin            |
| 775  | 23        |          0.04 | abs(result) \< tolerance | Wisconsin            |
| 856  | 321       |         -0.37 | abs(result) \< tolerance | Wisconsin            |
| 955  | 327       |         -0.34 | abs(result) \< tolerance | Wisconsin            |
| 1057 | 331       |         -0.06 | abs(result) \< tolerance | Wisconsin            |
| 1182 | 332       |         -0.46 | abs(result) \< tolerance | Wisconsin            |
| 1257 | 333       |         -0.27 | abs(result) \< tolerance | Wisconsin            |
| 1356 | 334       |          0.16 | abs(result) \< tolerance | Wisconsin            |
| 1456 | 335       |         -0.47 | abs(result) \< tolerance | Wisconsin            |
| 1550 | 3361MV    |          0.15 | abs(result) \< tolerance | Wisconsin            |
| 1648 | 3364OT    |         -0.09 | abs(result) \< tolerance | Wisconsin            |
| 1746 | 337       |         -0.39 | abs(result) \< tolerance | Wisconsin            |
| 1847 | 339       |         -0.19 | abs(result) \< tolerance | Wisconsin            |
| 1947 | 311FT     |         -0.35 | abs(result) \< tolerance | Wisconsin            |
| 2048 | 313TT     |          0.14 | abs(result) \< tolerance | Wisconsin            |
| 2171 | 315AL     |          0.04 | abs(result) \< tolerance | Wisconsin            |
| 2249 | 322       |         -0.55 | abs(result) \< tolerance | Wisconsin            |
| 2347 | 323       |         -0.69 | abs(result) \< tolerance | Wisconsin            |
| 2448 | 324       |          2.12 | abs(result) \< tolerance | Wisconsin            |
| 2548 | 325       |          0.50 | abs(result) \< tolerance | Wisconsin            |
| 2646 | 326       |         -0.42 | abs(result) \< tolerance | Wisconsin            |
| 2748 | 42        |          0.11 | abs(result) \< tolerance | Wisconsin            |
| 2848 | 441       |          0.65 | abs(result) \< tolerance | Wisconsin            |
| 2948 | 445       |         -0.07 | abs(result) \< tolerance | Wisconsin            |
| 3047 | 452       |         -0.29 | abs(result) \< tolerance | Wisconsin            |
| 3173 | 4A0       |         -0.11 | abs(result) \< tolerance | Wisconsin            |
| 3250 | 481       |          2.26 | abs(result) \< tolerance | Wisconsin            |
| 3348 | 482       |          0.14 | abs(result) \< tolerance | Wisconsin            |
| 3447 | 483       |          4.87 | abs(result) \< tolerance | Wisconsin            |
| 3547 | 484       |         -0.25 | abs(result) \< tolerance | Wisconsin            |
| 3648 | 485       |         -0.41 | abs(result) \< tolerance | Wisconsin            |
| 3747 | 486       |          1.50 | abs(result) \< tolerance | Wisconsin            |
| 3845 | 487OS     |          0.48 | abs(result) \< tolerance | Wisconsin            |
| 3948 | 493       |          0.12 | abs(result) \< tolerance | Wisconsin            |
| 4047 | 511       |         -0.19 | abs(result) \< tolerance | Wisconsin            |
| 4174 | 512       |          1.57 | abs(result) \< tolerance | Wisconsin            |
| 4250 | 513       |          0.40 | abs(result) \< tolerance | Wisconsin            |
| 4348 | 514       |          0.78 | abs(result) \< tolerance | Wisconsin            |
| 4448 | 521CI     |          0.58 | abs(result) \< tolerance | Wisconsin            |
| 4548 | 523       |          0.38 | abs(result) \< tolerance | Wisconsin            |
| 4646 | 524       |         -0.35 | abs(result) \< tolerance | Wisconsin            |
| 4748 | 525       |          2.26 | abs(result) \< tolerance | Wisconsin            |
| 4847 | HS        |         -0.20 | abs(result) \< tolerance | Wisconsin            |
| 4948 | ORE       |          0.79 | abs(result) \< tolerance | Wisconsin            |
| 5048 | 532RL     |          0.63 | abs(result) \< tolerance | Wisconsin            |
| 5172 | 5411      |          0.56 | abs(result) \< tolerance | Wisconsin            |
| 5246 | 5415      |          0.13 | abs(result) \< tolerance | Wisconsin            |
| 5347 | 5412OP    |          0.21 | abs(result) \< tolerance | Wisconsin            |
| 5447 | 55        |         -0.28 | abs(result) \< tolerance | Wisconsin            |
| 5546 | 561       |          0.13 | abs(result) \< tolerance | Wisconsin            |
| 5646 | 562       |         -0.07 | abs(result) \< tolerance | Wisconsin            |
| 5745 | 61        |         -0.04 | abs(result) \< tolerance | Wisconsin            |
| 5847 | 621       |         -0.22 | abs(result) \< tolerance | Wisconsin            |
| 5947 | 622       |         -0.24 | abs(result) \< tolerance | Wisconsin            |
| 6047 | 623       |         -0.33 | abs(result) \< tolerance | Wisconsin            |
| 6171 | 624       |         -0.31 | abs(result) \< tolerance | Wisconsin            |
| 6249 | 711AS     |          0.20 | abs(result) \< tolerance | Wisconsin            |
| 6347 | 713       |          0.15 | abs(result) \< tolerance | Wisconsin            |
| 6447 | 721       |          0.47 | abs(result) \< tolerance | Wisconsin            |
| 6542 | 722       |          0.07 | abs(result) \< tolerance | Wisconsin            |
| 6644 | 81        |         -0.05 | abs(result) \< tolerance | Wisconsin            |
| 6748 | GFGD      |         -0.32 | abs(result) \< tolerance | Wisconsin            |
| 6846 | GFGN      |         -0.49 | abs(result) \< tolerance | Wisconsin            |
| 6948 | GFE       |          0.75 | abs(result) \< tolerance | Wisconsin            |
| 7046 | GSLG      |         -0.08 | abs(result) \< tolerance | Wisconsin            |
| 7152 | GSLE      |          0.93 | abs(result) \< tolerance | Wisconsin            |
| 7249 | Used      |         -5.52 | abs(result) \< tolerance | Wisconsin            |
| 7348 | Other     |        -59.43 | abs(result) \< tolerance | Wisconsin            |
| 1183 | 111CA     |         -0.70 | abs(result) \< tolerance | Wyoming              |
| 2172 | 113FF     |         -0.07 | abs(result) \< tolerance | Wyoming              |
| 3174 | 211       |         -0.49 | abs(result) \< tolerance | Wyoming              |
| 4175 | 212       |         -0.84 | abs(result) \< tolerance | Wyoming              |
| 5173 | 213       |         -0.04 | abs(result) \< tolerance | Wyoming              |
| 6172 | 22        |         -0.34 | abs(result) \< tolerance | Wyoming              |
| 857  | 321       |          0.95 | abs(result) \< tolerance | Wyoming              |
| 956  | 327       |         -0.13 | abs(result) \< tolerance | Wyoming              |
| 1058 | 331       |          4.65 | abs(result) \< tolerance | Wyoming              |
| 1184 | 332       |          0.69 | abs(result) \< tolerance | Wyoming              |
| 1258 | 333       |          2.08 | abs(result) \< tolerance | Wyoming              |
| 1357 | 334       |          2.84 | abs(result) \< tolerance | Wyoming              |
| 1457 | 335       |          0.50 | abs(result) \< tolerance | Wyoming              |
| 1551 | 3361MV    |          7.28 | abs(result) \< tolerance | Wyoming              |
| 1649 | 3364OT    |          5.60 | abs(result) \< tolerance | Wyoming              |
| 1747 | 337       |          3.28 | abs(result) \< tolerance | Wyoming              |
| 1848 | 339       |          1.29 | abs(result) \< tolerance | Wyoming              |
| 1948 | 311FT     |          3.77 | abs(result) \< tolerance | Wyoming              |
| 2049 | 313TT     |          0.51 | abs(result) \< tolerance | Wyoming              |
| 2173 | 315AL     |          2.22 | abs(result) \< tolerance | Wyoming              |
| 2250 | 322       |         12.76 | abs(result) \< tolerance | Wyoming              |
| 2348 | 323       |          2.18 | abs(result) \< tolerance | Wyoming              |
| 2449 | 324       |         -0.60 | abs(result) \< tolerance | Wyoming              |
| 2549 | 325       |          0.11 | abs(result) \< tolerance | Wyoming              |
| 2647 | 326       |          1.45 | abs(result) \< tolerance | Wyoming              |
| 2749 | 42        |          0.40 | abs(result) \< tolerance | Wyoming              |
| 2849 | 441       |          0.61 | abs(result) \< tolerance | Wyoming              |
| 2949 | 445       |          0.12 | abs(result) \< tolerance | Wyoming              |
| 3048 | 452       |         -0.36 | abs(result) \< tolerance | Wyoming              |
| 3175 | 4A0       |         -0.21 | abs(result) \< tolerance | Wyoming              |
| 3251 | 481       |          1.14 | abs(result) \< tolerance | Wyoming              |
| 3349 | 482       |         -0.72 | abs(result) \< tolerance | Wyoming              |
| 3448 | 483       |          1.88 | abs(result) \< tolerance | Wyoming              |
| 3548 | 484       |         -0.14 | abs(result) \< tolerance | Wyoming              |
| 3649 | 485       |          1.04 | abs(result) \< tolerance | Wyoming              |
| 3748 | 486       |         -0.76 | abs(result) \< tolerance | Wyoming              |
| 3846 | 487OS     |          0.26 | abs(result) \< tolerance | Wyoming              |
| 3949 | 493       |          0.17 | abs(result) \< tolerance | Wyoming              |
| 4048 | 511       |          0.89 | abs(result) \< tolerance | Wyoming              |
| 4176 | 512       |          1.38 | abs(result) \< tolerance | Wyoming              |
| 4251 | 513       |          0.39 | abs(result) \< tolerance | Wyoming              |
| 4349 | 514       |          3.11 | abs(result) \< tolerance | Wyoming              |
| 4449 | 521CI     |          1.53 | abs(result) \< tolerance | Wyoming              |
| 4549 | 523       |          7.61 | abs(result) \< tolerance | Wyoming              |
| 4647 | 524       |          1.19 | abs(result) \< tolerance | Wyoming              |
| 4749 | 525       |          0.09 | abs(result) \< tolerance | Wyoming              |
| 4848 | HS        |         -0.16 | abs(result) \< tolerance | Wyoming              |
| 4949 | ORE       |          0.50 | abs(result) \< tolerance | Wyoming              |
| 5049 | 532RL     |          0.13 | abs(result) \< tolerance | Wyoming              |
| 5174 | 5411      |          1.05 | abs(result) \< tolerance | Wyoming              |
| 5247 | 5415      |          1.15 | abs(result) \< tolerance | Wyoming              |
| 5348 | 5412OP    |          0.44 | abs(result) \< tolerance | Wyoming              |
| 5448 | 55        |          4.74 | abs(result) \< tolerance | Wyoming              |
| 5547 | 561       |          0.59 | abs(result) \< tolerance | Wyoming              |
| 5647 | 562       |          0.33 | abs(result) \< tolerance | Wyoming              |
| 5746 | 61        |          0.25 | abs(result) \< tolerance | Wyoming              |
| 5848 | 621       |         -0.08 | abs(result) \< tolerance | Wyoming              |
| 5948 | 622       |          0.24 | abs(result) \< tolerance | Wyoming              |
| 6048 | 623       |         -0.05 | abs(result) \< tolerance | Wyoming              |
| 6173 | 624       |         -0.32 | abs(result) \< tolerance | Wyoming              |
| 6250 | 711AS     |          0.75 | abs(result) \< tolerance | Wyoming              |
| 6348 | 713       |         -0.41 | abs(result) \< tolerance | Wyoming              |
| 6448 | 721       |         -0.60 | abs(result) \< tolerance | Wyoming              |
| 6543 | 722       |          0.03 | abs(result) \< tolerance | Wyoming              |
| 6645 | 81        |         -0.02 | abs(result) \< tolerance | Wyoming              |
| 6749 | GFGD      |         -0.18 | abs(result) \< tolerance | Wyoming              |
| 6847 | GFGN      |         -0.40 | abs(result) \< tolerance | Wyoming              |
| 6949 | GFE       |         -0.35 | abs(result) \< tolerance | Wyoming              |
| 7047 | GSLG      |         -0.10 | abs(result) \< tolerance | Wyoming              |
| 7153 | GSLE      |         -0.18 | abs(result) \< tolerance | Wyoming              |
| 7250 | Used      |         -0.03 | abs(result) \< tolerance | Wyoming              |
| 7349 | Other     |          6.77 | abs(result) \< tolerance | Wyoming              |

#### 2.2. Check if sum of commodity output from state Use and sum demand from Domestic Use are almost equal (relative difference \<= 0.01).

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
| 111CA  |             -2.000e+06 |
| 113FF  |              2.000e+06 |
| 211    |             -3.000e+06 |
| 212    |             -1.000e+06 |
| 213    |              1.530e-05 |
| 22     |             -1.000e+06 |
| 23     |              3.000e+06 |
| 321    |              4.580e-05 |
| 327    |             -1.000e+06 |
| 331    |              6.000e+06 |
| 332    |             -1.000e+06 |
| 333    |             -2.000e+06 |
| 334    |              3.000e+06 |
| 335    |              3.050e-05 |
| 3361MV |             -2.000e+06 |
| 3364OT |             -3.000e+06 |
| 337    |             -1.000e+06 |
| 339    |              2.000e+06 |
| 311FT  |              2.000e+06 |
| 313TT  |             -7.600e-06 |
| 315AL  |             -1.000e+06 |
| 322    |             -7.000e+06 |
| 323    |              6.000e+06 |
| 324    |             -1.000e+06 |
| 325    |             -2.000e+06 |
| 326    |             -3.000e+06 |
| 42     |             -2.000e+06 |
| 441    |              2.000e+06 |
| 445    |              1.000e+06 |
| 452    |              1.000e+06 |
| 4A0    |             -1.221e-04 |
| 481    |             -4.000e+06 |
| 482    |              0.000e+00 |
| 483    |              3.000e+06 |
| 484    |              4.000e+06 |
| 485    |              3.000e+06 |
| 486    |              5.000e+06 |
| 487OS  |             -5.000e+06 |
| 493    |             -4.000e+06 |
| 511    |              3.000e+06 |
| 512    |              1.000e+06 |
| 513    |              0.000e+00 |
| 514    |             -1.000e+06 |
| 521CI  |              1.000e+06 |
| 523    |              2.000e+06 |
| 524    |             -4.000e+06 |
| 525    |              6.100e-05 |
| HS     |              2.441e-04 |
| ORE    |              0.000e+00 |
| 532RL  |             -1.000e+06 |
| 5411   |              4.000e+06 |
| 5415   |              1.000e+06 |
| 5412OP |              7.000e+06 |
| 55     |              1.000e+06 |
| 561    |             -5.000e+06 |
| 562    |              1.530e-05 |
| 61     |              1.000e+06 |
| 621    |              3.000e+06 |
| 622    |              0.000e+00 |
| 623    |              3.050e-05 |
| 624    |              3.050e-05 |
| 711AS  |              2.000e+06 |
| 713    |              1.000e+06 |
| 721    |              4.000e+06 |
| 722    |             -1.000e+06 |
| 81     |             -4.000e+06 |
| GFGD   |             -1.221e-04 |
| GFGN   |              6.100e-05 |
| GFE    |             -1.000e+06 |
| GSLG   |              0.000e+00 |
| GSLE   |             -3.050e-05 |
| Used   |              2.000e+06 |
| Other  |             -5.000e+06 |

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
| 562       | F050                  |         6e+06 | abs(result) \< tolerance |                      -0.025641 |

##### 8.2 State Domestic Use tables (checking absolute differences)

There are no failures.

##### 8.3 State Use tables (checking relative differences)

There are 11 failures, and they are

| Commodity | Industry/Final Demand | Relative Diff | Validation               |         US |    StateSum |
|:----------|:----------------------|--------------:|:-------------------------|-----------:|------------:|
| 212       | F050                  |         0.002 | abs(result) \< tolerance |  4.380e+08 |   438935544 |
| 487OS     | F050                  |         0.001 | abs(result) \< tolerance |  3.293e+09 |  3296933173 |
| 513       | F050                  |        -0.025 | abs(result) \< tolerance | -1.590e+08 |  -155000000 |
| 514       | F050                  |        -0.003 | abs(result) \< tolerance | -1.253e+09 | -1249000000 |
| 521CI     | F050                  |        -0.022 | abs(result) \< tolerance | -4.500e+07 |   -44000000 |
| 523       | F050                  |        -0.053 | abs(result) \< tolerance | -5.700e+07 |   -54000000 |
| 5411      | F050                  |         0.001 | abs(result) \< tolerance | -3.861e+09 | -3865000000 |
| 561       | F050                  |        -0.001 | abs(result) \< tolerance | -1.938e+09 | -1936000000 |
| 562       | F050                  |        -0.026 | abs(result) \< tolerance | -2.340e+08 |  -228000000 |
| 711AS     | F050                  |        -0.002 | abs(result) \< tolerance | -1.325e+09 | -1322000000 |
| GFE       | F050                  |        -0.010 | abs(result) \< tolerance | -2.890e+08 |  -286000000 |

##### 8.4 State Domestic Use tables (checking relative differences)

There are 3 failures, and they are

| Commodity | Industry/Final Demand | Relative Diff | Validation               |       US | StateSum |
|:----------|:----------------------|--------------:|:-------------------------|---------:|---------:|
| 211       | 326                   |        -1.000 | abs(result) \< tolerance | -1000000 |        0 |
| 211       | 711AS                 |        -1.000 | abs(result) \< tolerance | -3000000 |        0 |
| Other     | F051                  |        -0.001 | abs(result) \< tolerance | 27000000 | 26959917 |

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

Absolute Difference: There are 6 failures, and they areRelative
Difference: There are no failures.

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

Absolute Difference: There are 2 failures, and they areRelative
Difference: There are no failures.

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

Absolute Difference: There are 4 failures, and they areRelative
Difference: There are no failures.

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
