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

#### 2. Check commodity output

#### 2.1. Check if commodity output from state Make and Use are almost equal (relative difference \<= 0.01).

There are 3634 failures, and they are

|      | Commodity | Relative Diff | Validation               | State                |
|------|:----------|--------------:|:-------------------------|:---------------------|
| 1    | 111CA     |         -0.09 | abs(result) \< tolerance | Alabama              |
| 2    | 113FF     |          0.29 | abs(result) \< tolerance | Alabama              |
| 3    | 211       |          4.07 | abs(result) \< tolerance | Alabama              |
| 4    | 212       |          0.15 | abs(result) \< tolerance | Alabama              |
| 5    | 213       |          0.03 | abs(result) \< tolerance | Alabama              |
| 6    | 22        |         -0.32 | abs(result) \< tolerance | Alabama              |
| 7    | 23        |          0.07 | abs(result) \< tolerance | Alabama              |
| 8    | 321       |         -0.48 | abs(result) \< tolerance | Alabama              |
| 9    | 327       |         -0.18 | abs(result) \< tolerance | Alabama              |
| 10   | 331       |         -0.51 | abs(result) \< tolerance | Alabama              |
| 11   | 332       |         -0.12 | abs(result) \< tolerance | Alabama              |
| 12   | 333       |          0.26 | abs(result) \< tolerance | Alabama              |
| 13   | 334       |          0.61 | abs(result) \< tolerance | Alabama              |
| 14   | 335       |         -0.05 | abs(result) \< tolerance | Alabama              |
| 15   | 3361MV    |         -0.10 | abs(result) \< tolerance | Alabama              |
| 16   | 3364OT    |         -0.22 | abs(result) \< tolerance | Alabama              |
| 17   | 337       |         -0.47 | abs(result) \< tolerance | Alabama              |
| 18   | 339       |          0.20 | abs(result) \< tolerance | Alabama              |
| 19   | 311FT     |          0.28 | abs(result) \< tolerance | Alabama              |
| 20   | 313TT     |         -0.21 | abs(result) \< tolerance | Alabama              |
| 21   | 315AL     |         -0.01 | abs(result) \< tolerance | Alabama              |
| 22   | 322       |         -0.52 | abs(result) \< tolerance | Alabama              |
| 23   | 323       |          0.62 | abs(result) \< tolerance | Alabama              |
| 24   | 324       |         -0.06 | abs(result) \< tolerance | Alabama              |
| 25   | 325       |          0.28 | abs(result) \< tolerance | Alabama              |
| 26   | 326       |         -0.27 | abs(result) \< tolerance | Alabama              |
| 27   | 42        |          0.31 | abs(result) \< tolerance | Alabama              |
| 28   | 441       |          0.53 | abs(result) \< tolerance | Alabama              |
| 29   | 445       |          0.14 | abs(result) \< tolerance | Alabama              |
| 30   | 452       |         -0.43 | abs(result) \< tolerance | Alabama              |
| 31   | 4A0       |         -0.05 | abs(result) \< tolerance | Alabama              |
| 32   | 481       |          4.77 | abs(result) \< tolerance | Alabama              |
| 33   | 482       |          0.03 | abs(result) \< tolerance | Alabama              |
| 34   | 483       |          0.07 | abs(result) \< tolerance | Alabama              |
| 35   | 484       |         -0.12 | abs(result) \< tolerance | Alabama              |
| 36   | 485       |          1.64 | abs(result) \< tolerance | Alabama              |
| 37   | 486       |          0.64 | abs(result) \< tolerance | Alabama              |
| 38   | 487OS     |          0.10 | abs(result) \< tolerance | Alabama              |
| 39   | 493       |          0.05 | abs(result) \< tolerance | Alabama              |
| 40   | 511       |          0.62 | abs(result) \< tolerance | Alabama              |
| 41   | 512       |          3.24 | abs(result) \< tolerance | Alabama              |
| 42   | 513       |          0.56 | abs(result) \< tolerance | Alabama              |
| 43   | 514       |          3.58 | abs(result) \< tolerance | Alabama              |
| 44   | 521CI     |         -0.13 | abs(result) \< tolerance | Alabama              |
| 45   | 523       |          1.19 | abs(result) \< tolerance | Alabama              |
| 46   | 524       |          0.36 | abs(result) \< tolerance | Alabama              |
| 47   | 525       |          2.02 | abs(result) \< tolerance | Alabama              |
| 48   | HS        |         -0.06 | abs(result) \< tolerance | Alabama              |
| 49   | ORE       |          0.82 | abs(result) \< tolerance | Alabama              |
| 50   | 532RL     |          0.09 | abs(result) \< tolerance | Alabama              |
| 51   | 5411      |          0.12 | abs(result) \< tolerance | Alabama              |
| 52   | 5415      |          0.05 | abs(result) \< tolerance | Alabama              |
| 53   | 5412OP    |          0.31 | abs(result) \< tolerance | Alabama              |
| 54   | 55        |          1.00 | abs(result) \< tolerance | Alabama              |
| 55   | 561       |          0.07 | abs(result) \< tolerance | Alabama              |
| 56   | 562       |          0.08 | abs(result) \< tolerance | Alabama              |
| 57   | 61        |          0.66 | abs(result) \< tolerance | Alabama              |
| 58   | 621       |         -0.06 | abs(result) \< tolerance | Alabama              |
| 59   | 622       |          0.38 | abs(result) \< tolerance | Alabama              |
| 60   | 623       |          0.14 | abs(result) \< tolerance | Alabama              |
| 61   | 624       |          0.97 | abs(result) \< tolerance | Alabama              |
| 62   | 711AS     |          1.52 | abs(result) \< tolerance | Alabama              |
| 63   | 713       |          0.48 | abs(result) \< tolerance | Alabama              |
| 64   | 721       |          0.77 | abs(result) \< tolerance | Alabama              |
| 65   | 722       |          0.01 | abs(result) \< tolerance | Alabama              |
| 67   | GFGD      |         -0.61 | abs(result) \< tolerance | Alabama              |
| 68   | GFGN      |          0.07 | abs(result) \< tolerance | Alabama              |
| 69   | GFE       |         -0.45 | abs(result) \< tolerance | Alabama              |
| 70   | GSLG      |         -0.03 | abs(result) \< tolerance | Alabama              |
| 71   | GSLE      |         -0.04 | abs(result) \< tolerance | Alabama              |
| 72   | Used      |         -2.19 | abs(result) \< tolerance | Alabama              |
| 73   | Other     |         17.01 | abs(result) \< tolerance | Alabama              |
| 110  | 111CA     |         21.20 | abs(result) \< tolerance | Alaska               |
| 210  | 113FF     |         -0.77 | abs(result) \< tolerance | Alaska               |
| 310  | 211       |         -0.75 | abs(result) \< tolerance | Alaska               |
| 410  | 212       |         -0.33 | abs(result) \< tolerance | Alaska               |
| 510  | 213       |          0.11 | abs(result) \< tolerance | Alaska               |
| 610  | 22        |         -0.06 | abs(result) \< tolerance | Alaska               |
| 74   | 23        |          0.14 | abs(result) \< tolerance | Alaska               |
| 81   | 321       |          0.23 | abs(result) \< tolerance | Alaska               |
| 91   | 327       |          1.17 | abs(result) \< tolerance | Alaska               |
| 101  | 331       |         19.85 | abs(result) \< tolerance | Alaska               |
| 111  | 332       |          3.22 | abs(result) \< tolerance | Alaska               |
| 121  | 333       |          9.44 | abs(result) \< tolerance | Alaska               |
| 131  | 334       |          9.50 | abs(result) \< tolerance | Alaska               |
| 141  | 335       |         14.94 | abs(result) \< tolerance | Alaska               |
| 151  | 3361MV    |         29.83 | abs(result) \< tolerance | Alaska               |
| 161  | 3364OT    |          4.11 | abs(result) \< tolerance | Alaska               |
| 171  | 337       |          3.40 | abs(result) \< tolerance | Alaska               |
| 181  | 339       |          0.55 | abs(result) \< tolerance | Alaska               |
| 191  | 311FT     |         -0.11 | abs(result) \< tolerance | Alaska               |
| 201  | 313TT     |          3.91 | abs(result) \< tolerance | Alaska               |
| 211  | 315AL     |          9.81 | abs(result) \< tolerance | Alaska               |
| 221  | 322       |         10.62 | abs(result) \< tolerance | Alaska               |
| 231  | 323       |          2.18 | abs(result) \< tolerance | Alaska               |
| 241  | 324       |         -0.37 | abs(result) \< tolerance | Alaska               |
| 251  | 325       |          4.55 | abs(result) \< tolerance | Alaska               |
| 261  | 326       |         12.33 | abs(result) \< tolerance | Alaska               |
| 271  | 42        |          0.82 | abs(result) \< tolerance | Alaska               |
| 281  | 441       |          0.85 | abs(result) \< tolerance | Alaska               |
| 291  | 445       |          0.32 | abs(result) \< tolerance | Alaska               |
| 301  | 452       |         -0.43 | abs(result) \< tolerance | Alaska               |
| 311  | 4A0       |          0.13 | abs(result) \< tolerance | Alaska               |
| 321  | 481       |         -0.47 | abs(result) \< tolerance | Alaska               |
| 331  | 482       |        382.62 | abs(result) \< tolerance | Alaska               |
| 341  | 483       |         -0.54 | abs(result) \< tolerance | Alaska               |
| 351  | 484       |          0.27 | abs(result) \< tolerance | Alaska               |
| 361  | 485       |         -0.09 | abs(result) \< tolerance | Alaska               |
| 371  | 486       |         -0.86 | abs(result) \< tolerance | Alaska               |
| 381  | 487OS     |         -0.41 | abs(result) \< tolerance | Alaska               |
| 391  | 493       |          1.52 | abs(result) \< tolerance | Alaska               |
| 401  | 511       |          2.45 | abs(result) \< tolerance | Alaska               |
| 411  | 512       |          4.55 | abs(result) \< tolerance | Alaska               |
| 421  | 513       |         -0.13 | abs(result) \< tolerance | Alaska               |
| 431  | 514       |          6.41 | abs(result) \< tolerance | Alaska               |
| 441  | 521CI     |          0.53 | abs(result) \< tolerance | Alaska               |
| 451  | 523       |          4.02 | abs(result) \< tolerance | Alaska               |
| 461  | 524       |          2.43 | abs(result) \< tolerance | Alaska               |
| 471  | 525       |          1.12 | abs(result) \< tolerance | Alaska               |
| 481  | HS        |         -0.11 | abs(result) \< tolerance | Alaska               |
| 491  | ORE       |          0.57 | abs(result) \< tolerance | Alaska               |
| 501  | 532RL     |         -0.04 | abs(result) \< tolerance | Alaska               |
| 511  | 5411      |          2.06 | abs(result) \< tolerance | Alaska               |
| 521  | 5415      |          1.53 | abs(result) \< tolerance | Alaska               |
| 531  | 5412OP    |          0.18 | abs(result) \< tolerance | Alaska               |
| 541  | 55        |          1.47 | abs(result) \< tolerance | Alaska               |
| 551  | 561       |          0.39 | abs(result) \< tolerance | Alaska               |
| 561  | 562       |         -0.22 | abs(result) \< tolerance | Alaska               |
| 571  | 61        |          0.44 | abs(result) \< tolerance | Alaska               |
| 581  | 621       |         -0.26 | abs(result) \< tolerance | Alaska               |
| 591  | 622       |         -0.26 | abs(result) \< tolerance | Alaska               |
| 601  | 623       |          0.50 | abs(result) \< tolerance | Alaska               |
| 611  | 624       |         -0.39 | abs(result) \< tolerance | Alaska               |
| 621  | 711AS     |          1.78 | abs(result) \< tolerance | Alaska               |
| 631  | 713       |          0.24 | abs(result) \< tolerance | Alaska               |
| 641  | 721       |         -0.35 | abs(result) \< tolerance | Alaska               |
| 651  | 722       |          0.21 | abs(result) \< tolerance | Alaska               |
| 66   | 81        |          0.13 | abs(result) \< tolerance | Alaska               |
| 671  | GFGD      |         -0.16 | abs(result) \< tolerance | Alaska               |
| 681  | GFGN      |         16.70 | abs(result) \< tolerance | Alaska               |
| 691  | GFE       |         -0.45 | abs(result) \< tolerance | Alaska               |
| 701  | GSLG      |          0.07 | abs(result) \< tolerance | Alaska               |
| 711  | GSLE      |          0.54 | abs(result) \< tolerance | Alaska               |
| 721  | Used      |         -6.37 | abs(result) \< tolerance | Alaska               |
| 731  | Other     |         30.61 | abs(result) \< tolerance | Alaska               |
| 112  | 111CA     |         -0.21 | abs(result) \< tolerance | Arizona              |
| 212  | 113FF     |         -0.31 | abs(result) \< tolerance | Arizona              |
| 312  | 211       |         46.18 | abs(result) \< tolerance | Arizona              |
| 412  | 212       |         -0.47 | abs(result) \< tolerance | Arizona              |
| 512  | 213       |          0.08 | abs(result) \< tolerance | Arizona              |
| 612  | 22        |         -0.14 | abs(result) \< tolerance | Arizona              |
| 75   | 23        |          0.02 | abs(result) \< tolerance | Arizona              |
| 82   | 321       |          0.65 | abs(result) \< tolerance | Arizona              |
| 92   | 327       |          0.02 | abs(result) \< tolerance | Arizona              |
| 102  | 331       |         -0.12 | abs(result) \< tolerance | Arizona              |
| 113  | 332       |          0.19 | abs(result) \< tolerance | Arizona              |
| 122  | 333       |          0.56 | abs(result) \< tolerance | Arizona              |
| 132  | 334       |         -0.17 | abs(result) \< tolerance | Arizona              |
| 142  | 335       |          0.71 | abs(result) \< tolerance | Arizona              |
| 152  | 3361MV    |          1.16 | abs(result) \< tolerance | Arizona              |
| 162  | 3364OT    |         -0.13 | abs(result) \< tolerance | Arizona              |
| 172  | 337       |          0.32 | abs(result) \< tolerance | Arizona              |
| 182  | 339       |          0.08 | abs(result) \< tolerance | Arizona              |
| 192  | 311FT     |          1.11 | abs(result) \< tolerance | Arizona              |
| 202  | 313TT     |          1.19 | abs(result) \< tolerance | Arizona              |
| 213  | 315AL     |          2.73 | abs(result) \< tolerance | Arizona              |
| 222  | 322       |          1.53 | abs(result) \< tolerance | Arizona              |
| 232  | 323       |          0.23 | abs(result) \< tolerance | Arizona              |
| 242  | 324       |         11.81 | abs(result) \< tolerance | Arizona              |
| 252  | 325       |          1.86 | abs(result) \< tolerance | Arizona              |
| 262  | 326       |          1.05 | abs(result) \< tolerance | Arizona              |
| 272  | 42        |          0.02 | abs(result) \< tolerance | Arizona              |
| 282  | 441       |          0.27 | abs(result) \< tolerance | Arizona              |
| 292  | 445       |         -0.15 | abs(result) \< tolerance | Arizona              |
| 302  | 452       |         -0.15 | abs(result) \< tolerance | Arizona              |
| 313  | 4A0       |          0.03 | abs(result) \< tolerance | Arizona              |
| 322  | 481       |         -0.22 | abs(result) \< tolerance | Arizona              |
| 332  | 482       |         -0.19 | abs(result) \< tolerance | Arizona              |
| 342  | 483       |         17.51 | abs(result) \< tolerance | Arizona              |
| 352  | 484       |          0.08 | abs(result) \< tolerance | Arizona              |
| 362  | 485       |          0.25 | abs(result) \< tolerance | Arizona              |
| 372  | 486       |          1.69 | abs(result) \< tolerance | Arizona              |
| 382  | 487OS     |          0.08 | abs(result) \< tolerance | Arizona              |
| 392  | 493       |          0.65 | abs(result) \< tolerance | Arizona              |
| 402  | 511       |          0.47 | abs(result) \< tolerance | Arizona              |
| 413  | 512       |          1.68 | abs(result) \< tolerance | Arizona              |
| 422  | 513       |          0.26 | abs(result) \< tolerance | Arizona              |
| 432  | 514       |          0.29 | abs(result) \< tolerance | Arizona              |
| 442  | 521CI     |         -0.09 | abs(result) \< tolerance | Arizona              |
| 452  | 523       |          0.50 | abs(result) \< tolerance | Arizona              |
| 462  | 524       |          0.15 | abs(result) \< tolerance | Arizona              |
| 472  | 525       |         -0.26 | abs(result) \< tolerance | Arizona              |
| 482  | HS        |         -0.19 | abs(result) \< tolerance | Arizona              |
| 492  | ORE       |          0.55 | abs(result) \< tolerance | Arizona              |
| 502  | 532RL     |         -0.23 | abs(result) \< tolerance | Arizona              |
| 513  | 5411      |          0.55 | abs(result) \< tolerance | Arizona              |
| 532  | 5412OP    |          0.09 | abs(result) \< tolerance | Arizona              |
| 542  | 55        |          0.49 | abs(result) \< tolerance | Arizona              |
| 552  | 561       |         -0.37 | abs(result) \< tolerance | Arizona              |
| 562  | 562       |          0.10 | abs(result) \< tolerance | Arizona              |
| 572  | 61        |          0.14 | abs(result) \< tolerance | Arizona              |
| 582  | 621       |         -0.10 | abs(result) \< tolerance | Arizona              |
| 592  | 622       |          0.06 | abs(result) \< tolerance | Arizona              |
| 602  | 623       |          0.21 | abs(result) \< tolerance | Arizona              |
| 613  | 624       |          0.22 | abs(result) \< tolerance | Arizona              |
| 632  | 713       |          0.27 | abs(result) \< tolerance | Arizona              |
| 642  | 721       |          0.01 | abs(result) \< tolerance | Arizona              |
| 652  | 722       |          0.05 | abs(result) \< tolerance | Arizona              |
| 661  | 81        |          0.17 | abs(result) \< tolerance | Arizona              |
| 672  | GFGD      |         -0.48 | abs(result) \< tolerance | Arizona              |
| 682  | GFGN      |         -0.09 | abs(result) \< tolerance | Arizona              |
| 702  | GSLG      |         -0.17 | abs(result) \< tolerance | Arizona              |
| 712  | GSLE      |          0.02 | abs(result) \< tolerance | Arizona              |
| 722  | Used      |          3.44 | abs(result) \< tolerance | Arizona              |
| 732  | Other     |        -10.25 | abs(result) \< tolerance | Arizona              |
| 114  | 111CA     |         -0.14 | abs(result) \< tolerance | Arkansas             |
| 214  | 113FF     |          0.02 | abs(result) \< tolerance | Arkansas             |
| 314  | 211       |          1.03 | abs(result) \< tolerance | Arkansas             |
| 414  | 212       |          0.45 | abs(result) \< tolerance | Arkansas             |
| 514  | 213       |         -0.08 | abs(result) \< tolerance | Arkansas             |
| 614  | 22        |         -0.24 | abs(result) \< tolerance | Arkansas             |
| 76   | 23        |          0.09 | abs(result) \< tolerance | Arkansas             |
| 83   | 321       |         -0.59 | abs(result) \< tolerance | Arkansas             |
| 93   | 327       |         -0.15 | abs(result) \< tolerance | Arkansas             |
| 103  | 331       |         -0.58 | abs(result) \< tolerance | Arkansas             |
| 115  | 332       |         -0.35 | abs(result) \< tolerance | Arkansas             |
| 123  | 333       |         -0.20 | abs(result) \< tolerance | Arkansas             |
| 133  | 334       |          0.94 | abs(result) \< tolerance | Arkansas             |
| 143  | 335       |         -0.13 | abs(result) \< tolerance | Arkansas             |
| 153  | 3361MV    |          0.43 | abs(result) \< tolerance | Arkansas             |
| 163  | 3364OT    |         -0.04 | abs(result) \< tolerance | Arkansas             |
| 173  | 337       |         -0.11 | abs(result) \< tolerance | Arkansas             |
| 183  | 339       |          0.30 | abs(result) \< tolerance | Arkansas             |
| 193  | 311FT     |         -0.35 | abs(result) \< tolerance | Arkansas             |
| 203  | 313TT     |          0.82 | abs(result) \< tolerance | Arkansas             |
| 215  | 315AL     |          0.09 | abs(result) \< tolerance | Arkansas             |
| 223  | 322       |         -0.59 | abs(result) \< tolerance | Arkansas             |
| 233  | 323       |         -0.19 | abs(result) \< tolerance | Arkansas             |
| 243  | 324       |          0.65 | abs(result) \< tolerance | Arkansas             |
| 253  | 325       |          1.22 | abs(result) \< tolerance | Arkansas             |
| 263  | 326       |         -0.49 | abs(result) \< tolerance | Arkansas             |
| 273  | 42        |          0.02 | abs(result) \< tolerance | Arkansas             |
| 283  | 441       |          0.42 | abs(result) \< tolerance | Arkansas             |
| 293  | 445       |          0.06 | abs(result) \< tolerance | Arkansas             |
| 303  | 452       |         -0.55 | abs(result) \< tolerance | Arkansas             |
| 315  | 4A0       |         -0.14 | abs(result) \< tolerance | Arkansas             |
| 323  | 481       |          5.16 | abs(result) \< tolerance | Arkansas             |
| 333  | 482       |         -0.31 | abs(result) \< tolerance | Arkansas             |
| 343  | 483       |         10.42 | abs(result) \< tolerance | Arkansas             |
| 353  | 484       |         -0.45 | abs(result) \< tolerance | Arkansas             |
| 363  | 485       |          1.13 | abs(result) \< tolerance | Arkansas             |
| 373  | 486       |          0.98 | abs(result) \< tolerance | Arkansas             |
| 383  | 487OS     |          0.20 | abs(result) \< tolerance | Arkansas             |
| 393  | 493       |          0.02 | abs(result) \< tolerance | Arkansas             |
| 403  | 511       |          1.81 | abs(result) \< tolerance | Arkansas             |
| 415  | 512       |          1.97 | abs(result) \< tolerance | Arkansas             |
| 423  | 513       |          0.55 | abs(result) \< tolerance | Arkansas             |
| 433  | 514       |          2.08 | abs(result) \< tolerance | Arkansas             |
| 443  | 521CI     |          0.44 | abs(result) \< tolerance | Arkansas             |
| 453  | 523       |          1.66 | abs(result) \< tolerance | Arkansas             |
| 463  | 524       |          0.34 | abs(result) \< tolerance | Arkansas             |
| 473  | 525       |          2.08 | abs(result) \< tolerance | Arkansas             |
| 493  | ORE       |          1.13 | abs(result) \< tolerance | Arkansas             |
| 503  | 532RL     |          0.38 | abs(result) \< tolerance | Arkansas             |
| 515  | 5411      |          1.05 | abs(result) \< tolerance | Arkansas             |
| 522  | 5415      |          0.20 | abs(result) \< tolerance | Arkansas             |
| 533  | 5412OP    |          0.54 | abs(result) \< tolerance | Arkansas             |
| 543  | 55        |         -0.51 | abs(result) \< tolerance | Arkansas             |
| 553  | 561       |          0.07 | abs(result) \< tolerance | Arkansas             |
| 563  | 562       |         -0.18 | abs(result) \< tolerance | Arkansas             |
| 573  | 61        |          0.54 | abs(result) \< tolerance | Arkansas             |
| 583  | 621       |         -0.09 | abs(result) \< tolerance | Arkansas             |
| 603  | 623       |         -0.15 | abs(result) \< tolerance | Arkansas             |
| 615  | 624       |         -0.29 | abs(result) \< tolerance | Arkansas             |
| 622  | 711AS     |          1.13 | abs(result) \< tolerance | Arkansas             |
| 633  | 713       |          0.27 | abs(result) \< tolerance | Arkansas             |
| 643  | 721       |          0.82 | abs(result) \< tolerance | Arkansas             |
| 653  | 722       |         -0.06 | abs(result) \< tolerance | Arkansas             |
| 673  | GFGD      |         -0.22 | abs(result) \< tolerance | Arkansas             |
| 683  | GFGN      |         -0.05 | abs(result) \< tolerance | Arkansas             |
| 692  | GFE       |          0.22 | abs(result) \< tolerance | Arkansas             |
| 703  | GSLG      |          0.02 | abs(result) \< tolerance | Arkansas             |
| 713  | GSLE      |          0.30 | abs(result) \< tolerance | Arkansas             |
| 723  | Used      |         -2.02 | abs(result) \< tolerance | Arkansas             |
| 733  | Other     |        -27.29 | abs(result) \< tolerance | Arkansas             |
| 116  | 111CA     |         -0.27 | abs(result) \< tolerance | California           |
| 216  | 113FF     |         -0.46 | abs(result) \< tolerance | California           |
| 316  | 211       |          1.53 | abs(result) \< tolerance | California           |
| 416  | 212       |          1.30 | abs(result) \< tolerance | California           |
| 516  | 213       |          0.03 | abs(result) \< tolerance | California           |
| 616  | 22        |          0.12 | abs(result) \< tolerance | California           |
| 77   | 23        |          0.02 | abs(result) \< tolerance | California           |
| 84   | 321       |          0.72 | abs(result) \< tolerance | California           |
| 94   | 327       |          0.51 | abs(result) \< tolerance | California           |
| 104  | 331       |          1.26 | abs(result) \< tolerance | California           |
| 117  | 332       |          0.15 | abs(result) \< tolerance | California           |
| 124  | 333       |          0.14 | abs(result) \< tolerance | California           |
| 134  | 334       |         -0.34 | abs(result) \< tolerance | California           |
| 144  | 335       |          0.48 | abs(result) \< tolerance | California           |
| 154  | 3361MV    |          0.86 | abs(result) \< tolerance | California           |
| 164  | 3364OT    |         -0.25 | abs(result) \< tolerance | California           |
| 174  | 337       |          0.34 | abs(result) \< tolerance | California           |
| 184  | 339       |         -0.02 | abs(result) \< tolerance | California           |
| 194  | 311FT     |          0.16 | abs(result) \< tolerance | California           |
| 204  | 313TT     |          0.52 | abs(result) \< tolerance | California           |
| 217  | 315AL     |         -0.44 | abs(result) \< tolerance | California           |
| 224  | 322       |          0.92 | abs(result) \< tolerance | California           |
| 234  | 323       |          0.68 | abs(result) \< tolerance | California           |
| 244  | 324       |         -0.17 | abs(result) \< tolerance | California           |
| 254  | 325       |         -0.34 | abs(result) \< tolerance | California           |
| 264  | 326       |          0.78 | abs(result) \< tolerance | California           |
| 274  | 42        |         -0.07 | abs(result) \< tolerance | California           |
| 284  | 441       |          0.23 | abs(result) \< tolerance | California           |
| 294  | 445       |         -0.31 | abs(result) \< tolerance | California           |
| 304  | 452       |         -0.14 | abs(result) \< tolerance | California           |
| 324  | 481       |          0.08 | abs(result) \< tolerance | California           |
| 334  | 482       |          1.45 | abs(result) \< tolerance | California           |
| 344  | 483       |          0.19 | abs(result) \< tolerance | California           |
| 354  | 484       |          0.18 | abs(result) \< tolerance | California           |
| 364  | 485       |          0.02 | abs(result) \< tolerance | California           |
| 374  | 486       |          4.33 | abs(result) \< tolerance | California           |
| 384  | 487OS     |         -0.05 | abs(result) \< tolerance | California           |
| 394  | 493       |          0.15 | abs(result) \< tolerance | California           |
| 404  | 511       |         -0.12 | abs(result) \< tolerance | California           |
| 417  | 512       |         -0.34 | abs(result) \< tolerance | California           |
| 424  | 513       |         -0.12 | abs(result) \< tolerance | California           |
| 434  | 514       |         -0.56 | abs(result) \< tolerance | California           |
| 444  | 521CI     |          0.25 | abs(result) \< tolerance | California           |
| 454  | 523       |          0.03 | abs(result) \< tolerance | California           |
| 464  | 524       |          0.62 | abs(result) \< tolerance | California           |
| 474  | 525       |          0.35 | abs(result) \< tolerance | California           |
| 483  | HS        |         -0.27 | abs(result) \< tolerance | California           |
| 494  | ORE       |          0.64 | abs(result) \< tolerance | California           |
| 504  | 532RL     |          0.18 | abs(result) \< tolerance | California           |
| 517  | 5411      |         -0.07 | abs(result) \< tolerance | California           |
| 523  | 5415      |         -0.16 | abs(result) \< tolerance | California           |
| 534  | 5412OP    |         -0.10 | abs(result) \< tolerance | California           |
| 544  | 55        |          0.19 | abs(result) \< tolerance | California           |
| 554  | 561       |         -0.04 | abs(result) \< tolerance | California           |
| 584  | 621       |          0.04 | abs(result) \< tolerance | California           |
| 593  | 622       |          0.22 | abs(result) \< tolerance | California           |
| 604  | 623       |          0.33 | abs(result) \< tolerance | California           |
| 617  | 624       |         -0.22 | abs(result) \< tolerance | California           |
| 623  | 711AS     |         -0.17 | abs(result) \< tolerance | California           |
| 634  | 713       |          0.30 | abs(result) \< tolerance | California           |
| 644  | 721       |          0.14 | abs(result) \< tolerance | California           |
| 654  | 722       |         -0.05 | abs(result) \< tolerance | California           |
| 662  | 81        |          0.06 | abs(result) \< tolerance | California           |
| 674  | GFGD      |         -0.50 | abs(result) \< tolerance | California           |
| 684  | GFGN      |         -0.14 | abs(result) \< tolerance | California           |
| 693  | GFE       |          0.52 | abs(result) \< tolerance | California           |
| 704  | GSLG      |         -0.04 | abs(result) \< tolerance | California           |
| 714  | GSLE      |          0.33 | abs(result) \< tolerance | California           |
| 724  | Used      |          0.09 | abs(result) \< tolerance | California           |
| 734  | Other     |        -12.00 | abs(result) \< tolerance | California           |
| 118  | 111CA     |         -0.15 | abs(result) \< tolerance | Colorado             |
| 218  | 113FF     |          0.07 | abs(result) \< tolerance | Colorado             |
| 317  | 211       |         -0.69 | abs(result) \< tolerance | Colorado             |
| 418  | 212       |         -0.36 | abs(result) \< tolerance | Colorado             |
| 518  | 213       |         -0.04 | abs(result) \< tolerance | Colorado             |
| 618  | 22        |          0.30 | abs(result) \< tolerance | Colorado             |
| 78   | 23        |         -0.13 | abs(result) \< tolerance | Colorado             |
| 85   | 321       |          0.91 | abs(result) \< tolerance | Colorado             |
| 95   | 327       |         -0.12 | abs(result) \< tolerance | Colorado             |
| 105  | 331       |          1.37 | abs(result) \< tolerance | Colorado             |
| 119  | 332       |          0.30 | abs(result) \< tolerance | Colorado             |
| 125  | 333       |          0.17 | abs(result) \< tolerance | Colorado             |
| 135  | 334       |         -0.24 | abs(result) \< tolerance | Colorado             |
| 145  | 335       |          0.58 | abs(result) \< tolerance | Colorado             |
| 155  | 3361MV    |          5.35 | abs(result) \< tolerance | Colorado             |
| 165  | 3364OT    |         -0.42 | abs(result) \< tolerance | Colorado             |
| 175  | 337       |          0.15 | abs(result) \< tolerance | Colorado             |
| 185  | 339       |         -0.25 | abs(result) \< tolerance | Colorado             |
| 195  | 311FT     |          0.19 | abs(result) \< tolerance | Colorado             |
| 205  | 313TT     |          0.99 | abs(result) \< tolerance | Colorado             |
| 219  | 315AL     |          2.10 | abs(result) \< tolerance | Colorado             |
| 225  | 322       |          3.15 | abs(result) \< tolerance | Colorado             |
| 235  | 323       |          0.50 | abs(result) \< tolerance | Colorado             |
| 245  | 324       |          0.38 | abs(result) \< tolerance | Colorado             |
| 255  | 325       |          0.65 | abs(result) \< tolerance | Colorado             |
| 265  | 326       |          0.62 | abs(result) \< tolerance | Colorado             |
| 275  | 42        |         -0.02 | abs(result) \< tolerance | Colorado             |
| 285  | 441       |          0.45 | abs(result) \< tolerance | Colorado             |
| 295  | 445       |         -0.06 | abs(result) \< tolerance | Colorado             |
| 305  | 452       |         -0.12 | abs(result) \< tolerance | Colorado             |
| 318  | 4A0       |          0.04 | abs(result) \< tolerance | Colorado             |
| 325  | 481       |         -0.30 | abs(result) \< tolerance | Colorado             |
| 335  | 482       |         -0.11 | abs(result) \< tolerance | Colorado             |
| 345  | 483       |         11.25 | abs(result) \< tolerance | Colorado             |
| 355  | 484       |          0.20 | abs(result) \< tolerance | Colorado             |
| 365  | 485       |          0.58 | abs(result) \< tolerance | Colorado             |
| 375  | 486       |         -0.66 | abs(result) \< tolerance | Colorado             |
| 385  | 487OS     |          0.21 | abs(result) \< tolerance | Colorado             |
| 395  | 493       |          0.97 | abs(result) \< tolerance | Colorado             |
| 405  | 511       |         -0.14 | abs(result) \< tolerance | Colorado             |
| 419  | 512       |          1.27 | abs(result) \< tolerance | Colorado             |
| 425  | 513       |         -0.08 | abs(result) \< tolerance | Colorado             |
| 435  | 514       |         -0.11 | abs(result) \< tolerance | Colorado             |
| 445  | 521CI     |          0.36 | abs(result) \< tolerance | Colorado             |
| 455  | 523       |          0.03 | abs(result) \< tolerance | Colorado             |
| 465  | 524       |          0.25 | abs(result) \< tolerance | Colorado             |
| 475  | 525       |          0.16 | abs(result) \< tolerance | Colorado             |
| 484  | HS        |         -0.23 | abs(result) \< tolerance | Colorado             |
| 495  | ORE       |          0.50 | abs(result) \< tolerance | Colorado             |
| 505  | 532RL     |          0.14 | abs(result) \< tolerance | Colorado             |
| 519  | 5411      |          0.27 | abs(result) \< tolerance | Colorado             |
| 524  | 5415      |         -0.12 | abs(result) \< tolerance | Colorado             |
| 535  | 5412OP    |         -0.08 | abs(result) \< tolerance | Colorado             |
| 545  | 55        |         -0.06 | abs(result) \< tolerance | Colorado             |
| 555  | 561       |         -0.08 | abs(result) \< tolerance | Colorado             |
| 564  | 562       |         -0.03 | abs(result) \< tolerance | Colorado             |
| 574  | 61        |          0.21 | abs(result) \< tolerance | Colorado             |
| 585  | 621       |         -0.04 | abs(result) \< tolerance | Colorado             |
| 594  | 622       |          0.28 | abs(result) \< tolerance | Colorado             |
| 605  | 623       |          0.24 | abs(result) \< tolerance | Colorado             |
| 619  | 624       |          0.10 | abs(result) \< tolerance | Colorado             |
| 624  | 711AS     |          0.03 | abs(result) \< tolerance | Colorado             |
| 635  | 713       |         -0.24 | abs(result) \< tolerance | Colorado             |
| 645  | 721       |          0.03 | abs(result) \< tolerance | Colorado             |
| 663  | 81        |         -0.06 | abs(result) \< tolerance | Colorado             |
| 675  | GFGD      |         -0.24 | abs(result) \< tolerance | Colorado             |
| 685  | GFGN      |         -0.28 | abs(result) \< tolerance | Colorado             |
| 694  | GFE       |         -0.11 | abs(result) \< tolerance | Colorado             |
| 705  | GSLG      |         -0.11 | abs(result) \< tolerance | Colorado             |
| 715  | GSLE      |          0.22 | abs(result) \< tolerance | Colorado             |
| 725  | Used      |          5.81 | abs(result) \< tolerance | Colorado             |
| 735  | Other     |          5.19 | abs(result) \< tolerance | Colorado             |
| 120  | 111CA     |          2.17 | abs(result) \< tolerance | Connecticut          |
| 220  | 113FF     |          0.51 | abs(result) \< tolerance | Connecticut          |
| 319  | 211       |        451.14 | abs(result) \< tolerance | Connecticut          |
| 420  | 212       |          0.42 | abs(result) \< tolerance | Connecticut          |
| 520  | 213       |          0.07 | abs(result) \< tolerance | Connecticut          |
| 620  | 22        |         -0.08 | abs(result) \< tolerance | Connecticut          |
| 79   | 23        |          0.21 | abs(result) \< tolerance | Connecticut          |
| 86   | 321       |          1.91 | abs(result) \< tolerance | Connecticut          |
| 96   | 327       |          1.00 | abs(result) \< tolerance | Connecticut          |
| 106  | 331       |          0.65 | abs(result) \< tolerance | Connecticut          |
| 1110 | 332       |         -0.42 | abs(result) \< tolerance | Connecticut          |
| 126  | 333       |         -0.06 | abs(result) \< tolerance | Connecticut          |
| 136  | 334       |          0.14 | abs(result) \< tolerance | Connecticut          |
| 146  | 335       |         -0.25 | abs(result) \< tolerance | Connecticut          |
| 156  | 3361MV    |          0.71 | abs(result) \< tolerance | Connecticut          |
| 166  | 3364OT    |          0.04 | abs(result) \< tolerance | Connecticut          |
| 176  | 337       |          0.51 | abs(result) \< tolerance | Connecticut          |
| 186  | 339       |         -0.43 | abs(result) \< tolerance | Connecticut          |
| 196  | 311FT     |          0.87 | abs(result) \< tolerance | Connecticut          |
| 206  | 313TT     |         -0.08 | abs(result) \< tolerance | Connecticut          |
| 2110 | 315AL     |         -0.10 | abs(result) \< tolerance | Connecticut          |
| 226  | 322       |          0.75 | abs(result) \< tolerance | Connecticut          |
| 236  | 323       |          0.13 | abs(result) \< tolerance | Connecticut          |
| 246  | 324       |          3.01 | abs(result) \< tolerance | Connecticut          |
| 256  | 325       |         -0.23 | abs(result) \< tolerance | Connecticut          |
| 266  | 326       |          0.46 | abs(result) \< tolerance | Connecticut          |
| 276  | 42        |         -0.09 | abs(result) \< tolerance | Connecticut          |
| 286  | 441       |          0.40 | abs(result) \< tolerance | Connecticut          |
| 296  | 445       |         -0.37 | abs(result) \< tolerance | Connecticut          |
| 306  | 452       |          0.12 | abs(result) \< tolerance | Connecticut          |
| 3110 | 4A0       |          0.08 | abs(result) \< tolerance | Connecticut          |
| 326  | 481       |          2.32 | abs(result) \< tolerance | Connecticut          |
| 336  | 482       |          1.85 | abs(result) \< tolerance | Connecticut          |
| 346  | 483       |         -0.24 | abs(result) \< tolerance | Connecticut          |
| 356  | 484       |          0.78 | abs(result) \< tolerance | Connecticut          |
| 366  | 485       |         -0.23 | abs(result) \< tolerance | Connecticut          |
| 376  | 486       |         -0.65 | abs(result) \< tolerance | Connecticut          |
| 386  | 487OS     |          0.07 | abs(result) \< tolerance | Connecticut          |
| 396  | 493       |          0.11 | abs(result) \< tolerance | Connecticut          |
| 406  | 511       |          0.01 | abs(result) \< tolerance | Connecticut          |
| 426  | 513       |         -0.22 | abs(result) \< tolerance | Connecticut          |
| 436  | 514       |          1.04 | abs(result) \< tolerance | Connecticut          |
| 446  | 521CI     |          0.45 | abs(result) \< tolerance | Connecticut          |
| 456  | 523       |         -0.48 | abs(result) \< tolerance | Connecticut          |
| 466  | 524       |         -0.46 | abs(result) \< tolerance | Connecticut          |
| 476  | 525       |          0.49 | abs(result) \< tolerance | Connecticut          |
| 485  | HS        |         -0.30 | abs(result) \< tolerance | Connecticut          |
| 496  | ORE       |          0.84 | abs(result) \< tolerance | Connecticut          |
| 506  | 532RL     |         -0.07 | abs(result) \< tolerance | Connecticut          |
| 5110 | 5411      |          0.34 | abs(result) \< tolerance | Connecticut          |
| 525  | 5415      |         -0.04 | abs(result) \< tolerance | Connecticut          |
| 536  | 5412OP    |          0.03 | abs(result) \< tolerance | Connecticut          |
| 546  | 55        |         -0.37 | abs(result) \< tolerance | Connecticut          |
| 556  | 561       |          0.08 | abs(result) \< tolerance | Connecticut          |
| 565  | 562       |         -0.18 | abs(result) \< tolerance | Connecticut          |
| 575  | 61        |         -0.30 | abs(result) \< tolerance | Connecticut          |
| 586  | 621       |          0.04 | abs(result) \< tolerance | Connecticut          |
| 595  | 622       |          0.15 | abs(result) \< tolerance | Connecticut          |
| 606  | 623       |         -0.35 | abs(result) \< tolerance | Connecticut          |
| 6110 | 624       |         -0.13 | abs(result) \< tolerance | Connecticut          |
| 625  | 711AS     |          0.33 | abs(result) \< tolerance | Connecticut          |
| 636  | 713       |          0.10 | abs(result) \< tolerance | Connecticut          |
| 646  | 721       |          0.18 | abs(result) \< tolerance | Connecticut          |
| 664  | 81        |          0.22 | abs(result) \< tolerance | Connecticut          |
| 676  | GFGD      |         -0.74 | abs(result) \< tolerance | Connecticut          |
| 686  | GFGN      |          1.09 | abs(result) \< tolerance | Connecticut          |
| 695  | GFE       |          1.94 | abs(result) \< tolerance | Connecticut          |
| 706  | GSLG      |         -0.15 | abs(result) \< tolerance | Connecticut          |
| 716  | GSLE      |          0.88 | abs(result) \< tolerance | Connecticut          |
| 726  | Used      |         -2.15 | abs(result) \< tolerance | Connecticut          |
| 736  | Other     |        -55.53 | abs(result) \< tolerance | Connecticut          |
| 127  | 111CA     |          0.08 | abs(result) \< tolerance | Delaware             |
| 227  | 113FF     |          0.34 | abs(result) \< tolerance | Delaware             |
| 320  | 211       |       2387.45 | abs(result) \< tolerance | Delaware             |
| 427  | 212       |          5.92 | abs(result) \< tolerance | Delaware             |
| 526  | 213       |          2.19 | abs(result) \< tolerance | Delaware             |
| 626  | 22        |         -0.09 | abs(result) \< tolerance | Delaware             |
| 710  | 23        |         -0.03 | abs(result) \< tolerance | Delaware             |
| 87   | 321       |          2.00 | abs(result) \< tolerance | Delaware             |
| 97   | 327       |          1.47 | abs(result) \< tolerance | Delaware             |
| 107  | 331       |          0.70 | abs(result) \< tolerance | Delaware             |
| 1111 | 332       |          0.79 | abs(result) \< tolerance | Delaware             |
| 128  | 333       |          0.88 | abs(result) \< tolerance | Delaware             |
| 137  | 334       |          0.02 | abs(result) \< tolerance | Delaware             |
| 147  | 335       |          0.23 | abs(result) \< tolerance | Delaware             |
| 157  | 3361MV    |         10.31 | abs(result) \< tolerance | Delaware             |
| 167  | 3364OT    |          0.38 | abs(result) \< tolerance | Delaware             |
| 177  | 337       |          1.14 | abs(result) \< tolerance | Delaware             |
| 187  | 339       |          0.30 | abs(result) \< tolerance | Delaware             |
| 197  | 311FT     |         -0.04 | abs(result) \< tolerance | Delaware             |
| 207  | 313TT     |         -0.03 | abs(result) \< tolerance | Delaware             |
| 2111 | 315AL     |          2.68 | abs(result) \< tolerance | Delaware             |
| 237  | 323       |          1.80 | abs(result) \< tolerance | Delaware             |
| 247  | 324       |         -0.32 | abs(result) \< tolerance | Delaware             |
| 257  | 325       |          0.41 | abs(result) \< tolerance | Delaware             |
| 267  | 326       |         -0.06 | abs(result) \< tolerance | Delaware             |
| 277  | 42        |          0.35 | abs(result) \< tolerance | Delaware             |
| 287  | 441       |          0.81 | abs(result) \< tolerance | Delaware             |
| 297  | 445       |         -0.05 | abs(result) \< tolerance | Delaware             |
| 307  | 452       |          0.26 | abs(result) \< tolerance | Delaware             |
| 3111 | 4A0       |          0.39 | abs(result) \< tolerance | Delaware             |
| 327  | 481       |          8.05 | abs(result) \< tolerance | Delaware             |
| 337  | 482       |         -0.31 | abs(result) \< tolerance | Delaware             |
| 347  | 483       |          7.93 | abs(result) \< tolerance | Delaware             |
| 357  | 484       |          0.41 | abs(result) \< tolerance | Delaware             |
| 367  | 485       |          0.35 | abs(result) \< tolerance | Delaware             |
| 377  | 486       |          9.28 | abs(result) \< tolerance | Delaware             |
| 387  | 487OS     |         -0.12 | abs(result) \< tolerance | Delaware             |
| 397  | 493       |         -0.47 | abs(result) \< tolerance | Delaware             |
| 407  | 511       |          0.45 | abs(result) \< tolerance | Delaware             |
| 4110 | 512       |          1.83 | abs(result) \< tolerance | Delaware             |
| 428  | 513       |          1.50 | abs(result) \< tolerance | Delaware             |
| 437  | 514       |          1.29 | abs(result) \< tolerance | Delaware             |
| 447  | 521CI     |         -0.73 | abs(result) \< tolerance | Delaware             |
| 457  | 523       |         -0.20 | abs(result) \< tolerance | Delaware             |
| 467  | 524       |         -0.53 | abs(result) \< tolerance | Delaware             |
| 477  | 525       |         -0.12 | abs(result) \< tolerance | Delaware             |
| 486  | HS        |         -0.27 | abs(result) \< tolerance | Delaware             |
| 497  | ORE       |          0.95 | abs(result) \< tolerance | Delaware             |
| 507  | 532RL     |         -0.63 | abs(result) \< tolerance | Delaware             |
| 5111 | 5411      |         -0.40 | abs(result) \< tolerance | Delaware             |
| 527  | 5415      |          0.16 | abs(result) \< tolerance | Delaware             |
| 537  | 5412OP    |          0.39 | abs(result) \< tolerance | Delaware             |
| 547  | 55        |         -0.43 | abs(result) \< tolerance | Delaware             |
| 557  | 561       |          0.18 | abs(result) \< tolerance | Delaware             |
| 566  | 562       |         -0.11 | abs(result) \< tolerance | Delaware             |
| 576  | 61        |          0.48 | abs(result) \< tolerance | Delaware             |
| 587  | 621       |          0.17 | abs(result) \< tolerance | Delaware             |
| 596  | 622       |         -0.30 | abs(result) \< tolerance | Delaware             |
| 607  | 623       |         -0.20 | abs(result) \< tolerance | Delaware             |
| 6111 | 624       |          0.03 | abs(result) \< tolerance | Delaware             |
| 627  | 711AS     |          1.63 | abs(result) \< tolerance | Delaware             |
| 637  | 713       |         -0.24 | abs(result) \< tolerance | Delaware             |
| 647  | 721       |          1.04 | abs(result) \< tolerance | Delaware             |
| 655  | 722       |          0.15 | abs(result) \< tolerance | Delaware             |
| 665  | 81        |          0.49 | abs(result) \< tolerance | Delaware             |
| 677  | GFGD      |         -0.28 | abs(result) \< tolerance | Delaware             |
| 687  | GFGN      |         -0.45 | abs(result) \< tolerance | Delaware             |
| 696  | GFE       |          1.10 | abs(result) \< tolerance | Delaware             |
| 717  | GSLE      |          0.45 | abs(result) \< tolerance | Delaware             |
| 727  | Used      |          2.09 | abs(result) \< tolerance | Delaware             |
| 737  | Other     |        -51.51 | abs(result) \< tolerance | Delaware             |
| 129  | 111CA     |        170.18 | abs(result) \< tolerance | District of Columbia |
| 228  | 113FF     |          1.36 | abs(result) \< tolerance | District of Columbia |
| 328  | 211       |        590.95 | abs(result) \< tolerance | District of Columbia |
| 429  | 212       |         60.02 | abs(result) \< tolerance | District of Columbia |
| 528  | 213       |        496.73 | abs(result) \< tolerance | District of Columbia |
| 628  | 22        |         -0.33 | abs(result) \< tolerance | District of Columbia |
| 718  | 23        |          1.28 | abs(result) \< tolerance | District of Columbia |
| 88   | 321       |         99.82 | abs(result) \< tolerance | District of Columbia |
| 98   | 327       |          2.23 | abs(result) \< tolerance | District of Columbia |
| 108  | 331       |         11.30 | abs(result) \< tolerance | District of Columbia |
| 1112 | 332       |         34.98 | abs(result) \< tolerance | District of Columbia |
| 1210 | 333       |         13.01 | abs(result) \< tolerance | District of Columbia |
| 138  | 334       |         12.14 | abs(result) \< tolerance | District of Columbia |
| 148  | 335       |         84.05 | abs(result) \< tolerance | District of Columbia |
| 158  | 3361MV    |       3515.18 | abs(result) \< tolerance | District of Columbia |
| 168  | 3364OT    |         54.33 | abs(result) \< tolerance | District of Columbia |
| 178  | 337       |          5.93 | abs(result) \< tolerance | District of Columbia |
| 188  | 339       |         24.24 | abs(result) \< tolerance | District of Columbia |
| 198  | 311FT     |          9.96 | abs(result) \< tolerance | District of Columbia |
| 208  | 313TT     |          7.83 | abs(result) \< tolerance | District of Columbia |
| 2112 | 315AL     |         17.83 | abs(result) \< tolerance | District of Columbia |
| 229  | 322       |        136.18 | abs(result) \< tolerance | District of Columbia |
| 238  | 323       |          3.90 | abs(result) \< tolerance | District of Columbia |
| 248  | 324       |        872.98 | abs(result) \< tolerance | District of Columbia |
| 258  | 325       |         52.55 | abs(result) \< tolerance | District of Columbia |
| 268  | 326       |         74.96 | abs(result) \< tolerance | District of Columbia |
| 278  | 42        |          1.55 | abs(result) \< tolerance | District of Columbia |
| 288  | 441       |          7.45 | abs(result) \< tolerance | District of Columbia |
| 298  | 445       |          0.19 | abs(result) \< tolerance | District of Columbia |
| 308  | 452       |          0.24 | abs(result) \< tolerance | District of Columbia |
| 3112 | 4A0       |          0.75 | abs(result) \< tolerance | District of Columbia |
| 329  | 481       |          6.01 | abs(result) \< tolerance | District of Columbia |
| 338  | 482       |         -0.53 | abs(result) \< tolerance | District of Columbia |
| 348  | 483       |         11.86 | abs(result) \< tolerance | District of Columbia |
| 358  | 484       |          7.29 | abs(result) \< tolerance | District of Columbia |
| 368  | 485       |          0.52 | abs(result) \< tolerance | District of Columbia |
| 378  | 486       |          3.11 | abs(result) \< tolerance | District of Columbia |
| 388  | 487OS     |          1.58 | abs(result) \< tolerance | District of Columbia |
| 398  | 493       |         37.67 | abs(result) \< tolerance | District of Columbia |
| 408  | 511       |          0.18 | abs(result) \< tolerance | District of Columbia |
| 4111 | 512       |          1.28 | abs(result) \< tolerance | District of Columbia |
| 4210 | 513       |         -0.13 | abs(result) \< tolerance | District of Columbia |
| 438  | 514       |          0.31 | abs(result) \< tolerance | District of Columbia |
| 448  | 521CI     |          0.29 | abs(result) \< tolerance | District of Columbia |
| 458  | 523       |          0.16 | abs(result) \< tolerance | District of Columbia |
| 468  | 524       |          2.01 | abs(result) \< tolerance | District of Columbia |
| 478  | 525       |         -0.66 | abs(result) \< tolerance | District of Columbia |
| 487  | HS        |         -0.53 | abs(result) \< tolerance | District of Columbia |
| 498  | ORE       |          1.28 | abs(result) \< tolerance | District of Columbia |
| 508  | 532RL     |          1.75 | abs(result) \< tolerance | District of Columbia |
| 5112 | 5411      |         -0.84 | abs(result) \< tolerance | District of Columbia |
| 529  | 5415      |          0.86 | abs(result) \< tolerance | District of Columbia |
| 538  | 5412OP    |         -0.13 | abs(result) \< tolerance | District of Columbia |
| 548  | 55        |          1.18 | abs(result) \< tolerance | District of Columbia |
| 558  | 561       |         -0.07 | abs(result) \< tolerance | District of Columbia |
| 567  | 562       |          0.82 | abs(result) \< tolerance | District of Columbia |
| 577  | 61        |         -0.53 | abs(result) \< tolerance | District of Columbia |
| 588  | 621       |          1.50 | abs(result) \< tolerance | District of Columbia |
| 597  | 622       |          0.09 | abs(result) \< tolerance | District of Columbia |
| 608  | 623       |          1.80 | abs(result) \< tolerance | District of Columbia |
| 6112 | 624       |          0.04 | abs(result) \< tolerance | District of Columbia |
| 629  | 711AS     |         -0.32 | abs(result) \< tolerance | District of Columbia |
| 638  | 713       |         -0.30 | abs(result) \< tolerance | District of Columbia |
| 648  | 721       |         -0.64 | abs(result) \< tolerance | District of Columbia |
| 656  | 722       |         -0.30 | abs(result) \< tolerance | District of Columbia |
| 666  | 81        |         -0.65 | abs(result) \< tolerance | District of Columbia |
| 678  | GFGD      |         -0.64 | abs(result) \< tolerance | District of Columbia |
| 688  | GFGN      |          0.03 | abs(result) \< tolerance | District of Columbia |
| 697  | GFE       |         -0.93 | abs(result) \< tolerance | District of Columbia |
| 707  | GSLG      |          1.04 | abs(result) \< tolerance | District of Columbia |
| 719  | GSLE      |          1.61 | abs(result) \< tolerance | District of Columbia |
| 728  | Used      |         42.07 | abs(result) \< tolerance | District of Columbia |
| 738  | Other     |         58.99 | abs(result) \< tolerance | District of Columbia |
| 130  | 111CA     |          0.07 | abs(result) \< tolerance | Florida              |
| 230  | 113FF     |         -0.28 | abs(result) \< tolerance | Florida              |
| 330  | 211       |         30.54 | abs(result) \< tolerance | Florida              |
| 430  | 212       |          0.47 | abs(result) \< tolerance | Florida              |
| 530  | 213       |          0.12 | abs(result) \< tolerance | Florida              |
| 630  | 22        |          0.14 | abs(result) \< tolerance | Florida              |
| 89   | 321       |          0.68 | abs(result) \< tolerance | Florida              |
| 99   | 327       |          0.01 | abs(result) \< tolerance | Florida              |
| 109  | 331       |         -0.03 | abs(result) \< tolerance | Florida              |
| 1113 | 332       |          0.69 | abs(result) \< tolerance | Florida              |
| 1211 | 333       |          0.34 | abs(result) \< tolerance | Florida              |
| 139  | 334       |          0.50 | abs(result) \< tolerance | Florida              |
| 149  | 335       |          1.34 | abs(result) \< tolerance | Florida              |
| 159  | 3361MV    |          4.69 | abs(result) \< tolerance | Florida              |
| 169  | 3364OT    |          0.39 | abs(result) \< tolerance | Florida              |
| 179  | 337       |          1.07 | abs(result) \< tolerance | Florida              |
| 189  | 339       |          0.26 | abs(result) \< tolerance | Florida              |
| 199  | 311FT     |          1.01 | abs(result) \< tolerance | Florida              |
| 209  | 313TT     |          0.93 | abs(result) \< tolerance | Florida              |
| 2113 | 315AL     |          1.13 | abs(result) \< tolerance | Florida              |
| 2210 | 322       |          0.48 | abs(result) \< tolerance | Florida              |
| 239  | 323       |          0.33 | abs(result) \< tolerance | Florida              |
| 249  | 324       |          2.79 | abs(result) \< tolerance | Florida              |
| 259  | 325       |          0.90 | abs(result) \< tolerance | Florida              |
| 269  | 326       |          1.26 | abs(result) \< tolerance | Florida              |
| 279  | 42        |         -0.08 | abs(result) \< tolerance | Florida              |
| 289  | 441       |          0.32 | abs(result) \< tolerance | Florida              |
| 299  | 445       |         -0.20 | abs(result) \< tolerance | Florida              |
| 309  | 452       |         -0.08 | abs(result) \< tolerance | Florida              |
| 3113 | 4A0       |          0.16 | abs(result) \< tolerance | Florida              |
| 3210 | 481       |         -0.25 | abs(result) \< tolerance | Florida              |
| 339  | 482       |          0.57 | abs(result) \< tolerance | Florida              |
| 349  | 483       |         -0.49 | abs(result) \< tolerance | Florida              |
| 359  | 484       |          0.26 | abs(result) \< tolerance | Florida              |
| 369  | 485       |          0.70 | abs(result) \< tolerance | Florida              |
| 379  | 486       |          3.75 | abs(result) \< tolerance | Florida              |
| 389  | 487OS     |         -0.14 | abs(result) \< tolerance | Florida              |
| 399  | 493       |          0.56 | abs(result) \< tolerance | Florida              |
| 409  | 511       |          0.25 | abs(result) \< tolerance | Florida              |
| 4112 | 512       |          0.79 | abs(result) \< tolerance | Florida              |
| 4211 | 513       |          0.04 | abs(result) \< tolerance | Florida              |
| 439  | 514       |          0.51 | abs(result) \< tolerance | Florida              |
| 449  | 521CI     |          1.19 | abs(result) \< tolerance | Florida              |
| 459  | 523       |          0.65 | abs(result) \< tolerance | Florida              |
| 469  | 524       |          0.08 | abs(result) \< tolerance | Florida              |
| 479  | 525       |          1.15 | abs(result) \< tolerance | Florida              |
| 488  | HS        |         -0.19 | abs(result) \< tolerance | Florida              |
| 499  | ORE       |          0.44 | abs(result) \< tolerance | Florida              |
| 509  | 532RL     |         -0.10 | abs(result) \< tolerance | Florida              |
| 5113 | 5411      |         -0.16 | abs(result) \< tolerance | Florida              |
| 5210 | 5415      |          0.14 | abs(result) \< tolerance | Florida              |
| 539  | 5412OP    |          0.04 | abs(result) \< tolerance | Florida              |
| 549  | 55        |          0.25 | abs(result) \< tolerance | Florida              |
| 559  | 561       |         -0.25 | abs(result) \< tolerance | Florida              |
| 568  | 562       |          0.14 | abs(result) \< tolerance | Florida              |
| 578  | 61        |          0.34 | abs(result) \< tolerance | Florida              |
| 589  | 621       |         -0.06 | abs(result) \< tolerance | Florida              |
| 598  | 622       |          0.18 | abs(result) \< tolerance | Florida              |
| 609  | 623       |          0.07 | abs(result) \< tolerance | Florida              |
| 6113 | 624       |          0.54 | abs(result) \< tolerance | Florida              |
| 6210 | 711AS     |          0.06 | abs(result) \< tolerance | Florida              |
| 639  | 713       |         -0.33 | abs(result) \< tolerance | Florida              |
| 649  | 721       |         -0.25 | abs(result) \< tolerance | Florida              |
| 657  | 722       |          0.03 | abs(result) \< tolerance | Florida              |
| 667  | 81        |         -0.04 | abs(result) \< tolerance | Florida              |
| 679  | GFGD      |          6.82 | abs(result) \< tolerance | Florida              |
| 689  | GFGN      |         -0.03 | abs(result) \< tolerance | Florida              |
| 698  | GFE       |          0.61 | abs(result) \< tolerance | Florida              |
| 708  | GSLG      |         -0.05 | abs(result) \< tolerance | Florida              |
| 7110 | GSLE      |         -0.32 | abs(result) \< tolerance | Florida              |
| 729  | Used      |          8.06 | abs(result) \< tolerance | Florida              |
| 739  | Other     |        -37.92 | abs(result) \< tolerance | Florida              |
| 140  | 111CA     |          0.88 | abs(result) \< tolerance | Georgia              |
| 240  | 113FF     |          0.33 | abs(result) \< tolerance | Georgia              |
| 340  | 211       |        254.39 | abs(result) \< tolerance | Georgia              |
| 440  | 212       |          0.22 | abs(result) \< tolerance | Georgia              |
| 540  | 213       |          0.10 | abs(result) \< tolerance | Georgia              |
| 640  | 22        |         -0.11 | abs(result) \< tolerance | Georgia              |
| 720  | 23        |         -0.08 | abs(result) \< tolerance | Georgia              |
| 810  | 321       |         -0.30 | abs(result) \< tolerance | Georgia              |
| 910  | 327       |         -0.23 | abs(result) \< tolerance | Georgia              |
| 1010 | 331       |          0.32 | abs(result) \< tolerance | Georgia              |
| 1114 | 332       |          0.35 | abs(result) \< tolerance | Georgia              |
| 1212 | 333       |          0.12 | abs(result) \< tolerance | Georgia              |
| 1310 | 334       |          0.76 | abs(result) \< tolerance | Georgia              |
| 1410 | 335       |         -0.21 | abs(result) \< tolerance | Georgia              |
| 1510 | 3361MV    |          0.24 | abs(result) \< tolerance | Georgia              |
| 1610 | 3364OT    |          0.25 | abs(result) \< tolerance | Georgia              |
| 1710 | 337       |         -0.17 | abs(result) \< tolerance | Georgia              |
| 1810 | 339       |          0.25 | abs(result) \< tolerance | Georgia              |
| 1910 | 311FT     |         -0.32 | abs(result) \< tolerance | Georgia              |
| 2010 | 313TT     |         -0.60 | abs(result) \< tolerance | Georgia              |
| 2114 | 315AL     |          0.28 | abs(result) \< tolerance | Georgia              |
| 2211 | 322       |         -0.27 | abs(result) \< tolerance | Georgia              |
| 2310 | 323       |         -0.14 | abs(result) \< tolerance | Georgia              |
| 2410 | 324       |          3.47 | abs(result) \< tolerance | Georgia              |
| 2510 | 325       |          0.45 | abs(result) \< tolerance | Georgia              |
| 2610 | 326       |         -0.16 | abs(result) \< tolerance | Georgia              |
| 2710 | 42        |         -0.15 | abs(result) \< tolerance | Georgia              |
| 2810 | 441       |          0.49 | abs(result) \< tolerance | Georgia              |
| 2910 | 445       |         -0.09 | abs(result) \< tolerance | Georgia              |
| 3010 | 452       |         -0.24 | abs(result) \< tolerance | Georgia              |
| 3114 | 4A0       |          0.08 | abs(result) \< tolerance | Georgia              |
| 3211 | 481       |         -0.49 | abs(result) \< tolerance | Georgia              |
| 3310 | 482       |          0.05 | abs(result) \< tolerance | Georgia              |
| 3410 | 483       |          4.13 | abs(result) \< tolerance | Georgia              |
| 3510 | 484       |          0.03 | abs(result) \< tolerance | Georgia              |
| 3610 | 485       |          1.54 | abs(result) \< tolerance | Georgia              |
| 3710 | 486       |          0.95 | abs(result) \< tolerance | Georgia              |
| 3810 | 487OS     |          0.05 | abs(result) \< tolerance | Georgia              |
| 3910 | 493       |         -0.21 | abs(result) \< tolerance | Georgia              |
| 4010 | 511       |         -0.08 | abs(result) \< tolerance | Georgia              |
| 4113 | 512       |          0.30 | abs(result) \< tolerance | Georgia              |
| 4212 | 513       |         -0.44 | abs(result) \< tolerance | Georgia              |
| 4310 | 514       |          0.34 | abs(result) \< tolerance | Georgia              |
| 4410 | 521CI     |         -0.35 | abs(result) \< tolerance | Georgia              |
| 4510 | 523       |          0.52 | abs(result) \< tolerance | Georgia              |
| 4610 | 524       |          0.18 | abs(result) \< tolerance | Georgia              |
| 4710 | 525       |         -0.05 | abs(result) \< tolerance | Georgia              |
| 489  | HS        |         -0.18 | abs(result) \< tolerance | Georgia              |
| 4910 | ORE       |          0.87 | abs(result) \< tolerance | Georgia              |
| 5010 | 532RL     |         -0.22 | abs(result) \< tolerance | Georgia              |
| 5114 | 5411      |          0.05 | abs(result) \< tolerance | Georgia              |
| 5211 | 5415      |         -0.05 | abs(result) \< tolerance | Georgia              |
| 5310 | 5412OP    |          0.03 | abs(result) \< tolerance | Georgia              |
| 5410 | 55        |          0.03 | abs(result) \< tolerance | Georgia              |
| 5510 | 561       |         -0.16 | abs(result) \< tolerance | Georgia              |
| 569  | 562       |          0.28 | abs(result) \< tolerance | Georgia              |
| 579  | 61        |          0.09 | abs(result) \< tolerance | Georgia              |
| 5810 | 621       |          0.05 | abs(result) \< tolerance | Georgia              |
| 599  | 622       |          0.06 | abs(result) \< tolerance | Georgia              |
| 6010 | 623       |          0.72 | abs(result) \< tolerance | Georgia              |
| 6114 | 624       |          0.42 | abs(result) \< tolerance | Georgia              |
| 6211 | 711AS     |          1.36 | abs(result) \< tolerance | Georgia              |
| 6310 | 713       |          0.79 | abs(result) \< tolerance | Georgia              |
| 6410 | 721       |          0.53 | abs(result) \< tolerance | Georgia              |
| 658  | 722       |          0.04 | abs(result) \< tolerance | Georgia              |
| 668  | 81        |          0.10 | abs(result) \< tolerance | Georgia              |
| 6710 | GFGD      |         -0.21 | abs(result) \< tolerance | Georgia              |
| 6810 | GFGN      |         -0.29 | abs(result) \< tolerance | Georgia              |
| 699  | GFE       |         -0.03 | abs(result) \< tolerance | Georgia              |
| 709  | GSLG      |         -0.17 | abs(result) \< tolerance | Georgia              |
| 7111 | GSLE      |         -0.12 | abs(result) \< tolerance | Georgia              |
| 7210 | Used      |          3.20 | abs(result) \< tolerance | Georgia              |
| 7310 | Other     |          2.20 | abs(result) \< tolerance | Georgia              |
| 150  | 111CA     |          0.11 | abs(result) \< tolerance | Hawaii               |
| 250  | 113FF     |         -0.66 | abs(result) \< tolerance | Hawaii               |
| 350  | 211       |        374.96 | abs(result) \< tolerance | Hawaii               |
| 450  | 212       |          1.22 | abs(result) \< tolerance | Hawaii               |
| 550  | 213       |          0.09 | abs(result) \< tolerance | Hawaii               |
| 650  | 22        |         -0.16 | abs(result) \< tolerance | Hawaii               |
| 730  | 23        |         -0.09 | abs(result) \< tolerance | Hawaii               |
| 811  | 321       |          7.76 | abs(result) \< tolerance | Hawaii               |
| 911  | 327       |          0.75 | abs(result) \< tolerance | Hawaii               |
| 1011 | 331       |         12.14 | abs(result) \< tolerance | Hawaii               |
| 1115 | 332       |          9.15 | abs(result) \< tolerance | Hawaii               |
| 1213 | 333       |          6.67 | abs(result) \< tolerance | Hawaii               |
| 1311 | 334       |          9.43 | abs(result) \< tolerance | Hawaii               |
| 1411 | 335       |         21.25 | abs(result) \< tolerance | Hawaii               |
| 1511 | 3361MV    |         46.04 | abs(result) \< tolerance | Hawaii               |
| 1611 | 3364OT    |          3.38 | abs(result) \< tolerance | Hawaii               |
| 1711 | 337       |          4.44 | abs(result) \< tolerance | Hawaii               |
| 1811 | 339       |          1.85 | abs(result) \< tolerance | Hawaii               |
| 1911 | 311FT     |          1.20 | abs(result) \< tolerance | Hawaii               |
| 2011 | 313TT     |          1.85 | abs(result) \< tolerance | Hawaii               |
| 2115 | 315AL     |          0.79 | abs(result) \< tolerance | Hawaii               |
| 2212 | 322       |          8.55 | abs(result) \< tolerance | Hawaii               |
| 2311 | 323       |          1.06 | abs(result) \< tolerance | Hawaii               |
| 2411 | 324       |         -0.03 | abs(result) \< tolerance | Hawaii               |
| 2511 | 325       |          3.49 | abs(result) \< tolerance | Hawaii               |
| 2611 | 326       |          5.98 | abs(result) \< tolerance | Hawaii               |
| 2711 | 42        |          0.45 | abs(result) \< tolerance | Hawaii               |
| 2811 | 441       |          0.44 | abs(result) \< tolerance | Hawaii               |
| 2911 | 445       |         -0.20 | abs(result) \< tolerance | Hawaii               |
| 3011 | 452       |         -0.38 | abs(result) \< tolerance | Hawaii               |
| 3115 | 4A0       |         -0.21 | abs(result) \< tolerance | Hawaii               |
| 3212 | 481       |         -0.63 | abs(result) \< tolerance | Hawaii               |
| 3311 | 482       |        349.37 | abs(result) \< tolerance | Hawaii               |
| 3411 | 483       |         -0.50 | abs(result) \< tolerance | Hawaii               |
| 3511 | 484       |          0.68 | abs(result) \< tolerance | Hawaii               |
| 3611 | 485       |         -0.24 | abs(result) \< tolerance | Hawaii               |
| 3711 | 486       |         10.74 | abs(result) \< tolerance | Hawaii               |
| 3811 | 487OS     |         -0.14 | abs(result) \< tolerance | Hawaii               |
| 3911 | 493       |          4.06 | abs(result) \< tolerance | Hawaii               |
| 4011 | 511       |          1.42 | abs(result) \< tolerance | Hawaii               |
| 4114 | 512       |          0.25 | abs(result) \< tolerance | Hawaii               |
| 4213 | 513       |          0.43 | abs(result) \< tolerance | Hawaii               |
| 4311 | 514       |          4.38 | abs(result) \< tolerance | Hawaii               |
| 4411 | 521CI     |          1.36 | abs(result) \< tolerance | Hawaii               |
| 4511 | 523       |          3.10 | abs(result) \< tolerance | Hawaii               |
| 4611 | 524       |          0.40 | abs(result) \< tolerance | Hawaii               |
| 4711 | 525       |          1.38 | abs(result) \< tolerance | Hawaii               |
| 4810 | HS        |         -0.31 | abs(result) \< tolerance | Hawaii               |
| 4911 | ORE       |          0.26 | abs(result) \< tolerance | Hawaii               |
| 5011 | 532RL     |         -0.26 | abs(result) \< tolerance | Hawaii               |
| 5115 | 5411      |          0.34 | abs(result) \< tolerance | Hawaii               |
| 5212 | 5415      |          0.62 | abs(result) \< tolerance | Hawaii               |
| 5311 | 5412OP    |          0.43 | abs(result) \< tolerance | Hawaii               |
| 5411 | 55        |          0.40 | abs(result) \< tolerance | Hawaii               |
| 5511 | 561       |         -0.20 | abs(result) \< tolerance | Hawaii               |
| 5610 | 562       |          0.03 | abs(result) \< tolerance | Hawaii               |
| 5710 | 61        |          0.08 | abs(result) \< tolerance | Hawaii               |
| 5811 | 621       |          0.02 | abs(result) \< tolerance | Hawaii               |
| 5910 | 622       |          0.07 | abs(result) \< tolerance | Hawaii               |
| 6011 | 623       |          0.45 | abs(result) \< tolerance | Hawaii               |
| 6115 | 624       |         -0.14 | abs(result) \< tolerance | Hawaii               |
| 6212 | 711AS     |          0.10 | abs(result) \< tolerance | Hawaii               |
| 6311 | 713       |         -0.46 | abs(result) \< tolerance | Hawaii               |
| 6411 | 721       |         -0.80 | abs(result) \< tolerance | Hawaii               |
| 659  | 722       |         -0.35 | abs(result) \< tolerance | Hawaii               |
| 669  | 81        |         -0.02 | abs(result) \< tolerance | Hawaii               |
| 6711 | GFGD      |         -0.17 | abs(result) \< tolerance | Hawaii               |
| 6811 | GFGN      |         -0.33 | abs(result) \< tolerance | Hawaii               |
| 6910 | GFE       |         -0.53 | abs(result) \< tolerance | Hawaii               |
| 7010 | GSLG      |         -0.11 | abs(result) \< tolerance | Hawaii               |
| 7112 | GSLE      |          0.89 | abs(result) \< tolerance | Hawaii               |
| 7211 | Used      |          2.13 | abs(result) \< tolerance | Hawaii               |
| 7311 | Other     |         35.06 | abs(result) \< tolerance | Hawaii               |
| 160  | 111CA     |         -0.63 | abs(result) \< tolerance | Idaho                |
| 260  | 113FF     |         -0.03 | abs(result) \< tolerance | Idaho                |
| 360  | 211       |          3.66 | abs(result) \< tolerance | Idaho                |
| 460  | 212       |         -0.45 | abs(result) \< tolerance | Idaho                |
| 560  | 213       |         -0.02 | abs(result) \< tolerance | Idaho                |
| 660  | 22        |         -0.02 | abs(result) \< tolerance | Idaho                |
| 740  | 23        |         -0.16 | abs(result) \< tolerance | Idaho                |
| 812  | 321       |         -0.63 | abs(result) \< tolerance | Idaho                |
| 912  | 327       |          0.42 | abs(result) \< tolerance | Idaho                |
| 1012 | 331       |         -0.01 | abs(result) \< tolerance | Idaho                |
| 1116 | 332       |         -0.01 | abs(result) \< tolerance | Idaho                |
| 1214 | 333       |          0.21 | abs(result) \< tolerance | Idaho                |
| 1312 | 334       |         -0.03 | abs(result) \< tolerance | Idaho                |
| 1412 | 335       |          0.12 | abs(result) \< tolerance | Idaho                |
| 1512 | 3361MV    |          1.96 | abs(result) \< tolerance | Idaho                |
| 1612 | 3364OT    |          0.11 | abs(result) \< tolerance | Idaho                |
| 1712 | 337       |          0.19 | abs(result) \< tolerance | Idaho                |
| 1812 | 339       |          0.32 | abs(result) \< tolerance | Idaho                |
| 1912 | 311FT     |         -0.14 | abs(result) \< tolerance | Idaho                |
| 2012 | 313TT     |          1.35 | abs(result) \< tolerance | Idaho                |
| 2116 | 315AL     |          0.73 | abs(result) \< tolerance | Idaho                |
| 2213 | 322       |         -0.09 | abs(result) \< tolerance | Idaho                |
| 2312 | 323       |         -0.09 | abs(result) \< tolerance | Idaho                |
| 2412 | 324       |          8.67 | abs(result) \< tolerance | Idaho                |
| 2512 | 325       |          1.77 | abs(result) \< tolerance | Idaho                |
| 2612 | 326       |          0.32 | abs(result) \< tolerance | Idaho                |
| 2712 | 42        |          0.14 | abs(result) \< tolerance | Idaho                |
| 2812 | 441       |          0.19 | abs(result) \< tolerance | Idaho                |
| 2912 | 445       |          0.04 | abs(result) \< tolerance | Idaho                |
| 3012 | 452       |         -0.32 | abs(result) \< tolerance | Idaho                |
| 3116 | 4A0       |         -0.17 | abs(result) \< tolerance | Idaho                |
| 3213 | 481       |          0.88 | abs(result) \< tolerance | Idaho                |
| 3312 | 482       |         -0.35 | abs(result) \< tolerance | Idaho                |
| 3412 | 483       |          4.56 | abs(result) \< tolerance | Idaho                |
| 3512 | 484       |         -0.22 | abs(result) \< tolerance | Idaho                |
| 3612 | 485       |          0.57 | abs(result) \< tolerance | Idaho                |
| 3712 | 486       |          2.51 | abs(result) \< tolerance | Idaho                |
| 3812 | 487OS     |          0.40 | abs(result) \< tolerance | Idaho                |
| 3912 | 493       |          1.43 | abs(result) \< tolerance | Idaho                |
| 4012 | 511       |          0.52 | abs(result) \< tolerance | Idaho                |
| 4115 | 512       |          1.95 | abs(result) \< tolerance | Idaho                |
| 4214 | 513       |          0.60 | abs(result) \< tolerance | Idaho                |
| 4312 | 514       |          0.74 | abs(result) \< tolerance | Idaho                |
| 4412 | 521CI     |          0.56 | abs(result) \< tolerance | Idaho                |
| 4512 | 523       |          1.99 | abs(result) \< tolerance | Idaho                |
| 4612 | 524       |          0.46 | abs(result) \< tolerance | Idaho                |
| 4712 | 525       |         -0.06 | abs(result) \< tolerance | Idaho                |
| 4811 | HS        |         -0.16 | abs(result) \< tolerance | Idaho                |
| 4912 | ORE       |          0.81 | abs(result) \< tolerance | Idaho                |
| 5012 | 532RL     |          0.59 | abs(result) \< tolerance | Idaho                |
| 5116 | 5411      |          1.06 | abs(result) \< tolerance | Idaho                |
| 5213 | 5415      |          0.26 | abs(result) \< tolerance | Idaho                |
| 5312 | 5412OP    |         -0.02 | abs(result) \< tolerance | Idaho                |
| 5412 | 55        |          1.20 | abs(result) \< tolerance | Idaho                |
| 5512 | 561       |         -0.14 | abs(result) \< tolerance | Idaho                |
| 5611 | 562       |         -0.46 | abs(result) \< tolerance | Idaho                |
| 5711 | 61        |          0.15 | abs(result) \< tolerance | Idaho                |
| 5812 | 621       |         -0.14 | abs(result) \< tolerance | Idaho                |
| 5911 | 622       |         -0.39 | abs(result) \< tolerance | Idaho                |
| 6012 | 623       |         -0.14 | abs(result) \< tolerance | Idaho                |
| 6116 | 624       |         -0.10 | abs(result) \< tolerance | Idaho                |
| 6213 | 711AS     |          1.00 | abs(result) \< tolerance | Idaho                |
| 6312 | 713       |         -0.15 | abs(result) \< tolerance | Idaho                |
| 6412 | 721       |          0.05 | abs(result) \< tolerance | Idaho                |
| 6510 | 722       |          0.04 | abs(result) \< tolerance | Idaho                |
| 6610 | 81        |         -0.05 | abs(result) \< tolerance | Idaho                |
| 6712 | GFGD      |         -0.22 | abs(result) \< tolerance | Idaho                |
| 6812 | GFGN      |         -0.15 | abs(result) \< tolerance | Idaho                |
| 6911 | GFE       |         -0.16 | abs(result) \< tolerance | Idaho                |
| 7011 | GSLG      |         -0.15 | abs(result) \< tolerance | Idaho                |
| 7113 | GSLE      |         -0.24 | abs(result) \< tolerance | Idaho                |
| 7212 | Used      |         -2.22 | abs(result) \< tolerance | Idaho                |
| 7312 | Other     |         -7.14 | abs(result) \< tolerance | Idaho                |
| 170  | 111CA     |          0.18 | abs(result) \< tolerance | Illinois             |
| 270  | 113FF     |          0.70 | abs(result) \< tolerance | Illinois             |
| 370  | 211       |         38.59 | abs(result) \< tolerance | Illinois             |
| 470  | 212       |          0.02 | abs(result) \< tolerance | Illinois             |
| 570  | 213       |          0.10 | abs(result) \< tolerance | Illinois             |
| 741  | 23        |          0.04 | abs(result) \< tolerance | Illinois             |
| 813  | 321       |          1.29 | abs(result) \< tolerance | Illinois             |
| 913  | 327       |          0.04 | abs(result) \< tolerance | Illinois             |
| 1013 | 331       |          0.23 | abs(result) \< tolerance | Illinois             |
| 1117 | 332       |         -0.27 | abs(result) \< tolerance | Illinois             |
| 1215 | 333       |         -0.19 | abs(result) \< tolerance | Illinois             |
| 1313 | 334       |          0.43 | abs(result) \< tolerance | Illinois             |
| 1413 | 335       |         -0.12 | abs(result) \< tolerance | Illinois             |
| 1513 | 3361MV    |          0.19 | abs(result) \< tolerance | Illinois             |
| 1613 | 3364OT    |          0.68 | abs(result) \< tolerance | Illinois             |
| 1713 | 337       |         -0.06 | abs(result) \< tolerance | Illinois             |
| 1813 | 339       |         -0.25 | abs(result) \< tolerance | Illinois             |
| 1913 | 311FT     |         -0.18 | abs(result) \< tolerance | Illinois             |
| 2013 | 313TT     |          0.98 | abs(result) \< tolerance | Illinois             |
| 2117 | 315AL     |          0.36 | abs(result) \< tolerance | Illinois             |
| 2214 | 322       |          0.20 | abs(result) \< tolerance | Illinois             |
| 2313 | 323       |         -0.34 | abs(result) \< tolerance | Illinois             |
| 2413 | 324       |         -0.20 | abs(result) \< tolerance | Illinois             |
| 2513 | 325       |         -0.23 | abs(result) \< tolerance | Illinois             |
| 2613 | 326       |         -0.32 | abs(result) \< tolerance | Illinois             |
| 2713 | 42        |         -0.17 | abs(result) \< tolerance | Illinois             |
| 2813 | 441       |          0.52 | abs(result) \< tolerance | Illinois             |
| 2913 | 445       |         -0.26 | abs(result) \< tolerance | Illinois             |
| 3013 | 452       |         -0.20 | abs(result) \< tolerance | Illinois             |
| 3117 | 4A0       |          0.11 | abs(result) \< tolerance | Illinois             |
| 3214 | 481       |         -0.25 | abs(result) \< tolerance | Illinois             |
| 3313 | 482       |         -0.24 | abs(result) \< tolerance | Illinois             |
| 3413 | 483       |          0.52 | abs(result) \< tolerance | Illinois             |
| 3513 | 484       |         -0.11 | abs(result) \< tolerance | Illinois             |
| 3713 | 486       |          2.36 | abs(result) \< tolerance | Illinois             |
| 3813 | 487OS     |          0.12 | abs(result) \< tolerance | Illinois             |
| 3913 | 493       |         -0.20 | abs(result) \< tolerance | Illinois             |
| 4013 | 511       |          0.03 | abs(result) \< tolerance | Illinois             |
| 4116 | 512       |          0.79 | abs(result) \< tolerance | Illinois             |
| 4215 | 513       |          0.35 | abs(result) \< tolerance | Illinois             |
| 4313 | 514       |          0.21 | abs(result) \< tolerance | Illinois             |
| 4513 | 523       |         -0.15 | abs(result) \< tolerance | Illinois             |
| 4613 | 524       |         -0.26 | abs(result) \< tolerance | Illinois             |
| 4713 | 525       |          0.17 | abs(result) \< tolerance | Illinois             |
| 4812 | HS        |         -0.29 | abs(result) \< tolerance | Illinois             |
| 4913 | ORE       |          0.82 | abs(result) \< tolerance | Illinois             |
| 5013 | 532RL     |         -0.10 | abs(result) \< tolerance | Illinois             |
| 5117 | 5411      |         -0.30 | abs(result) \< tolerance | Illinois             |
| 5214 | 5415      |         -0.06 | abs(result) \< tolerance | Illinois             |
| 5313 | 5412OP    |         -0.03 | abs(result) \< tolerance | Illinois             |
| 5513 | 561       |         -0.11 | abs(result) \< tolerance | Illinois             |
| 5612 | 562       |         -0.08 | abs(result) \< tolerance | Illinois             |
| 5712 | 61        |         -0.06 | abs(result) \< tolerance | Illinois             |
| 5813 | 621       |          0.27 | abs(result) \< tolerance | Illinois             |
| 5912 | 622       |         -0.05 | abs(result) \< tolerance | Illinois             |
| 6013 | 623       |          0.04 | abs(result) \< tolerance | Illinois             |
| 6117 | 624       |          0.21 | abs(result) \< tolerance | Illinois             |
| 6214 | 711AS     |         -0.03 | abs(result) \< tolerance | Illinois             |
| 6313 | 713       |         -0.14 | abs(result) \< tolerance | Illinois             |
| 6413 | 721       |         -0.05 | abs(result) \< tolerance | Illinois             |
| 6511 | 722       |         -0.06 | abs(result) \< tolerance | Illinois             |
| 6611 | 81        |          0.02 | abs(result) \< tolerance | Illinois             |
| 6713 | GFGD      |         -0.30 | abs(result) \< tolerance | Illinois             |
| 6813 | GFGN      |          0.09 | abs(result) \< tolerance | Illinois             |
| 6912 | GFE       |          0.87 | abs(result) \< tolerance | Illinois             |
| 7012 | GSLG      |         -0.09 | abs(result) \< tolerance | Illinois             |
| 7114 | GSLE      |          1.12 | abs(result) \< tolerance | Illinois             |
| 7213 | Used      |          0.71 | abs(result) \< tolerance | Illinois             |
| 7313 | Other     |        -23.55 | abs(result) \< tolerance | Illinois             |
| 180  | 111CA     |         -0.11 | abs(result) \< tolerance | Indiana              |
| 280  | 113FF     |          0.48 | abs(result) \< tolerance | Indiana              |
| 380  | 211       |         49.41 | abs(result) \< tolerance | Indiana              |
| 480  | 212       |          0.37 | abs(result) \< tolerance | Indiana              |
| 580  | 213       |          0.05 | abs(result) \< tolerance | Indiana              |
| 670  | 22        |          0.03 | abs(result) \< tolerance | Indiana              |
| 742  | 23        |         -0.10 | abs(result) \< tolerance | Indiana              |
| 814  | 321       |         -0.15 | abs(result) \< tolerance | Indiana              |
| 914  | 327       |         -0.10 | abs(result) \< tolerance | Indiana              |
| 1014 | 331       |         -0.56 | abs(result) \< tolerance | Indiana              |
| 1118 | 332       |         -0.15 | abs(result) \< tolerance | Indiana              |
| 1216 | 333       |         -0.08 | abs(result) \< tolerance | Indiana              |
| 1314 | 334       |          0.54 | abs(result) \< tolerance | Indiana              |
| 1414 | 335       |          0.46 | abs(result) \< tolerance | Indiana              |
| 1514 | 3361MV    |         -0.35 | abs(result) \< tolerance | Indiana              |
| 1714 | 337       |         -0.53 | abs(result) \< tolerance | Indiana              |
| 1814 | 339       |         -0.33 | abs(result) \< tolerance | Indiana              |
| 1914 | 311FT     |         -0.19 | abs(result) \< tolerance | Indiana              |
| 2014 | 313TT     |          0.80 | abs(result) \< tolerance | Indiana              |
| 2118 | 315AL     |          0.44 | abs(result) \< tolerance | Indiana              |
| 2215 | 322       |          0.25 | abs(result) \< tolerance | Indiana              |
| 2314 | 323       |         -0.44 | abs(result) \< tolerance | Indiana              |
| 2414 | 324       |         -0.42 | abs(result) \< tolerance | Indiana              |
| 2514 | 325       |         -0.41 | abs(result) \< tolerance | Indiana              |
| 2614 | 326       |         -0.24 | abs(result) \< tolerance | Indiana              |
| 2714 | 42        |          0.48 | abs(result) \< tolerance | Indiana              |
| 2814 | 441       |          0.64 | abs(result) \< tolerance | Indiana              |
| 2914 | 445       |          0.14 | abs(result) \< tolerance | Indiana              |
| 3014 | 452       |         -0.29 | abs(result) \< tolerance | Indiana              |
| 3118 | 4A0       |          0.01 | abs(result) \< tolerance | Indiana              |
| 3215 | 481       |          2.01 | abs(result) \< tolerance | Indiana              |
| 3314 | 482       |          0.09 | abs(result) \< tolerance | Indiana              |
| 3414 | 483       |         -0.03 | abs(result) \< tolerance | Indiana              |
| 3514 | 484       |         -0.18 | abs(result) \< tolerance | Indiana              |
| 3613 | 485       |          0.74 | abs(result) \< tolerance | Indiana              |
| 3714 | 486       |          2.28 | abs(result) \< tolerance | Indiana              |
| 3814 | 487OS     |          0.12 | abs(result) \< tolerance | Indiana              |
| 3914 | 493       |         -0.38 | abs(result) \< tolerance | Indiana              |
| 4014 | 511       |          0.24 | abs(result) \< tolerance | Indiana              |
| 4117 | 512       |          1.19 | abs(result) \< tolerance | Indiana              |
| 4216 | 513       |          0.56 | abs(result) \< tolerance | Indiana              |
| 4314 | 514       |          2.01 | abs(result) \< tolerance | Indiana              |
| 4413 | 521CI     |          0.95 | abs(result) \< tolerance | Indiana              |
| 4514 | 523       |          1.43 | abs(result) \< tolerance | Indiana              |
| 4614 | 524       |         -0.24 | abs(result) \< tolerance | Indiana              |
| 4714 | 525       |         -0.12 | abs(result) \< tolerance | Indiana              |
| 4813 | HS        |         -0.06 | abs(result) \< tolerance | Indiana              |
| 4914 | ORE       |          1.10 | abs(result) \< tolerance | Indiana              |
| 5014 | 532RL     |          0.59 | abs(result) \< tolerance | Indiana              |
| 5118 | 5411      |          0.65 | abs(result) \< tolerance | Indiana              |
| 5215 | 5415      |          0.13 | abs(result) \< tolerance | Indiana              |
| 5314 | 5412OP    |          0.21 | abs(result) \< tolerance | Indiana              |
| 5413 | 55        |          0.77 | abs(result) \< tolerance | Indiana              |
| 5514 | 561       |         -0.03 | abs(result) \< tolerance | Indiana              |
| 5613 | 562       |         -0.19 | abs(result) \< tolerance | Indiana              |
| 5713 | 61        |         -0.05 | abs(result) \< tolerance | Indiana              |
| 5814 | 621       |         -0.27 | abs(result) \< tolerance | Indiana              |
| 5913 | 622       |         -0.26 | abs(result) \< tolerance | Indiana              |
| 6014 | 623       |         -0.36 | abs(result) \< tolerance | Indiana              |
| 6118 | 624       |         -0.10 | abs(result) \< tolerance | Indiana              |
| 6215 | 711AS     |         -0.09 | abs(result) \< tolerance | Indiana              |
| 6314 | 713       |         -0.35 | abs(result) \< tolerance | Indiana              |
| 6414 | 721       |          0.35 | abs(result) \< tolerance | Indiana              |
| 6512 | 722       |         -0.01 | abs(result) \< tolerance | Indiana              |
| 6612 | 81        |         -0.13 | abs(result) \< tolerance | Indiana              |
| 6714 | GFGD      |         -0.45 | abs(result) \< tolerance | Indiana              |
| 6814 | GFGN      |         -0.11 | abs(result) \< tolerance | Indiana              |
| 6913 | GFE       |          0.56 | abs(result) \< tolerance | Indiana              |
| 7013 | GSLG      |          0.04 | abs(result) \< tolerance | Indiana              |
| 7115 | GSLE      |          0.85 | abs(result) \< tolerance | Indiana              |
| 7214 | Used      |         -5.66 | abs(result) \< tolerance | Indiana              |
| 7314 | Other     |        -49.93 | abs(result) \< tolerance | Indiana              |
| 190  | 111CA     |         -0.48 | abs(result) \< tolerance | Iowa                 |
| 290  | 113FF     |          0.68 | abs(result) \< tolerance | Iowa                 |
| 390  | 211       |        631.78 | abs(result) \< tolerance | Iowa                 |
| 490  | 212       |          0.69 | abs(result) \< tolerance | Iowa                 |
| 590  | 213       |          0.16 | abs(result) \< tolerance | Iowa                 |
| 680  | 22        |         -0.06 | abs(result) \< tolerance | Iowa                 |
| 743  | 23        |         -0.08 | abs(result) \< tolerance | Iowa                 |
| 815  | 321       |         -0.42 | abs(result) \< tolerance | Iowa                 |
| 915  | 327       |         -0.40 | abs(result) \< tolerance | Iowa                 |
| 1015 | 331       |         -0.13 | abs(result) \< tolerance | Iowa                 |
| 1119 | 332       |         -0.03 | abs(result) \< tolerance | Iowa                 |
| 1217 | 333       |         -0.30 | abs(result) \< tolerance | Iowa                 |
| 1315 | 334       |          0.02 | abs(result) \< tolerance | Iowa                 |
| 1415 | 335       |         -0.21 | abs(result) \< tolerance | Iowa                 |
| 1515 | 3361MV    |          0.27 | abs(result) \< tolerance | Iowa                 |
| 1715 | 337       |         -0.48 | abs(result) \< tolerance | Iowa                 |
| 1815 | 339       |          0.20 | abs(result) \< tolerance | Iowa                 |
| 1915 | 311FT     |         -0.41 | abs(result) \< tolerance | Iowa                 |
| 2015 | 313TT     |          0.50 | abs(result) \< tolerance | Iowa                 |
| 2119 | 315AL     |          0.21 | abs(result) \< tolerance | Iowa                 |
| 2216 | 322       |         -0.05 | abs(result) \< tolerance | Iowa                 |
| 2315 | 323       |         -0.32 | abs(result) \< tolerance | Iowa                 |
| 2415 | 324       |          4.37 | abs(result) \< tolerance | Iowa                 |
| 2515 | 325       |         -0.17 | abs(result) \< tolerance | Iowa                 |
| 2615 | 326       |         -0.16 | abs(result) \< tolerance | Iowa                 |
| 2715 | 42        |          0.20 | abs(result) \< tolerance | Iowa                 |
| 2815 | 441       |          0.92 | abs(result) \< tolerance | Iowa                 |
| 2915 | 445       |         -0.25 | abs(result) \< tolerance | Iowa                 |
| 3015 | 452       |         -0.24 | abs(result) \< tolerance | Iowa                 |
| 3119 | 4A0       |         -0.04 | abs(result) \< tolerance | Iowa                 |
| 3216 | 481       |          6.82 | abs(result) \< tolerance | Iowa                 |
| 3315 | 482       |         -0.31 | abs(result) \< tolerance | Iowa                 |
| 3415 | 483       |          3.20 | abs(result) \< tolerance | Iowa                 |
| 3515 | 484       |         -0.27 | abs(result) \< tolerance | Iowa                 |
| 3614 | 485       |          0.96 | abs(result) \< tolerance | Iowa                 |
| 3715 | 486       |          0.84 | abs(result) \< tolerance | Iowa                 |
| 3815 | 487OS     |          0.47 | abs(result) \< tolerance | Iowa                 |
| 3915 | 493       |         -0.26 | abs(result) \< tolerance | Iowa                 |
| 4015 | 511       |         -0.02 | abs(result) \< tolerance | Iowa                 |
| 4118 | 512       |          1.20 | abs(result) \< tolerance | Iowa                 |
| 4217 | 513       |          0.58 | abs(result) \< tolerance | Iowa                 |
| 4315 | 514       |          0.76 | abs(result) \< tolerance | Iowa                 |
| 4414 | 521CI     |         -0.22 | abs(result) \< tolerance | Iowa                 |
| 4515 | 523       |          1.03 | abs(result) \< tolerance | Iowa                 |
| 4615 | 524       |         -0.53 | abs(result) \< tolerance | Iowa                 |
| 4715 | 525       |          1.09 | abs(result) \< tolerance | Iowa                 |
| 4814 | HS        |         -0.16 | abs(result) \< tolerance | Iowa                 |
| 4915 | ORE       |          1.30 | abs(result) \< tolerance | Iowa                 |
| 5015 | 532RL     |          0.25 | abs(result) \< tolerance | Iowa                 |
| 5119 | 5411      |          1.02 | abs(result) \< tolerance | Iowa                 |
| 5216 | 5415      |          0.22 | abs(result) \< tolerance | Iowa                 |
| 5315 | 5412OP    |          0.45 | abs(result) \< tolerance | Iowa                 |
| 5414 | 55        |          0.58 | abs(result) \< tolerance | Iowa                 |
| 5515 | 561       |          0.23 | abs(result) \< tolerance | Iowa                 |
| 5714 | 61        |         -0.03 | abs(result) \< tolerance | Iowa                 |
| 5815 | 621       |         -0.04 | abs(result) \< tolerance | Iowa                 |
| 5914 | 622       |          0.03 | abs(result) \< tolerance | Iowa                 |
| 6015 | 623       |         -0.45 | abs(result) \< tolerance | Iowa                 |
| 6119 | 624       |         -0.14 | abs(result) \< tolerance | Iowa                 |
| 6216 | 711AS     |          0.64 | abs(result) \< tolerance | Iowa                 |
| 6315 | 713       |         -0.19 | abs(result) \< tolerance | Iowa                 |
| 6415 | 721       |         -0.04 | abs(result) \< tolerance | Iowa                 |
| 6513 | 722       |          0.08 | abs(result) \< tolerance | Iowa                 |
| 6613 | 81        |         -0.04 | abs(result) \< tolerance | Iowa                 |
| 6715 | GFGD      |         -0.59 | abs(result) \< tolerance | Iowa                 |
| 6914 | GFE       |          0.84 | abs(result) \< tolerance | Iowa                 |
| 7014 | GSLG      |         -0.15 | abs(result) \< tolerance | Iowa                 |
| 7116 | GSLE      |          0.46 | abs(result) \< tolerance | Iowa                 |
| 7215 | Used      |         -0.87 | abs(result) \< tolerance | Iowa                 |
| 7315 | Other     |        -64.95 | abs(result) \< tolerance | Iowa                 |
| 1100 | 111CA     |         -0.43 | abs(result) \< tolerance | Kansas               |
| 2100 | 113FF     |          0.30 | abs(result) \< tolerance | Kansas               |
| 3100 | 211       |          2.01 | abs(result) \< tolerance | Kansas               |
| 4100 | 212       |          0.78 | abs(result) \< tolerance | Kansas               |
| 5100 | 213       |         -0.03 | abs(result) \< tolerance | Kansas               |
| 690  | 22        |         -0.11 | abs(result) \< tolerance | Kansas               |
| 744  | 23        |          0.04 | abs(result) \< tolerance | Kansas               |
| 816  | 321       |          0.50 | abs(result) \< tolerance | Kansas               |
| 916  | 327       |         -0.22 | abs(result) \< tolerance | Kansas               |
| 1016 | 331       |          2.42 | abs(result) \< tolerance | Kansas               |
| 1218 | 333       |         -0.16 | abs(result) \< tolerance | Kansas               |
| 1316 | 334       |          0.88 | abs(result) \< tolerance | Kansas               |
| 1416 | 335       |         -0.07 | abs(result) \< tolerance | Kansas               |
| 1516 | 3361MV    |         -0.07 | abs(result) \< tolerance | Kansas               |
| 1614 | 3364OT    |         -0.52 | abs(result) \< tolerance | Kansas               |
| 1816 | 339       |          0.12 | abs(result) \< tolerance | Kansas               |
| 1916 | 311FT     |         -0.20 | abs(result) \< tolerance | Kansas               |
| 2016 | 313TT     |          0.47 | abs(result) \< tolerance | Kansas               |
| 2120 | 315AL     |          0.46 | abs(result) \< tolerance | Kansas               |
| 2217 | 322       |          0.81 | abs(result) \< tolerance | Kansas               |
| 2316 | 323       |         -0.61 | abs(result) \< tolerance | Kansas               |
| 2416 | 324       |         -0.55 | abs(result) \< tolerance | Kansas               |
| 2516 | 325       |          0.19 | abs(result) \< tolerance | Kansas               |
| 2616 | 326       |         -0.23 | abs(result) \< tolerance | Kansas               |
| 2716 | 42        |          0.06 | abs(result) \< tolerance | Kansas               |
| 2816 | 441       |          0.52 | abs(result) \< tolerance | Kansas               |
| 2916 | 445       |         -0.16 | abs(result) \< tolerance | Kansas               |
| 3016 | 452       |         -0.33 | abs(result) \< tolerance | Kansas               |
| 3120 | 4A0       |         -0.14 | abs(result) \< tolerance | Kansas               |
| 3217 | 481       |         10.25 | abs(result) \< tolerance | Kansas               |
| 3316 | 482       |         -0.59 | abs(result) \< tolerance | Kansas               |
| 3416 | 483       |         14.22 | abs(result) \< tolerance | Kansas               |
| 3516 | 484       |         -0.14 | abs(result) \< tolerance | Kansas               |
| 3615 | 485       |          0.70 | abs(result) \< tolerance | Kansas               |
| 3716 | 486       |         -0.39 | abs(result) \< tolerance | Kansas               |
| 3816 | 487OS     |         -0.04 | abs(result) \< tolerance | Kansas               |
| 3916 | 493       |         -0.14 | abs(result) \< tolerance | Kansas               |
| 4016 | 511       |          0.28 | abs(result) \< tolerance | Kansas               |
| 4119 | 512       |          2.52 | abs(result) \< tolerance | Kansas               |
| 4316 | 514       |          2.00 | abs(result) \< tolerance | Kansas               |
| 4415 | 521CI     |          0.74 | abs(result) \< tolerance | Kansas               |
| 4516 | 523       |          1.54 | abs(result) \< tolerance | Kansas               |
| 4616 | 524       |         -0.06 | abs(result) \< tolerance | Kansas               |
| 4716 | 525       |         -0.50 | abs(result) \< tolerance | Kansas               |
| 4815 | HS        |         -0.12 | abs(result) \< tolerance | Kansas               |
| 4916 | ORE       |          1.23 | abs(result) \< tolerance | Kansas               |
| 5016 | 532RL     |         -0.51 | abs(result) \< tolerance | Kansas               |
| 5120 | 5411      |          1.19 | abs(result) \< tolerance | Kansas               |
| 5316 | 5412OP    |          0.06 | abs(result) \< tolerance | Kansas               |
| 5415 | 55        |         -0.04 | abs(result) \< tolerance | Kansas               |
| 5516 | 561       |         -0.04 | abs(result) \< tolerance | Kansas               |
| 5614 | 562       |          0.26 | abs(result) \< tolerance | Kansas               |
| 5715 | 61        |          0.63 | abs(result) \< tolerance | Kansas               |
| 5816 | 621       |          0.23 | abs(result) \< tolerance | Kansas               |
| 5915 | 622       |          0.05 | abs(result) \< tolerance | Kansas               |
| 6016 | 623       |         -0.10 | abs(result) \< tolerance | Kansas               |
| 6120 | 624       |          0.12 | abs(result) \< tolerance | Kansas               |
| 6217 | 711AS     |          3.58 | abs(result) \< tolerance | Kansas               |
| 6316 | 713       |         -0.06 | abs(result) \< tolerance | Kansas               |
| 6416 | 721       |          0.79 | abs(result) \< tolerance | Kansas               |
| 6514 | 722       |         -0.09 | abs(result) \< tolerance | Kansas               |
| 6614 | 81        |          0.13 | abs(result) \< tolerance | Kansas               |
| 6716 | GFGD      |         -0.18 | abs(result) \< tolerance | Kansas               |
| 6815 | GFGN      |         -0.04 | abs(result) \< tolerance | Kansas               |
| 6915 | GFE       |          0.34 | abs(result) \< tolerance | Kansas               |
| 7015 | GSLG      |         -0.15 | abs(result) \< tolerance | Kansas               |
| 7117 | GSLE      |          0.27 | abs(result) \< tolerance | Kansas               |
| 7216 | Used      |         -0.05 | abs(result) \< tolerance | Kansas               |
| 7316 | Other     |        -21.71 | abs(result) \< tolerance | Kansas               |
| 1101 | 111CA     |          0.28 | abs(result) \< tolerance | Kentucky             |
| 2101 | 113FF     |          0.12 | abs(result) \< tolerance | Kentucky             |
| 3101 | 211       |          7.19 | abs(result) \< tolerance | Kentucky             |
| 4101 | 212       |         -0.53 | abs(result) \< tolerance | Kentucky             |
| 6100 | 22        |          0.02 | abs(result) \< tolerance | Kentucky             |
| 745  | 23        |          0.08 | abs(result) \< tolerance | Kentucky             |
| 817  | 321       |         -0.21 | abs(result) \< tolerance | Kentucky             |
| 917  | 327       |          0.02 | abs(result) \< tolerance | Kentucky             |
| 1017 | 331       |         -0.42 | abs(result) \< tolerance | Kentucky             |
| 1120 | 332       |          0.30 | abs(result) \< tolerance | Kentucky             |
| 1219 | 333       |          0.05 | abs(result) \< tolerance | Kentucky             |
| 1317 | 334       |          0.60 | abs(result) \< tolerance | Kentucky             |
| 1417 | 335       |         -0.29 | abs(result) \< tolerance | Kentucky             |
| 1517 | 3361MV    |         -0.29 | abs(result) \< tolerance | Kentucky             |
| 1615 | 3364OT    |          0.24 | abs(result) \< tolerance | Kentucky             |
| 1716 | 337       |          0.05 | abs(result) \< tolerance | Kentucky             |
| 1817 | 339       |          0.77 | abs(result) \< tolerance | Kentucky             |
| 1917 | 311FT     |         -0.38 | abs(result) \< tolerance | Kentucky             |
| 2017 | 313TT     |          0.19 | abs(result) \< tolerance | Kentucky             |
| 2121 | 315AL     |          0.71 | abs(result) \< tolerance | Kentucky             |
| 2218 | 322       |         -0.36 | abs(result) \< tolerance | Kentucky             |
| 2317 | 323       |         -0.38 | abs(result) \< tolerance | Kentucky             |
| 2417 | 324       |          0.16 | abs(result) \< tolerance | Kentucky             |
| 2517 | 325       |          0.99 | abs(result) \< tolerance | Kentucky             |
| 2617 | 326       |         -0.16 | abs(result) \< tolerance | Kentucky             |
| 2717 | 42        |          0.19 | abs(result) \< tolerance | Kentucky             |
| 2817 | 441       |          0.70 | abs(result) \< tolerance | Kentucky             |
| 2917 | 445       |          0.23 | abs(result) \< tolerance | Kentucky             |
| 3017 | 452       |         -0.32 | abs(result) \< tolerance | Kentucky             |
| 3121 | 4A0       |          0.07 | abs(result) \< tolerance | Kentucky             |
| 3218 | 481       |          1.08 | abs(result) \< tolerance | Kentucky             |
| 3317 | 482       |          0.05 | abs(result) \< tolerance | Kentucky             |
| 3417 | 483       |         -0.50 | abs(result) \< tolerance | Kentucky             |
| 3517 | 484       |         -0.02 | abs(result) \< tolerance | Kentucky             |
| 3616 | 485       |          0.79 | abs(result) \< tolerance | Kentucky             |
| 3717 | 486       |          0.47 | abs(result) \< tolerance | Kentucky             |
| 3817 | 487OS     |         -0.47 | abs(result) \< tolerance | Kentucky             |
| 3917 | 493       |         -0.48 | abs(result) \< tolerance | Kentucky             |
| 4017 | 511       |          0.18 | abs(result) \< tolerance | Kentucky             |
| 4120 | 512       |          2.41 | abs(result) \< tolerance | Kentucky             |
| 4218 | 513       |          0.27 | abs(result) \< tolerance | Kentucky             |
| 4317 | 514       |          3.15 | abs(result) \< tolerance | Kentucky             |
| 4416 | 521CI     |          0.47 | abs(result) \< tolerance | Kentucky             |
| 4517 | 523       |          0.94 | abs(result) \< tolerance | Kentucky             |
| 4617 | 524       |         -0.06 | abs(result) \< tolerance | Kentucky             |
| 4717 | 525       |          0.87 | abs(result) \< tolerance | Kentucky             |
| 4816 | HS        |         -0.08 | abs(result) \< tolerance | Kentucky             |
| 4917 | ORE       |          1.00 | abs(result) \< tolerance | Kentucky             |
| 5017 | 532RL     |          0.44 | abs(result) \< tolerance | Kentucky             |
| 5121 | 5411      |          0.48 | abs(result) \< tolerance | Kentucky             |
| 5217 | 5415      |          0.35 | abs(result) \< tolerance | Kentucky             |
| 5317 | 5412OP    |          0.36 | abs(result) \< tolerance | Kentucky             |
| 5416 | 55        |          0.53 | abs(result) \< tolerance | Kentucky             |
| 5517 | 561       |         -0.04 | abs(result) \< tolerance | Kentucky             |
| 5615 | 562       |         -0.17 | abs(result) \< tolerance | Kentucky             |
| 5716 | 61        |          0.39 | abs(result) \< tolerance | Kentucky             |
| 5817 | 621       |         -0.15 | abs(result) \< tolerance | Kentucky             |
| 5916 | 622       |         -0.27 | abs(result) \< tolerance | Kentucky             |
| 6017 | 623       |         -0.19 | abs(result) \< tolerance | Kentucky             |
| 6121 | 624       |          0.03 | abs(result) \< tolerance | Kentucky             |
| 6218 | 711AS     |          0.59 | abs(result) \< tolerance | Kentucky             |
| 6317 | 713       |          0.37 | abs(result) \< tolerance | Kentucky             |
| 6417 | 721       |          0.19 | abs(result) \< tolerance | Kentucky             |
| 6515 | 722       |         -0.11 | abs(result) \< tolerance | Kentucky             |
| 6717 | GFGD      |         -0.19 | abs(result) \< tolerance | Kentucky             |
| 6816 | GFGN      |          1.16 | abs(result) \< tolerance | Kentucky             |
| 6916 | GFE       |          0.16 | abs(result) \< tolerance | Kentucky             |
| 7016 | GSLG      |          0.10 | abs(result) \< tolerance | Kentucky             |
| 7118 | GSLE      |          0.56 | abs(result) \< tolerance | Kentucky             |
| 7217 | Used      |         -0.62 | abs(result) \< tolerance | Kentucky             |
| 7317 | Other     |        -14.12 | abs(result) \< tolerance | Kentucky             |
| 1102 | 111CA     |          0.37 | abs(result) \< tolerance | Louisiana            |
| 2102 | 113FF     |         -0.25 | abs(result) \< tolerance | Louisiana            |
| 3102 | 211       |          1.58 | abs(result) \< tolerance | Louisiana            |
| 4102 | 212       |          1.09 | abs(result) \< tolerance | Louisiana            |
| 5101 | 213       |         -0.03 | abs(result) \< tolerance | Louisiana            |
| 6101 | 22        |         -0.07 | abs(result) \< tolerance | Louisiana            |
| 746  | 23        |         -0.20 | abs(result) \< tolerance | Louisiana            |
| 818  | 321       |         -0.29 | abs(result) \< tolerance | Louisiana            |
| 918  | 327       |          0.28 | abs(result) \< tolerance | Louisiana            |
| 1018 | 331       |          0.30 | abs(result) \< tolerance | Louisiana            |
| 1121 | 332       |          0.09 | abs(result) \< tolerance | Louisiana            |
| 1318 | 334       |          2.13 | abs(result) \< tolerance | Louisiana            |
| 1418 | 335       |          2.34 | abs(result) \< tolerance | Louisiana            |
| 1518 | 3361MV    |          6.67 | abs(result) \< tolerance | Louisiana            |
| 1616 | 3364OT    |          0.19 | abs(result) \< tolerance | Louisiana            |
| 1717 | 337       |          2.91 | abs(result) \< tolerance | Louisiana            |
| 1818 | 339       |          0.69 | abs(result) \< tolerance | Louisiana            |
| 1918 | 311FT     |          0.76 | abs(result) \< tolerance | Louisiana            |
| 2018 | 313TT     |          1.09 | abs(result) \< tolerance | Louisiana            |
| 2122 | 315AL     |          2.98 | abs(result) \< tolerance | Louisiana            |
| 2219 | 322       |         -0.50 | abs(result) \< tolerance | Louisiana            |
| 2318 | 323       |          0.83 | abs(result) \< tolerance | Louisiana            |
| 2418 | 324       |         -0.60 | abs(result) \< tolerance | Louisiana            |
| 2518 | 325       |         -0.44 | abs(result) \< tolerance | Louisiana            |
| 2618 | 326       |          0.69 | abs(result) \< tolerance | Louisiana            |
| 2718 | 42        |          0.29 | abs(result) \< tolerance | Louisiana            |
| 2818 | 441       |          0.55 | abs(result) \< tolerance | Louisiana            |
| 2918 | 445       |         -0.14 | abs(result) \< tolerance | Louisiana            |
| 3018 | 452       |         -0.48 | abs(result) \< tolerance | Louisiana            |
| 3122 | 4A0       |         -0.15 | abs(result) \< tolerance | Louisiana            |
| 3219 | 481       |          0.57 | abs(result) \< tolerance | Louisiana            |
| 3318 | 482       |          0.17 | abs(result) \< tolerance | Louisiana            |
| 3418 | 483       |         -0.58 | abs(result) \< tolerance | Louisiana            |
| 3518 | 484       |          0.27 | abs(result) \< tolerance | Louisiana            |
| 3617 | 485       |          0.22 | abs(result) \< tolerance | Louisiana            |
| 3718 | 486       |          1.82 | abs(result) \< tolerance | Louisiana            |
| 3818 | 487OS     |         -0.30 | abs(result) \< tolerance | Louisiana            |
| 3918 | 493       |         -0.07 | abs(result) \< tolerance | Louisiana            |
| 4018 | 511       |          1.25 | abs(result) \< tolerance | Louisiana            |
| 4121 | 512       |         -0.14 | abs(result) \< tolerance | Louisiana            |
| 4219 | 513       |          0.47 | abs(result) \< tolerance | Louisiana            |
| 4318 | 514       |          3.24 | abs(result) \< tolerance | Louisiana            |
| 4417 | 521CI     |          0.55 | abs(result) \< tolerance | Louisiana            |
| 4518 | 523       |          2.57 | abs(result) \< tolerance | Louisiana            |
| 4618 | 524       |          0.13 | abs(result) \< tolerance | Louisiana            |
| 4718 | 525       |          0.38 | abs(result) \< tolerance | Louisiana            |
| 4817 | HS        |         -0.06 | abs(result) \< tolerance | Louisiana            |
| 4918 | ORE       |          1.02 | abs(result) \< tolerance | Louisiana            |
| 5018 | 532RL     |         -0.24 | abs(result) \< tolerance | Louisiana            |
| 5122 | 5411      |         -0.18 | abs(result) \< tolerance | Louisiana            |
| 5218 | 5415      |          0.64 | abs(result) \< tolerance | Louisiana            |
| 5318 | 5412OP    |          0.27 | abs(result) \< tolerance | Louisiana            |
| 5417 | 55        |          1.05 | abs(result) \< tolerance | Louisiana            |
| 5518 | 561       |          0.11 | abs(result) \< tolerance | Louisiana            |
| 5616 | 562       |         -0.27 | abs(result) \< tolerance | Louisiana            |
| 5717 | 61        |         -0.02 | abs(result) \< tolerance | Louisiana            |
| 5818 | 621       |         -0.20 | abs(result) \< tolerance | Louisiana            |
| 5917 | 622       |         -0.24 | abs(result) \< tolerance | Louisiana            |
| 6018 | 623       |         -0.07 | abs(result) \< tolerance | Louisiana            |
| 6122 | 624       |         -0.06 | abs(result) \< tolerance | Louisiana            |
| 6219 | 711AS     |         -0.08 | abs(result) \< tolerance | Louisiana            |
| 6318 | 713       |         -0.25 | abs(result) \< tolerance | Louisiana            |
| 6418 | 721       |         -0.36 | abs(result) \< tolerance | Louisiana            |
| 6516 | 722       |         -0.01 | abs(result) \< tolerance | Louisiana            |
| 6615 | 81        |         -0.11 | abs(result) \< tolerance | Louisiana            |
| 6718 | GFGD      |         -0.19 | abs(result) \< tolerance | Louisiana            |
| 6817 | GFGN      |         -0.09 | abs(result) \< tolerance | Louisiana            |
| 6917 | GFE       |          0.75 | abs(result) \< tolerance | Louisiana            |
| 7017 | GSLG      |          0.02 | abs(result) \< tolerance | Louisiana            |
| 7119 | GSLE      |          0.24 | abs(result) \< tolerance | Louisiana            |
| 7218 | Used      |          1.25 | abs(result) \< tolerance | Louisiana            |
| 7318 | Other     |        -37.63 | abs(result) \< tolerance | Louisiana            |
| 1103 | 111CA     |          0.52 | abs(result) \< tolerance | Maine                |
| 3103 | 211       |      13380.39 | abs(result) \< tolerance | Maine                |
| 4103 | 212       |          1.03 | abs(result) \< tolerance | Maine                |
| 5102 | 213       |          0.77 | abs(result) \< tolerance | Maine                |
| 6102 | 22        |          0.20 | abs(result) \< tolerance | Maine                |
| 747  | 23        |          0.22 | abs(result) \< tolerance | Maine                |
| 819  | 321       |         -0.53 | abs(result) \< tolerance | Maine                |
| 919  | 327       |          0.10 | abs(result) \< tolerance | Maine                |
| 1019 | 331       |          2.12 | abs(result) \< tolerance | Maine                |
| 1122 | 332       |         -0.16 | abs(result) \< tolerance | Maine                |
| 1220 | 333       |         -0.08 | abs(result) \< tolerance | Maine                |
| 1319 | 334       |          0.19 | abs(result) \< tolerance | Maine                |
| 1419 | 335       |          1.87 | abs(result) \< tolerance | Maine                |
| 1519 | 3361MV    |          1.83 | abs(result) \< tolerance | Maine                |
| 1617 | 3364OT    |         -0.30 | abs(result) \< tolerance | Maine                |
| 1718 | 337       |          0.10 | abs(result) \< tolerance | Maine                |
| 1819 | 339       |          0.18 | abs(result) \< tolerance | Maine                |
| 1919 | 311FT     |          0.45 | abs(result) \< tolerance | Maine                |
| 2019 | 313TT     |         -0.33 | abs(result) \< tolerance | Maine                |
| 2123 | 315AL     |         -0.68 | abs(result) \< tolerance | Maine                |
| 2220 | 322       |         -0.48 | abs(result) \< tolerance | Maine                |
| 2319 | 323       |          0.12 | abs(result) \< tolerance | Maine                |
| 2419 | 324       |          2.12 | abs(result) \< tolerance | Maine                |
| 2519 | 325       |          0.70 | abs(result) \< tolerance | Maine                |
| 2619 | 326       |         -0.03 | abs(result) \< tolerance | Maine                |
| 2719 | 42        |          0.15 | abs(result) \< tolerance | Maine                |
| 2819 | 441       |          0.38 | abs(result) \< tolerance | Maine                |
| 2919 | 445       |         -0.25 | abs(result) \< tolerance | Maine                |
| 3019 | 452       |         -0.24 | abs(result) \< tolerance | Maine                |
| 3123 | 4A0       |         -0.23 | abs(result) \< tolerance | Maine                |
| 3220 | 481       |          3.21 | abs(result) \< tolerance | Maine                |
| 3319 | 482       |          0.86 | abs(result) \< tolerance | Maine                |
| 3419 | 483       |          2.47 | abs(result) \< tolerance | Maine                |
| 3519 | 484       |         -0.10 | abs(result) \< tolerance | Maine                |
| 3618 | 485       |          0.23 | abs(result) \< tolerance | Maine                |
| 3719 | 486       |          1.49 | abs(result) \< tolerance | Maine                |
| 3819 | 487OS     |          0.19 | abs(result) \< tolerance | Maine                |
| 3919 | 493       |         -0.07 | abs(result) \< tolerance | Maine                |
| 4019 | 511       |          0.47 | abs(result) \< tolerance | Maine                |
| 4122 | 512       |          1.56 | abs(result) \< tolerance | Maine                |
| 4220 | 513       |          1.09 | abs(result) \< tolerance | Maine                |
| 4319 | 514       |          1.97 | abs(result) \< tolerance | Maine                |
| 4418 | 521CI     |          0.49 | abs(result) \< tolerance | Maine                |
| 4519 | 523       |          1.08 | abs(result) \< tolerance | Maine                |
| 4719 | 525       |          3.68 | abs(result) \< tolerance | Maine                |
| 4818 | HS        |         -0.16 | abs(result) \< tolerance | Maine                |
| 4919 | ORE       |          0.62 | abs(result) \< tolerance | Maine                |
| 5019 | 532RL     |          0.25 | abs(result) \< tolerance | Maine                |
| 5123 | 5411      |          0.37 | abs(result) \< tolerance | Maine                |
| 5219 | 5415      |          0.10 | abs(result) \< tolerance | Maine                |
| 5319 | 5412OP    |          0.14 | abs(result) \< tolerance | Maine                |
| 5519 | 561       |         -0.02 | abs(result) \< tolerance | Maine                |
| 5617 | 562       |         -0.08 | abs(result) \< tolerance | Maine                |
| 5718 | 61        |         -0.10 | abs(result) \< tolerance | Maine                |
| 5819 | 621       |         -0.05 | abs(result) \< tolerance | Maine                |
| 5918 | 622       |         -0.42 | abs(result) \< tolerance | Maine                |
| 6019 | 623       |         -0.46 | abs(result) \< tolerance | Maine                |
| 6123 | 624       |         -0.36 | abs(result) \< tolerance | Maine                |
| 6220 | 711AS     |          0.22 | abs(result) \< tolerance | Maine                |
| 6319 | 713       |          0.05 | abs(result) \< tolerance | Maine                |
| 6419 | 721       |         -0.25 | abs(result) \< tolerance | Maine                |
| 6517 | 722       |         -0.03 | abs(result) \< tolerance | Maine                |
| 6616 | 81        |          0.07 | abs(result) \< tolerance | Maine                |
| 6719 | GFGD      |         -0.38 | abs(result) \< tolerance | Maine                |
| 6818 | GFGN      |          0.17 | abs(result) \< tolerance | Maine                |
| 6918 | GFE       |         -0.28 | abs(result) \< tolerance | Maine                |
| 7018 | GSLG      |          0.06 | abs(result) \< tolerance | Maine                |
| 7120 | GSLE      |          1.41 | abs(result) \< tolerance | Maine                |
| 7219 | Used      |         -1.97 | abs(result) \< tolerance | Maine                |
| 7319 | Other     |         -0.11 | abs(result) \< tolerance | Maine                |
| 1104 | 111CA     |          0.84 | abs(result) \< tolerance | Maryland             |
| 2103 | 113FF     |         -0.13 | abs(result) \< tolerance | Maryland             |
| 3104 | 211       |        219.06 | abs(result) \< tolerance | Maryland             |
| 4104 | 212       |          2.43 | abs(result) \< tolerance | Maryland             |
| 5103 | 213       |         -0.05 | abs(result) \< tolerance | Maryland             |
| 6103 | 22        |         -0.14 | abs(result) \< tolerance | Maryland             |
| 748  | 23        |         -0.17 | abs(result) \< tolerance | Maryland             |
| 820  | 321       |          1.49 | abs(result) \< tolerance | Maryland             |
| 920  | 327       |          0.66 | abs(result) \< tolerance | Maryland             |
| 1020 | 331       |          1.42 | abs(result) \< tolerance | Maryland             |
| 1123 | 332       |          1.38 | abs(result) \< tolerance | Maryland             |
| 1221 | 333       |          0.24 | abs(result) \< tolerance | Maryland             |
| 1420 | 335       |          2.24 | abs(result) \< tolerance | Maryland             |
| 1520 | 3361MV    |          5.19 | abs(result) \< tolerance | Maryland             |
| 1618 | 3364OT    |          1.03 | abs(result) \< tolerance | Maryland             |
| 1719 | 337       |          0.68 | abs(result) \< tolerance | Maryland             |
| 1820 | 339       |          0.22 | abs(result) \< tolerance | Maryland             |
| 1920 | 311FT     |          0.43 | abs(result) \< tolerance | Maryland             |
| 2020 | 313TT     |          0.32 | abs(result) \< tolerance | Maryland             |
| 2124 | 315AL     |          0.07 | abs(result) \< tolerance | Maryland             |
| 2221 | 322       |          1.78 | abs(result) \< tolerance | Maryland             |
| 2320 | 323       |          0.21 | abs(result) \< tolerance | Maryland             |
| 2420 | 324       |          2.27 | abs(result) \< tolerance | Maryland             |
| 2520 | 325       |         -0.16 | abs(result) \< tolerance | Maryland             |
| 2620 | 326       |          0.36 | abs(result) \< tolerance | Maryland             |
| 2720 | 42        |          0.15 | abs(result) \< tolerance | Maryland             |
| 2820 | 441       |          0.40 | abs(result) \< tolerance | Maryland             |
| 2920 | 445       |         -0.35 | abs(result) \< tolerance | Maryland             |
| 3020 | 452       |         -0.09 | abs(result) \< tolerance | Maryland             |
| 3124 | 4A0       |          0.15 | abs(result) \< tolerance | Maryland             |
| 3221 | 481       |          0.39 | abs(result) \< tolerance | Maryland             |
| 3320 | 482       |          0.12 | abs(result) \< tolerance | Maryland             |
| 3420 | 483       |          0.14 | abs(result) \< tolerance | Maryland             |
| 3520 | 484       |          0.39 | abs(result) \< tolerance | Maryland             |
| 3619 | 485       |         -0.08 | abs(result) \< tolerance | Maryland             |
| 3720 | 486       |          3.68 | abs(result) \< tolerance | Maryland             |
| 3820 | 487OS     |         -0.05 | abs(result) \< tolerance | Maryland             |
| 3920 | 493       |         -0.20 | abs(result) \< tolerance | Maryland             |
| 4020 | 511       |          0.34 | abs(result) \< tolerance | Maryland             |
| 4123 | 512       |          1.73 | abs(result) \< tolerance | Maryland             |
| 4221 | 513       |         -0.13 | abs(result) \< tolerance | Maryland             |
| 4320 | 514       |          1.26 | abs(result) \< tolerance | Maryland             |
| 4419 | 521CI     |          0.91 | abs(result) \< tolerance | Maryland             |
| 4520 | 523       |          0.46 | abs(result) \< tolerance | Maryland             |
| 4619 | 524       |          0.39 | abs(result) \< tolerance | Maryland             |
| 4720 | 525       |         -0.57 | abs(result) \< tolerance | Maryland             |
| 4819 | HS        |         -0.28 | abs(result) \< tolerance | Maryland             |
| 4920 | ORE       |          0.48 | abs(result) \< tolerance | Maryland             |
| 5020 | 532RL     |         -0.45 | abs(result) \< tolerance | Maryland             |
| 5124 | 5411      |          0.23 | abs(result) \< tolerance | Maryland             |
| 5220 | 5415      |          0.18 | abs(result) \< tolerance | Maryland             |
| 5320 | 5412OP    |          0.09 | abs(result) \< tolerance | Maryland             |
| 5418 | 55        |          0.48 | abs(result) \< tolerance | Maryland             |
| 5520 | 561       |         -0.04 | abs(result) \< tolerance | Maryland             |
| 5618 | 562       |         -0.03 | abs(result) \< tolerance | Maryland             |
| 5820 | 621       |          0.16 | abs(result) \< tolerance | Maryland             |
| 5919 | 622       |          0.17 | abs(result) \< tolerance | Maryland             |
| 6020 | 623       |          0.04 | abs(result) \< tolerance | Maryland             |
| 6124 | 624       |          0.34 | abs(result) \< tolerance | Maryland             |
| 6221 | 711AS     |          0.08 | abs(result) \< tolerance | Maryland             |
| 6320 | 713       |         -0.12 | abs(result) \< tolerance | Maryland             |
| 6420 | 721       |          0.32 | abs(result) \< tolerance | Maryland             |
| 6518 | 722       |         -0.02 | abs(result) \< tolerance | Maryland             |
| 6617 | 81        |          0.12 | abs(result) \< tolerance | Maryland             |
| 6720 | GFGD      |         -0.60 | abs(result) \< tolerance | Maryland             |
| 6819 | GFGN      |         -0.37 | abs(result) \< tolerance | Maryland             |
| 6919 | GFE       |         -0.77 | abs(result) \< tolerance | Maryland             |
| 7019 | GSLG      |          0.05 | abs(result) \< tolerance | Maryland             |
| 7121 | GSLE      |          0.67 | abs(result) \< tolerance | Maryland             |
| 7220 | Used      |          6.34 | abs(result) \< tolerance | Maryland             |
| 7320 | Other     |         48.11 | abs(result) \< tolerance | Maryland             |
| 1105 | 111CA     |          8.66 | abs(result) \< tolerance | Massachusetts        |
| 2104 | 113FF     |         -0.27 | abs(result) \< tolerance | Massachusetts        |
| 3105 | 211       |       1369.30 | abs(result) \< tolerance | Massachusetts        |
| 4105 | 212       |          1.42 | abs(result) \< tolerance | Massachusetts        |
| 6104 | 22        |          0.23 | abs(result) \< tolerance | Massachusetts        |
| 749  | 23        |         -0.02 | abs(result) \< tolerance | Massachusetts        |
| 821  | 321       |          1.66 | abs(result) \< tolerance | Massachusetts        |
| 921  | 327       |          0.41 | abs(result) \< tolerance | Massachusetts        |
| 1021 | 331       |          1.38 | abs(result) \< tolerance | Massachusetts        |
| 1124 | 332       |         -0.33 | abs(result) \< tolerance | Massachusetts        |
| 1222 | 333       |          0.23 | abs(result) \< tolerance | Massachusetts        |
| 1320 | 334       |         -0.26 | abs(result) \< tolerance | Massachusetts        |
| 1421 | 335       |          0.07 | abs(result) \< tolerance | Massachusetts        |
| 1521 | 3361MV    |          3.19 | abs(result) \< tolerance | Massachusetts        |
| 1619 | 3364OT    |          0.04 | abs(result) \< tolerance | Massachusetts        |
| 1720 | 337       |          0.74 | abs(result) \< tolerance | Massachusetts        |
| 1821 | 339       |         -0.25 | abs(result) \< tolerance | Massachusetts        |
| 1921 | 311FT     |          0.96 | abs(result) \< tolerance | Massachusetts        |
| 2021 | 313TT     |         -0.07 | abs(result) \< tolerance | Massachusetts        |
| 2125 | 315AL     |         -0.37 | abs(result) \< tolerance | Massachusetts        |
| 2222 | 322       |          0.43 | abs(result) \< tolerance | Massachusetts        |
| 2421 | 324       |          2.93 | abs(result) \< tolerance | Massachusetts        |
| 2521 | 325       |         -0.20 | abs(result) \< tolerance | Massachusetts        |
| 2621 | 326       |          0.10 | abs(result) \< tolerance | Massachusetts        |
| 2721 | 42        |         -0.06 | abs(result) \< tolerance | Massachusetts        |
| 2821 | 441       |          0.64 | abs(result) \< tolerance | Massachusetts        |
| 2921 | 445       |         -0.32 | abs(result) \< tolerance | Massachusetts        |
| 3021 | 452       |          0.41 | abs(result) \< tolerance | Massachusetts        |
| 3125 | 4A0       |          0.33 | abs(result) \< tolerance | Massachusetts        |
| 3222 | 481       |          0.62 | abs(result) \< tolerance | Massachusetts        |
| 3321 | 482       |          0.29 | abs(result) \< tolerance | Massachusetts        |
| 3421 | 483       |          0.98 | abs(result) \< tolerance | Massachusetts        |
| 3521 | 484       |          0.77 | abs(result) \< tolerance | Massachusetts        |
| 3620 | 485       |         -0.25 | abs(result) \< tolerance | Massachusetts        |
| 3721 | 486       |          3.65 | abs(result) \< tolerance | Massachusetts        |
| 3821 | 487OS     |          0.49 | abs(result) \< tolerance | Massachusetts        |
| 3921 | 493       |          0.44 | abs(result) \< tolerance | Massachusetts        |
| 4021 | 511       |         -0.22 | abs(result) \< tolerance | Massachusetts        |
| 4124 | 512       |          1.02 | abs(result) \< tolerance | Massachusetts        |
| 4222 | 513       |          0.74 | abs(result) \< tolerance | Massachusetts        |
| 4321 | 514       |         -0.13 | abs(result) \< tolerance | Massachusetts        |
| 4420 | 521CI     |          0.14 | abs(result) \< tolerance | Massachusetts        |
| 4521 | 523       |         -0.38 | abs(result) \< tolerance | Massachusetts        |
| 4620 | 524       |         -0.06 | abs(result) \< tolerance | Massachusetts        |
| 4721 | 525       |         -0.20 | abs(result) \< tolerance | Massachusetts        |
| 4820 | HS        |         -0.33 | abs(result) \< tolerance | Massachusetts        |
| 4921 | ORE       |          0.74 | abs(result) \< tolerance | Massachusetts        |
| 5021 | 532RL     |          0.28 | abs(result) \< tolerance | Massachusetts        |
| 5125 | 5411      |         -0.04 | abs(result) \< tolerance | Massachusetts        |
| 5221 | 5415      |         -0.23 | abs(result) \< tolerance | Massachusetts        |
| 5321 | 5412OP    |         -0.20 | abs(result) \< tolerance | Massachusetts        |
| 5419 | 55        |         -0.20 | abs(result) \< tolerance | Massachusetts        |
| 5521 | 561       |          0.15 | abs(result) \< tolerance | Massachusetts        |
| 5619 | 562       |         -0.22 | abs(result) \< tolerance | Massachusetts        |
| 5719 | 61        |         -0.49 | abs(result) \< tolerance | Massachusetts        |
| 5920 | 622       |         -0.29 | abs(result) \< tolerance | Massachusetts        |
| 6021 | 623       |         -0.20 | abs(result) \< tolerance | Massachusetts        |
| 6125 | 624       |         -0.31 | abs(result) \< tolerance | Massachusetts        |
| 6222 | 711AS     |         -0.24 | abs(result) \< tolerance | Massachusetts        |
| 6321 | 713       |          0.09 | abs(result) \< tolerance | Massachusetts        |
| 6421 | 721       |         -0.08 | abs(result) \< tolerance | Massachusetts        |
| 6519 | 722       |         -0.02 | abs(result) \< tolerance | Massachusetts        |
| 6618 | 81        |          0.20 | abs(result) \< tolerance | Massachusetts        |
| 6721 | GFGD      |         -0.88 | abs(result) \< tolerance | Massachusetts        |
| 6820 | GFGN      |         -0.18 | abs(result) \< tolerance | Massachusetts        |
| 6920 | GFE       |          0.78 | abs(result) \< tolerance | Massachusetts        |
| 7020 | GSLG      |          0.10 | abs(result) \< tolerance | Massachusetts        |
| 7122 | GSLE      |          1.15 | abs(result) \< tolerance | Massachusetts        |
| 7221 | Used      |         -2.30 | abs(result) \< tolerance | Massachusetts        |
| 7321 | Other     |        -13.29 | abs(result) \< tolerance | Massachusetts        |
| 1106 | 111CA     |          0.18 | abs(result) \< tolerance | Michigan             |
| 2105 | 113FF     |          0.52 | abs(result) \< tolerance | Michigan             |
| 3106 | 211       |          9.60 | abs(result) \< tolerance | Michigan             |
| 4106 | 212       |          0.11 | abs(result) \< tolerance | Michigan             |
| 6105 | 22        |         -0.06 | abs(result) \< tolerance | Michigan             |
| 750  | 23        |          0.05 | abs(result) \< tolerance | Michigan             |
| 822  | 321       |          0.30 | abs(result) \< tolerance | Michigan             |
| 922  | 327       |          0.46 | abs(result) \< tolerance | Michigan             |
| 1022 | 331       |          0.69 | abs(result) \< tolerance | Michigan             |
| 1125 | 332       |          0.12 | abs(result) \< tolerance | Michigan             |
| 1223 | 333       |         -0.07 | abs(result) \< tolerance | Michigan             |
| 1321 | 334       |          1.29 | abs(result) \< tolerance | Michigan             |
| 1422 | 335       |          0.07 | abs(result) \< tolerance | Michigan             |
| 1522 | 3361MV    |         -0.32 | abs(result) \< tolerance | Michigan             |
| 1620 | 3364OT    |          0.02 | abs(result) \< tolerance | Michigan             |
| 1721 | 337       |         -0.46 | abs(result) \< tolerance | Michigan             |
| 1822 | 339       |         -0.21 | abs(result) \< tolerance | Michigan             |
| 1922 | 311FT     |          0.24 | abs(result) \< tolerance | Michigan             |
| 2022 | 313TT     |          1.87 | abs(result) \< tolerance | Michigan             |
| 2126 | 315AL     |          0.71 | abs(result) \< tolerance | Michigan             |
| 2223 | 322       |          0.17 | abs(result) \< tolerance | Michigan             |
| 2321 | 323       |         -0.25 | abs(result) \< tolerance | Michigan             |
| 2422 | 324       |          1.43 | abs(result) \< tolerance | Michigan             |
| 2522 | 325       |          0.45 | abs(result) \< tolerance | Michigan             |
| 2622 | 326       |          0.03 | abs(result) \< tolerance | Michigan             |
| 2722 | 42        |          0.22 | abs(result) \< tolerance | Michigan             |
| 2822 | 441       |          0.55 | abs(result) \< tolerance | Michigan             |
| 2922 | 445       |          0.03 | abs(result) \< tolerance | Michigan             |
| 3022 | 452       |         -0.22 | abs(result) \< tolerance | Michigan             |
| 3126 | 4A0       |          0.14 | abs(result) \< tolerance | Michigan             |
| 3223 | 481       |         -0.07 | abs(result) \< tolerance | Michigan             |
| 3322 | 482       |          1.61 | abs(result) \< tolerance | Michigan             |
| 3422 | 483       |          1.33 | abs(result) \< tolerance | Michigan             |
| 3522 | 484       |          0.08 | abs(result) \< tolerance | Michigan             |
| 3621 | 485       |          0.92 | abs(result) \< tolerance | Michigan             |
| 3722 | 486       |          0.69 | abs(result) \< tolerance | Michigan             |
| 3822 | 487OS     |          0.29 | abs(result) \< tolerance | Michigan             |
| 3922 | 493       |          0.38 | abs(result) \< tolerance | Michigan             |
| 4022 | 511       |          0.09 | abs(result) \< tolerance | Michigan             |
| 4125 | 512       |          0.89 | abs(result) \< tolerance | Michigan             |
| 4223 | 513       |          0.66 | abs(result) \< tolerance | Michigan             |
| 4322 | 514       |          0.70 | abs(result) \< tolerance | Michigan             |
| 4421 | 521CI     |          0.93 | abs(result) \< tolerance | Michigan             |
| 4522 | 523       |          1.83 | abs(result) \< tolerance | Michigan             |
| 4621 | 524       |         -0.05 | abs(result) \< tolerance | Michigan             |
| 4722 | 525       |          1.06 | abs(result) \< tolerance | Michigan             |
| 4821 | HS        |         -0.07 | abs(result) \< tolerance | Michigan             |
| 4922 | ORE       |          0.82 | abs(result) \< tolerance | Michigan             |
| 5022 | 532RL     |         -0.08 | abs(result) \< tolerance | Michigan             |
| 5126 | 5411      |          0.34 | abs(result) \< tolerance | Michigan             |
| 5222 | 5415      |         -0.03 | abs(result) \< tolerance | Michigan             |
| 5322 | 5412OP    |         -0.17 | abs(result) \< tolerance | Michigan             |
| 5420 | 55        |          0.12 | abs(result) \< tolerance | Michigan             |
| 5522 | 561       |         -0.12 | abs(result) \< tolerance | Michigan             |
| 5620 | 562       |         -0.13 | abs(result) \< tolerance | Michigan             |
| 5720 | 61        |          0.32 | abs(result) \< tolerance | Michigan             |
| 5821 | 621       |         -0.02 | abs(result) \< tolerance | Michigan             |
| 5921 | 622       |         -0.27 | abs(result) \< tolerance | Michigan             |
| 6022 | 623       |         -0.08 | abs(result) \< tolerance | Michigan             |
| 6126 | 624       |          0.29 | abs(result) \< tolerance | Michigan             |
| 6223 | 711AS     |          0.15 | abs(result) \< tolerance | Michigan             |
| 6322 | 713       |          0.24 | abs(result) \< tolerance | Michigan             |
| 6422 | 721       |          0.15 | abs(result) \< tolerance | Michigan             |
| 6520 | 722       |          0.07 | abs(result) \< tolerance | Michigan             |
| 6619 | 81        |         -0.02 | abs(result) \< tolerance | Michigan             |
| 6722 | GFGD      |         -0.61 | abs(result) \< tolerance | Michigan             |
| 6821 | GFGN      |         -0.06 | abs(result) \< tolerance | Michigan             |
| 6921 | GFE       |          0.46 | abs(result) \< tolerance | Michigan             |
| 7021 | GSLG      |          0.07 | abs(result) \< tolerance | Michigan             |
| 7123 | GSLE      |          1.54 | abs(result) \< tolerance | Michigan             |
| 7222 | Used      |         -8.15 | abs(result) \< tolerance | Michigan             |
| 7322 | Other     |        -41.29 | abs(result) \< tolerance | Michigan             |
| 1107 | 111CA     |         -0.39 | abs(result) \< tolerance | Minnesota            |
| 2106 | 113FF     |          2.69 | abs(result) \< tolerance | Minnesota            |
| 3107 | 211       |        506.92 | abs(result) \< tolerance | Minnesota            |
| 4107 | 212       |         -0.40 | abs(result) \< tolerance | Minnesota            |
| 5104 | 213       |          0.20 | abs(result) \< tolerance | Minnesota            |
| 6106 | 22        |          0.05 | abs(result) \< tolerance | Minnesota            |
| 751  | 23        |         -0.06 | abs(result) \< tolerance | Minnesota            |
| 823  | 321       |         -0.38 | abs(result) \< tolerance | Minnesota            |
| 923  | 327       |         -0.16 | abs(result) \< tolerance | Minnesota            |
| 1023 | 331       |          0.48 | abs(result) \< tolerance | Minnesota            |
| 1126 | 332       |         -0.31 | abs(result) \< tolerance | Minnesota            |
| 1224 | 333       |         -0.17 | abs(result) \< tolerance | Minnesota            |
| 1322 | 334       |         -0.36 | abs(result) \< tolerance | Minnesota            |
| 1423 | 335       |         -0.11 | abs(result) \< tolerance | Minnesota            |
| 1523 | 3361MV    |          0.93 | abs(result) \< tolerance | Minnesota            |
| 1621 | 3364OT    |         -0.21 | abs(result) \< tolerance | Minnesota            |
| 1722 | 337       |         -0.26 | abs(result) \< tolerance | Minnesota            |
| 1823 | 339       |         -0.43 | abs(result) \< tolerance | Minnesota            |
| 1923 | 311FT     |         -0.17 | abs(result) \< tolerance | Minnesota            |
| 2127 | 315AL     |          0.41 | abs(result) \< tolerance | Minnesota            |
| 2224 | 322       |         -0.17 | abs(result) \< tolerance | Minnesota            |
| 2322 | 323       |         -0.63 | abs(result) \< tolerance | Minnesota            |
| 2423 | 324       |         -0.27 | abs(result) \< tolerance | Minnesota            |
| 2523 | 325       |          0.37 | abs(result) \< tolerance | Minnesota            |
| 2623 | 326       |         -0.07 | abs(result) \< tolerance | Minnesota            |
| 2723 | 42        |         -0.13 | abs(result) \< tolerance | Minnesota            |
| 2823 | 441       |          0.67 | abs(result) \< tolerance | Minnesota            |
| 2923 | 445       |         -0.18 | abs(result) \< tolerance | Minnesota            |
| 3023 | 452       |         -0.25 | abs(result) \< tolerance | Minnesota            |
| 3127 | 4A0       |         -0.08 | abs(result) \< tolerance | Minnesota            |
| 3224 | 481       |         -0.27 | abs(result) \< tolerance | Minnesota            |
| 3323 | 482       |         -0.23 | abs(result) \< tolerance | Minnesota            |
| 3423 | 483       |          0.03 | abs(result) \< tolerance | Minnesota            |
| 3523 | 484       |         -0.04 | abs(result) \< tolerance | Minnesota            |
| 3622 | 485       |         -0.04 | abs(result) \< tolerance | Minnesota            |
| 3723 | 486       |          0.87 | abs(result) \< tolerance | Minnesota            |
| 3823 | 487OS     |          0.42 | abs(result) \< tolerance | Minnesota            |
| 3923 | 493       |          0.78 | abs(result) \< tolerance | Minnesota            |
| 4023 | 511       |         -0.10 | abs(result) \< tolerance | Minnesota            |
| 4126 | 512       |          1.44 | abs(result) \< tolerance | Minnesota            |
| 4224 | 513       |          0.53 | abs(result) \< tolerance | Minnesota            |
| 4323 | 514       |          0.41 | abs(result) \< tolerance | Minnesota            |
| 4422 | 521CI     |         -0.04 | abs(result) \< tolerance | Minnesota            |
| 4523 | 523       |          0.33 | abs(result) \< tolerance | Minnesota            |
| 4622 | 524       |         -0.17 | abs(result) \< tolerance | Minnesota            |
| 4723 | 525       |         -0.27 | abs(result) \< tolerance | Minnesota            |
| 4822 | HS        |         -0.19 | abs(result) \< tolerance | Minnesota            |
| 4923 | ORE       |          0.97 | abs(result) \< tolerance | Minnesota            |
| 5023 | 532RL     |          0.50 | abs(result) \< tolerance | Minnesota            |
| 5127 | 5411      |          0.26 | abs(result) \< tolerance | Minnesota            |
| 5223 | 5415      |         -0.07 | abs(result) \< tolerance | Minnesota            |
| 5323 | 5412OP    |         -0.01 | abs(result) \< tolerance | Minnesota            |
| 5421 | 55        |         -0.47 | abs(result) \< tolerance | Minnesota            |
| 5523 | 561       |          0.13 | abs(result) \< tolerance | Minnesota            |
| 5621 | 562       |          0.16 | abs(result) \< tolerance | Minnesota            |
| 5721 | 61        |          0.26 | abs(result) \< tolerance | Minnesota            |
| 5822 | 621       |         -0.07 | abs(result) \< tolerance | Minnesota            |
| 5922 | 622       |         -0.03 | abs(result) \< tolerance | Minnesota            |
| 6023 | 623       |         -0.34 | abs(result) \< tolerance | Minnesota            |
| 6127 | 624       |         -0.19 | abs(result) \< tolerance | Minnesota            |
| 6224 | 711AS     |         -0.03 | abs(result) \< tolerance | Minnesota            |
| 6323 | 713       |          0.14 | abs(result) \< tolerance | Minnesota            |
| 6423 | 721       |          0.42 | abs(result) \< tolerance | Minnesota            |
| 6521 | 722       |          0.02 | abs(result) \< tolerance | Minnesota            |
| 6620 | 81        |          0.12 | abs(result) \< tolerance | Minnesota            |
| 6723 | GFGD      |         -0.58 | abs(result) \< tolerance | Minnesota            |
| 6822 | GFGN      |          0.16 | abs(result) \< tolerance | Minnesota            |
| 6922 | GFE       |          1.21 | abs(result) \< tolerance | Minnesota            |
| 7022 | GSLG      |          0.02 | abs(result) \< tolerance | Minnesota            |
| 7124 | GSLE      |          0.91 | abs(result) \< tolerance | Minnesota            |
| 7223 | Used      |         -1.94 | abs(result) \< tolerance | Minnesota            |
| 7323 | Other     |        -54.16 | abs(result) \< tolerance | Minnesota            |
| 1108 | 111CA     |         -0.33 | abs(result) \< tolerance | Mississippi          |
| 2107 | 113FF     |         -0.01 | abs(result) \< tolerance | Mississippi          |
| 3108 | 211       |          2.94 | abs(result) \< tolerance | Mississippi          |
| 4108 | 212       |          0.88 | abs(result) \< tolerance | Mississippi          |
| 5105 | 213       |         -0.04 | abs(result) \< tolerance | Mississippi          |
| 6107 | 22        |         -0.29 | abs(result) \< tolerance | Mississippi          |
| 752  | 23        |          0.26 | abs(result) \< tolerance | Mississippi          |
| 824  | 321       |         -0.59 | abs(result) \< tolerance | Mississippi          |
| 924  | 327       |         -0.21 | abs(result) \< tolerance | Mississippi          |
| 1024 | 331       |         -0.11 | abs(result) \< tolerance | Mississippi          |
| 1127 | 332       |          0.23 | abs(result) \< tolerance | Mississippi          |
| 1225 | 333       |         -0.16 | abs(result) \< tolerance | Mississippi          |
| 1323 | 334       |          1.39 | abs(result) \< tolerance | Mississippi          |
| 1424 | 335       |         -0.37 | abs(result) \< tolerance | Mississippi          |
| 1524 | 3361MV    |         -0.18 | abs(result) \< tolerance | Mississippi          |
| 1622 | 3364OT    |          0.08 | abs(result) \< tolerance | Mississippi          |
| 1723 | 337       |         -0.61 | abs(result) \< tolerance | Mississippi          |
| 1824 | 339       |          1.01 | abs(result) \< tolerance | Mississippi          |
| 1924 | 311FT     |          0.23 | abs(result) \< tolerance | Mississippi          |
| 2023 | 313TT     |         -0.45 | abs(result) \< tolerance | Mississippi          |
| 2128 | 315AL     |         -0.42 | abs(result) \< tolerance | Mississippi          |
| 2225 | 322       |         -0.09 | abs(result) \< tolerance | Mississippi          |
| 2323 | 323       |          0.14 | abs(result) \< tolerance | Mississippi          |
| 2424 | 324       |         -0.16 | abs(result) \< tolerance | Mississippi          |
| 2524 | 325       |          0.61 | abs(result) \< tolerance | Mississippi          |
| 2624 | 326       |         -0.25 | abs(result) \< tolerance | Mississippi          |
| 2724 | 42        |          0.42 | abs(result) \< tolerance | Mississippi          |
| 2824 | 441       |          0.44 | abs(result) \< tolerance | Mississippi          |
| 2924 | 445       |          0.13 | abs(result) \< tolerance | Mississippi          |
| 3024 | 452       |         -0.46 | abs(result) \< tolerance | Mississippi          |
| 3128 | 4A0       |         -0.10 | abs(result) \< tolerance | Mississippi          |
| 3225 | 481       |          5.54 | abs(result) \< tolerance | Mississippi          |
| 3324 | 482       |         -0.05 | abs(result) \< tolerance | Mississippi          |
| 3424 | 483       |         -0.41 | abs(result) \< tolerance | Mississippi          |
| 3524 | 484       |         -0.25 | abs(result) \< tolerance | Mississippi          |
| 3623 | 485       |          1.28 | abs(result) \< tolerance | Mississippi          |
| 3724 | 486       |          0.85 | abs(result) \< tolerance | Mississippi          |
| 3824 | 487OS     |          0.06 | abs(result) \< tolerance | Mississippi          |
| 3924 | 493       |         -0.32 | abs(result) \< tolerance | Mississippi          |
| 4024 | 511       |          1.18 | abs(result) \< tolerance | Mississippi          |
| 4127 | 512       |          2.06 | abs(result) \< tolerance | Mississippi          |
| 4225 | 513       |          0.26 | abs(result) \< tolerance | Mississippi          |
| 4324 | 514       |          3.54 | abs(result) \< tolerance | Mississippi          |
| 4423 | 521CI     |          0.03 | abs(result) \< tolerance | Mississippi          |
| 4524 | 523       |          3.38 | abs(result) \< tolerance | Mississippi          |
| 4623 | 524       |          0.28 | abs(result) \< tolerance | Mississippi          |
| 4724 | 525       |          0.32 | abs(result) \< tolerance | Mississippi          |
| 4823 | HS        |          0.08 | abs(result) \< tolerance | Mississippi          |
| 4924 | ORE       |          1.05 | abs(result) \< tolerance | Mississippi          |
| 5024 | 532RL     |          0.04 | abs(result) \< tolerance | Mississippi          |
| 5128 | 5411      |          0.28 | abs(result) \< tolerance | Mississippi          |
| 5224 | 5415      |          0.69 | abs(result) \< tolerance | Mississippi          |
| 5324 | 5412OP    |          0.53 | abs(result) \< tolerance | Mississippi          |
| 5422 | 55        |          0.74 | abs(result) \< tolerance | Mississippi          |
| 5524 | 561       |         -0.02 | abs(result) \< tolerance | Mississippi          |
| 5722 | 61        |          0.21 | abs(result) \< tolerance | Mississippi          |
| 5823 | 621       |         -0.15 | abs(result) \< tolerance | Mississippi          |
| 5923 | 622       |          0.05 | abs(result) \< tolerance | Mississippi          |
| 6024 | 623       |         -0.12 | abs(result) \< tolerance | Mississippi          |
| 6128 | 624       |         -0.06 | abs(result) \< tolerance | Mississippi          |
| 6225 | 711AS     |          2.50 | abs(result) \< tolerance | Mississippi          |
| 6324 | 713       |         -0.27 | abs(result) \< tolerance | Mississippi          |
| 6424 | 721       |         -0.30 | abs(result) \< tolerance | Mississippi          |
| 6522 | 722       |         -0.04 | abs(result) \< tolerance | Mississippi          |
| 6621 | 81        |         -0.06 | abs(result) \< tolerance | Mississippi          |
| 6724 | GFGD      |         -0.29 | abs(result) \< tolerance | Mississippi          |
| 6823 | GFGN      |         -0.39 | abs(result) \< tolerance | Mississippi          |
| 6923 | GFE       |         -0.25 | abs(result) \< tolerance | Mississippi          |
| 7125 | GSLE      |          0.02 | abs(result) \< tolerance | Mississippi          |
| 7224 | Used      |         -1.92 | abs(result) \< tolerance | Mississippi          |
| 7324 | Other     |         -0.98 | abs(result) \< tolerance | Mississippi          |
| 1109 | 111CA     |         -0.03 | abs(result) \< tolerance | Missouri             |
| 2108 | 113FF     |          0.43 | abs(result) \< tolerance | Missouri             |
| 3109 | 211       |        544.77 | abs(result) \< tolerance | Missouri             |
| 4109 | 212       |          0.03 | abs(result) \< tolerance | Missouri             |
| 5106 | 213       |          0.03 | abs(result) \< tolerance | Missouri             |
| 6108 | 22        |         -0.04 | abs(result) \< tolerance | Missouri             |
| 753  | 23        |         -0.04 | abs(result) \< tolerance | Missouri             |
| 925  | 327       |          0.06 | abs(result) \< tolerance | Missouri             |
| 1025 | 331       |          0.40 | abs(result) \< tolerance | Missouri             |
| 1128 | 332       |         -0.06 | abs(result) \< tolerance | Missouri             |
| 1226 | 333       |         -0.14 | abs(result) \< tolerance | Missouri             |
| 1324 | 334       |          0.17 | abs(result) \< tolerance | Missouri             |
| 1425 | 335       |         -0.31 | abs(result) \< tolerance | Missouri             |
| 1525 | 3361MV    |         -0.18 | abs(result) \< tolerance | Missouri             |
| 1623 | 3364OT    |          0.39 | abs(result) \< tolerance | Missouri             |
| 1724 | 337       |          0.01 | abs(result) \< tolerance | Missouri             |
| 1825 | 339       |         -0.03 | abs(result) \< tolerance | Missouri             |
| 1925 | 311FT     |         -0.26 | abs(result) \< tolerance | Missouri             |
| 2024 | 313TT     |          0.72 | abs(result) \< tolerance | Missouri             |
| 2129 | 315AL     |          0.25 | abs(result) \< tolerance | Missouri             |
| 2226 | 322       |         -0.14 | abs(result) \< tolerance | Missouri             |
| 2324 | 323       |         -0.42 | abs(result) \< tolerance | Missouri             |
| 2425 | 324       |          2.27 | abs(result) \< tolerance | Missouri             |
| 2525 | 325       |         -0.04 | abs(result) \< tolerance | Missouri             |
| 2625 | 326       |         -0.02 | abs(result) \< tolerance | Missouri             |
| 2725 | 42        |          0.02 | abs(result) \< tolerance | Missouri             |
| 2825 | 441       |          0.60 | abs(result) \< tolerance | Missouri             |
| 2925 | 445       |          0.01 | abs(result) \< tolerance | Missouri             |
| 3025 | 452       |         -0.28 | abs(result) \< tolerance | Missouri             |
| 3129 | 4A0       |         -0.05 | abs(result) \< tolerance | Missouri             |
| 3226 | 481       |          0.55 | abs(result) \< tolerance | Missouri             |
| 3325 | 482       |         -0.44 | abs(result) \< tolerance | Missouri             |
| 3425 | 483       |          0.57 | abs(result) \< tolerance | Missouri             |
| 3525 | 484       |         -0.24 | abs(result) \< tolerance | Missouri             |
| 3624 | 485       |          0.45 | abs(result) \< tolerance | Missouri             |
| 3725 | 486       |          2.08 | abs(result) \< tolerance | Missouri             |
| 3825 | 487OS     |          0.09 | abs(result) \< tolerance | Missouri             |
| 4025 | 511       |          0.09 | abs(result) \< tolerance | Missouri             |
| 4128 | 512       |          1.68 | abs(result) \< tolerance | Missouri             |
| 4226 | 513       |          0.17 | abs(result) \< tolerance | Missouri             |
| 4325 | 514       |          0.22 | abs(result) \< tolerance | Missouri             |
| 4424 | 521CI     |         -0.01 | abs(result) \< tolerance | Missouri             |
| 4525 | 523       |          0.07 | abs(result) \< tolerance | Missouri             |
| 4624 | 524       |          0.03 | abs(result) \< tolerance | Missouri             |
| 4725 | 525       |          1.64 | abs(result) \< tolerance | Missouri             |
| 4824 | HS        |         -0.09 | abs(result) \< tolerance | Missouri             |
| 4925 | ORE       |          1.11 | abs(result) \< tolerance | Missouri             |
| 5025 | 532RL     |         -0.13 | abs(result) \< tolerance | Missouri             |
| 5129 | 5411      |         -0.02 | abs(result) \< tolerance | Missouri             |
| 5225 | 5415      |         -0.05 | abs(result) \< tolerance | Missouri             |
| 5325 | 5412OP    |          0.10 | abs(result) \< tolerance | Missouri             |
| 5423 | 55        |         -0.33 | abs(result) \< tolerance | Missouri             |
| 5622 | 562       |          0.01 | abs(result) \< tolerance | Missouri             |
| 5723 | 61        |          0.14 | abs(result) \< tolerance | Missouri             |
| 5824 | 621       |          0.17 | abs(result) \< tolerance | Missouri             |
| 5924 | 622       |         -0.14 | abs(result) \< tolerance | Missouri             |
| 6025 | 623       |         -0.05 | abs(result) \< tolerance | Missouri             |
| 6129 | 624       |         -0.01 | abs(result) \< tolerance | Missouri             |
| 6226 | 711AS     |         -0.13 | abs(result) \< tolerance | Missouri             |
| 6325 | 713       |          0.28 | abs(result) \< tolerance | Missouri             |
| 6425 | 721       |          0.33 | abs(result) \< tolerance | Missouri             |
| 6622 | 81        |          0.09 | abs(result) \< tolerance | Missouri             |
| 6725 | GFGD      |         -0.33 | abs(result) \< tolerance | Missouri             |
| 6824 | GFGN      |          0.36 | abs(result) \< tolerance | Missouri             |
| 6924 | GFE       |          0.10 | abs(result) \< tolerance | Missouri             |
| 7023 | GSLG      |         -0.06 | abs(result) \< tolerance | Missouri             |
| 7126 | GSLE      |          0.61 | abs(result) \< tolerance | Missouri             |
| 7225 | Used      |          1.02 | abs(result) \< tolerance | Missouri             |
| 7325 | Other     |         -5.52 | abs(result) \< tolerance | Missouri             |
| 1129 | 111CA     |         -0.71 | abs(result) \< tolerance | Montana              |
| 2109 | 113FF     |         -0.01 | abs(result) \< tolerance | Montana              |
| 3130 | 211       |          1.15 | abs(result) \< tolerance | Montana              |
| 4129 | 212       |         -0.73 | abs(result) \< tolerance | Montana              |
| 6109 | 22        |         -0.20 | abs(result) \< tolerance | Montana              |
| 754  | 23        |         -0.09 | abs(result) \< tolerance | Montana              |
| 825  | 321       |         -0.58 | abs(result) \< tolerance | Montana              |
| 926  | 327       |         -0.05 | abs(result) \< tolerance | Montana              |
| 1026 | 331       |          1.67 | abs(result) \< tolerance | Montana              |
| 1130 | 332       |          0.35 | abs(result) \< tolerance | Montana              |
| 1227 | 333       |          1.05 | abs(result) \< tolerance | Montana              |
| 1325 | 334       |          1.68 | abs(result) \< tolerance | Montana              |
| 1426 | 335       |          4.05 | abs(result) \< tolerance | Montana              |
| 1526 | 3361MV    |          6.41 | abs(result) \< tolerance | Montana              |
| 1624 | 3364OT    |          4.20 | abs(result) \< tolerance | Montana              |
| 1725 | 337       |          1.08 | abs(result) \< tolerance | Montana              |
| 1826 | 339       |          0.28 | abs(result) \< tolerance | Montana              |
| 1926 | 311FT     |          1.75 | abs(result) \< tolerance | Montana              |
| 2025 | 313TT     |          1.59 | abs(result) \< tolerance | Montana              |
| 2130 | 315AL     |          2.30 | abs(result) \< tolerance | Montana              |
| 2227 | 322       |          7.79 | abs(result) \< tolerance | Montana              |
| 2325 | 323       |          0.18 | abs(result) \< tolerance | Montana              |
| 2426 | 324       |         -0.58 | abs(result) \< tolerance | Montana              |
| 2526 | 325       |          1.92 | abs(result) \< tolerance | Montana              |
| 2626 | 326       |          3.72 | abs(result) \< tolerance | Montana              |
| 2726 | 42        |          0.23 | abs(result) \< tolerance | Montana              |
| 2826 | 441       |          0.78 | abs(result) \< tolerance | Montana              |
| 2926 | 445       |          0.17 | abs(result) \< tolerance | Montana              |
| 3026 | 452       |         -0.05 | abs(result) \< tolerance | Montana              |
| 3131 | 4A0       |          0.03 | abs(result) \< tolerance | Montana              |
| 3227 | 481       |          1.05 | abs(result) \< tolerance | Montana              |
| 3326 | 482       |         -0.69 | abs(result) \< tolerance | Montana              |
| 3426 | 483       |         12.54 | abs(result) \< tolerance | Montana              |
| 3526 | 484       |         -0.14 | abs(result) \< tolerance | Montana              |
| 3625 | 485       |          0.97 | abs(result) \< tolerance | Montana              |
| 3726 | 486       |          0.74 | abs(result) \< tolerance | Montana              |
| 3826 | 487OS     |          0.14 | abs(result) \< tolerance | Montana              |
| 3925 | 493       |          6.11 | abs(result) \< tolerance | Montana              |
| 4026 | 511       |          0.55 | abs(result) \< tolerance | Montana              |
| 4130 | 512       |          0.65 | abs(result) \< tolerance | Montana              |
| 4227 | 513       |          0.49 | abs(result) \< tolerance | Montana              |
| 4326 | 514       |          1.83 | abs(result) \< tolerance | Montana              |
| 4425 | 521CI     |          0.26 | abs(result) \< tolerance | Montana              |
| 4526 | 523       |          1.27 | abs(result) \< tolerance | Montana              |
| 4625 | 524       |          0.61 | abs(result) \< tolerance | Montana              |
| 4726 | 525       |          2.89 | abs(result) \< tolerance | Montana              |
| 4825 | HS        |         -0.16 | abs(result) \< tolerance | Montana              |
| 4926 | ORE       |          0.75 | abs(result) \< tolerance | Montana              |
| 5026 | 532RL     |         -0.04 | abs(result) \< tolerance | Montana              |
| 5130 | 5411      |          0.47 | abs(result) \< tolerance | Montana              |
| 5226 | 5415      |          0.23 | abs(result) \< tolerance | Montana              |
| 5326 | 5412OP    |          0.25 | abs(result) \< tolerance | Montana              |
| 5424 | 55        |          2.67 | abs(result) \< tolerance | Montana              |
| 5525 | 561       |          0.35 | abs(result) \< tolerance | Montana              |
| 5623 | 562       |         -0.04 | abs(result) \< tolerance | Montana              |
| 5724 | 61        |          0.63 | abs(result) \< tolerance | Montana              |
| 5825 | 621       |         -0.03 | abs(result) \< tolerance | Montana              |
| 5925 | 622       |         -0.40 | abs(result) \< tolerance | Montana              |
| 6026 | 623       |         -0.22 | abs(result) \< tolerance | Montana              |
| 6130 | 624       |          0.07 | abs(result) \< tolerance | Montana              |
| 6227 | 711AS     |          0.79 | abs(result) \< tolerance | Montana              |
| 6326 | 713       |         -0.29 | abs(result) \< tolerance | Montana              |
| 6426 | 721       |         -0.33 | abs(result) \< tolerance | Montana              |
| 6523 | 722       |          0.07 | abs(result) \< tolerance | Montana              |
| 6623 | 81        |          0.04 | abs(result) \< tolerance | Montana              |
| 6726 | GFGD      |         -0.23 | abs(result) \< tolerance | Montana              |
| 6825 | GFGN      |          0.21 | abs(result) \< tolerance | Montana              |
| 6925 | GFE       |         -0.39 | abs(result) \< tolerance | Montana              |
| 7024 | GSLG      |         -0.07 | abs(result) \< tolerance | Montana              |
| 7127 | GSLE      |          0.66 | abs(result) \< tolerance | Montana              |
| 7226 | Used      |          6.44 | abs(result) \< tolerance | Montana              |
| 7326 | Other     |          7.35 | abs(result) \< tolerance | Montana              |
| 1131 | 111CA     |         -0.64 | abs(result) \< tolerance | Nebraska             |
| 2131 | 113FF     |          0.69 | abs(result) \< tolerance | Nebraska             |
| 3132 | 211       |         12.43 | abs(result) \< tolerance | Nebraska             |
| 4131 | 212       |          1.42 | abs(result) \< tolerance | Nebraska             |
| 5107 | 213       |          0.03 | abs(result) \< tolerance | Nebraska             |
| 6131 | 22        |         -0.44 | abs(result) \< tolerance | Nebraska             |
| 755  | 23        |          0.07 | abs(result) \< tolerance | Nebraska             |
| 826  | 321       |          0.57 | abs(result) \< tolerance | Nebraska             |
| 927  | 327       |          0.04 | abs(result) \< tolerance | Nebraska             |
| 1027 | 331       |          0.59 | abs(result) \< tolerance | Nebraska             |
| 1132 | 332       |          0.04 | abs(result) \< tolerance | Nebraska             |
| 1228 | 333       |         -0.09 | abs(result) \< tolerance | Nebraska             |
| 1326 | 334       |          0.28 | abs(result) \< tolerance | Nebraska             |
| 1427 | 335       |          0.26 | abs(result) \< tolerance | Nebraska             |
| 1527 | 3361MV    |          0.29 | abs(result) \< tolerance | Nebraska             |
| 1625 | 3364OT    |          0.92 | abs(result) \< tolerance | Nebraska             |
| 1726 | 337       |          0.17 | abs(result) \< tolerance | Nebraska             |
| 1827 | 339       |         -0.42 | abs(result) \< tolerance | Nebraska             |
| 1927 | 311FT     |         -0.28 | abs(result) \< tolerance | Nebraska             |
| 2026 | 313TT     |          0.54 | abs(result) \< tolerance | Nebraska             |
| 2132 | 315AL     |          0.49 | abs(result) \< tolerance | Nebraska             |
| 2228 | 322       |          1.36 | abs(result) \< tolerance | Nebraska             |
| 2326 | 323       |          0.02 | abs(result) \< tolerance | Nebraska             |
| 2427 | 324       |         21.20 | abs(result) \< tolerance | Nebraska             |
| 2627 | 326       |          0.02 | abs(result) \< tolerance | Nebraska             |
| 2727 | 42        |          0.12 | abs(result) \< tolerance | Nebraska             |
| 2827 | 441       |          0.78 | abs(result) \< tolerance | Nebraska             |
| 2927 | 445       |         -0.18 | abs(result) \< tolerance | Nebraska             |
| 3027 | 452       |         -0.03 | abs(result) \< tolerance | Nebraska             |
| 3133 | 4A0       |          0.12 | abs(result) \< tolerance | Nebraska             |
| 3228 | 481       |          2.56 | abs(result) \< tolerance | Nebraska             |
| 3327 | 482       |         -0.72 | abs(result) \< tolerance | Nebraska             |
| 3427 | 483       |         20.17 | abs(result) \< tolerance | Nebraska             |
| 3527 | 484       |         -0.42 | abs(result) \< tolerance | Nebraska             |
| 3626 | 485       |          1.26 | abs(result) \< tolerance | Nebraska             |
| 3727 | 486       |         -0.83 | abs(result) \< tolerance | Nebraska             |
| 3827 | 487OS     |          0.44 | abs(result) \< tolerance | Nebraska             |
| 3926 | 493       |          0.08 | abs(result) \< tolerance | Nebraska             |
| 4027 | 511       |         -0.06 | abs(result) \< tolerance | Nebraska             |
| 4132 | 512       |          4.07 | abs(result) \< tolerance | Nebraska             |
| 4228 | 513       |          0.44 | abs(result) \< tolerance | Nebraska             |
| 4327 | 514       |         -0.06 | abs(result) \< tolerance | Nebraska             |
| 4426 | 521CI     |          0.37 | abs(result) \< tolerance | Nebraska             |
| 4527 | 523       |          0.84 | abs(result) \< tolerance | Nebraska             |
| 4626 | 524       |         -0.43 | abs(result) \< tolerance | Nebraska             |
| 4727 | 525       |          2.32 | abs(result) \< tolerance | Nebraska             |
| 4826 | HS        |         -0.18 | abs(result) \< tolerance | Nebraska             |
| 4927 | ORE       |          1.46 | abs(result) \< tolerance | Nebraska             |
| 5027 | 532RL     |          0.61 | abs(result) \< tolerance | Nebraska             |
| 5131 | 5411      |          0.53 | abs(result) \< tolerance | Nebraska             |
| 5227 | 5415      |          0.12 | abs(result) \< tolerance | Nebraska             |
| 5327 | 5412OP    |          0.34 | abs(result) \< tolerance | Nebraska             |
| 5425 | 55        |         -0.29 | abs(result) \< tolerance | Nebraska             |
| 5624 | 562       |         -0.04 | abs(result) \< tolerance | Nebraska             |
| 5725 | 61        |          0.09 | abs(result) \< tolerance | Nebraska             |
| 5826 | 621       |         -0.10 | abs(result) \< tolerance | Nebraska             |
| 5926 | 622       |         -0.15 | abs(result) \< tolerance | Nebraska             |
| 6027 | 623       |         -0.41 | abs(result) \< tolerance | Nebraska             |
| 6132 | 624       |         -0.14 | abs(result) \< tolerance | Nebraska             |
| 6228 | 711AS     |          0.60 | abs(result) \< tolerance | Nebraska             |
| 6327 | 713       |         -0.14 | abs(result) \< tolerance | Nebraska             |
| 6427 | 721       |          0.58 | abs(result) \< tolerance | Nebraska             |
| 6624 | 81        |         -0.01 | abs(result) \< tolerance | Nebraska             |
| 6727 | GFGD      |         -0.20 | abs(result) \< tolerance | Nebraska             |
| 6826 | GFGN      |          0.24 | abs(result) \< tolerance | Nebraska             |
| 6926 | GFE       |          0.47 | abs(result) \< tolerance | Nebraska             |
| 7025 | GSLG      |         -0.29 | abs(result) \< tolerance | Nebraska             |
| 7128 | GSLE      |          0.29 | abs(result) \< tolerance | Nebraska             |
| 7227 | Used      |          2.20 | abs(result) \< tolerance | Nebraska             |
| 7327 | Other     |        -28.63 | abs(result) \< tolerance | Nebraska             |
| 1133 | 111CA     |          0.98 | abs(result) \< tolerance | Nevada               |
| 2133 | 113FF     |          0.65 | abs(result) \< tolerance | Nevada               |
| 3134 | 211       |        186.38 | abs(result) \< tolerance | Nevada               |
| 4133 | 212       |         -0.55 | abs(result) \< tolerance | Nevada               |
| 5108 | 213       |         -0.03 | abs(result) \< tolerance | Nevada               |
| 6133 | 22        |          0.17 | abs(result) \< tolerance | Nevada               |
| 756  | 23        |         -0.24 | abs(result) \< tolerance | Nevada               |
| 827  | 321       |          1.92 | abs(result) \< tolerance | Nevada               |
| 928  | 327       |          0.02 | abs(result) \< tolerance | Nevada               |
| 1028 | 331       |          0.23 | abs(result) \< tolerance | Nevada               |
| 1134 | 332       |          0.46 | abs(result) \< tolerance | Nevada               |
| 1229 | 333       |          1.24 | abs(result) \< tolerance | Nevada               |
| 1327 | 334       |          0.60 | abs(result) \< tolerance | Nevada               |
| 1428 | 335       |          0.94 | abs(result) \< tolerance | Nevada               |
| 1528 | 3361MV    |          7.03 | abs(result) \< tolerance | Nevada               |
| 1626 | 3364OT    |          1.51 | abs(result) \< tolerance | Nevada               |
| 1727 | 337       |          1.27 | abs(result) \< tolerance | Nevada               |
| 1828 | 339       |         -0.35 | abs(result) \< tolerance | Nevada               |
| 1928 | 311FT     |          2.16 | abs(result) \< tolerance | Nevada               |
| 2027 | 313TT     |          0.25 | abs(result) \< tolerance | Nevada               |
| 2134 | 315AL     |         -0.36 | abs(result) \< tolerance | Nevada               |
| 2229 | 322       |          2.04 | abs(result) \< tolerance | Nevada               |
| 2327 | 323       |          0.07 | abs(result) \< tolerance | Nevada               |
| 2428 | 324       |          6.38 | abs(result) \< tolerance | Nevada               |
| 2527 | 325       |          1.17 | abs(result) \< tolerance | Nevada               |
| 2628 | 326       |          0.49 | abs(result) \< tolerance | Nevada               |
| 2728 | 42        |          0.24 | abs(result) \< tolerance | Nevada               |
| 2828 | 441       |          0.35 | abs(result) \< tolerance | Nevada               |
| 2928 | 445       |         -0.05 | abs(result) \< tolerance | Nevada               |
| 3028 | 452       |         -0.28 | abs(result) \< tolerance | Nevada               |
| 3135 | 4A0       |         -0.14 | abs(result) \< tolerance | Nevada               |
| 3229 | 481       |         -0.52 | abs(result) \< tolerance | Nevada               |
| 3328 | 482       |          0.23 | abs(result) \< tolerance | Nevada               |
| 3428 | 483       |          6.24 | abs(result) \< tolerance | Nevada               |
| 3528 | 484       |          0.16 | abs(result) \< tolerance | Nevada               |
| 3627 | 485       |         -0.63 | abs(result) \< tolerance | Nevada               |
| 3728 | 486       |          4.77 | abs(result) \< tolerance | Nevada               |
| 3828 | 487OS     |         -0.03 | abs(result) \< tolerance | Nevada               |
| 3927 | 493       |         -0.32 | abs(result) \< tolerance | Nevada               |
| 4028 | 511       |          0.37 | abs(result) \< tolerance | Nevada               |
| 4134 | 512       |          0.02 | abs(result) \< tolerance | Nevada               |
| 4229 | 513       |          0.52 | abs(result) \< tolerance | Nevada               |
| 4328 | 514       |          0.61 | abs(result) \< tolerance | Nevada               |
| 4427 | 521CI     |          0.24 | abs(result) \< tolerance | Nevada               |
| 4528 | 523       |          2.64 | abs(result) \< tolerance | Nevada               |
| 4627 | 524       |          0.12 | abs(result) \< tolerance | Nevada               |
| 4728 | 525       |          0.26 | abs(result) \< tolerance | Nevada               |
| 4827 | HS        |         -0.22 | abs(result) \< tolerance | Nevada               |
| 4928 | ORE       |          0.71 | abs(result) \< tolerance | Nevada               |
| 5028 | 532RL     |         -0.23 | abs(result) \< tolerance | Nevada               |
| 5132 | 5411      |          0.21 | abs(result) \< tolerance | Nevada               |
| 5228 | 5415      |          0.40 | abs(result) \< tolerance | Nevada               |
| 5328 | 5412OP    |          0.28 | abs(result) \< tolerance | Nevada               |
| 5426 | 55        |         -0.14 | abs(result) \< tolerance | Nevada               |
| 5526 | 561       |         -0.16 | abs(result) \< tolerance | Nevada               |
| 5625 | 562       |          0.20 | abs(result) \< tolerance | Nevada               |
| 5726 | 61        |          0.62 | abs(result) \< tolerance | Nevada               |
| 5827 | 621       |         -0.06 | abs(result) \< tolerance | Nevada               |
| 5927 | 622       |          0.09 | abs(result) \< tolerance | Nevada               |
| 6028 | 623       |          0.68 | abs(result) \< tolerance | Nevada               |
| 6134 | 624       |          0.38 | abs(result) \< tolerance | Nevada               |
| 6229 | 711AS     |         -0.60 | abs(result) \< tolerance | Nevada               |
| 6328 | 713       |         -0.73 | abs(result) \< tolerance | Nevada               |
| 6428 | 721       |         -0.90 | abs(result) \< tolerance | Nevada               |
| 6524 | 722       |         -0.45 | abs(result) \< tolerance | Nevada               |
| 6625 | 81        |          0.09 | abs(result) \< tolerance | Nevada               |
| 6728 | GFGD      |         -0.18 | abs(result) \< tolerance | Nevada               |
| 6827 | GFGN      |          0.35 | abs(result) \< tolerance | Nevada               |
| 6927 | GFE       |          0.55 | abs(result) \< tolerance | Nevada               |
| 7026 | GSLG      |         -0.20 | abs(result) \< tolerance | Nevada               |
| 7129 | GSLE      |          0.61 | abs(result) \< tolerance | Nevada               |
| 7228 | Used      |          3.92 | abs(result) \< tolerance | Nevada               |
| 7328 | Other     |        -40.17 | abs(result) \< tolerance | Nevada               |
| 1135 | 111CA     |          1.88 | abs(result) \< tolerance | New Hampshire        |
| 2135 | 113FF     |          0.11 | abs(result) \< tolerance | New Hampshire        |
| 3136 | 211       |        347.15 | abs(result) \< tolerance | New Hampshire        |
| 4135 | 212       |          0.42 | abs(result) \< tolerance | New Hampshire        |
| 5109 | 213       |         -0.03 | abs(result) \< tolerance | New Hampshire        |
| 6135 | 22        |          0.09 | abs(result) \< tolerance | New Hampshire        |
| 757  | 23        |          0.18 | abs(result) \< tolerance | New Hampshire        |
| 828  | 321       |         -0.26 | abs(result) \< tolerance | New Hampshire        |
| 929  | 327       |         -0.26 | abs(result) \< tolerance | New Hampshire        |
| 1029 | 331       |          0.16 | abs(result) \< tolerance | New Hampshire        |
| 1136 | 332       |         -0.53 | abs(result) \< tolerance | New Hampshire        |
| 1230 | 333       |         -0.13 | abs(result) \< tolerance | New Hampshire        |
| 1328 | 334       |         -0.20 | abs(result) \< tolerance | New Hampshire        |
| 1429 | 335       |         -0.49 | abs(result) \< tolerance | New Hampshire        |
| 1529 | 3361MV    |          1.78 | abs(result) \< tolerance | New Hampshire        |
| 1627 | 3364OT    |          0.73 | abs(result) \< tolerance | New Hampshire        |
| 1728 | 337       |          0.79 | abs(result) \< tolerance | New Hampshire        |
| 1829 | 339       |          1.02 | abs(result) \< tolerance | New Hampshire        |
| 1929 | 311FT     |          0.67 | abs(result) \< tolerance | New Hampshire        |
| 2028 | 313TT     |         -0.44 | abs(result) \< tolerance | New Hampshire        |
| 2136 | 315AL     |         -0.22 | abs(result) \< tolerance | New Hampshire        |
| 2230 | 322       |          0.90 | abs(result) \< tolerance | New Hampshire        |
| 2328 | 323       |         -0.17 | abs(result) \< tolerance | New Hampshire        |
| 2429 | 324       |          2.34 | abs(result) \< tolerance | New Hampshire        |
| 2528 | 325       |          9.00 | abs(result) \< tolerance | New Hampshire        |
| 2629 | 326       |         -0.37 | abs(result) \< tolerance | New Hampshire        |
| 2729 | 42        |         -0.10 | abs(result) \< tolerance | New Hampshire        |
| 2829 | 441       |          0.45 | abs(result) \< tolerance | New Hampshire        |
| 2929 | 445       |         -0.29 | abs(result) \< tolerance | New Hampshire        |
| 3029 | 452       |         -0.04 | abs(result) \< tolerance | New Hampshire        |
| 3137 | 4A0       |         -0.03 | abs(result) \< tolerance | New Hampshire        |
| 3230 | 481       |          2.30 | abs(result) \< tolerance | New Hampshire        |
| 3329 | 482       |          7.98 | abs(result) \< tolerance | New Hampshire        |
| 3429 | 483       |          8.95 | abs(result) \< tolerance | New Hampshire        |
| 3529 | 484       |          0.61 | abs(result) \< tolerance | New Hampshire        |
| 3628 | 485       |          0.14 | abs(result) \< tolerance | New Hampshire        |
| 3729 | 486       |          5.40 | abs(result) \< tolerance | New Hampshire        |
| 3829 | 487OS     |          0.22 | abs(result) \< tolerance | New Hampshire        |
| 3928 | 493       |          0.10 | abs(result) \< tolerance | New Hampshire        |
| 4029 | 511       |         -0.15 | abs(result) \< tolerance | New Hampshire        |
| 4136 | 512       |          0.98 | abs(result) \< tolerance | New Hampshire        |
| 4230 | 513       |          0.48 | abs(result) \< tolerance | New Hampshire        |
| 4329 | 514       |          0.45 | abs(result) \< tolerance | New Hampshire        |
| 4428 | 521CI     |          1.31 | abs(result) \< tolerance | New Hampshire        |
| 4529 | 523       |         -0.21 | abs(result) \< tolerance | New Hampshire        |
| 4628 | 524       |         -0.29 | abs(result) \< tolerance | New Hampshire        |
| 4729 | 525       |          3.55 | abs(result) \< tolerance | New Hampshire        |
| 4828 | HS        |         -0.25 | abs(result) \< tolerance | New Hampshire        |
| 4929 | ORE       |          0.60 | abs(result) \< tolerance | New Hampshire        |
| 5029 | 532RL     |          0.20 | abs(result) \< tolerance | New Hampshire        |
| 5133 | 5411      |          0.57 | abs(result) \< tolerance | New Hampshire        |
| 5229 | 5415      |         -0.13 | abs(result) \< tolerance | New Hampshire        |
| 5329 | 5412OP    |         -0.07 | abs(result) \< tolerance | New Hampshire        |
| 5427 | 55        |          0.20 | abs(result) \< tolerance | New Hampshire        |
| 5527 | 561       |         -0.12 | abs(result) \< tolerance | New Hampshire        |
| 5626 | 562       |         -0.09 | abs(result) \< tolerance | New Hampshire        |
| 5727 | 61        |         -0.27 | abs(result) \< tolerance | New Hampshire        |
| 5828 | 621       |         -0.03 | abs(result) \< tolerance | New Hampshire        |
| 5928 | 622       |         -0.05 | abs(result) \< tolerance | New Hampshire        |
| 6029 | 623       |          0.01 | abs(result) \< tolerance | New Hampshire        |
| 6136 | 624       |          0.25 | abs(result) \< tolerance | New Hampshire        |
| 6230 | 711AS     |          0.43 | abs(result) \< tolerance | New Hampshire        |
| 6329 | 713       |         -0.32 | abs(result) \< tolerance | New Hampshire        |
| 6429 | 721       |         -0.28 | abs(result) \< tolerance | New Hampshire        |
| 6525 | 722       |         -0.05 | abs(result) \< tolerance | New Hampshire        |
| 6626 | 81        |          0.12 | abs(result) \< tolerance | New Hampshire        |
| 6729 | GFGD      |         -0.85 | abs(result) \< tolerance | New Hampshire        |
| 6828 | GFGN      |         -0.49 | abs(result) \< tolerance | New Hampshire        |
| 6928 | GFE       |          0.61 | abs(result) \< tolerance | New Hampshire        |
| 7027 | GSLG      |         -0.07 | abs(result) \< tolerance | New Hampshire        |
| 7130 | GSLE      |          1.38 | abs(result) \< tolerance | New Hampshire        |
| 7229 | Used      |          0.19 | abs(result) \< tolerance | New Hampshire        |
| 7329 | Other     |        -36.36 | abs(result) \< tolerance | New Hampshire        |
| 1137 | 111CA     |          3.31 | abs(result) \< tolerance | New Jersey           |
| 2137 | 113FF     |         -0.25 | abs(result) \< tolerance | New Jersey           |
| 3138 | 211       |         26.77 | abs(result) \< tolerance | New Jersey           |
| 4137 | 212       |          1.22 | abs(result) \< tolerance | New Jersey           |
| 5134 | 213       |          0.02 | abs(result) \< tolerance | New Jersey           |
| 6137 | 22        |          0.02 | abs(result) \< tolerance | New Jersey           |
| 758  | 23        |          0.11 | abs(result) \< tolerance | New Jersey           |
| 829  | 321       |          3.04 | abs(result) \< tolerance | New Jersey           |
| 930  | 327       |          0.07 | abs(result) \< tolerance | New Jersey           |
| 1030 | 331       |          0.36 | abs(result) \< tolerance | New Jersey           |
| 1138 | 332       |          0.41 | abs(result) \< tolerance | New Jersey           |
| 1231 | 333       |          0.18 | abs(result) \< tolerance | New Jersey           |
| 1329 | 334       |          0.34 | abs(result) \< tolerance | New Jersey           |
| 1430 | 335       |          0.16 | abs(result) \< tolerance | New Jersey           |
| 1530 | 3361MV    |          5.50 | abs(result) \< tolerance | New Jersey           |
| 1628 | 3364OT    |          0.63 | abs(result) \< tolerance | New Jersey           |
| 1729 | 337       |          0.70 | abs(result) \< tolerance | New Jersey           |
| 1830 | 339       |          0.46 | abs(result) \< tolerance | New Jersey           |
| 1930 | 311FT     |          0.13 | abs(result) \< tolerance | New Jersey           |
| 2029 | 313TT     |          0.17 | abs(result) \< tolerance | New Jersey           |
| 2138 | 315AL     |          0.27 | abs(result) \< tolerance | New Jersey           |
| 2231 | 322       |          0.17 | abs(result) \< tolerance | New Jersey           |
| 2329 | 323       |         -0.07 | abs(result) \< tolerance | New Jersey           |
| 2430 | 324       |          0.12 | abs(result) \< tolerance | New Jersey           |
| 2529 | 325       |          1.12 | abs(result) \< tolerance | New Jersey           |
| 2730 | 42        |         -0.28 | abs(result) \< tolerance | New Jersey           |
| 2830 | 441       |          0.41 | abs(result) \< tolerance | New Jersey           |
| 2930 | 445       |         -0.39 | abs(result) \< tolerance | New Jersey           |
| 3030 | 452       |          0.05 | abs(result) \< tolerance | New Jersey           |
| 3139 | 4A0       |          0.10 | abs(result) \< tolerance | New Jersey           |
| 3231 | 481       |         -0.26 | abs(result) \< tolerance | New Jersey           |
| 3330 | 482       |          1.72 | abs(result) \< tolerance | New Jersey           |
| 3430 | 483       |         -0.03 | abs(result) \< tolerance | New Jersey           |
| 3530 | 484       |         -0.09 | abs(result) \< tolerance | New Jersey           |
| 3629 | 485       |         -0.28 | abs(result) \< tolerance | New Jersey           |
| 3730 | 486       |          2.91 | abs(result) \< tolerance | New Jersey           |
| 3830 | 487OS     |         -0.15 | abs(result) \< tolerance | New Jersey           |
| 3929 | 493       |         -0.24 | abs(result) \< tolerance | New Jersey           |
| 4030 | 511       |          0.04 | abs(result) \< tolerance | New Jersey           |
| 4138 | 512       |          0.60 | abs(result) \< tolerance | New Jersey           |
| 4231 | 513       |          0.11 | abs(result) \< tolerance | New Jersey           |
| 4330 | 514       |          0.09 | abs(result) \< tolerance | New Jersey           |
| 4429 | 521CI     |          1.04 | abs(result) \< tolerance | New Jersey           |
| 4530 | 523       |         -0.18 | abs(result) \< tolerance | New Jersey           |
| 4629 | 524       |         -0.07 | abs(result) \< tolerance | New Jersey           |
| 4730 | 525       |          0.62 | abs(result) \< tolerance | New Jersey           |
| 4829 | HS        |         -0.33 | abs(result) \< tolerance | New Jersey           |
| 4930 | ORE       |          0.44 | abs(result) \< tolerance | New Jersey           |
| 5030 | 532RL     |          0.13 | abs(result) \< tolerance | New Jersey           |
| 5135 | 5411      |          0.05 | abs(result) \< tolerance | New Jersey           |
| 5230 | 5415      |          0.01 | abs(result) \< tolerance | New Jersey           |
| 5330 | 5412OP    |         -0.28 | abs(result) \< tolerance | New Jersey           |
| 5428 | 55        |         -0.37 | abs(result) \< tolerance | New Jersey           |
| 5528 | 561       |         -0.18 | abs(result) \< tolerance | New Jersey           |
| 5627 | 562       |         -0.20 | abs(result) \< tolerance | New Jersey           |
| 5728 | 61        |          0.04 | abs(result) \< tolerance | New Jersey           |
| 5829 | 621       |         -0.07 | abs(result) \< tolerance | New Jersey           |
| 5929 | 622       |          0.04 | abs(result) \< tolerance | New Jersey           |
| 6030 | 623       |         -0.01 | abs(result) \< tolerance | New Jersey           |
| 6138 | 624       |          0.12 | abs(result) \< tolerance | New Jersey           |
| 6231 | 711AS     |          0.17 | abs(result) \< tolerance | New Jersey           |
| 6330 | 713       |          0.11 | abs(result) \< tolerance | New Jersey           |
| 6430 | 721       |          0.18 | abs(result) \< tolerance | New Jersey           |
| 6526 | 722       |          0.16 | abs(result) \< tolerance | New Jersey           |
| 6627 | 81        |          0.13 | abs(result) \< tolerance | New Jersey           |
| 6730 | GFGD      |         -0.54 | abs(result) \< tolerance | New Jersey           |
| 6829 | GFGN      |          3.14 | abs(result) \< tolerance | New Jersey           |
| 6929 | GFE       |          1.36 | abs(result) \< tolerance | New Jersey           |
| 7028 | GSLG      |         -0.04 | abs(result) \< tolerance | New Jersey           |
| 7131 | GSLE      |          1.50 | abs(result) \< tolerance | New Jersey           |
| 7230 | Used      |          4.26 | abs(result) \< tolerance | New Jersey           |
| 7330 | Other     |        -60.16 | abs(result) \< tolerance | New Jersey           |
| 1139 | 111CA     |         -0.59 | abs(result) \< tolerance | New Mexico           |
| 3140 | 211       |         -0.64 | abs(result) \< tolerance | New Mexico           |
| 4139 | 212       |         -0.66 | abs(result) \< tolerance | New Mexico           |
| 5136 | 213       |         -0.05 | abs(result) \< tolerance | New Mexico           |
| 6139 | 22        |         -0.15 | abs(result) \< tolerance | New Mexico           |
| 759  | 23        |          0.11 | abs(result) \< tolerance | New Mexico           |
| 830  | 321       |          1.22 | abs(result) \< tolerance | New Mexico           |
| 931  | 327       |         -0.15 | abs(result) \< tolerance | New Mexico           |
| 1031 | 331       |          0.98 | abs(result) \< tolerance | New Mexico           |
| 1140 | 332       |          1.71 | abs(result) \< tolerance | New Mexico           |
| 1232 | 333       |          1.98 | abs(result) \< tolerance | New Mexico           |
| 1330 | 334       |          0.56 | abs(result) \< tolerance | New Mexico           |
| 1431 | 335       |          1.70 | abs(result) \< tolerance | New Mexico           |
| 1531 | 3361MV    |         13.84 | abs(result) \< tolerance | New Mexico           |
| 1629 | 3364OT    |          1.94 | abs(result) \< tolerance | New Mexico           |
| 1730 | 337       |          2.95 | abs(result) \< tolerance | New Mexico           |
| 1831 | 339       |          2.50 | abs(result) \< tolerance | New Mexico           |
| 1931 | 311FT     |          1.03 | abs(result) \< tolerance | New Mexico           |
| 2030 | 313TT     |          3.93 | abs(result) \< tolerance | New Mexico           |
| 2139 | 315AL     |          4.23 | abs(result) \< tolerance | New Mexico           |
| 2232 | 322       |          0.71 | abs(result) \< tolerance | New Mexico           |
| 2330 | 323       |          1.53 | abs(result) \< tolerance | New Mexico           |
| 2431 | 324       |         -0.09 | abs(result) \< tolerance | New Mexico           |
| 2530 | 325       |          3.40 | abs(result) \< tolerance | New Mexico           |
| 2630 | 326       |          1.47 | abs(result) \< tolerance | New Mexico           |
| 2731 | 42        |          0.53 | abs(result) \< tolerance | New Mexico           |
| 2831 | 441       |          0.52 | abs(result) \< tolerance | New Mexico           |
| 2931 | 445       |          0.23 | abs(result) \< tolerance | New Mexico           |
| 3031 | 452       |         -0.18 | abs(result) \< tolerance | New Mexico           |
| 3141 | 4A0       |          0.25 | abs(result) \< tolerance | New Mexico           |
| 3232 | 481       |          0.91 | abs(result) \< tolerance | New Mexico           |
| 3331 | 482       |         -0.59 | abs(result) \< tolerance | New Mexico           |
| 3431 | 483       |          2.57 | abs(result) \< tolerance | New Mexico           |
| 3531 | 484       |         -0.15 | abs(result) \< tolerance | New Mexico           |
| 3630 | 485       |          0.47 | abs(result) \< tolerance | New Mexico           |
| 3731 | 486       |          3.22 | abs(result) \< tolerance | New Mexico           |
| 3831 | 487OS     |          0.19 | abs(result) \< tolerance | New Mexico           |
| 3930 | 493       |          1.61 | abs(result) \< tolerance | New Mexico           |
| 4031 | 511       |          0.90 | abs(result) \< tolerance | New Mexico           |
| 4140 | 512       |         -0.27 | abs(result) \< tolerance | New Mexico           |
| 4232 | 513       |          0.25 | abs(result) \< tolerance | New Mexico           |
| 4331 | 514       |          3.91 | abs(result) \< tolerance | New Mexico           |
| 4430 | 521CI     |          1.25 | abs(result) \< tolerance | New Mexico           |
| 4531 | 523       |          1.61 | abs(result) \< tolerance | New Mexico           |
| 4630 | 524       |          0.56 | abs(result) \< tolerance | New Mexico           |
| 4731 | 525       |          1.06 | abs(result) \< tolerance | New Mexico           |
| 4830 | HS        |         -0.13 | abs(result) \< tolerance | New Mexico           |
| 4931 | ORE       |          0.63 | abs(result) \< tolerance | New Mexico           |
| 5031 | 532RL     |          0.14 | abs(result) \< tolerance | New Mexico           |
| 5137 | 5411      |          0.49 | abs(result) \< tolerance | New Mexico           |
| 5231 | 5415      |          0.69 | abs(result) \< tolerance | New Mexico           |
| 5331 | 5412OP    |         -0.09 | abs(result) \< tolerance | New Mexico           |
| 5429 | 55        |          1.97 | abs(result) \< tolerance | New Mexico           |
| 5529 | 561       |          0.03 | abs(result) \< tolerance | New Mexico           |
| 5628 | 562       |         -0.20 | abs(result) \< tolerance | New Mexico           |
| 5729 | 61        |          0.14 | abs(result) \< tolerance | New Mexico           |
| 5830 | 621       |         -0.27 | abs(result) \< tolerance | New Mexico           |
| 5930 | 622       |         -0.22 | abs(result) \< tolerance | New Mexico           |
| 6140 | 624       |         -0.47 | abs(result) \< tolerance | New Mexico           |
| 6232 | 711AS     |          0.44 | abs(result) \< tolerance | New Mexico           |
| 6331 | 713       |         -0.11 | abs(result) \< tolerance | New Mexico           |
| 6431 | 721       |          0.04 | abs(result) \< tolerance | New Mexico           |
| 6527 | 722       |          0.03 | abs(result) \< tolerance | New Mexico           |
| 6628 | 81        |         -0.12 | abs(result) \< tolerance | New Mexico           |
| 6731 | GFGD      |         -0.67 | abs(result) \< tolerance | New Mexico           |
| 6830 | GFGN      |         -0.66 | abs(result) \< tolerance | New Mexico           |
| 6930 | GFE       |         -0.76 | abs(result) \< tolerance | New Mexico           |
| 7029 | GSLG      |         -0.01 | abs(result) \< tolerance | New Mexico           |
| 7132 | GSLE      |          0.18 | abs(result) \< tolerance | New Mexico           |
| 7231 | Used      |          0.34 | abs(result) \< tolerance | New Mexico           |
| 7331 | Other     |         39.37 | abs(result) \< tolerance | New Mexico           |
| 1141 | 111CA     |          1.36 | abs(result) \< tolerance | New York             |
| 2140 | 113FF     |          1.07 | abs(result) \< tolerance | New York             |
| 3142 | 211       |         20.12 | abs(result) \< tolerance | New York             |
| 4141 | 212       |          1.61 | abs(result) \< tolerance | New York             |
| 5138 | 213       |          0.08 | abs(result) \< tolerance | New York             |
| 6141 | 22        |         -0.02 | abs(result) \< tolerance | New York             |
| 760  | 23        |          0.12 | abs(result) \< tolerance | New York             |
| 831  | 321       |          1.66 | abs(result) \< tolerance | New York             |
| 932  | 327       |          0.12 | abs(result) \< tolerance | New York             |
| 1032 | 331       |          1.06 | abs(result) \< tolerance | New York             |
| 1142 | 332       |          0.25 | abs(result) \< tolerance | New York             |
| 1331 | 334       |          0.08 | abs(result) \< tolerance | New York             |
| 1432 | 335       |          0.92 | abs(result) \< tolerance | New York             |
| 1532 | 3361MV    |          1.50 | abs(result) \< tolerance | New York             |
| 1630 | 3364OT    |          0.39 | abs(result) \< tolerance | New York             |
| 1731 | 337       |          0.72 | abs(result) \< tolerance | New York             |
| 1832 | 339       |          0.79 | abs(result) \< tolerance | New York             |
| 1932 | 311FT     |          0.28 | abs(result) \< tolerance | New York             |
| 2031 | 313TT     |          0.18 | abs(result) \< tolerance | New York             |
| 2141 | 315AL     |         -0.49 | abs(result) \< tolerance | New York             |
| 2233 | 322       |          0.53 | abs(result) \< tolerance | New York             |
| 2331 | 323       |          0.75 | abs(result) \< tolerance | New York             |
| 2432 | 324       |          4.63 | abs(result) \< tolerance | New York             |
| 2531 | 325       |          1.34 | abs(result) \< tolerance | New York             |
| 2631 | 326       |          0.09 | abs(result) \< tolerance | New York             |
| 2732 | 42        |         -0.09 | abs(result) \< tolerance | New York             |
| 2832 | 441       |          0.39 | abs(result) \< tolerance | New York             |
| 2932 | 445       |         -0.42 | abs(result) \< tolerance | New York             |
| 3143 | 4A0       |         -0.03 | abs(result) \< tolerance | New York             |
| 3233 | 481       |          0.14 | abs(result) \< tolerance | New York             |
| 3332 | 482       |          0.83 | abs(result) \< tolerance | New York             |
| 3432 | 483       |          0.33 | abs(result) \< tolerance | New York             |
| 3532 | 484       |          0.91 | abs(result) \< tolerance | New York             |
| 3631 | 485       |         -0.53 | abs(result) \< tolerance | New York             |
| 3732 | 486       |          1.72 | abs(result) \< tolerance | New York             |
| 3832 | 487OS     |          0.27 | abs(result) \< tolerance | New York             |
| 3931 | 493       |          1.41 | abs(result) \< tolerance | New York             |
| 4032 | 511       |         -0.14 | abs(result) \< tolerance | New York             |
| 4142 | 512       |         -0.24 | abs(result) \< tolerance | New York             |
| 4233 | 513       |         -0.28 | abs(result) \< tolerance | New York             |
| 4332 | 514       |         -0.23 | abs(result) \< tolerance | New York             |
| 4431 | 521CI     |         -0.55 | abs(result) \< tolerance | New York             |
| 4532 | 523       |         -0.59 | abs(result) \< tolerance | New York             |
| 4631 | 524       |         -0.19 | abs(result) \< tolerance | New York             |
| 4732 | 525       |         -0.32 | abs(result) \< tolerance | New York             |
| 4831 | HS        |         -0.40 | abs(result) \< tolerance | New York             |
| 4932 | ORE       |          0.74 | abs(result) \< tolerance | New York             |
| 5032 | 532RL     |         -0.05 | abs(result) \< tolerance | New York             |
| 5139 | 5411      |         -0.44 | abs(result) \< tolerance | New York             |
| 5232 | 5415      |          0.05 | abs(result) \< tolerance | New York             |
| 5332 | 5412OP    |         -0.08 | abs(result) \< tolerance | New York             |
| 5430 | 55        |         -0.08 | abs(result) \< tolerance | New York             |
| 5530 | 561       |          0.20 | abs(result) \< tolerance | New York             |
| 5629 | 562       |          0.17 | abs(result) \< tolerance | New York             |
| 5730 | 61        |         -0.35 | abs(result) \< tolerance | New York             |
| 5831 | 621       |          0.16 | abs(result) \< tolerance | New York             |
| 5931 | 622       |         -0.08 | abs(result) \< tolerance | New York             |
| 6031 | 623       |         -0.07 | abs(result) \< tolerance | New York             |
| 6142 | 624       |         -0.26 | abs(result) \< tolerance | New York             |
| 6233 | 711AS     |         -0.37 | abs(result) \< tolerance | New York             |
| 6332 | 713       |          0.13 | abs(result) \< tolerance | New York             |
| 6629 | 81        |          0.13 | abs(result) \< tolerance | New York             |
| 6732 | GFGD      |         -0.48 | abs(result) \< tolerance | New York             |
| 6831 | GFGN      |         -0.20 | abs(result) \< tolerance | New York             |
| 6931 | GFE       |          2.19 | abs(result) \< tolerance | New York             |
| 7030 | GSLG      |          0.07 | abs(result) \< tolerance | New York             |
| 7133 | GSLE      |          0.62 | abs(result) \< tolerance | New York             |
| 7232 | Used      |          0.63 | abs(result) \< tolerance | New York             |
| 7332 | Other     |        -27.44 | abs(result) \< tolerance | New York             |
| 1143 | 111CA     |          0.98 | abs(result) \< tolerance | North Carolina       |
| 2142 | 113FF     |          0.29 | abs(result) \< tolerance | North Carolina       |
| 3144 | 211       |        379.26 | abs(result) \< tolerance | North Carolina       |
| 4143 | 212       |          0.63 | abs(result) \< tolerance | North Carolina       |
| 5140 | 213       |          0.14 | abs(result) \< tolerance | North Carolina       |
| 6143 | 22        |          0.08 | abs(result) \< tolerance | North Carolina       |
| 761  | 23        |         -0.03 | abs(result) \< tolerance | North Carolina       |
| 832  | 321       |         -0.29 | abs(result) \< tolerance | North Carolina       |
| 933  | 327       |          0.02 | abs(result) \< tolerance | North Carolina       |
| 1033 | 331       |          0.84 | abs(result) \< tolerance | North Carolina       |
| 1144 | 332       |          0.12 | abs(result) \< tolerance | North Carolina       |
| 1233 | 333       |         -0.11 | abs(result) \< tolerance | North Carolina       |
| 1332 | 334       |         -0.32 | abs(result) \< tolerance | North Carolina       |
| 1433 | 335       |         -0.42 | abs(result) \< tolerance | North Carolina       |
| 1533 | 3361MV    |          0.07 | abs(result) \< tolerance | North Carolina       |
| 1631 | 3364OT    |         -0.38 | abs(result) \< tolerance | North Carolina       |
| 1732 | 337       |         -0.47 | abs(result) \< tolerance | North Carolina       |
| 1833 | 339       |          0.33 | abs(result) \< tolerance | North Carolina       |
| 1933 | 311FT     |         -0.49 | abs(result) \< tolerance | North Carolina       |
| 2032 | 313TT     |         -0.50 | abs(result) \< tolerance | North Carolina       |
| 2143 | 315AL     |         -0.05 | abs(result) \< tolerance | North Carolina       |
| 2234 | 322       |          0.11 | abs(result) \< tolerance | North Carolina       |
| 2433 | 324       |          5.66 | abs(result) \< tolerance | North Carolina       |
| 2532 | 325       |         -0.26 | abs(result) \< tolerance | North Carolina       |
| 2632 | 326       |         -0.29 | abs(result) \< tolerance | North Carolina       |
| 2733 | 42        |          0.10 | abs(result) \< tolerance | North Carolina       |
| 2833 | 441       |          0.62 | abs(result) \< tolerance | North Carolina       |
| 2933 | 445       |         -0.03 | abs(result) \< tolerance | North Carolina       |
| 3032 | 452       |         -0.20 | abs(result) \< tolerance | North Carolina       |
| 3145 | 4A0       |          0.11 | abs(result) \< tolerance | North Carolina       |
| 3234 | 481       |          0.05 | abs(result) \< tolerance | North Carolina       |
| 3333 | 482       |          2.08 | abs(result) \< tolerance | North Carolina       |
| 3433 | 483       |          8.28 | abs(result) \< tolerance | North Carolina       |
| 3533 | 484       |          0.14 | abs(result) \< tolerance | North Carolina       |
| 3632 | 485       |          0.89 | abs(result) \< tolerance | North Carolina       |
| 3733 | 486       |          2.82 | abs(result) \< tolerance | North Carolina       |
| 3833 | 487OS     |          0.13 | abs(result) \< tolerance | North Carolina       |
| 3932 | 493       |          0.08 | abs(result) \< tolerance | North Carolina       |
| 4033 | 511       |         -0.02 | abs(result) \< tolerance | North Carolina       |
| 4144 | 512       |          1.79 | abs(result) \< tolerance | North Carolina       |
| 4234 | 513       |          0.36 | abs(result) \< tolerance | North Carolina       |
| 4333 | 514       |          0.30 | abs(result) \< tolerance | North Carolina       |
| 4432 | 521CI     |         -0.43 | abs(result) \< tolerance | North Carolina       |
| 4533 | 523       |          0.09 | abs(result) \< tolerance | North Carolina       |
| 4632 | 524       |          0.33 | abs(result) \< tolerance | North Carolina       |
| 4733 | 525       |          2.54 | abs(result) \< tolerance | North Carolina       |
| 4832 | HS        |         -0.16 | abs(result) \< tolerance | North Carolina       |
| 4933 | ORE       |          0.81 | abs(result) \< tolerance | North Carolina       |
| 5033 | 532RL     |          0.05 | abs(result) \< tolerance | North Carolina       |
| 5141 | 5411      |          0.73 | abs(result) \< tolerance | North Carolina       |
| 5233 | 5415      |         -0.02 | abs(result) \< tolerance | North Carolina       |
| 5333 | 5412OP    |         -0.07 | abs(result) \< tolerance | North Carolina       |
| 5431 | 55        |         -0.16 | abs(result) \< tolerance | North Carolina       |
| 5531 | 561       |         -0.16 | abs(result) \< tolerance | North Carolina       |
| 5630 | 562       |          0.27 | abs(result) \< tolerance | North Carolina       |
| 5832 | 621       |          0.08 | abs(result) \< tolerance | North Carolina       |
| 5932 | 622       |          0.33 | abs(result) \< tolerance | North Carolina       |
| 6032 | 623       |          0.13 | abs(result) \< tolerance | North Carolina       |
| 6144 | 624       |          0.26 | abs(result) \< tolerance | North Carolina       |
| 6234 | 711AS     |          0.06 | abs(result) \< tolerance | North Carolina       |
| 6333 | 713       |          0.37 | abs(result) \< tolerance | North Carolina       |
| 6432 | 721       |          0.32 | abs(result) \< tolerance | North Carolina       |
| 6528 | 722       |         -0.02 | abs(result) \< tolerance | North Carolina       |
| 6630 | 81        |          0.13 | abs(result) \< tolerance | North Carolina       |
| 6733 | GFGD      |         -0.17 | abs(result) \< tolerance | North Carolina       |
| 6832 | GFGN      |         -0.19 | abs(result) \< tolerance | North Carolina       |
| 6932 | GFE       |          0.19 | abs(result) \< tolerance | North Carolina       |
| 7031 | GSLG      |         -0.12 | abs(result) \< tolerance | North Carolina       |
| 7134 | GSLE      |         -0.41 | abs(result) \< tolerance | North Carolina       |
| 7233 | Used      |          0.56 | abs(result) \< tolerance | North Carolina       |
| 7333 | Other     |        -19.68 | abs(result) \< tolerance | North Carolina       |
| 1145 | 111CA     |         -0.70 | abs(result) \< tolerance | North Dakota         |
| 2144 | 113FF     |          0.47 | abs(result) \< tolerance | North Dakota         |
| 3146 | 211       |         -0.78 | abs(result) \< tolerance | North Dakota         |
| 4145 | 212       |         -0.58 | abs(result) \< tolerance | North Dakota         |
| 5142 | 213       |          0.03 | abs(result) \< tolerance | North Dakota         |
| 6145 | 22        |         -0.33 | abs(result) \< tolerance | North Dakota         |
| 762  | 23        |         -0.17 | abs(result) \< tolerance | North Dakota         |
| 833  | 321       |         -0.19 | abs(result) \< tolerance | North Dakota         |
| 934  | 327       |         -0.04 | abs(result) \< tolerance | North Dakota         |
| 1034 | 331       |          0.62 | abs(result) \< tolerance | North Dakota         |
| 1146 | 332       |          1.50 | abs(result) \< tolerance | North Dakota         |
| 1234 | 333       |         -0.10 | abs(result) \< tolerance | North Dakota         |
| 1333 | 334       |          0.90 | abs(result) \< tolerance | North Dakota         |
| 1434 | 335       |          7.45 | abs(result) \< tolerance | North Dakota         |
| 1534 | 3361MV    |          1.43 | abs(result) \< tolerance | North Dakota         |
| 1632 | 3364OT    |         -0.03 | abs(result) \< tolerance | North Dakota         |
| 1733 | 337       |          1.16 | abs(result) \< tolerance | North Dakota         |
| 1834 | 339       |          2.45 | abs(result) \< tolerance | North Dakota         |
| 1934 | 311FT     |          0.07 | abs(result) \< tolerance | North Dakota         |
| 2033 | 313TT     |          0.71 | abs(result) \< tolerance | North Dakota         |
| 2145 | 315AL     |          2.59 | abs(result) \< tolerance | North Dakota         |
| 2235 | 322       |          6.08 | abs(result) \< tolerance | North Dakota         |
| 2332 | 323       |          1.23 | abs(result) \< tolerance | North Dakota         |
| 2434 | 324       |          0.67 | abs(result) \< tolerance | North Dakota         |
| 2533 | 325       |          4.18 | abs(result) \< tolerance | North Dakota         |
| 2633 | 326       |          0.22 | abs(result) \< tolerance | North Dakota         |
| 2734 | 42        |         -0.12 | abs(result) \< tolerance | North Dakota         |
| 2834 | 441       |          0.36 | abs(result) \< tolerance | North Dakota         |
| 2934 | 445       |         -0.09 | abs(result) \< tolerance | North Dakota         |
| 3033 | 452       |         -0.27 | abs(result) \< tolerance | North Dakota         |
| 3147 | 4A0       |         -0.13 | abs(result) \< tolerance | North Dakota         |
| 3235 | 481       |          4.59 | abs(result) \< tolerance | North Dakota         |
| 3334 | 482       |         -0.60 | abs(result) \< tolerance | North Dakota         |
| 3434 | 483       |          1.96 | abs(result) \< tolerance | North Dakota         |
| 3534 | 484       |         -0.48 | abs(result) \< tolerance | North Dakota         |
| 3633 | 485       |          0.42 | abs(result) \< tolerance | North Dakota         |
| 3734 | 486       |         -0.28 | abs(result) \< tolerance | North Dakota         |
| 3834 | 487OS     |          0.28 | abs(result) \< tolerance | North Dakota         |
| 3933 | 493       |          2.69 | abs(result) \< tolerance | North Dakota         |
| 4034 | 511       |         -0.05 | abs(result) \< tolerance | North Dakota         |
| 4146 | 512       |          2.91 | abs(result) \< tolerance | North Dakota         |
| 4235 | 513       |          0.51 | abs(result) \< tolerance | North Dakota         |
| 4334 | 514       |          2.32 | abs(result) \< tolerance | North Dakota         |
| 4433 | 521CI     |          0.38 | abs(result) \< tolerance | North Dakota         |
| 4534 | 523       |          2.24 | abs(result) \< tolerance | North Dakota         |
| 4633 | 524       |          0.18 | abs(result) \< tolerance | North Dakota         |
| 4734 | 525       |          1.58 | abs(result) \< tolerance | North Dakota         |
| 4833 | HS        |         -0.19 | abs(result) \< tolerance | North Dakota         |
| 4934 | ORE       |          1.21 | abs(result) \< tolerance | North Dakota         |
| 5034 | 532RL     |         -0.22 | abs(result) \< tolerance | North Dakota         |
| 5143 | 5411      |          1.98 | abs(result) \< tolerance | North Dakota         |
| 5234 | 5415      |          0.64 | abs(result) \< tolerance | North Dakota         |
| 5334 | 5412OP    |          0.47 | abs(result) \< tolerance | North Dakota         |
| 5432 | 55        |          0.84 | abs(result) \< tolerance | North Dakota         |
| 5532 | 561       |          0.69 | abs(result) \< tolerance | North Dakota         |
| 5631 | 562       |          0.65 | abs(result) \< tolerance | North Dakota         |
| 5731 | 61        |          0.80 | abs(result) \< tolerance | North Dakota         |
| 5933 | 622       |         -0.30 | abs(result) \< tolerance | North Dakota         |
| 6033 | 623       |         -0.51 | abs(result) \< tolerance | North Dakota         |
| 6146 | 624       |          0.01 | abs(result) \< tolerance | North Dakota         |
| 6235 | 711AS     |          2.42 | abs(result) \< tolerance | North Dakota         |
| 6334 | 713       |          0.12 | abs(result) \< tolerance | North Dakota         |
| 6433 | 721       |          0.18 | abs(result) \< tolerance | North Dakota         |
| 6529 | 722       |          0.17 | abs(result) \< tolerance | North Dakota         |
| 6631 | 81        |          0.03 | abs(result) \< tolerance | North Dakota         |
| 6734 | GFGD      |         -0.18 | abs(result) \< tolerance | North Dakota         |
| 6833 | GFGN      |          0.58 | abs(result) \< tolerance | North Dakota         |
| 6933 | GFE       |          1.73 | abs(result) \< tolerance | North Dakota         |
| 7032 | GSLG      |         -0.10 | abs(result) \< tolerance | North Dakota         |
| 7135 | GSLE      |          0.58 | abs(result) \< tolerance | North Dakota         |
| 7234 | Used      |          0.81 | abs(result) \< tolerance | North Dakota         |
| 7334 | Other     |        -88.27 | abs(result) \< tolerance | North Dakota         |
| 1147 | 111CA     |          1.26 | abs(result) \< tolerance | Ohio                 |
| 2146 | 113FF     |          0.88 | abs(result) \< tolerance | Ohio                 |
| 3148 | 211       |         76.02 | abs(result) \< tolerance | Ohio                 |
| 4147 | 212       |          0.43 | abs(result) \< tolerance | Ohio                 |
| 5144 | 213       |         -0.09 | abs(result) \< tolerance | Ohio                 |
| 6147 | 22        |          0.01 | abs(result) \< tolerance | Ohio                 |
| 763  | 23        |          0.03 | abs(result) \< tolerance | Ohio                 |
| 834  | 321       |          0.11 | abs(result) \< tolerance | Ohio                 |
| 935  | 327       |         -0.30 | abs(result) \< tolerance | Ohio                 |
| 1035 | 331       |         -0.34 | abs(result) \< tolerance | Ohio                 |
| 1148 | 332       |         -0.33 | abs(result) \< tolerance | Ohio                 |
| 1235 | 333       |         -0.14 | abs(result) \< tolerance | Ohio                 |
| 1334 | 334       |          0.89 | abs(result) \< tolerance | Ohio                 |
| 1435 | 335       |         -0.33 | abs(result) \< tolerance | Ohio                 |
| 1535 | 3361MV    |         -0.19 | abs(result) \< tolerance | Ohio                 |
| 1633 | 3364OT    |         -0.21 | abs(result) \< tolerance | Ohio                 |
| 1734 | 337       |         -0.09 | abs(result) \< tolerance | Ohio                 |
| 1835 | 339       |          0.03 | abs(result) \< tolerance | Ohio                 |
| 1935 | 311FT     |         -0.18 | abs(result) \< tolerance | Ohio                 |
| 2034 | 313TT     |          0.53 | abs(result) \< tolerance | Ohio                 |
| 2147 | 315AL     |          1.03 | abs(result) \< tolerance | Ohio                 |
| 2236 | 322       |          0.09 | abs(result) \< tolerance | Ohio                 |
| 2333 | 323       |         -0.36 | abs(result) \< tolerance | Ohio                 |
| 2435 | 324       |         -0.35 | abs(result) \< tolerance | Ohio                 |
| 2534 | 325       |         -0.22 | abs(result) \< tolerance | Ohio                 |
| 2634 | 326       |         -0.33 | abs(result) \< tolerance | Ohio                 |
| 2735 | 42        |          0.10 | abs(result) \< tolerance | Ohio                 |
| 2835 | 441       |          0.38 | abs(result) \< tolerance | Ohio                 |
| 2935 | 445       |         -0.10 | abs(result) \< tolerance | Ohio                 |
| 3034 | 452       |         -0.27 | abs(result) \< tolerance | Ohio                 |
| 3149 | 4A0       |         -0.05 | abs(result) \< tolerance | Ohio                 |
| 3236 | 481       |          0.40 | abs(result) \< tolerance | Ohio                 |
| 3335 | 482       |          0.18 | abs(result) \< tolerance | Ohio                 |
| 3435 | 483       |          1.46 | abs(result) \< tolerance | Ohio                 |
| 3535 | 484       |         -0.20 | abs(result) \< tolerance | Ohio                 |
| 3634 | 485       |          0.72 | abs(result) \< tolerance | Ohio                 |
| 3735 | 486       |         -0.03 | abs(result) \< tolerance | Ohio                 |
| 3934 | 493       |         -0.24 | abs(result) \< tolerance | Ohio                 |
| 4148 | 512       |          1.69 | abs(result) \< tolerance | Ohio                 |
| 4236 | 513       |          0.52 | abs(result) \< tolerance | Ohio                 |
| 4335 | 514       |          1.25 | abs(result) \< tolerance | Ohio                 |
| 4434 | 521CI     |         -0.28 | abs(result) \< tolerance | Ohio                 |
| 4535 | 523       |          0.59 | abs(result) \< tolerance | Ohio                 |
| 4634 | 524       |         -0.23 | abs(result) \< tolerance | Ohio                 |
| 4735 | 525       |          0.66 | abs(result) \< tolerance | Ohio                 |
| 4834 | HS        |         -0.19 | abs(result) \< tolerance | Ohio                 |
| 4935 | ORE       |          0.95 | abs(result) \< tolerance | Ohio                 |
| 5035 | 532RL     |          0.05 | abs(result) \< tolerance | Ohio                 |
| 5145 | 5411      |          0.46 | abs(result) \< tolerance | Ohio                 |
| 5235 | 5415      |          0.07 | abs(result) \< tolerance | Ohio                 |
| 5335 | 5412OP    |          0.23 | abs(result) \< tolerance | Ohio                 |
| 5433 | 55        |         -0.37 | abs(result) \< tolerance | Ohio                 |
| 5533 | 561       |         -0.08 | abs(result) \< tolerance | Ohio                 |
| 5632 | 562       |         -0.26 | abs(result) \< tolerance | Ohio                 |
| 5732 | 61        |          0.16 | abs(result) \< tolerance | Ohio                 |
| 5833 | 621       |         -0.09 | abs(result) \< tolerance | Ohio                 |
| 5934 | 622       |         -0.28 | abs(result) \< tolerance | Ohio                 |
| 6034 | 623       |         -0.32 | abs(result) \< tolerance | Ohio                 |
| 6236 | 711AS     |          0.13 | abs(result) \< tolerance | Ohio                 |
| 6335 | 713       |         -0.24 | abs(result) \< tolerance | Ohio                 |
| 6434 | 721       |          0.72 | abs(result) \< tolerance | Ohio                 |
| 6530 | 722       |         -0.06 | abs(result) \< tolerance | Ohio                 |
| 6632 | 81        |          0.02 | abs(result) \< tolerance | Ohio                 |
| 6735 | GFGD      |         -0.62 | abs(result) \< tolerance | Ohio                 |
| 6834 | GFGN      |         -0.22 | abs(result) \< tolerance | Ohio                 |
| 6934 | GFE       |          0.29 | abs(result) \< tolerance | Ohio                 |
| 7033 | GSLG      |          0.02 | abs(result) \< tolerance | Ohio                 |
| 7136 | GSLE      |          1.13 | abs(result) \< tolerance | Ohio                 |
| 7235 | Used      |         -1.89 | abs(result) \< tolerance | Ohio                 |
| 7335 | Other     |        -22.77 | abs(result) \< tolerance | Ohio                 |
| 1149 | 111CA     |         -0.48 | abs(result) \< tolerance | Oklahoma             |
| 2148 | 113FF     |          0.32 | abs(result) \< tolerance | Oklahoma             |
| 3150 | 211       |         -0.74 | abs(result) \< tolerance | Oklahoma             |
| 4149 | 212       |          0.06 | abs(result) \< tolerance | Oklahoma             |
| 5146 | 213       |         -0.02 | abs(result) \< tolerance | Oklahoma             |
| 6148 | 22        |         -0.22 | abs(result) \< tolerance | Oklahoma             |
| 764  | 23        |          0.06 | abs(result) \< tolerance | Oklahoma             |
| 835  | 321       |          0.10 | abs(result) \< tolerance | Oklahoma             |
| 936  | 327       |         -0.45 | abs(result) \< tolerance | Oklahoma             |
| 1036 | 331       |          0.85 | abs(result) \< tolerance | Oklahoma             |
| 1150 | 332       |         -0.26 | abs(result) \< tolerance | Oklahoma             |
| 1236 | 333       |         -0.18 | abs(result) \< tolerance | Oklahoma             |
| 1335 | 334       |          0.83 | abs(result) \< tolerance | Oklahoma             |
| 1436 | 335       |          0.43 | abs(result) \< tolerance | Oklahoma             |
| 1536 | 3361MV    |          0.57 | abs(result) \< tolerance | Oklahoma             |
| 1634 | 3364OT    |         -0.07 | abs(result) \< tolerance | Oklahoma             |
| 1735 | 337       |          0.79 | abs(result) \< tolerance | Oklahoma             |
| 1836 | 339       |          0.53 | abs(result) \< tolerance | Oklahoma             |
| 1936 | 311FT     |          0.20 | abs(result) \< tolerance | Oklahoma             |
| 2035 | 313TT     |          1.31 | abs(result) \< tolerance | Oklahoma             |
| 2149 | 315AL     |          0.71 | abs(result) \< tolerance | Oklahoma             |
| 2237 | 322       |         -0.33 | abs(result) \< tolerance | Oklahoma             |
| 2334 | 323       |          0.88 | abs(result) \< tolerance | Oklahoma             |
| 2436 | 324       |         -0.43 | abs(result) \< tolerance | Oklahoma             |
| 2535 | 325       |          1.79 | abs(result) \< tolerance | Oklahoma             |
| 2635 | 326       |         -0.35 | abs(result) \< tolerance | Oklahoma             |
| 2736 | 42        |          0.16 | abs(result) \< tolerance | Oklahoma             |
| 2836 | 441       |          0.74 | abs(result) \< tolerance | Oklahoma             |
| 2936 | 445       |          0.07 | abs(result) \< tolerance | Oklahoma             |
| 3035 | 452       |         -0.30 | abs(result) \< tolerance | Oklahoma             |
| 3237 | 481       |          0.03 | abs(result) \< tolerance | Oklahoma             |
| 3336 | 482       |         -0.36 | abs(result) \< tolerance | Oklahoma             |
| 3436 | 483       |         16.40 | abs(result) \< tolerance | Oklahoma             |
| 3536 | 484       |         -0.24 | abs(result) \< tolerance | Oklahoma             |
| 3635 | 485       |          1.71 | abs(result) \< tolerance | Oklahoma             |
| 3736 | 486       |         -0.80 | abs(result) \< tolerance | Oklahoma             |
| 3835 | 487OS     |          0.10 | abs(result) \< tolerance | Oklahoma             |
| 4035 | 511       |          0.38 | abs(result) \< tolerance | Oklahoma             |
| 4150 | 512       |          2.23 | abs(result) \< tolerance | Oklahoma             |
| 4237 | 513       |          0.12 | abs(result) \< tolerance | Oklahoma             |
| 4336 | 514       |          2.78 | abs(result) \< tolerance | Oklahoma             |
| 4435 | 521CI     |          0.49 | abs(result) \< tolerance | Oklahoma             |
| 4536 | 523       |          2.00 | abs(result) \< tolerance | Oklahoma             |
| 4635 | 524       |          0.40 | abs(result) \< tolerance | Oklahoma             |
| 4736 | 525       |         -0.10 | abs(result) \< tolerance | Oklahoma             |
| 4936 | ORE       |          1.00 | abs(result) \< tolerance | Oklahoma             |
| 5036 | 532RL     |          0.06 | abs(result) \< tolerance | Oklahoma             |
| 5147 | 5411      |          0.39 | abs(result) \< tolerance | Oklahoma             |
| 5236 | 5415      |          1.53 | abs(result) \< tolerance | Oklahoma             |
| 5336 | 5412OP    |          0.22 | abs(result) \< tolerance | Oklahoma             |
| 5434 | 55        |          0.68 | abs(result) \< tolerance | Oklahoma             |
| 5534 | 561       |         -0.17 | abs(result) \< tolerance | Oklahoma             |
| 5633 | 562       |          0.51 | abs(result) \< tolerance | Oklahoma             |
| 5733 | 61        |          0.36 | abs(result) \< tolerance | Oklahoma             |
| 5834 | 621       |         -0.09 | abs(result) \< tolerance | Oklahoma             |
| 5935 | 622       |         -0.12 | abs(result) \< tolerance | Oklahoma             |
| 6149 | 624       |          0.03 | abs(result) \< tolerance | Oklahoma             |
| 6237 | 711AS     |          0.54 | abs(result) \< tolerance | Oklahoma             |
| 6336 | 713       |          0.04 | abs(result) \< tolerance | Oklahoma             |
| 6435 | 721       |          0.59 | abs(result) \< tolerance | Oklahoma             |
| 6633 | 81        |         -0.01 | abs(result) \< tolerance | Oklahoma             |
| 6736 | GFGD      |         -0.20 | abs(result) \< tolerance | Oklahoma             |
| 6835 | GFGN      |         -0.27 | abs(result) \< tolerance | Oklahoma             |
| 6935 | GFE       |         -0.37 | abs(result) \< tolerance | Oklahoma             |
| 7034 | GSLG      |         -0.28 | abs(result) \< tolerance | Oklahoma             |
| 7137 | GSLE      |         -0.26 | abs(result) \< tolerance | Oklahoma             |
| 7236 | Used      |          0.42 | abs(result) \< tolerance | Oklahoma             |
| 7336 | Other     |         10.42 | abs(result) \< tolerance | Oklahoma             |
| 1151 | 111CA     |         -0.18 | abs(result) \< tolerance | Oregon               |
| 2150 | 113FF     |         -0.26 | abs(result) \< tolerance | Oregon               |
| 3151 | 211       |        343.83 | abs(result) \< tolerance | Oregon               |
| 4151 | 212       |          1.07 | abs(result) \< tolerance | Oregon               |
| 5148 | 213       |          0.05 | abs(result) \< tolerance | Oregon               |
| 6150 | 22        |          0.17 | abs(result) \< tolerance | Oregon               |
| 765  | 23        |          0.05 | abs(result) \< tolerance | Oregon               |
| 836  | 321       |         -0.65 | abs(result) \< tolerance | Oregon               |
| 937  | 327       |          0.04 | abs(result) \< tolerance | Oregon               |
| 1037 | 331       |         -0.50 | abs(result) \< tolerance | Oregon               |
| 1152 | 332       |         -0.05 | abs(result) \< tolerance | Oregon               |
| 1237 | 333       |          0.23 | abs(result) \< tolerance | Oregon               |
| 1336 | 334       |         -0.20 | abs(result) \< tolerance | Oregon               |
| 1437 | 335       |          0.13 | abs(result) \< tolerance | Oregon               |
| 1537 | 3361MV    |          0.98 | abs(result) \< tolerance | Oregon               |
| 1635 | 3364OT    |         -0.31 | abs(result) \< tolerance | Oregon               |
| 1736 | 337       |         -0.15 | abs(result) \< tolerance | Oregon               |
| 1837 | 339       |          0.07 | abs(result) \< tolerance | Oregon               |
| 1937 | 311FT     |          0.14 | abs(result) \< tolerance | Oregon               |
| 2036 | 313TT     |          0.73 | abs(result) \< tolerance | Oregon               |
| 2151 | 315AL     |          0.49 | abs(result) \< tolerance | Oregon               |
| 2238 | 322       |         -0.19 | abs(result) \< tolerance | Oregon               |
| 2335 | 323       |          0.05 | abs(result) \< tolerance | Oregon               |
| 2437 | 324       |          3.72 | abs(result) \< tolerance | Oregon               |
| 2536 | 325       |          2.34 | abs(result) \< tolerance | Oregon               |
| 2636 | 326       |          0.50 | abs(result) \< tolerance | Oregon               |
| 2737 | 42        |          0.09 | abs(result) \< tolerance | Oregon               |
| 2837 | 441       |          0.62 | abs(result) \< tolerance | Oregon               |
| 2937 | 445       |          0.04 | abs(result) \< tolerance | Oregon               |
| 3036 | 452       |         -0.16 | abs(result) \< tolerance | Oregon               |
| 3152 | 4A0       |          0.09 | abs(result) \< tolerance | Oregon               |
| 3238 | 481       |          0.07 | abs(result) \< tolerance | Oregon               |
| 3337 | 482       |          0.14 | abs(result) \< tolerance | Oregon               |
| 3437 | 483       |          0.37 | abs(result) \< tolerance | Oregon               |
| 3537 | 484       |         -0.08 | abs(result) \< tolerance | Oregon               |
| 3636 | 485       |          0.06 | abs(result) \< tolerance | Oregon               |
| 3737 | 486       |          3.79 | abs(result) \< tolerance | Oregon               |
| 3836 | 487OS     |         -0.02 | abs(result) \< tolerance | Oregon               |
| 3935 | 493       |          0.27 | abs(result) \< tolerance | Oregon               |
| 4036 | 511       |         -0.19 | abs(result) \< tolerance | Oregon               |
| 4152 | 512       |          0.08 | abs(result) \< tolerance | Oregon               |
| 4238 | 513       |          0.99 | abs(result) \< tolerance | Oregon               |
| 4337 | 514       |          0.17 | abs(result) \< tolerance | Oregon               |
| 4436 | 521CI     |          0.65 | abs(result) \< tolerance | Oregon               |
| 4537 | 523       |          0.85 | abs(result) \< tolerance | Oregon               |
| 4737 | 525       |          2.58 | abs(result) \< tolerance | Oregon               |
| 4835 | HS        |         -0.21 | abs(result) \< tolerance | Oregon               |
| 4937 | ORE       |          0.59 | abs(result) \< tolerance | Oregon               |
| 5037 | 532RL     |         -0.05 | abs(result) \< tolerance | Oregon               |
| 5149 | 5411      |          0.34 | abs(result) \< tolerance | Oregon               |
| 5237 | 5415      |          0.01 | abs(result) \< tolerance | Oregon               |
| 5337 | 5412OP    |         -0.13 | abs(result) \< tolerance | Oregon               |
| 5435 | 55        |         -0.46 | abs(result) \< tolerance | Oregon               |
| 5535 | 561       |         -0.05 | abs(result) \< tolerance | Oregon               |
| 5634 | 562       |         -0.12 | abs(result) \< tolerance | Oregon               |
| 5734 | 61        |         -0.07 | abs(result) \< tolerance | Oregon               |
| 5835 | 621       |         -0.30 | abs(result) \< tolerance | Oregon               |
| 5936 | 622       |         -0.29 | abs(result) \< tolerance | Oregon               |
| 6035 | 623       |         -0.36 | abs(result) \< tolerance | Oregon               |
| 6151 | 624       |         -0.42 | abs(result) \< tolerance | Oregon               |
| 6238 | 711AS     |          0.04 | abs(result) \< tolerance | Oregon               |
| 6337 | 713       |          0.09 | abs(result) \< tolerance | Oregon               |
| 6436 | 721       |          0.04 | abs(result) \< tolerance | Oregon               |
| 6531 | 722       |         -0.01 | abs(result) \< tolerance | Oregon               |
| 6634 | 81        |         -0.12 | abs(result) \< tolerance | Oregon               |
| 6737 | GFGD      |         -0.34 | abs(result) \< tolerance | Oregon               |
| 6836 | GFGN      |         -0.37 | abs(result) \< tolerance | Oregon               |
| 6936 | GFE       |          0.06 | abs(result) \< tolerance | Oregon               |
| 7035 | GSLG      |          0.02 | abs(result) \< tolerance | Oregon               |
| 7138 | GSLE      |          0.42 | abs(result) \< tolerance | Oregon               |
| 7237 | Used      |         -2.57 | abs(result) \< tolerance | Oregon               |
| 7337 | Other     |        -15.66 | abs(result) \< tolerance | Oregon               |
| 1153 | 111CA     |          0.86 | abs(result) \< tolerance | Pennsylvania         |
| 2152 | 113FF     |          1.84 | abs(result) \< tolerance | Pennsylvania         |
| 3153 | 211       |          1.30 | abs(result) \< tolerance | Pennsylvania         |
| 4153 | 212       |          0.05 | abs(result) \< tolerance | Pennsylvania         |
| 5150 | 213       |         -0.04 | abs(result) \< tolerance | Pennsylvania         |
| 6152 | 22        |          0.03 | abs(result) \< tolerance | Pennsylvania         |
| 766  | 23        |          0.02 | abs(result) \< tolerance | Pennsylvania         |
| 837  | 321       |         -0.18 | abs(result) \< tolerance | Pennsylvania         |
| 938  | 327       |         -0.18 | abs(result) \< tolerance | Pennsylvania         |
| 1038 | 331       |         -0.46 | abs(result) \< tolerance | Pennsylvania         |
| 1154 | 332       |         -0.22 | abs(result) \< tolerance | Pennsylvania         |
| 1238 | 333       |         -0.05 | abs(result) \< tolerance | Pennsylvania         |
| 1337 | 334       |          0.14 | abs(result) \< tolerance | Pennsylvania         |
| 1438 | 335       |         -0.26 | abs(result) \< tolerance | Pennsylvania         |
| 1538 | 3361MV    |          0.65 | abs(result) \< tolerance | Pennsylvania         |
| 1636 | 3364OT    |          0.03 | abs(result) \< tolerance | Pennsylvania         |
| 1737 | 337       |         -0.14 | abs(result) \< tolerance | Pennsylvania         |
| 1838 | 339       |         -0.07 | abs(result) \< tolerance | Pennsylvania         |
| 1938 | 311FT     |         -0.04 | abs(result) \< tolerance | Pennsylvania         |
| 2037 | 313TT     |          0.16 | abs(result) \< tolerance | Pennsylvania         |
| 2153 | 315AL     |          0.20 | abs(result) \< tolerance | Pennsylvania         |
| 2239 | 322       |         -0.37 | abs(result) \< tolerance | Pennsylvania         |
| 2336 | 323       |         -0.34 | abs(result) \< tolerance | Pennsylvania         |
| 2438 | 324       |         -0.24 | abs(result) \< tolerance | Pennsylvania         |
| 2537 | 325       |         -0.20 | abs(result) \< tolerance | Pennsylvania         |
| 2637 | 326       |         -0.28 | abs(result) \< tolerance | Pennsylvania         |
| 2738 | 42        |          0.06 | abs(result) \< tolerance | Pennsylvania         |
| 2838 | 441       |          0.61 | abs(result) \< tolerance | Pennsylvania         |
| 2938 | 445       |         -0.19 | abs(result) \< tolerance | Pennsylvania         |
| 3037 | 452       |         -0.02 | abs(result) \< tolerance | Pennsylvania         |
| 3154 | 4A0       |          0.13 | abs(result) \< tolerance | Pennsylvania         |
| 3239 | 481       |          0.42 | abs(result) \< tolerance | Pennsylvania         |
| 3338 | 482       |          0.26 | abs(result) \< tolerance | Pennsylvania         |
| 3438 | 483       |          2.48 | abs(result) \< tolerance | Pennsylvania         |
| 3538 | 484       |         -0.12 | abs(result) \< tolerance | Pennsylvania         |
| 3637 | 485       |         -0.03 | abs(result) \< tolerance | Pennsylvania         |
| 3738 | 486       |         -0.66 | abs(result) \< tolerance | Pennsylvania         |
| 3837 | 487OS     |          0.21 | abs(result) \< tolerance | Pennsylvania         |
| 3936 | 493       |         -0.49 | abs(result) \< tolerance | Pennsylvania         |
| 4037 | 511       |          0.22 | abs(result) \< tolerance | Pennsylvania         |
| 4154 | 512       |          1.99 | abs(result) \< tolerance | Pennsylvania         |
| 4239 | 513       |         -0.36 | abs(result) \< tolerance | Pennsylvania         |
| 4338 | 514       |          1.10 | abs(result) \< tolerance | Pennsylvania         |
| 4437 | 521CI     |          0.75 | abs(result) \< tolerance | Pennsylvania         |
| 4538 | 523       |          0.34 | abs(result) \< tolerance | Pennsylvania         |
| 4636 | 524       |         -0.06 | abs(result) \< tolerance | Pennsylvania         |
| 4738 | 525       |          0.85 | abs(result) \< tolerance | Pennsylvania         |
| 4836 | HS        |         -0.22 | abs(result) \< tolerance | Pennsylvania         |
| 4938 | ORE       |          0.84 | abs(result) \< tolerance | Pennsylvania         |
| 5038 | 532RL     |          0.21 | abs(result) \< tolerance | Pennsylvania         |
| 5151 | 5411      |         -0.05 | abs(result) \< tolerance | Pennsylvania         |
| 5338 | 5412OP    |         -0.02 | abs(result) \< tolerance | Pennsylvania         |
| 5436 | 55        |         -0.42 | abs(result) \< tolerance | Pennsylvania         |
| 5536 | 561       |          0.23 | abs(result) \< tolerance | Pennsylvania         |
| 5635 | 562       |         -0.18 | abs(result) \< tolerance | Pennsylvania         |
| 5735 | 61        |         -0.17 | abs(result) \< tolerance | Pennsylvania         |
| 5836 | 621       |          0.16 | abs(result) \< tolerance | Pennsylvania         |
| 5937 | 622       |          0.09 | abs(result) \< tolerance | Pennsylvania         |
| 6036 | 623       |         -0.15 | abs(result) \< tolerance | Pennsylvania         |
| 6153 | 624       |          0.02 | abs(result) \< tolerance | Pennsylvania         |
| 6239 | 711AS     |          0.09 | abs(result) \< tolerance | Pennsylvania         |
| 6338 | 713       |          0.13 | abs(result) \< tolerance | Pennsylvania         |
| 6437 | 721       |          0.24 | abs(result) \< tolerance | Pennsylvania         |
| 6532 | 722       |          0.08 | abs(result) \< tolerance | Pennsylvania         |
| 6635 | 81        |          0.31 | abs(result) \< tolerance | Pennsylvania         |
| 6738 | GFGD      |         -0.56 | abs(result) \< tolerance | Pennsylvania         |
| 6837 | GFGN      |         -0.12 | abs(result) \< tolerance | Pennsylvania         |
| 6937 | GFE       |          0.21 | abs(result) \< tolerance | Pennsylvania         |
| 7036 | GSLG      |          0.17 | abs(result) \< tolerance | Pennsylvania         |
| 7139 | GSLE      |          1.26 | abs(result) \< tolerance | Pennsylvania         |
| 7238 | Used      |          3.41 | abs(result) \< tolerance | Pennsylvania         |
| 7338 | Other     |        -15.94 | abs(result) \< tolerance | Pennsylvania         |
| 1155 | 111CA     |          4.20 | abs(result) \< tolerance | Rhode Island         |
| 2154 | 113FF     |         -0.42 | abs(result) \< tolerance | Rhode Island         |
| 3155 | 211       |        331.79 | abs(result) \< tolerance | Rhode Island         |
| 4155 | 212       |          0.81 | abs(result) \< tolerance | Rhode Island         |
| 6154 | 22        |          0.10 | abs(result) \< tolerance | Rhode Island         |
| 767  | 23        |          0.06 | abs(result) \< tolerance | Rhode Island         |
| 838  | 321       |          0.58 | abs(result) \< tolerance | Rhode Island         |
| 939  | 327       |          0.93 | abs(result) \< tolerance | Rhode Island         |
| 1039 | 331       |         -0.12 | abs(result) \< tolerance | Rhode Island         |
| 1156 | 332       |          0.06 | abs(result) \< tolerance | Rhode Island         |
| 1239 | 333       |         -0.12 | abs(result) \< tolerance | Rhode Island         |
| 1338 | 334       |         -0.05 | abs(result) \< tolerance | Rhode Island         |
| 1439 | 335       |         -0.06 | abs(result) \< tolerance | Rhode Island         |
| 1539 | 3361MV    |          4.62 | abs(result) \< tolerance | Rhode Island         |
| 1637 | 3364OT    |         -0.59 | abs(result) \< tolerance | Rhode Island         |
| 1839 | 339       |         -0.02 | abs(result) \< tolerance | Rhode Island         |
| 1939 | 311FT     |          1.35 | abs(result) \< tolerance | Rhode Island         |
| 2038 | 313TT     |         -0.52 | abs(result) \< tolerance | Rhode Island         |
| 2155 | 315AL     |          1.84 | abs(result) \< tolerance | Rhode Island         |
| 2240 | 322       |          0.25 | abs(result) \< tolerance | Rhode Island         |
| 2337 | 323       |         -0.10 | abs(result) \< tolerance | Rhode Island         |
| 2439 | 324       |          2.15 | abs(result) \< tolerance | Rhode Island         |
| 2538 | 325       |          3.25 | abs(result) \< tolerance | Rhode Island         |
| 2638 | 326       |         -0.30 | abs(result) \< tolerance | Rhode Island         |
| 2739 | 42        |         -0.09 | abs(result) \< tolerance | Rhode Island         |
| 2839 | 441       |          0.50 | abs(result) \< tolerance | Rhode Island         |
| 2939 | 445       |         -0.24 | abs(result) \< tolerance | Rhode Island         |
| 3038 | 452       |          0.07 | abs(result) \< tolerance | Rhode Island         |
| 3156 | 4A0       |          0.09 | abs(result) \< tolerance | Rhode Island         |
| 3240 | 481       |          1.76 | abs(result) \< tolerance | Rhode Island         |
| 3339 | 482       |          0.73 | abs(result) \< tolerance | Rhode Island         |
| 3439 | 483       |          0.52 | abs(result) \< tolerance | Rhode Island         |
| 3539 | 484       |          0.53 | abs(result) \< tolerance | Rhode Island         |
| 3638 | 485       |          0.17 | abs(result) \< tolerance | Rhode Island         |
| 3739 | 486       |          3.50 | abs(result) \< tolerance | Rhode Island         |
| 3838 | 487OS     |          0.16 | abs(result) \< tolerance | Rhode Island         |
| 3937 | 493       |          0.84 | abs(result) \< tolerance | Rhode Island         |
| 4038 | 511       |          0.28 | abs(result) \< tolerance | Rhode Island         |
| 4156 | 512       |          1.03 | abs(result) \< tolerance | Rhode Island         |
| 4240 | 513       |          0.63 | abs(result) \< tolerance | Rhode Island         |
| 4339 | 514       |          0.11 | abs(result) \< tolerance | Rhode Island         |
| 4438 | 521CI     |          0.28 | abs(result) \< tolerance | Rhode Island         |
| 4539 | 523       |         -0.37 | abs(result) \< tolerance | Rhode Island         |
| 4637 | 524       |         -0.27 | abs(result) \< tolerance | Rhode Island         |
| 4739 | 525       |          1.86 | abs(result) \< tolerance | Rhode Island         |
| 4837 | HS        |         -0.25 | abs(result) \< tolerance | Rhode Island         |
| 4939 | ORE       |          0.71 | abs(result) \< tolerance | Rhode Island         |
| 5039 | 532RL     |          0.27 | abs(result) \< tolerance | Rhode Island         |
| 5152 | 5411      |          0.14 | abs(result) \< tolerance | Rhode Island         |
| 5238 | 5415      |         -0.01 | abs(result) \< tolerance | Rhode Island         |
| 5437 | 55        |         -0.55 | abs(result) \< tolerance | Rhode Island         |
| 5636 | 562       |         -0.37 | abs(result) \< tolerance | Rhode Island         |
| 5736 | 61        |         -0.50 | abs(result) \< tolerance | Rhode Island         |
| 5837 | 621       |         -0.08 | abs(result) \< tolerance | Rhode Island         |
| 5938 | 622       |         -0.30 | abs(result) \< tolerance | Rhode Island         |
| 6037 | 623       |         -0.50 | abs(result) \< tolerance | Rhode Island         |
| 6155 | 624       |         -0.16 | abs(result) \< tolerance | Rhode Island         |
| 6240 | 711AS     |          0.14 | abs(result) \< tolerance | Rhode Island         |
| 6339 | 713       |         -0.18 | abs(result) \< tolerance | Rhode Island         |
| 6438 | 721       |         -0.01 | abs(result) \< tolerance | Rhode Island         |
| 6533 | 722       |         -0.06 | abs(result) \< tolerance | Rhode Island         |
| 6636 | 81        |          0.07 | abs(result) \< tolerance | Rhode Island         |
| 6739 | GFGD      |         -0.55 | abs(result) \< tolerance | Rhode Island         |
| 6838 | GFGN      |         -0.32 | abs(result) \< tolerance | Rhode Island         |
| 6938 | GFE       |         -0.04 | abs(result) \< tolerance | Rhode Island         |
| 7037 | GSLG      |          0.21 | abs(result) \< tolerance | Rhode Island         |
| 7140 | GSLE      |          1.12 | abs(result) \< tolerance | Rhode Island         |
| 7239 | Used      |          3.47 | abs(result) \< tolerance | Rhode Island         |
| 7339 | Other     |         10.62 | abs(result) \< tolerance | Rhode Island         |
| 1157 | 111CA     |          0.84 | abs(result) \< tolerance | South Carolina       |
| 2156 | 113FF     |          0.37 | abs(result) \< tolerance | South Carolina       |
| 3157 | 211       |        143.59 | abs(result) \< tolerance | South Carolina       |
| 4157 | 212       |          0.65 | abs(result) \< tolerance | South Carolina       |
| 5153 | 213       |          0.02 | abs(result) \< tolerance | South Carolina       |
| 6156 | 22        |         -0.22 | abs(result) \< tolerance | South Carolina       |
| 768  | 23        |         -0.02 | abs(result) \< tolerance | South Carolina       |
| 839  | 321       |         -0.36 | abs(result) \< tolerance | South Carolina       |
| 940  | 327       |         -0.17 | abs(result) \< tolerance | South Carolina       |
| 1040 | 331       |          0.12 | abs(result) \< tolerance | South Carolina       |
| 1158 | 332       |         -0.18 | abs(result) \< tolerance | South Carolina       |
| 1240 | 333       |         -0.12 | abs(result) \< tolerance | South Carolina       |
| 1339 | 334       |          0.32 | abs(result) \< tolerance | South Carolina       |
| 1440 | 335       |         -0.51 | abs(result) \< tolerance | South Carolina       |
| 1540 | 3361MV    |          0.18 | abs(result) \< tolerance | South Carolina       |
| 1638 | 3364OT    |         -0.07 | abs(result) \< tolerance | South Carolina       |
| 1738 | 337       |         -0.09 | abs(result) \< tolerance | South Carolina       |
| 1840 | 339       |          0.75 | abs(result) \< tolerance | South Carolina       |
| 1940 | 311FT     |          0.54 | abs(result) \< tolerance | South Carolina       |
| 2039 | 313TT     |         -0.58 | abs(result) \< tolerance | South Carolina       |
| 2157 | 315AL     |          0.05 | abs(result) \< tolerance | South Carolina       |
| 2241 | 322       |         -0.47 | abs(result) \< tolerance | South Carolina       |
| 2338 | 323       |          0.02 | abs(result) \< tolerance | South Carolina       |
| 2440 | 324       |          4.67 | abs(result) \< tolerance | South Carolina       |
| 2539 | 325       |          1.07 | abs(result) \< tolerance | South Carolina       |
| 2639 | 326       |         -0.32 | abs(result) \< tolerance | South Carolina       |
| 2740 | 42        |          0.22 | abs(result) \< tolerance | South Carolina       |
| 2840 | 441       |          0.58 | abs(result) \< tolerance | South Carolina       |
| 2940 | 445       |         -0.06 | abs(result) \< tolerance | South Carolina       |
| 3039 | 452       |         -0.27 | abs(result) \< tolerance | South Carolina       |
| 3158 | 4A0       |          0.10 | abs(result) \< tolerance | South Carolina       |
| 3241 | 481       |          3.16 | abs(result) \< tolerance | South Carolina       |
| 3340 | 482       |          0.76 | abs(result) \< tolerance | South Carolina       |
| 3440 | 483       |          1.05 | abs(result) \< tolerance | South Carolina       |
| 3639 | 485       |          1.12 | abs(result) \< tolerance | South Carolina       |
| 3740 | 486       |          3.74 | abs(result) \< tolerance | South Carolina       |
| 3938 | 493       |         -0.24 | abs(result) \< tolerance | South Carolina       |
| 4039 | 511       |          0.59 | abs(result) \< tolerance | South Carolina       |
| 4158 | 512       |          2.76 | abs(result) \< tolerance | South Carolina       |
| 4241 | 513       |          0.32 | abs(result) \< tolerance | South Carolina       |
| 4340 | 514       |          1.76 | abs(result) \< tolerance | South Carolina       |
| 4439 | 521CI     |          0.71 | abs(result) \< tolerance | South Carolina       |
| 4540 | 523       |          1.26 | abs(result) \< tolerance | South Carolina       |
| 4638 | 524       |          0.17 | abs(result) \< tolerance | South Carolina       |
| 4740 | 525       |          2.09 | abs(result) \< tolerance | South Carolina       |
| 4838 | HS        |         -0.06 | abs(result) \< tolerance | South Carolina       |
| 4940 | ORE       |          0.64 | abs(result) \< tolerance | South Carolina       |
| 5040 | 532RL     |          0.11 | abs(result) \< tolerance | South Carolina       |
| 5154 | 5411      |          0.32 | abs(result) \< tolerance | South Carolina       |
| 5239 | 5415      |          0.20 | abs(result) \< tolerance | South Carolina       |
| 5339 | 5412OP    |         -0.04 | abs(result) \< tolerance | South Carolina       |
| 5438 | 55        |          1.30 | abs(result) \< tolerance | South Carolina       |
| 5537 | 561       |         -0.23 | abs(result) \< tolerance | South Carolina       |
| 5637 | 562       |         -0.50 | abs(result) \< tolerance | South Carolina       |
| 5737 | 61        |          0.40 | abs(result) \< tolerance | South Carolina       |
| 5838 | 621       |          0.08 | abs(result) \< tolerance | South Carolina       |
| 5939 | 622       |          0.47 | abs(result) \< tolerance | South Carolina       |
| 6038 | 623       |          0.14 | abs(result) \< tolerance | South Carolina       |
| 6157 | 624       |          0.68 | abs(result) \< tolerance | South Carolina       |
| 6241 | 711AS     |          1.03 | abs(result) \< tolerance | South Carolina       |
| 6340 | 713       |          0.15 | abs(result) \< tolerance | South Carolina       |
| 6439 | 721       |         -0.23 | abs(result) \< tolerance | South Carolina       |
| 6534 | 722       |         -0.03 | abs(result) \< tolerance | South Carolina       |
| 6637 | 81        |          0.06 | abs(result) \< tolerance | South Carolina       |
| 6740 | GFGD      |         -0.21 | abs(result) \< tolerance | South Carolina       |
| 6839 | GFGN      |         -0.42 | abs(result) \< tolerance | South Carolina       |
| 6939 | GFE       |          0.14 | abs(result) \< tolerance | South Carolina       |
| 7038 | GSLG      |         -0.15 | abs(result) \< tolerance | South Carolina       |
| 7141 | GSLE      |         -0.07 | abs(result) \< tolerance | South Carolina       |
| 7240 | Used      |         -3.90 | abs(result) \< tolerance | South Carolina       |
| 7340 | Other     |        -33.11 | abs(result) \< tolerance | South Carolina       |
| 1159 | 111CA     |         -0.77 | abs(result) \< tolerance | South Dakota         |
| 2158 | 113FF     |          0.55 | abs(result) \< tolerance | South Dakota         |
| 3159 | 211       |        639.11 | abs(result) \< tolerance | South Dakota         |
| 4159 | 212       |          0.28 | abs(result) \< tolerance | South Dakota         |
| 5155 | 213       |          0.02 | abs(result) \< tolerance | South Dakota         |
| 6158 | 22        |         -0.09 | abs(result) \< tolerance | South Dakota         |
| 769  | 23        |          0.05 | abs(result) \< tolerance | South Dakota         |
| 840  | 321       |         -0.44 | abs(result) \< tolerance | South Dakota         |
| 941  | 327       |         -0.51 | abs(result) \< tolerance | South Dakota         |
| 1041 | 331       |          1.31 | abs(result) \< tolerance | South Dakota         |
| 1160 | 332       |         -0.07 | abs(result) \< tolerance | South Dakota         |
| 1241 | 333       |         -0.29 | abs(result) \< tolerance | South Dakota         |
| 1340 | 334       |          0.59 | abs(result) \< tolerance | South Dakota         |
| 1441 | 335       |          0.55 | abs(result) \< tolerance | South Dakota         |
| 1541 | 3361MV    |          0.15 | abs(result) \< tolerance | South Dakota         |
| 1639 | 3364OT    |          0.83 | abs(result) \< tolerance | South Dakota         |
| 1739 | 337       |         -0.40 | abs(result) \< tolerance | South Dakota         |
| 1841 | 339       |          0.76 | abs(result) \< tolerance | South Dakota         |
| 1941 | 311FT     |          0.19 | abs(result) \< tolerance | South Dakota         |
| 2040 | 313TT     |          0.32 | abs(result) \< tolerance | South Dakota         |
| 2159 | 315AL     |          4.60 | abs(result) \< tolerance | South Dakota         |
| 2242 | 322       |          0.78 | abs(result) \< tolerance | South Dakota         |
| 2339 | 323       |         -0.20 | abs(result) \< tolerance | South Dakota         |
| 2441 | 324       |         13.06 | abs(result) \< tolerance | South Dakota         |
| 2540 | 325       |          1.28 | abs(result) \< tolerance | South Dakota         |
| 2640 | 326       |          0.28 | abs(result) \< tolerance | South Dakota         |
| 2741 | 42        |         -0.04 | abs(result) \< tolerance | South Dakota         |
| 2841 | 441       |          0.12 | abs(result) \< tolerance | South Dakota         |
| 2941 | 445       |         -0.26 | abs(result) \< tolerance | South Dakota         |
| 3040 | 452       |         -0.40 | abs(result) \< tolerance | South Dakota         |
| 3160 | 4A0       |         -0.33 | abs(result) \< tolerance | South Dakota         |
| 3242 | 481       |          2.19 | abs(result) \< tolerance | South Dakota         |
| 3341 | 482       |         -0.11 | abs(result) \< tolerance | South Dakota         |
| 3441 | 483       |         21.82 | abs(result) \< tolerance | South Dakota         |
| 3540 | 484       |         -0.22 | abs(result) \< tolerance | South Dakota         |
| 3640 | 485       |          0.54 | abs(result) \< tolerance | South Dakota         |
| 3741 | 486       |          0.95 | abs(result) \< tolerance | South Dakota         |
| 3839 | 487OS     |          0.32 | abs(result) \< tolerance | South Dakota         |
| 3939 | 493       |          2.24 | abs(result) \< tolerance | South Dakota         |
| 4040 | 511       |          0.95 | abs(result) \< tolerance | South Dakota         |
| 4160 | 512       |          2.48 | abs(result) \< tolerance | South Dakota         |
| 4242 | 513       |          0.08 | abs(result) \< tolerance | South Dakota         |
| 4341 | 514       |          4.32 | abs(result) \< tolerance | South Dakota         |
| 4440 | 521CI     |         -0.71 | abs(result) \< tolerance | South Dakota         |
| 4541 | 523       |          1.17 | abs(result) \< tolerance | South Dakota         |
| 4639 | 524       |          0.05 | abs(result) \< tolerance | South Dakota         |
| 4741 | 525       |         -0.40 | abs(result) \< tolerance | South Dakota         |
| 4839 | HS        |         -0.14 | abs(result) \< tolerance | South Dakota         |
| 4941 | ORE       |          1.65 | abs(result) \< tolerance | South Dakota         |
| 5041 | 532RL     |         -0.11 | abs(result) \< tolerance | South Dakota         |
| 5156 | 5411      |          1.33 | abs(result) \< tolerance | South Dakota         |
| 5240 | 5415      |          0.50 | abs(result) \< tolerance | South Dakota         |
| 5340 | 5412OP    |          0.29 | abs(result) \< tolerance | South Dakota         |
| 5439 | 55        |          0.27 | abs(result) \< tolerance | South Dakota         |
| 5538 | 561       |          0.83 | abs(result) \< tolerance | South Dakota         |
| 5638 | 562       |          0.41 | abs(result) \< tolerance | South Dakota         |
| 5738 | 61        |          0.38 | abs(result) \< tolerance | South Dakota         |
| 5839 | 621       |         -0.18 | abs(result) \< tolerance | South Dakota         |
| 5940 | 622       |         -0.39 | abs(result) \< tolerance | South Dakota         |
| 6039 | 623       |         -0.31 | abs(result) \< tolerance | South Dakota         |
| 6159 | 624       |          0.05 | abs(result) \< tolerance | South Dakota         |
| 6242 | 711AS     |          1.29 | abs(result) \< tolerance | South Dakota         |
| 6341 | 713       |         -0.08 | abs(result) \< tolerance | South Dakota         |
| 6440 | 721       |         -0.44 | abs(result) \< tolerance | South Dakota         |
| 6535 | 722       |          0.10 | abs(result) \< tolerance | South Dakota         |
| 6638 | 81        |         -0.04 | abs(result) \< tolerance | South Dakota         |
| 6741 | GFGD      |         -0.21 | abs(result) \< tolerance | South Dakota         |
| 6840 | GFGN      |          0.74 | abs(result) \< tolerance | South Dakota         |
| 6940 | GFE       |          0.57 | abs(result) \< tolerance | South Dakota         |
| 7039 | GSLG      |         -0.15 | abs(result) \< tolerance | South Dakota         |
| 7142 | GSLE      |          0.89 | abs(result) \< tolerance | South Dakota         |
| 7241 | Used      |          1.24 | abs(result) \< tolerance | South Dakota         |
| 7341 | Other     |        -22.69 | abs(result) \< tolerance | South Dakota         |
| 1161 | 111CA     |          1.98 | abs(result) \< tolerance | Tennessee            |
| 2160 | 113FF     |          0.83 | abs(result) \< tolerance | Tennessee            |
| 3161 | 211       |       5811.15 | abs(result) \< tolerance | Tennessee            |
| 4161 | 212       |         -0.04 | abs(result) \< tolerance | Tennessee            |
| 5157 | 213       |          0.06 | abs(result) \< tolerance | Tennessee            |
| 6160 | 22        |          1.28 | abs(result) \< tolerance | Tennessee            |
| 770  | 23        |          0.06 | abs(result) \< tolerance | Tennessee            |
| 841  | 321       |         -0.18 | abs(result) \< tolerance | Tennessee            |
| 942  | 327       |         -0.26 | abs(result) \< tolerance | Tennessee            |
| 1042 | 331       |          0.19 | abs(result) \< tolerance | Tennessee            |
| 1341 | 334       |          0.94 | abs(result) \< tolerance | Tennessee            |
| 1442 | 335       |         -0.48 | abs(result) \< tolerance | Tennessee            |
| 1542 | 3361MV    |         -0.28 | abs(result) \< tolerance | Tennessee            |
| 1640 | 3364OT    |          0.74 | abs(result) \< tolerance | Tennessee            |
| 1740 | 337       |         -0.04 | abs(result) \< tolerance | Tennessee            |
| 1842 | 339       |          0.08 | abs(result) \< tolerance | Tennessee            |
| 1942 | 311FT     |         -0.35 | abs(result) \< tolerance | Tennessee            |
| 2041 | 313TT     |         -0.12 | abs(result) \< tolerance | Tennessee            |
| 2243 | 322       |         -0.36 | abs(result) \< tolerance | Tennessee            |
| 2340 | 323       |         -0.32 | abs(result) \< tolerance | Tennessee            |
| 2442 | 324       |          1.17 | abs(result) \< tolerance | Tennessee            |
| 2541 | 325       |          0.24 | abs(result) \< tolerance | Tennessee            |
| 2641 | 326       |         -0.16 | abs(result) \< tolerance | Tennessee            |
| 2742 | 42        |          0.07 | abs(result) \< tolerance | Tennessee            |
| 2842 | 441       |          0.38 | abs(result) \< tolerance | Tennessee            |
| 2942 | 445       |         -0.21 | abs(result) \< tolerance | Tennessee            |
| 3041 | 452       |         -0.40 | abs(result) \< tolerance | Tennessee            |
| 3162 | 4A0       |         -0.19 | abs(result) \< tolerance | Tennessee            |
| 3243 | 481       |          1.27 | abs(result) \< tolerance | Tennessee            |
| 3342 | 482       |          0.11 | abs(result) \< tolerance | Tennessee            |
| 3442 | 483       |         -0.32 | abs(result) \< tolerance | Tennessee            |
| 3541 | 484       |         -0.34 | abs(result) \< tolerance | Tennessee            |
| 3641 | 485       |          0.40 | abs(result) \< tolerance | Tennessee            |
| 3742 | 486       |         -0.13 | abs(result) \< tolerance | Tennessee            |
| 3840 | 487OS     |         -0.43 | abs(result) \< tolerance | Tennessee            |
| 3940 | 493       |         -0.29 | abs(result) \< tolerance | Tennessee            |
| 4041 | 511       |          0.21 | abs(result) \< tolerance | Tennessee            |
| 4162 | 512       |         -0.14 | abs(result) \< tolerance | Tennessee            |
| 4243 | 513       |          0.42 | abs(result) \< tolerance | Tennessee            |
| 4342 | 514       |          1.70 | abs(result) \< tolerance | Tennessee            |
| 4441 | 521CI     |          0.37 | abs(result) \< tolerance | Tennessee            |
| 4542 | 523       |          0.88 | abs(result) \< tolerance | Tennessee            |
| 4640 | 524       |          0.07 | abs(result) \< tolerance | Tennessee            |
| 4742 | 525       |          0.03 | abs(result) \< tolerance | Tennessee            |
| 4840 | HS        |         -0.15 | abs(result) \< tolerance | Tennessee            |
| 4942 | ORE       |          0.99 | abs(result) \< tolerance | Tennessee            |
| 5042 | 532RL     |          0.18 | abs(result) \< tolerance | Tennessee            |
| 5158 | 5411      |          0.60 | abs(result) \< tolerance | Tennessee            |
| 5241 | 5415      |          0.26 | abs(result) \< tolerance | Tennessee            |
| 5341 | 5412OP    |          0.04 | abs(result) \< tolerance | Tennessee            |
| 5440 | 55        |          0.28 | abs(result) \< tolerance | Tennessee            |
| 5539 | 561       |         -0.24 | abs(result) \< tolerance | Tennessee            |
| 5639 | 562       |         -0.16 | abs(result) \< tolerance | Tennessee            |
| 5739 | 61        |          0.15 | abs(result) \< tolerance | Tennessee            |
| 5840 | 621       |         -0.25 | abs(result) \< tolerance | Tennessee            |
| 5941 | 622       |         -0.38 | abs(result) \< tolerance | Tennessee            |
| 6040 | 623       |         -0.05 | abs(result) \< tolerance | Tennessee            |
| 6161 | 624       |          0.42 | abs(result) \< tolerance | Tennessee            |
| 6243 | 711AS     |         -0.53 | abs(result) \< tolerance | Tennessee            |
| 6342 | 713       |          0.10 | abs(result) \< tolerance | Tennessee            |
| 6441 | 721       |         -0.09 | abs(result) \< tolerance | Tennessee            |
| 6536 | 722       |         -0.12 | abs(result) \< tolerance | Tennessee            |
| 6639 | 81        |         -0.07 | abs(result) \< tolerance | Tennessee            |
| 6742 | GFGD      |         -0.38 | abs(result) \< tolerance | Tennessee            |
| 6841 | GFGN      |         -0.42 | abs(result) \< tolerance | Tennessee            |
| 6941 | GFE       |         -0.06 | abs(result) \< tolerance | Tennessee            |
| 7040 | GSLG      |         -0.11 | abs(result) \< tolerance | Tennessee            |
| 7143 | GSLE      |          0.10 | abs(result) \< tolerance | Tennessee            |
| 7242 | Used      |         -5.51 | abs(result) \< tolerance | Tennessee            |
| 7342 | Other     |          8.59 | abs(result) \< tolerance | Tennessee            |
| 1162 | 111CA     |          0.13 | abs(result) \< tolerance | Texas                |
| 2161 | 113FF     |          0.13 | abs(result) \< tolerance | Texas                |
| 3163 | 211       |         -0.55 | abs(result) \< tolerance | Texas                |
| 4163 | 212       |          0.22 | abs(result) \< tolerance | Texas                |
| 5159 | 213       |          0.02 | abs(result) \< tolerance | Texas                |
| 771  | 23        |         -0.18 | abs(result) \< tolerance | Texas                |
| 842  | 321       |          0.39 | abs(result) \< tolerance | Texas                |
| 943  | 327       |         -0.03 | abs(result) \< tolerance | Texas                |
| 1043 | 331       |          0.68 | abs(result) \< tolerance | Texas                |
| 1163 | 332       |          0.15 | abs(result) \< tolerance | Texas                |
| 1242 | 333       |          0.31 | abs(result) \< tolerance | Texas                |
| 1342 | 334       |          0.20 | abs(result) \< tolerance | Texas                |
| 1443 | 335       |          0.57 | abs(result) \< tolerance | Texas                |
| 1543 | 3361MV    |          0.06 | abs(result) \< tolerance | Texas                |
| 1641 | 3364OT    |          0.07 | abs(result) \< tolerance | Texas                |
| 1741 | 337       |          0.75 | abs(result) \< tolerance | Texas                |
| 1843 | 339       |          0.51 | abs(result) \< tolerance | Texas                |
| 1943 | 311FT     |          0.41 | abs(result) \< tolerance | Texas                |
| 2042 | 313TT     |          1.61 | abs(result) \< tolerance | Texas                |
| 2162 | 315AL     |          1.01 | abs(result) \< tolerance | Texas                |
| 2244 | 322       |          0.92 | abs(result) \< tolerance | Texas                |
| 2341 | 323       |          0.59 | abs(result) \< tolerance | Texas                |
| 2443 | 324       |         -0.36 | abs(result) \< tolerance | Texas                |
| 2542 | 325       |         -0.21 | abs(result) \< tolerance | Texas                |
| 2642 | 326       |          0.42 | abs(result) \< tolerance | Texas                |
| 2743 | 42        |         -0.16 | abs(result) \< tolerance | Texas                |
| 2843 | 441       |          0.51 | abs(result) \< tolerance | Texas                |
| 2943 | 445       |         -0.14 | abs(result) \< tolerance | Texas                |
| 3042 | 452       |         -0.27 | abs(result) \< tolerance | Texas                |
| 3164 | 4A0       |          0.06 | abs(result) \< tolerance | Texas                |
| 3244 | 481       |         -0.25 | abs(result) \< tolerance | Texas                |
| 3443 | 483       |          0.07 | abs(result) \< tolerance | Texas                |
| 3542 | 484       |         -0.12 | abs(result) \< tolerance | Texas                |
| 3642 | 485       |          0.97 | abs(result) \< tolerance | Texas                |
| 3743 | 486       |          0.03 | abs(result) \< tolerance | Texas                |
| 3841 | 487OS     |          0.02 | abs(result) \< tolerance | Texas                |
| 3941 | 493       |          0.04 | abs(result) \< tolerance | Texas                |
| 4042 | 511       |          0.15 | abs(result) \< tolerance | Texas                |
| 4164 | 512       |          1.22 | abs(result) \< tolerance | Texas                |
| 4244 | 513       |         -0.11 | abs(result) \< tolerance | Texas                |
| 4343 | 514       |          0.54 | abs(result) \< tolerance | Texas                |
| 4442 | 521CI     |          0.33 | abs(result) \< tolerance | Texas                |
| 4543 | 523       |          1.05 | abs(result) \< tolerance | Texas                |
| 4641 | 524       |          0.05 | abs(result) \< tolerance | Texas                |
| 4743 | 525       |         -0.60 | abs(result) \< tolerance | Texas                |
| 4841 | HS        |         -0.06 | abs(result) \< tolerance | Texas                |
| 4943 | ORE       |          1.07 | abs(result) \< tolerance | Texas                |
| 5043 | 532RL     |         -0.04 | abs(result) \< tolerance | Texas                |
| 5160 | 5411      |          0.12 | abs(result) \< tolerance | Texas                |
| 5242 | 5415      |         -0.03 | abs(result) \< tolerance | Texas                |
| 5342 | 5412OP    |          0.02 | abs(result) \< tolerance | Texas                |
| 5441 | 55        |          0.82 | abs(result) \< tolerance | Texas                |
| 5540 | 561       |         -0.17 | abs(result) \< tolerance | Texas                |
| 5640 | 562       |         -0.09 | abs(result) \< tolerance | Texas                |
| 5740 | 61        |          0.29 | abs(result) \< tolerance | Texas                |
| 5841 | 621       |         -0.11 | abs(result) \< tolerance | Texas                |
| 5942 | 622       |          0.09 | abs(result) \< tolerance | Texas                |
| 6041 | 623       |          0.43 | abs(result) \< tolerance | Texas                |
| 6162 | 624       |          0.47 | abs(result) \< tolerance | Texas                |
| 6244 | 711AS     |          0.44 | abs(result) \< tolerance | Texas                |
| 6343 | 713       |          0.57 | abs(result) \< tolerance | Texas                |
| 6442 | 721       |          0.30 | abs(result) \< tolerance | Texas                |
| 6537 | 722       |         -0.07 | abs(result) \< tolerance | Texas                |
| 6640 | 81        |         -0.06 | abs(result) \< tolerance | Texas                |
| 6743 | GFGD      |         -0.26 | abs(result) \< tolerance | Texas                |
| 6842 | GFGN      |         -0.05 | abs(result) \< tolerance | Texas                |
| 6942 | GFE       |          0.47 | abs(result) \< tolerance | Texas                |
| 7041 | GSLG      |         -0.18 | abs(result) \< tolerance | Texas                |
| 7144 | GSLE      |          0.18 | abs(result) \< tolerance | Texas                |
| 7243 | Used      |          4.18 | abs(result) \< tolerance | Texas                |
| 7343 | Other     |        -24.77 | abs(result) \< tolerance | Texas                |
| 1164 | 111CA     |          0.13 | abs(result) \< tolerance | Utah                 |
| 2163 | 113FF     |          0.48 | abs(result) \< tolerance | Utah                 |
| 3165 | 211       |          0.88 | abs(result) \< tolerance | Utah                 |
| 4165 | 212       |         -0.57 | abs(result) \< tolerance | Utah                 |
| 5161 | 213       |         -0.04 | abs(result) \< tolerance | Utah                 |
| 6163 | 22        |          0.16 | abs(result) \< tolerance | Utah                 |
| 772  | 23        |         -0.28 | abs(result) \< tolerance | Utah                 |
| 843  | 321       |          1.02 | abs(result) \< tolerance | Utah                 |
| 944  | 327       |          0.04 | abs(result) \< tolerance | Utah                 |
| 1044 | 331       |          0.09 | abs(result) \< tolerance | Utah                 |
| 1165 | 332       |         -0.02 | abs(result) \< tolerance | Utah                 |
| 1243 | 333       |          0.30 | abs(result) \< tolerance | Utah                 |
| 1343 | 334       |          0.02 | abs(result) \< tolerance | Utah                 |
| 1444 | 335       |          0.64 | abs(result) \< tolerance | Utah                 |
| 1544 | 3361MV    |          0.20 | abs(result) \< tolerance | Utah                 |
| 1642 | 3364OT    |         -0.38 | abs(result) \< tolerance | Utah                 |
| 1742 | 337       |         -0.32 | abs(result) \< tolerance | Utah                 |
| 1844 | 339       |         -0.47 | abs(result) \< tolerance | Utah                 |
| 1944 | 311FT     |          0.21 | abs(result) \< tolerance | Utah                 |
| 2043 | 313TT     |          0.14 | abs(result) \< tolerance | Utah                 |
| 2164 | 315AL     |          0.02 | abs(result) \< tolerance | Utah                 |
| 2245 | 322       |         -0.07 | abs(result) \< tolerance | Utah                 |
| 2342 | 323       |         -0.26 | abs(result) \< tolerance | Utah                 |
| 2444 | 324       |         -0.11 | abs(result) \< tolerance | Utah                 |
| 2543 | 325       |          0.35 | abs(result) \< tolerance | Utah                 |
| 2643 | 326       |          0.25 | abs(result) \< tolerance | Utah                 |
| 2744 | 42        |          0.14 | abs(result) \< tolerance | Utah                 |
| 2844 | 441       |          0.36 | abs(result) \< tolerance | Utah                 |
| 2944 | 445       |         -0.15 | abs(result) \< tolerance | Utah                 |
| 3043 | 452       |         -0.22 | abs(result) \< tolerance | Utah                 |
| 3166 | 4A0       |         -0.15 | abs(result) \< tolerance | Utah                 |
| 3245 | 481       |         -0.31 | abs(result) \< tolerance | Utah                 |
| 3343 | 482       |          0.16 | abs(result) \< tolerance | Utah                 |
| 3444 | 483       |         14.91 | abs(result) \< tolerance | Utah                 |
| 3543 | 484       |         -0.23 | abs(result) \< tolerance | Utah                 |
| 3643 | 485       |          0.87 | abs(result) \< tolerance | Utah                 |
| 3744 | 486       |          1.25 | abs(result) \< tolerance | Utah                 |
| 3842 | 487OS     |          0.07 | abs(result) \< tolerance | Utah                 |
| 3942 | 493       |         -0.10 | abs(result) \< tolerance | Utah                 |
| 4043 | 511       |         -0.22 | abs(result) \< tolerance | Utah                 |
| 4166 | 512       |          0.24 | abs(result) \< tolerance | Utah                 |
| 4245 | 513       |          0.22 | abs(result) \< tolerance | Utah                 |
| 4344 | 514       |         -0.09 | abs(result) \< tolerance | Utah                 |
| 4443 | 521CI     |         -0.45 | abs(result) \< tolerance | Utah                 |
| 4544 | 523       |          1.09 | abs(result) \< tolerance | Utah                 |
| 4642 | 524       |          0.22 | abs(result) \< tolerance | Utah                 |
| 4744 | 525       |         -0.62 | abs(result) \< tolerance | Utah                 |
| 4842 | HS        |         -0.21 | abs(result) \< tolerance | Utah                 |
| 4944 | ORE       |          0.85 | abs(result) \< tolerance | Utah                 |
| 5044 | 532RL     |         -0.27 | abs(result) \< tolerance | Utah                 |
| 5162 | 5411      |          0.43 | abs(result) \< tolerance | Utah                 |
| 5243 | 5415      |         -0.09 | abs(result) \< tolerance | Utah                 |
| 5343 | 5412OP    |          0.02 | abs(result) \< tolerance | Utah                 |
| 5442 | 55        |          0.26 | abs(result) \< tolerance | Utah                 |
| 5541 | 561       |         -0.11 | abs(result) \< tolerance | Utah                 |
| 5641 | 562       |          0.12 | abs(result) \< tolerance | Utah                 |
| 5741 | 61        |         -0.33 | abs(result) \< tolerance | Utah                 |
| 5842 | 621       |         -0.12 | abs(result) \< tolerance | Utah                 |
| 5943 | 622       |         -0.13 | abs(result) \< tolerance | Utah                 |
| 6042 | 623       |         -0.10 | abs(result) \< tolerance | Utah                 |
| 6164 | 624       |          0.12 | abs(result) \< tolerance | Utah                 |
| 6245 | 711AS     |          0.25 | abs(result) \< tolerance | Utah                 |
| 6344 | 713       |          0.08 | abs(result) \< tolerance | Utah                 |
| 6538 | 722       |          0.10 | abs(result) \< tolerance | Utah                 |
| 6641 | 81        |         -0.33 | abs(result) \< tolerance | Utah                 |
| 6744 | GFGD      |         -0.52 | abs(result) \< tolerance | Utah                 |
| 6843 | GFGN      |         -0.33 | abs(result) \< tolerance | Utah                 |
| 6943 | GFE       |         -0.24 | abs(result) \< tolerance | Utah                 |
| 7042 | GSLG      |         -0.13 | abs(result) \< tolerance | Utah                 |
| 7145 | GSLE      |          0.09 | abs(result) \< tolerance | Utah                 |
| 7244 | Used      |          3.25 | abs(result) \< tolerance | Utah                 |
| 7344 | Other     |          9.94 | abs(result) \< tolerance | Utah                 |
| 1166 | 111CA     |         -0.21 | abs(result) \< tolerance | Vermont              |
| 2165 | 113FF     |          0.32 | abs(result) \< tolerance | Vermont              |
| 3167 | 211       |         74.12 | abs(result) \< tolerance | Vermont              |
| 4167 | 212       |         -0.48 | abs(result) \< tolerance | Vermont              |
| 5163 | 213       |          0.13 | abs(result) \< tolerance | Vermont              |
| 6165 | 22        |         -0.03 | abs(result) \< tolerance | Vermont              |
| 773  | 23        |          0.22 | abs(result) \< tolerance | Vermont              |
| 844  | 321       |         -0.48 | abs(result) \< tolerance | Vermont              |
| 945  | 327       |         -0.32 | abs(result) \< tolerance | Vermont              |
| 1045 | 331       |          1.70 | abs(result) \< tolerance | Vermont              |
| 1167 | 332       |          0.27 | abs(result) \< tolerance | Vermont              |
| 1244 | 333       |         -0.22 | abs(result) \< tolerance | Vermont              |
| 1344 | 334       |         -0.16 | abs(result) \< tolerance | Vermont              |
| 1445 | 335       |         -0.19 | abs(result) \< tolerance | Vermont              |
| 1545 | 3361MV    |          1.91 | abs(result) \< tolerance | Vermont              |
| 1643 | 3364OT    |         -0.20 | abs(result) \< tolerance | Vermont              |
| 1743 | 337       |         -0.12 | abs(result) \< tolerance | Vermont              |
| 1845 | 339       |          0.05 | abs(result) \< tolerance | Vermont              |
| 1945 | 311FT     |          0.07 | abs(result) \< tolerance | Vermont              |
| 2044 | 313TT     |          0.26 | abs(result) \< tolerance | Vermont              |
| 2166 | 315AL     |         -0.39 | abs(result) \< tolerance | Vermont              |
| 2246 | 322       |          0.34 | abs(result) \< tolerance | Vermont              |
| 2343 | 323       |         -0.08 | abs(result) \< tolerance | Vermont              |
| 2445 | 324       |          5.39 | abs(result) \< tolerance | Vermont              |
| 2544 | 325       |          1.72 | abs(result) \< tolerance | Vermont              |
| 2644 | 326       |          0.18 | abs(result) \< tolerance | Vermont              |
| 2745 | 42        |          0.18 | abs(result) \< tolerance | Vermont              |
| 2845 | 441       |          0.43 | abs(result) \< tolerance | Vermont              |
| 2945 | 445       |         -0.28 | abs(result) \< tolerance | Vermont              |
| 3044 | 452       |          0.27 | abs(result) \< tolerance | Vermont              |
| 3168 | 4A0       |         -0.32 | abs(result) \< tolerance | Vermont              |
| 3246 | 481       |          5.46 | abs(result) \< tolerance | Vermont              |
| 3344 | 482       |          2.51 | abs(result) \< tolerance | Vermont              |
| 3445 | 483       |          0.59 | abs(result) \< tolerance | Vermont              |
| 3544 | 484       |          0.17 | abs(result) \< tolerance | Vermont              |
| 3644 | 485       |          0.20 | abs(result) \< tolerance | Vermont              |
| 3745 | 486       |          6.13 | abs(result) \< tolerance | Vermont              |
| 3843 | 487OS     |          0.29 | abs(result) \< tolerance | Vermont              |
| 3943 | 493       |          0.72 | abs(result) \< tolerance | Vermont              |
| 4044 | 511       |          0.03 | abs(result) \< tolerance | Vermont              |
| 4168 | 512       |          2.09 | abs(result) \< tolerance | Vermont              |
| 4246 | 513       |          0.98 | abs(result) \< tolerance | Vermont              |
| 4345 | 514       |          1.08 | abs(result) \< tolerance | Vermont              |
| 4444 | 521CI     |          1.00 | abs(result) \< tolerance | Vermont              |
| 4545 | 523       |          1.01 | abs(result) \< tolerance | Vermont              |
| 4745 | 525       |          1.85 | abs(result) \< tolerance | Vermont              |
| 4843 | HS        |         -0.15 | abs(result) \< tolerance | Vermont              |
| 4945 | ORE       |          0.60 | abs(result) \< tolerance | Vermont              |
| 5045 | 532RL     |          0.70 | abs(result) \< tolerance | Vermont              |
| 5164 | 5411      |          0.41 | abs(result) \< tolerance | Vermont              |
| 5244 | 5415      |         -0.11 | abs(result) \< tolerance | Vermont              |
| 5344 | 5412OP    |          0.04 | abs(result) \< tolerance | Vermont              |
| 5443 | 55        |          1.18 | abs(result) \< tolerance | Vermont              |
| 5542 | 561       |          0.15 | abs(result) \< tolerance | Vermont              |
| 5642 | 562       |          0.04 | abs(result) \< tolerance | Vermont              |
| 5742 | 61        |         -0.39 | abs(result) \< tolerance | Vermont              |
| 5843 | 621       |         -0.08 | abs(result) \< tolerance | Vermont              |
| 5944 | 622       |         -0.23 | abs(result) \< tolerance | Vermont              |
| 6043 | 623       |         -0.15 | abs(result) \< tolerance | Vermont              |
| 6166 | 624       |         -0.38 | abs(result) \< tolerance | Vermont              |
| 6246 | 711AS     |         -0.06 | abs(result) \< tolerance | Vermont              |
| 6345 | 713       |         -0.17 | abs(result) \< tolerance | Vermont              |
| 6443 | 721       |         -0.60 | abs(result) \< tolerance | Vermont              |
| 6539 | 722       |          0.05 | abs(result) \< tolerance | Vermont              |
| 6642 | 81        |          0.09 | abs(result) \< tolerance | Vermont              |
| 6745 | GFGD      |         -0.33 | abs(result) \< tolerance | Vermont              |
| 6844 | GFGN      |         -0.40 | abs(result) \< tolerance | Vermont              |
| 6944 | GFE       |         -0.24 | abs(result) \< tolerance | Vermont              |
| 7043 | GSLG      |          0.17 | abs(result) \< tolerance | Vermont              |
| 7146 | GSLE      |          1.64 | abs(result) \< tolerance | Vermont              |
| 7245 | Used      |         -4.46 | abs(result) \< tolerance | Vermont              |
| 7345 | Other     |          2.50 | abs(result) \< tolerance | Vermont              |
| 1168 | 111CA     |          4.27 | abs(result) \< tolerance | Virginia             |
| 2167 | 113FF     |          0.12 | abs(result) \< tolerance | Virginia             |
| 3169 | 211       |         61.79 | abs(result) \< tolerance | Virginia             |
| 4169 | 212       |          0.03 | abs(result) \< tolerance | Virginia             |
| 5165 | 213       |          0.05 | abs(result) \< tolerance | Virginia             |
| 6167 | 22        |          0.06 | abs(result) \< tolerance | Virginia             |
| 845  | 321       |         -0.26 | abs(result) \< tolerance | Virginia             |
| 946  | 327       |          0.17 | abs(result) \< tolerance | Virginia             |
| 1046 | 331       |          0.52 | abs(result) \< tolerance | Virginia             |
| 1169 | 332       |          0.35 | abs(result) \< tolerance | Virginia             |
| 1245 | 333       |          0.18 | abs(result) \< tolerance | Virginia             |
| 1345 | 334       |          0.99 | abs(result) \< tolerance | Virginia             |
| 1446 | 335       |          0.26 | abs(result) \< tolerance | Virginia             |
| 1546 | 3361MV    |          0.52 | abs(result) \< tolerance | Virginia             |
| 1644 | 3364OT    |         -0.03 | abs(result) \< tolerance | Virginia             |
| 1744 | 337       |          0.01 | abs(result) \< tolerance | Virginia             |
| 1846 | 339       |          0.57 | abs(result) \< tolerance | Virginia             |
| 1946 | 311FT     |         -0.49 | abs(result) \< tolerance | Virginia             |
| 2045 | 313TT     |         -0.03 | abs(result) \< tolerance | Virginia             |
| 2168 | 315AL     |          0.75 | abs(result) \< tolerance | Virginia             |
| 2247 | 322       |          0.55 | abs(result) \< tolerance | Virginia             |
| 2344 | 323       |          0.24 | abs(result) \< tolerance | Virginia             |
| 2446 | 324       |          7.92 | abs(result) \< tolerance | Virginia             |
| 2545 | 325       |          0.88 | abs(result) \< tolerance | Virginia             |
| 2645 | 326       |         -0.11 | abs(result) \< tolerance | Virginia             |
| 2746 | 42        |          0.37 | abs(result) \< tolerance | Virginia             |
| 2846 | 441       |          0.53 | abs(result) \< tolerance | Virginia             |
| 2946 | 445       |         -0.11 | abs(result) \< tolerance | Virginia             |
| 3045 | 452       |         -0.12 | abs(result) \< tolerance | Virginia             |
| 3170 | 4A0       |          0.21 | abs(result) \< tolerance | Virginia             |
| 3247 | 481       |         -0.03 | abs(result) \< tolerance | Virginia             |
| 3345 | 482       |          0.07 | abs(result) \< tolerance | Virginia             |
| 3446 | 483       |         -0.14 | abs(result) \< tolerance | Virginia             |
| 3545 | 484       |          0.35 | abs(result) \< tolerance | Virginia             |
| 3645 | 485       |          0.04 | abs(result) \< tolerance | Virginia             |
| 3746 | 486       |          1.52 | abs(result) \< tolerance | Virginia             |
| 3844 | 487OS     |          0.02 | abs(result) \< tolerance | Virginia             |
| 3944 | 493       |         -0.12 | abs(result) \< tolerance | Virginia             |
| 4045 | 511       |          0.31 | abs(result) \< tolerance | Virginia             |
| 4170 | 512       |          1.03 | abs(result) \< tolerance | Virginia             |
| 4247 | 513       |          0.27 | abs(result) \< tolerance | Virginia             |
| 4346 | 514       |          0.05 | abs(result) \< tolerance | Virginia             |
| 4445 | 521CI     |          0.09 | abs(result) \< tolerance | Virginia             |
| 4546 | 523       |          0.75 | abs(result) \< tolerance | Virginia             |
| 4643 | 524       |          0.71 | abs(result) \< tolerance | Virginia             |
| 4746 | 525       |          0.11 | abs(result) \< tolerance | Virginia             |
| 4844 | HS        |         -0.23 | abs(result) \< tolerance | Virginia             |
| 4946 | ORE       |          0.51 | abs(result) \< tolerance | Virginia             |
| 5046 | 532RL     |          0.34 | abs(result) \< tolerance | Virginia             |
| 5166 | 5411      |          0.28 | abs(result) \< tolerance | Virginia             |
| 5245 | 5415      |         -0.18 | abs(result) \< tolerance | Virginia             |
| 5345 | 5412OP    |         -0.03 | abs(result) \< tolerance | Virginia             |
| 5444 | 55        |         -0.29 | abs(result) \< tolerance | Virginia             |
| 5543 | 561       |         -0.17 | abs(result) \< tolerance | Virginia             |
| 5643 | 562       |          0.27 | abs(result) \< tolerance | Virginia             |
| 5743 | 61        |          0.36 | abs(result) \< tolerance | Virginia             |
| 5844 | 621       |          0.22 | abs(result) \< tolerance | Virginia             |
| 5945 | 622       |          0.50 | abs(result) \< tolerance | Virginia             |
| 6044 | 623       |          0.36 | abs(result) \< tolerance | Virginia             |
| 6168 | 624       |          0.34 | abs(result) \< tolerance | Virginia             |
| 6247 | 711AS     |          0.72 | abs(result) \< tolerance | Virginia             |
| 6346 | 713       |          0.96 | abs(result) \< tolerance | Virginia             |
| 6444 | 721       |          0.40 | abs(result) \< tolerance | Virginia             |
| 6540 | 722       |          0.09 | abs(result) \< tolerance | Virginia             |
| 6643 | 81        |          0.02 | abs(result) \< tolerance | Virginia             |
| 6746 | GFGD      |          4.08 | abs(result) \< tolerance | Virginia             |
| 6845 | GFGN      |         -0.22 | abs(result) \< tolerance | Virginia             |
| 6945 | GFE       |         -0.65 | abs(result) \< tolerance | Virginia             |
| 7044 | GSLG      |         -0.11 | abs(result) \< tolerance | Virginia             |
| 7147 | GSLE      |          0.21 | abs(result) \< tolerance | Virginia             |
| 7246 | Used      |          4.02 | abs(result) \< tolerance | Virginia             |
| 7346 | Other     |         38.09 | abs(result) \< tolerance | Virginia             |
| 1170 | 111CA     |          0.18 | abs(result) \< tolerance | Washington           |
| 2169 | 113FF     |          0.05 | abs(result) \< tolerance | Washington           |
| 3171 | 211       |       4289.58 | abs(result) \< tolerance | Washington           |
| 4171 | 212       |          0.76 | abs(result) \< tolerance | Washington           |
| 5167 | 213       |          0.06 | abs(result) \< tolerance | Washington           |
| 6169 | 22        |          0.45 | abs(result) \< tolerance | Washington           |
| 846  | 321       |         -0.30 | abs(result) \< tolerance | Washington           |
| 947  | 327       |          0.01 | abs(result) \< tolerance | Washington           |
| 1047 | 331       |          0.51 | abs(result) \< tolerance | Washington           |
| 1171 | 332       |          0.81 | abs(result) \< tolerance | Washington           |
| 1246 | 333       |          0.35 | abs(result) \< tolerance | Washington           |
| 1346 | 334       |          0.51 | abs(result) \< tolerance | Washington           |
| 1447 | 335       |          0.61 | abs(result) \< tolerance | Washington           |
| 1547 | 3361MV    |          1.75 | abs(result) \< tolerance | Washington           |
| 1645 | 3364OT    |          0.03 | abs(result) \< tolerance | Washington           |
| 1745 | 337       |          0.72 | abs(result) \< tolerance | Washington           |
| 1847 | 339       |          0.15 | abs(result) \< tolerance | Washington           |
| 1947 | 311FT     |          0.45 | abs(result) \< tolerance | Washington           |
| 2046 | 313TT     |          0.83 | abs(result) \< tolerance | Washington           |
| 2170 | 315AL     |          0.56 | abs(result) \< tolerance | Washington           |
| 2248 | 322       |          0.16 | abs(result) \< tolerance | Washington           |
| 2345 | 323       |          0.86 | abs(result) \< tolerance | Washington           |
| 2447 | 324       |         -0.24 | abs(result) \< tolerance | Washington           |
| 2546 | 325       |          1.13 | abs(result) \< tolerance | Washington           |
| 2646 | 326       |          1.10 | abs(result) \< tolerance | Washington           |
| 2747 | 42        |         -0.05 | abs(result) \< tolerance | Washington           |
| 2847 | 441       |          0.05 | abs(result) \< tolerance | Washington           |
| 2947 | 445       |         -0.39 | abs(result) \< tolerance | Washington           |
| 3046 | 452       |         -0.53 | abs(result) \< tolerance | Washington           |
| 3172 | 4A0       |         -0.40 | abs(result) \< tolerance | Washington           |
| 3248 | 481       |         -0.13 | abs(result) \< tolerance | Washington           |
| 3346 | 482       |         -0.04 | abs(result) \< tolerance | Washington           |
| 3447 | 483       |         -0.31 | abs(result) \< tolerance | Washington           |
| 3546 | 484       |          0.29 | abs(result) \< tolerance | Washington           |
| 3646 | 485       |          0.54 | abs(result) \< tolerance | Washington           |
| 3747 | 486       |          6.09 | abs(result) \< tolerance | Washington           |
| 3845 | 487OS     |         -0.08 | abs(result) \< tolerance | Washington           |
| 3945 | 493       |          1.01 | abs(result) \< tolerance | Washington           |
| 4046 | 511       |         -0.18 | abs(result) \< tolerance | Washington           |
| 4172 | 512       |          1.43 | abs(result) \< tolerance | Washington           |
| 4248 | 513       |          0.08 | abs(result) \< tolerance | Washington           |
| 4347 | 514       |         -0.56 | abs(result) \< tolerance | Washington           |
| 4446 | 521CI     |          0.65 | abs(result) \< tolerance | Washington           |
| 4547 | 523       |          0.72 | abs(result) \< tolerance | Washington           |
| 4644 | 524       |          0.39 | abs(result) \< tolerance | Washington           |
| 4747 | 525       |          1.46 | abs(result) \< tolerance | Washington           |
| 4845 | HS        |         -0.25 | abs(result) \< tolerance | Washington           |
| 4947 | ORE       |          0.73 | abs(result) \< tolerance | Washington           |
| 5047 | 532RL     |          0.28 | abs(result) \< tolerance | Washington           |
| 5168 | 5411      |          0.15 | abs(result) \< tolerance | Washington           |
| 5246 | 5415      |         -0.16 | abs(result) \< tolerance | Washington           |
| 5346 | 5412OP    |         -0.23 | abs(result) \< tolerance | Washington           |
| 5445 | 55        |          0.42 | abs(result) \< tolerance | Washington           |
| 5544 | 561       |          0.19 | abs(result) \< tolerance | Washington           |
| 5644 | 562       |         -0.46 | abs(result) \< tolerance | Washington           |
| 5744 | 61        |          0.04 | abs(result) \< tolerance | Washington           |
| 5845 | 621       |          0.02 | abs(result) \< tolerance | Washington           |
| 5946 | 622       |          0.13 | abs(result) \< tolerance | Washington           |
| 6045 | 623       |          0.25 | abs(result) \< tolerance | Washington           |
| 6170 | 624       |         -0.16 | abs(result) \< tolerance | Washington           |
| 6248 | 711AS     |          0.54 | abs(result) \< tolerance | Washington           |
| 6347 | 713       |          0.29 | abs(result) \< tolerance | Washington           |
| 6541 | 722       |         -0.13 | abs(result) \< tolerance | Washington           |
| 6644 | 81        |          0.01 | abs(result) \< tolerance | Washington           |
| 6747 | GFGD      |         -0.28 | abs(result) \< tolerance | Washington           |
| 6846 | GFGN      |         -0.31 | abs(result) \< tolerance | Washington           |
| 6946 | GFE       |         -0.02 | abs(result) \< tolerance | Washington           |
| 7045 | GSLG      |         -0.22 | abs(result) \< tolerance | Washington           |
| 7148 | GSLE      |          0.47 | abs(result) \< tolerance | Washington           |
| 7247 | Used      |         -4.24 | abs(result) \< tolerance | Washington           |
| 7347 | Other     |         11.92 | abs(result) \< tolerance | Washington           |
| 1172 | 111CA     |          0.38 | abs(result) \< tolerance | West Virginia        |
| 2171 | 113FF     |          0.20 | abs(result) \< tolerance | West Virginia        |
| 3173 | 211       |         -0.38 | abs(result) \< tolerance | West Virginia        |
| 4173 | 212       |         -0.66 | abs(result) \< tolerance | West Virginia        |
| 6171 | 22        |         -0.31 | abs(result) \< tolerance | West Virginia        |
| 774  | 23        |         -0.02 | abs(result) \< tolerance | West Virginia        |
| 847  | 321       |         -0.44 | abs(result) \< tolerance | West Virginia        |
| 948  | 327       |         -0.27 | abs(result) \< tolerance | West Virginia        |
| 1048 | 331       |         -0.59 | abs(result) \< tolerance | West Virginia        |
| 1173 | 332       |          0.17 | abs(result) \< tolerance | West Virginia        |
| 1247 | 333       |          1.33 | abs(result) \< tolerance | West Virginia        |
| 1347 | 334       |          1.68 | abs(result) \< tolerance | West Virginia        |
| 1448 | 335       |          1.74 | abs(result) \< tolerance | West Virginia        |
| 1548 | 3361MV    |          0.05 | abs(result) \< tolerance | West Virginia        |
| 1646 | 3364OT    |          0.21 | abs(result) \< tolerance | West Virginia        |
| 1746 | 337       |          0.87 | abs(result) \< tolerance | West Virginia        |
| 1848 | 339       |          1.38 | abs(result) \< tolerance | West Virginia        |
| 1948 | 311FT     |          1.91 | abs(result) \< tolerance | West Virginia        |
| 2047 | 313TT     |          2.28 | abs(result) \< tolerance | West Virginia        |
| 2172 | 315AL     |          2.35 | abs(result) \< tolerance | West Virginia        |
| 2249 | 322       |          2.06 | abs(result) \< tolerance | West Virginia        |
| 2346 | 323       |          0.96 | abs(result) \< tolerance | West Virginia        |
| 2448 | 324       |          0.01 | abs(result) \< tolerance | West Virginia        |
| 2547 | 325       |          3.15 | abs(result) \< tolerance | West Virginia        |
| 2647 | 326       |         -0.20 | abs(result) \< tolerance | West Virginia        |
| 2748 | 42        |          0.21 | abs(result) \< tolerance | West Virginia        |
| 2848 | 441       |          0.46 | abs(result) \< tolerance | West Virginia        |
| 2948 | 445       |          0.21 | abs(result) \< tolerance | West Virginia        |
| 3047 | 452       |         -0.51 | abs(result) \< tolerance | West Virginia        |
| 3174 | 4A0       |         -0.23 | abs(result) \< tolerance | West Virginia        |
| 3249 | 481       |         13.35 | abs(result) \< tolerance | West Virginia        |
| 3347 | 482       |         -0.41 | abs(result) \< tolerance | West Virginia        |
| 3448 | 483       |         -0.02 | abs(result) \< tolerance | West Virginia        |
| 3547 | 484       |         -0.15 | abs(result) \< tolerance | West Virginia        |
| 3647 | 485       |          1.71 | abs(result) \< tolerance | West Virginia        |
| 3748 | 486       |         -0.40 | abs(result) \< tolerance | West Virginia        |
| 3846 | 487OS     |          0.20 | abs(result) \< tolerance | West Virginia        |
| 3946 | 493       |          0.46 | abs(result) \< tolerance | West Virginia        |
| 4047 | 511       |          0.49 | abs(result) \< tolerance | West Virginia        |
| 4174 | 512       |          3.60 | abs(result) \< tolerance | West Virginia        |
| 4249 | 513       |          0.58 | abs(result) \< tolerance | West Virginia        |
| 4348 | 514       |          1.82 | abs(result) \< tolerance | West Virginia        |
| 4447 | 521CI     |          1.20 | abs(result) \< tolerance | West Virginia        |
| 4548 | 523       |          3.43 | abs(result) \< tolerance | West Virginia        |
| 4645 | 524       |          0.46 | abs(result) \< tolerance | West Virginia        |
| 4748 | 525       |          1.11 | abs(result) \< tolerance | West Virginia        |
| 4948 | ORE       |          0.77 | abs(result) \< tolerance | West Virginia        |
| 5048 | 532RL     |          0.33 | abs(result) \< tolerance | West Virginia        |
| 5169 | 5411      |         -0.10 | abs(result) \< tolerance | West Virginia        |
| 5247 | 5415      |          1.02 | abs(result) \< tolerance | West Virginia        |
| 5347 | 5412OP    |         -0.15 | abs(result) \< tolerance | West Virginia        |
| 5446 | 55        |          1.29 | abs(result) \< tolerance | West Virginia        |
| 5545 | 561       |          0.13 | abs(result) \< tolerance | West Virginia        |
| 5645 | 562       |          0.06 | abs(result) \< tolerance | West Virginia        |
| 5745 | 61        |          0.56 | abs(result) \< tolerance | West Virginia        |
| 5846 | 621       |         -0.16 | abs(result) \< tolerance | West Virginia        |
| 5947 | 622       |         -0.36 | abs(result) \< tolerance | West Virginia        |
| 6046 | 623       |         -0.21 | abs(result) \< tolerance | West Virginia        |
| 6172 | 624       |          0.02 | abs(result) \< tolerance | West Virginia        |
| 6249 | 711AS     |          1.40 | abs(result) \< tolerance | West Virginia        |
| 6348 | 713       |         -0.14 | abs(result) \< tolerance | West Virginia        |
| 6445 | 721       |         -0.13 | abs(result) \< tolerance | West Virginia        |
| 6542 | 722       |          0.06 | abs(result) \< tolerance | West Virginia        |
| 6645 | 81        |          0.11 | abs(result) \< tolerance | West Virginia        |
| 6748 | GFGD      |         -0.33 | abs(result) \< tolerance | West Virginia        |
| 6847 | GFGN      |         -0.40 | abs(result) \< tolerance | West Virginia        |
| 6947 | GFE       |         -0.53 | abs(result) \< tolerance | West Virginia        |
| 7046 | GSLG      |          0.08 | abs(result) \< tolerance | West Virginia        |
| 7149 | GSLE      |          0.99 | abs(result) \< tolerance | West Virginia        |
| 7248 | Used      |          1.54 | abs(result) \< tolerance | West Virginia        |
| 7348 | Other     |         19.49 | abs(result) \< tolerance | West Virginia        |
| 1174 | 111CA     |         -0.10 | abs(result) \< tolerance | Wisconsin            |
| 2173 | 113FF     |          1.17 | abs(result) \< tolerance | Wisconsin            |
| 3175 | 211       |        166.36 | abs(result) \< tolerance | Wisconsin            |
| 4175 | 212       |          0.36 | abs(result) \< tolerance | Wisconsin            |
| 5170 | 213       |          0.15 | abs(result) \< tolerance | Wisconsin            |
| 6173 | 22        |          0.01 | abs(result) \< tolerance | Wisconsin            |
| 775  | 23        |         -0.04 | abs(result) \< tolerance | Wisconsin            |
| 848  | 321       |         -0.40 | abs(result) \< tolerance | Wisconsin            |
| 949  | 327       |         -0.40 | abs(result) \< tolerance | Wisconsin            |
| 1049 | 331       |         -0.04 | abs(result) \< tolerance | Wisconsin            |
| 1175 | 332       |         -0.43 | abs(result) \< tolerance | Wisconsin            |
| 1248 | 333       |         -0.27 | abs(result) \< tolerance | Wisconsin            |
| 1348 | 334       |          0.17 | abs(result) \< tolerance | Wisconsin            |
| 1449 | 335       |         -0.46 | abs(result) \< tolerance | Wisconsin            |
| 1549 | 3361MV    |          0.17 | abs(result) \< tolerance | Wisconsin            |
| 1647 | 3364OT    |         -0.32 | abs(result) \< tolerance | Wisconsin            |
| 1747 | 337       |         -0.37 | abs(result) \< tolerance | Wisconsin            |
| 1849 | 339       |         -0.15 | abs(result) \< tolerance | Wisconsin            |
| 1949 | 311FT     |         -0.37 | abs(result) \< tolerance | Wisconsin            |
| 2048 | 313TT     |          0.21 | abs(result) \< tolerance | Wisconsin            |
| 2174 | 315AL     |          0.26 | abs(result) \< tolerance | Wisconsin            |
| 2250 | 322       |         -0.54 | abs(result) \< tolerance | Wisconsin            |
| 2347 | 323       |         -0.68 | abs(result) \< tolerance | Wisconsin            |
| 2449 | 324       |          2.05 | abs(result) \< tolerance | Wisconsin            |
| 2548 | 325       |          0.17 | abs(result) \< tolerance | Wisconsin            |
| 2648 | 326       |         -0.40 | abs(result) \< tolerance | Wisconsin            |
| 2749 | 42        |          0.14 | abs(result) \< tolerance | Wisconsin            |
| 2849 | 441       |          0.70 | abs(result) \< tolerance | Wisconsin            |
| 2949 | 445       |         -0.08 | abs(result) \< tolerance | Wisconsin            |
| 3048 | 452       |         -0.29 | abs(result) \< tolerance | Wisconsin            |
| 3176 | 4A0       |         -0.11 | abs(result) \< tolerance | Wisconsin            |
| 3250 | 481       |          2.16 | abs(result) \< tolerance | Wisconsin            |
| 3348 | 482       |          0.22 | abs(result) \< tolerance | Wisconsin            |
| 3449 | 483       |          6.37 | abs(result) \< tolerance | Wisconsin            |
| 3548 | 484       |         -0.25 | abs(result) \< tolerance | Wisconsin            |
| 3648 | 485       |         -0.41 | abs(result) \< tolerance | Wisconsin            |
| 3749 | 486       |          1.31 | abs(result) \< tolerance | Wisconsin            |
| 3847 | 487OS     |          0.45 | abs(result) \< tolerance | Wisconsin            |
| 3947 | 493       |         -0.08 | abs(result) \< tolerance | Wisconsin            |
| 4048 | 511       |         -0.21 | abs(result) \< tolerance | Wisconsin            |
| 4176 | 512       |          1.46 | abs(result) \< tolerance | Wisconsin            |
| 4250 | 513       |          0.46 | abs(result) \< tolerance | Wisconsin            |
| 4349 | 514       |          0.52 | abs(result) \< tolerance | Wisconsin            |
| 4448 | 521CI     |          0.56 | abs(result) \< tolerance | Wisconsin            |
| 4549 | 523       |          0.40 | abs(result) \< tolerance | Wisconsin            |
| 4646 | 524       |         -0.38 | abs(result) \< tolerance | Wisconsin            |
| 4749 | 525       |          1.59 | abs(result) \< tolerance | Wisconsin            |
| 4846 | HS        |         -0.21 | abs(result) \< tolerance | Wisconsin            |
| 4949 | ORE       |          0.81 | abs(result) \< tolerance | Wisconsin            |
| 5049 | 532RL     |          0.62 | abs(result) \< tolerance | Wisconsin            |
| 5171 | 5411      |          0.48 | abs(result) \< tolerance | Wisconsin            |
| 5248 | 5415      |          0.13 | abs(result) \< tolerance | Wisconsin            |
| 5348 | 5412OP    |          0.18 | abs(result) \< tolerance | Wisconsin            |
| 5447 | 55        |         -0.32 | abs(result) \< tolerance | Wisconsin            |
| 5546 | 561       |          0.14 | abs(result) \< tolerance | Wisconsin            |
| 5646 | 562       |         -0.04 | abs(result) \< tolerance | Wisconsin            |
| 5746 | 61        |         -0.06 | abs(result) \< tolerance | Wisconsin            |
| 5847 | 621       |         -0.22 | abs(result) \< tolerance | Wisconsin            |
| 5948 | 622       |         -0.25 | abs(result) \< tolerance | Wisconsin            |
| 6047 | 623       |         -0.34 | abs(result) \< tolerance | Wisconsin            |
| 6174 | 624       |         -0.27 | abs(result) \< tolerance | Wisconsin            |
| 6250 | 711AS     |          0.17 | abs(result) \< tolerance | Wisconsin            |
| 6349 | 713       |          0.13 | abs(result) \< tolerance | Wisconsin            |
| 6446 | 721       |          0.39 | abs(result) \< tolerance | Wisconsin            |
| 6543 | 722       |          0.08 | abs(result) \< tolerance | Wisconsin            |
| 6646 | 81        |         -0.05 | abs(result) \< tolerance | Wisconsin            |
| 6749 | GFGD      |         -0.32 | abs(result) \< tolerance | Wisconsin            |
| 6848 | GFGN      |         -0.49 | abs(result) \< tolerance | Wisconsin            |
| 6948 | GFE       |          0.81 | abs(result) \< tolerance | Wisconsin            |
| 7047 | GSLG      |         -0.08 | abs(result) \< tolerance | Wisconsin            |
| 7150 | GSLE      |          0.88 | abs(result) \< tolerance | Wisconsin            |
| 7249 | Used      |         -4.71 | abs(result) \< tolerance | Wisconsin            |
| 7349 | Other     |        -59.61 | abs(result) \< tolerance | Wisconsin            |
| 1176 | 111CA     |         -0.73 | abs(result) \< tolerance | Wyoming              |
| 2175 | 113FF     |         -0.03 | abs(result) \< tolerance | Wyoming              |
| 3177 | 211       |         -0.58 | abs(result) \< tolerance | Wyoming              |
| 4177 | 212       |         -0.83 | abs(result) \< tolerance | Wyoming              |
| 5172 | 213       |         -0.03 | abs(result) \< tolerance | Wyoming              |
| 6175 | 22        |         -0.33 | abs(result) \< tolerance | Wyoming              |
| 776  | 23        |         -0.09 | abs(result) \< tolerance | Wyoming              |
| 849  | 321       |          1.07 | abs(result) \< tolerance | Wyoming              |
| 950  | 327       |         -0.02 | abs(result) \< tolerance | Wyoming              |
| 1050 | 331       |          3.89 | abs(result) \< tolerance | Wyoming              |
| 1177 | 332       |          0.81 | abs(result) \< tolerance | Wyoming              |
| 1249 | 333       |          2.48 | abs(result) \< tolerance | Wyoming              |
| 1349 | 334       |          2.86 | abs(result) \< tolerance | Wyoming              |
| 1450 | 335       |          0.65 | abs(result) \< tolerance | Wyoming              |
| 1550 | 3361MV    |         12.57 | abs(result) \< tolerance | Wyoming              |
| 1648 | 3364OT    |          5.52 | abs(result) \< tolerance | Wyoming              |
| 1748 | 337       |          3.73 | abs(result) \< tolerance | Wyoming              |
| 1850 | 339       |          1.30 | abs(result) \< tolerance | Wyoming              |
| 1950 | 311FT     |          3.74 | abs(result) \< tolerance | Wyoming              |
| 2049 | 313TT     |          0.68 | abs(result) \< tolerance | Wyoming              |
| 2176 | 315AL     |          2.42 | abs(result) \< tolerance | Wyoming              |
| 2251 | 322       |         13.58 | abs(result) \< tolerance | Wyoming              |
| 2348 | 323       |          2.43 | abs(result) \< tolerance | Wyoming              |
| 2450 | 324       |         -0.54 | abs(result) \< tolerance | Wyoming              |
| 2549 | 325       |          0.10 | abs(result) \< tolerance | Wyoming              |
| 2649 | 326       |          1.65 | abs(result) \< tolerance | Wyoming              |
| 2750 | 42        |          0.35 | abs(result) \< tolerance | Wyoming              |
| 2850 | 441       |          0.59 | abs(result) \< tolerance | Wyoming              |
| 2950 | 445       |          0.07 | abs(result) \< tolerance | Wyoming              |
| 3049 | 452       |         -0.40 | abs(result) \< tolerance | Wyoming              |
| 3178 | 4A0       |         -0.21 | abs(result) \< tolerance | Wyoming              |
| 3251 | 481       |          1.74 | abs(result) \< tolerance | Wyoming              |
| 3349 | 482       |         -0.72 | abs(result) \< tolerance | Wyoming              |
| 3450 | 483       |          4.16 | abs(result) \< tolerance | Wyoming              |
| 3549 | 484       |         -0.13 | abs(result) \< tolerance | Wyoming              |
| 3649 | 485       |          0.95 | abs(result) \< tolerance | Wyoming              |
| 3750 | 486       |         -0.77 | abs(result) \< tolerance | Wyoming              |
| 3848 | 487OS     |          0.39 | abs(result) \< tolerance | Wyoming              |
| 3948 | 493       |          0.25 | abs(result) \< tolerance | Wyoming              |
| 4049 | 511       |          1.00 | abs(result) \< tolerance | Wyoming              |
| 4178 | 512       |          0.91 | abs(result) \< tolerance | Wyoming              |
| 4251 | 513       |          0.42 | abs(result) \< tolerance | Wyoming              |
| 4350 | 514       |          2.78 | abs(result) \< tolerance | Wyoming              |
| 4449 | 521CI     |          1.70 | abs(result) \< tolerance | Wyoming              |
| 4550 | 523       |          8.72 | abs(result) \< tolerance | Wyoming              |
| 4647 | 524       |          1.08 | abs(result) \< tolerance | Wyoming              |
| 4750 | 525       |         -0.24 | abs(result) \< tolerance | Wyoming              |
| 4847 | HS        |         -0.22 | abs(result) \< tolerance | Wyoming              |
| 4950 | ORE       |          0.50 | abs(result) \< tolerance | Wyoming              |
| 5050 | 532RL     |         -0.07 | abs(result) \< tolerance | Wyoming              |
| 5173 | 5411      |          1.16 | abs(result) \< tolerance | Wyoming              |
| 5249 | 5415      |          1.39 | abs(result) \< tolerance | Wyoming              |
| 5349 | 5412OP    |          0.53 | abs(result) \< tolerance | Wyoming              |
| 5448 | 55        |          4.68 | abs(result) \< tolerance | Wyoming              |
| 5547 | 561       |          0.68 | abs(result) \< tolerance | Wyoming              |
| 5647 | 562       |          0.34 | abs(result) \< tolerance | Wyoming              |
| 5747 | 61        |          0.28 | abs(result) \< tolerance | Wyoming              |
| 5848 | 621       |         -0.09 | abs(result) \< tolerance | Wyoming              |
| 5949 | 622       |          0.27 | abs(result) \< tolerance | Wyoming              |
| 6048 | 623       |         -0.06 | abs(result) \< tolerance | Wyoming              |
| 6176 | 624       |         -0.34 | abs(result) \< tolerance | Wyoming              |
| 6251 | 711AS     |          0.69 | abs(result) \< tolerance | Wyoming              |
| 6350 | 713       |         -0.41 | abs(result) \< tolerance | Wyoming              |
| 6447 | 721       |         -0.59 | abs(result) \< tolerance | Wyoming              |
| 6544 | 722       |          0.04 | abs(result) \< tolerance | Wyoming              |
| 6647 | 81        |         -0.01 | abs(result) \< tolerance | Wyoming              |
| 6750 | GFGD      |         -0.18 | abs(result) \< tolerance | Wyoming              |
| 6849 | GFGN      |         -0.41 | abs(result) \< tolerance | Wyoming              |
| 6949 | GFE       |         -0.30 | abs(result) \< tolerance | Wyoming              |
| 7048 | GSLG      |         -0.09 | abs(result) \< tolerance | Wyoming              |
| 7151 | GSLE      |         -0.18 | abs(result) \< tolerance | Wyoming              |
| 7250 | Used      |          0.16 | abs(result) \< tolerance | Wyoming              |
| 7350 | Other     |          5.67 | abs(result) \< tolerance | Wyoming              |

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

Absolute Difference: There are 2 failures, and they areRelative
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

Absolute Difference: There are 2 failures, and they areRelative
Difference: There are no failures.

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

Absolute Difference: There are 2 failures, and they areRelative
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
