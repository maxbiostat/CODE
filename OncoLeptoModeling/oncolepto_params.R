### This script is a companion (aux) to make_figures.R
### Copyleft (or the one to blame): Carvalho, LMF (2014)

#############
# WithOUT Sexual differentiation (SD)
#############

pe <- .87 # probability of eclosion (uninfected)
pe.i <- .76 # probability of eclosion (infected)

parameters <- c(o = 21, pe = pe, e = 1/6, # oviposition and eclosion
                d12 = 1/1.6, d23 = 1/5, d34 = 1/2.2, d45 = 1/5.1, d5A = 1/4.5, # development uninfected
                m1 = 1/3, m2 = 1/3, m3 = 1/3, m4 = 1/3, m5 = 1/2, mA = 1/70)

parameters.inf <-c(o = 12, pe = pe.i, e = 1/7, # oviposition and eclosion
                   d12 = 1/2.6, d23 = 1/2.8, d34 = 1/4.8, d45 = 1/2.6, d5A = 1/9.9, # development infected
                   m1 = 1/3, m2 = 1/3, m3 = 1/3, m4 = 1/3, m5 = 1/2, mA = 1/30) # mortality
#############
# With Sexual differentiation
#############
pF <- .55
pF.i <- .55

parameters.SD <- c(o = 21, pe = pe,  e = 1/6, # oviposition and eclosion
                  d12 = 1/1.6, d23 = 1/5, d34 = 1/2.2, d45 = 1/5.1, d5A = 1/4.5, # development uninfected
                  m1 = 1/3, m2 = 1/3, m3 = 1/3, m4 = 1/3, m5 = 1/2,
                  pF = pF, mM = 1/71, mF = 1/66)

parameters.SD.inf <- c(o = 12, pe = pe.i, e = 1/7, # oviposition and eclosion
                       d12 = 1/2.6, d23 = 1/2.8, d34 = 1/4.8, d45 = 1/2.6, d5A = 1/9.9, # development infected
                       m1 = 1/3, m2 = 1/3, m3 = 1/3, m4 = 1/3, m5 = 1/2,
                       pF = pF.i,  mM = 1/43, mF = 1/20) # mortality
########################
### Inital conditions
########################
Ac <- 50 # adults

init <-   c(E = 100, N1 = 20, N2 = 50, N3 = 50, N4 = 30, N5 = 100,
            A = Ac)
initSD <- c(E = 100, N1 = 20, N2 = 50, N3 = 50, N4 = 30, N5 = 100,
            M = Ac - ceiling(Ac * pF), Fe = ceiling(Ac * pF))
