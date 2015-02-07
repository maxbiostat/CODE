=====================
> cortest.bartlett(M42$rho, n = nrow(wdb)) # Bartlett's test for sphericity <- nearly useless, but...
$chisq
[1] 26036.07

$p.value
[1] 0

$df
[1] 861

=====================


> vss(M42$rho, n = 15,  n.obs = nrow(wdb))

Very Simple Structure
Call: vss(x = M42$rho, n = 15, n.obs = nrow(wdb))
VSS complexity 1 achieves a maximimum of 0.73  with  2  factors
VSS complexity 2 achieves a maximimum of 0.8  with  5  factors

The Velicer MAP achieves a minimum of 0.01  with  4  factors 
BIC achieves a minimum of  -1992.92  with  12  factors
Sample Size adjusted BIC achieves a minimum of  -670.5  with  15  factors

Statistics by number of factors 
   vss1 vss2    map dof chisq     prob sqresid  fit RMSEA   BIC SABIC complex eChisq  SRMR eCRMS  eBIC
1  0.57 0.00 0.0184 819 15070  0.0e+00      51 0.57 0.104  9015 11617     1.0  35425 0.113 0.115 29370
2  0.73 0.74 0.0113 778 10488  0.0e+00      31 0.74 0.088  4736  7208     1.0  12804 0.068 0.071  7052
3  0.68 0.78 0.0112 738  6854  0.0e+00      26 0.78 0.072  1398  3742     1.1   8215 0.054 0.059  2759
4  0.59 0.79 0.0085 699  4993  0.0e+00      23 0.81 0.062  -174  2046     1.3   5293 0.043 0.048   125
5  0.55 0.80 0.0085 661  4240  0.0e+00      20 0.83 0.058  -647  1453     1.5   3900 0.037 0.043  -987
6  0.47 0.74 0.0089 624  3672  0.0e+00      19 0.84 0.055  -941  1041     1.6   3194 0.034 0.040 -1419
7  0.47 0.73 0.0095 588  3024 8.9e-323      18 0.85 0.051 -1324   544     1.8   2700 0.031 0.038 -1647
8  0.44 0.72 0.0098 553  2482 2.1e-241      17 0.86 0.047 -1607   150     1.9   1994 0.027 0.033 -2094
9  0.43 0.71 0.0105 519  2375 1.9e-234      16 0.86 0.047 -1463   186     1.9   2020 0.027 0.035 -1817
10 0.41 0.69 0.0116 486  1633 6.7e-124      15 0.88 0.038 -1960  -416     2.0   1265 0.021 0.028 -2328
11 0.41 0.69 0.0127 454  1558 6.4e-121      15 0.88 0.039 -1798  -356     2.0   1259 0.021 0.029 -2098
12 0.42 0.68 0.0138 423  1134  2.2e-66      13 0.89 0.033 -1993  -649     1.9    679 0.016 0.022 -2448
13 0.41 0.69 0.0151 393  1047  6.4e-61      13 0.89 0.032 -1858  -610     1.9    654 0.015 0.023 -2251
14 0.40 0.68 0.0157 364   887  1.6e-45      12 0.90 0.030 -1805  -648     2.0    514 0.014 0.021 -2177
15 0.40 0.68 0.0172 336   746  3.4e-33      12 0.90 0.028 -1738  -670     2.1    395 0.012 0.019 -2089

=====================
> alpha(x = M42$rho)

Reliability analysis   

  raw_alpha std.alpha G6(smc) average_r S/N
      0.88      0.88    0.91      0.15 7.1

 Reliability if an item is dropped:
     raw_alpha std.alpha G6(smc) average_r S/N
A1        0.88      0.88    0.91      0.15 7.0
A2        0.88      0.88    0.91      0.15 7.1
A3        0.88      0.88    0.91      0.15 7.0
A4        0.87      0.87    0.91      0.15 7.0
A5        0.88      0.88    0.92      0.15 7.3
A6        0.87      0.87    0.91      0.14 6.9
A7        0.88      0.88    0.92      0.15 7.2
A8        0.88      0.88    0.91      0.15 7.1
A9        0.87      0.87    0.91      0.15 7.0
A10       0.88      0.88    0.92      0.15 7.2
A11       0.88      0.88    0.91      0.15 7.1
A12       0.88      0.88    0.91      0.15 7.0
A13       0.87      0.87    0.91      0.15 7.0
A14       0.88      0.88    0.91      0.15 7.1
A15       0.88      0.88    0.91      0.15 7.1
A16-      0.88      0.88    0.92      0.15 7.4
A17       0.88      0.88    0.91      0.15 7.1
A18       0.88      0.88    0.91      0.15 7.0
B1        0.87      0.87    0.91      0.14 6.8
B2        0.87      0.87    0.91      0.14 6.8
B3        0.87      0.87    0.91      0.14 6.9
B4        0.87      0.87    0.91      0.14 6.8
C1        0.87      0.87    0.91      0.14 6.9
C2        0.87      0.87    0.91      0.14 6.7
C3        0.87      0.87    0.91      0.14 6.8
C4        0.87      0.87    0.91      0.14 6.8
C5        0.87      0.87    0.91      0.14 6.7
C6        0.87      0.87    0.91      0.14 6.9
D1        0.87      0.87    0.91      0.14 6.9
D2        0.87      0.87    0.91      0.14 6.9
D3        0.87      0.87    0.91      0.14 6.9
F1        0.87      0.87    0.91      0.14 6.8
F2        0.87      0.87    0.91      0.14 6.9
F3        0.88      0.88    0.91      0.15 7.1
F4        0.87      0.87    0.91      0.14 6.8
F5        0.87      0.87    0.91      0.14 6.8
F6        0.87      0.87    0.91      0.14 6.9
F7        0.87      0.87    0.91      0.14 6.8
F8        0.87      0.87    0.91      0.14 6.9
F9        0.87      0.87    0.91      0.14 6.8
F10-      0.88      0.88    0.92      0.15 7.4
F11       0.87      0.87    0.91      0.14 6.9
=====================
omega(M42$rho, nfactors = 12)
Omega 
Call: omega(m = M42$rho, nfactors = 12)
Alpha:                 0.88 
G.6:                   0.91 
Omega Hierarchical:    0.59 
Omega H asymptotic:    0.64 
Omega Total            0.93 

Schmid Leiman Factor loadings greater than  0.2 
         g   F1*   F2*   F3*   F4*   F5*   F6*   F7*   F8*   F9*  F10*  F11*  F12*   h2   u2   p2
A1                      0.84                                                       0.67 0.33 0.02
A2                      0.23        0.44                                           0.36 0.64 0.03
A3                      0.68                                                       0.57 0.43 0.01
A4                      0.66                                                       0.53 0.47 0.02
A5                                                                      0.62       0.37 0.63 0.00
A6                      0.21                                0.44                   0.46 0.54 0.05
A7                                                                      0.40       0.19 0.81 0.03
A8                                                    0.75                         0.57 0.43 0.02
A9                                                    0.27  0.45                   0.47 0.53 0.04
A10                                -0.23                                0.31       0.21 0.79 0.02
A11                     0.33        0.20                                           0.28 0.72 0.01
A12                                                   0.58                         0.49 0.51 0.02
A13                                                         0.65                   0.47 0.53 0.04
A14                                 0.32                                0.35       0.39 0.61 0.02
A15                                 0.55                                           0.36 0.64 0.01
A16-                                                 -0.44  0.21                   0.23 0.77 0.00
A17                                 0.42                                           0.31 0.69 0.02
A18                                 0.30                    0.49                   0.41 0.59 0.02
B1    0.61                                                        0.60             0.73 0.27 0.51
B2    0.66                                                        0.54             0.75 0.25 0.58
B3    0.53                                      0.50                               0.54 0.46 0.51
B4    0.57                                      0.61                               0.72 0.28 0.45
C1    0.46        0.34                                                        0.24 0.40 0.60 0.53
C2    0.64        0.37                                                             0.57 0.43 0.73
C3    0.53        0.46                                                             0.54 0.46 0.52
C4    0.62        0.41                                                             0.61 0.39 0.62
C5    0.67        0.38                                                             0.64 0.36 0.71
C6    0.49        0.27                                                       -0.23 0.39 0.61 0.61
D1    0.44                    0.72                                                 0.75 0.25 0.26
D2    0.47                    0.84                                                 0.92 0.08 0.24
D3    0.47                    0.78                                                 0.81 0.19 0.27
F1    0.57                                0.44                                     0.55 0.45 0.58
F2    0.39  0.32                                                                   0.32 0.68 0.48
F3    0.25  0.33                                                                   0.20 0.80 0.32
F4    0.49  0.34                                                                   0.45 0.55 0.53
F5    0.42  0.70                                                                   0.66 0.34 0.27
F6    0.41  0.36                                                                   0.37 0.63 0.46
F7    0.43  0.67                                                                   0.65 0.35 0.28
F8    0.52                                0.64                                     0.69 0.31 0.39
F9    0.54                                0.37                                     0.52 0.48 0.56
F10-                                                                               0.02 0.98 0.00
F11   0.40  0.54                                                                   0.47 0.53 0.34

With eigenvalues of:
   g  F1*  F2*  F3*  F4*  F5*  F6*  F7*  F8*  F9* F10* F11* F12* 
6.22 1.75 0.86 1.90 1.89 1.01 0.81 0.76 1.29 1.23 0.73 0.83 0.38 

general/max  3.27   max/min =   5.02
mean percent general =  0.26    with sd =  0.25 and cv of  0.94 
Explained Common Variance of the general factor =  0.32 

The degrees of freedom are 423  and the fit is  0.71 

The root mean square of the residuals is  0.02 
=====================
legenda para as figuras com os cargos
1. Técnicos e auxiliares de enfermagem
2. Enfermeiros
3. Médicos 
4.Técnicos de laboratório, RX, hemoterapia, nutrição, etc
5.Demais profissionais de saúde de nível superior (bioquímico, farmaceutico, fisioterapeuta, nutricionista, psicólogo, terapeuta ocupacional,  etc) 
6. Assistente Social
7. Profissional administrativo / Profissional manutenção / Profissional de gestão

====================
> m1 <- glm(NAc ~ factor(UN) + IDADE + factor(SEXO) + factor(TURNO) +
+           factor(CARGOORD)  + TEMPOHOSP + TEMPOUNI, data = datascores, family = "poisson")
> summary(m1)

Call:
glm(formula = NAc ~ factor(UN) + IDADE + factor(SEXO) + factor(TURNO) + 
    factor(CARGOORD) + TEMPOHOSP + TEMPOUNI, family = "poisson", 
    data = datascores)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.0556  -1.5252  -1.3218  -0.2252  12.3159  

Coefficients:
                  Estimate Std. Error z value Pr(>|z|)    
(Intercept)        0.87824    0.12825   6.848 7.50e-12 ***
factor(UN)2        0.12726    0.09147   1.391   0.1641    
IDADE             -0.01817    0.00434  -4.186 2.84e-05 ***
factor(SEXO)2     -0.24021    0.06136  -3.915 9.06e-05 ***
factor(TURNO)MT   -0.41121    0.07389  -5.566 2.61e-08 ***
factor(TURNO)N    -0.22216    0.07585  -2.929   0.0034 ** 
factor(TURNO)T    -0.10532    0.07006  -1.503   0.1328    
factor(TURNO)TN   -0.18542    0.11770  -1.575   0.1152    
factor(CARGOORD)2 -0.30268    0.07703  -3.929 8.52e-05 ***
factor(CARGOORD)3  0.20008    0.12879   1.554   0.1203    
factor(CARGOORD)4 -0.54770    0.13006  -4.211 2.54e-05 ***
factor(CARGOORD)5 -0.16481    0.07765  -2.122   0.0338 *  
factor(CARGOORD)6 -0.47453    0.45015  -1.054   0.2918    
factor(CARGOORD)7 -0.05525    0.07346  -0.752   0.4520    
TEMPOHOSP         -0.08097    0.03749  -2.160   0.0308 *  
TEMPOUNI           0.15248    0.03689   4.134 3.57e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for poisson family taken to be 1)

Null deviance: 6076.6  on 1469  degrees of freedom
Residual deviance: 5945.7  on 1454  degrees of freedom
  (155 observations deleted due to missingness)
AIC: 7122.4

Number of Fisher Scoring iterations: 7
=========================
 m2 <- betareg(NAp ~ factor(UN) + IDADE + factor(SEXO) + factor(TURNO) +
+             factor(CARGOORD)  + TEMPOHOSP + TEMPOUNI, data = datascores, link = "probit")
> summary(m2)

Call:
betareg(formula = NAp ~ factor(UN) + IDADE + factor(SEXO) + factor(TURNO) + factor(CARGOORD) + TEMPOHOSP + TEMPOUNI, data = datascores, link = "probit")

Standardized weighted residuals 2:
    Min      1Q  Median      3Q     Max 
-0.6638 -0.3580 -0.2844  0.5486  1.8549 

Coefficients (mean model with probit link):
                   Estimate Std. Error z value Pr(>|z|)    
(Intercept)       -1.799863   0.058622 -30.703   <2e-16 ***
factor(UN)2       -0.003820   0.041370  -0.092    0.926    
IDADE             -0.001440   0.001804  -0.798    0.425    
factor(SEXO)2     -0.010736   0.024845  -0.432    0.666    
factor(TURNO)MT   -0.017688   0.030723  -0.576    0.565    
factor(TURNO)N    -0.014511   0.033238  -0.437    0.662    
factor(TURNO)T    -0.011154   0.031969  -0.349    0.727    
factor(TURNO)TN   -0.045126   0.051675  -0.873    0.383    
factor(CARGOORD)2 -0.048508   0.032519  -1.492    0.136    
factor(CARGOORD)3 -0.034966   0.060130  -0.582    0.561    
factor(CARGOORD)4 -0.041529   0.047159  -0.881    0.379    
factor(CARGOORD)5 -0.021858   0.034735  -0.629    0.529    
factor(CARGOORD)6  0.049290   0.174722   0.282    0.778    
factor(CARGOORD)7 -0.036702   0.033032  -1.111    0.267    
TEMPOHOSP          0.004624   0.014997   0.308    0.758    
TEMPOUNI          -0.001362   0.015051  -0.090    0.928    

Phi coefficients (precision model with identity link):
      Estimate Std. Error z value Pr(>|z|)    
(phi)  10.0265     0.5265   19.04   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 

Type of estimator: ML (maximum likelihood)
Log-likelihood:  4901 on 17 Df
Pseudo R-squared: 0.01115
Number of iterations: 34 (BFGS) + 2 (Fisher scoring) 
==========================
> m3 <- glm(SCORE ~ factor(UN) + IDADE + factor(SEXO) + factor(TURNO) +
+             factor(CARGOORD)  + TEMPOHOSP + TEMPOUNI, data = datascores)
> summary(m3)

Call:
glm(formula = SCORE ~ factor(UN) + IDADE + factor(SEXO) + factor(TURNO) + 
    factor(CARGOORD) + TEMPOHOSP + TEMPOUNI, data = datascores)

Deviance Residuals: 
     Min        1Q    Median        3Q       Max  
-109.416    -8.415     1.999    11.952    47.748  

Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
(Intercept)       139.09614    2.63779  52.732   <2e-16 ***
factor(UN)2         1.06351    1.93653   0.549   0.5830    
IDADE               0.12789    0.08448   1.514   0.1303    
factor(SEXO)2       2.06301    1.16313   1.774   0.0763 .  
factor(TURNO)MT     2.08359    1.43741   1.450   0.1474    
factor(TURNO)N     -0.80977    1.55230  -0.522   0.6020    
factor(TURNO)T     -0.19598    1.49249  -0.131   0.8955    
factor(TURNO)TN     0.53894    2.42940   0.222   0.8245    
factor(CARGOORD)2   1.58121    1.52101   1.040   0.2987    
factor(CARGOORD)3   0.96708    2.81954   0.343   0.7317    
factor(CARGOORD)4   1.58035    2.20839   0.716   0.4743    
factor(CARGOORD)5  -1.71552    1.62007  -1.059   0.2898    
factor(CARGOORD)6   7.17949    8.05703   0.891   0.3730    
factor(CARGOORD)7  -0.02003    1.54331  -0.013   0.9896    
TEMPOHOSP          -0.16686    0.70193  -0.238   0.8121    
TEMPOUNI           -0.07676    0.70453  -0.109   0.9133    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for gaussian family taken to be 381.9328)

    Null deviance: 561714  on 1469  degrees of freedom
Residual deviance: 555330  on 1454  degrees of freedom
  (155 observations deleted due to missingness)
AIC: 12929

Number of Fisher Scoring iterations: 2

==========================

> m4 <- clm(factor(SCORE) ~ factor(UN) + IDADE + factor(SEXO) + factor(TURNO) + TEMPOHOSP + TEMPOUNI, data = data)
> summary(m4)
formula: 
factor(SCORE) ~ factor(UN) + IDADE + factor(SEXO) + factor(TURNO) + TEMPOHOSP + TEMPOUNI
data:    data

 link  threshold nobs logLik   AIC      niter max.grad cond.H 
 logit flexible  1473 -6178.54 12593.08 7(1)  3.03e-12 3.8e+06

Coefficients:
                 Estimate Std. Error z value Pr(>|z|)  
factor(UN)2      0.220536   0.172213   1.281   0.2003  
IDADE            0.012324   0.007447   1.655   0.0979 .
factor(SEXO)2    0.207867   0.102965   2.019   0.0435 *
factor(TURNO)MT  0.156932   0.121560   1.291   0.1967  
factor(TURNO)N  -0.141495   0.133734  -1.058   0.2900  
factor(TURNO)T  -0.018888   0.131875  -0.143   0.8861  
factor(TURNO)TN  0.036781   0.215716   0.171   0.8646  
TEMPOHOSP       -0.071866   0.063066  -1.140   0.2545  
TEMPOUNI         0.044336   0.063715   0.696   0.4865  
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

==============================

> summary(cfa.1)

 Model Chisquare =  5480.065   Df =  819 Pr(>Chisq) = 0
 Goodness-of-fit index =  0.7558605
 Adjusted goodness-of-fit index =  0.7308206
 RMSEA index =  0.07131577   90% CI: (NA, NA)
 Bentler-Bonett NFI =  0.6151497
 Tucker-Lewis NNFI =  0.633733
 Bentler CFI =  0.6515996
 Bentler RNI =  0.6515996
 Bollen IFI =  0.65269
 SRMR =  0.152455
 AIC =  5648.065
 AICc =  5493.862
 BIC =  -270.2028
 CAIC =  -1089.203

 Normalized Residuals
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
-4.0120  0.3103  1.5810  3.3450  6.6750 17.6000 

 R-square for Endogenous Variables
    A1     A3     A4    A11     B1     B2     B3     B4     A6     A9    A13     F1     F8     F9    A15    A18    A10    A17     C1     C3     C5     C2     C4     C6     D1     D2     D3 
0.5767 0.4388 0.4419 0.1931 0.5888 0.6526 0.2254 0.2969 0.3758 0.3771 0.2484 0.4423 0.5071 0.4166 0.1720 0.2216 0.0158 0.4448 0.3036 0.5084 0.5350 0.3971 0.5175 0.4166 0.7055 0.9021 0.7566 
    F4    F10     F2     F6     A2     A5     A7    A14     F3     F5     F7    F11     A8    A12    A16 
0.3776 0.0000 0.2087 0.3898 0.1933 0.1098 0.0576 0.4642 0.1082 0.6931 0.5748 0.4044 0.6511 0.2758 0.0999 
