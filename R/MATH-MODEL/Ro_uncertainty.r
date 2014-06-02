## Companion of the generalized beta script
## Shows how one can calculate the distribution of R0 analytically for Gamma distributed \beta and \gamma
source("~/Dropbox/SCRIPTS/R/DISTRIBUTIONS/generalized_beta_prime.R")
##
 M <- 1000000
## hyper parameters
N <- 1000
k1 <- 1.2
t1 <- 1/500
k2 <- 1
t2 <- .5
####
beta <- rgamma(M, k1, 1/t1)
betaN <- beta*N
gamma <- rgamma(M, k2, 1/t2)
####
hist(beta)
hist(betaN)
hist(gamma)
####
R0<-betaN/gamma
pR0<-mean(R0<1)
hist(R0[R0<50], prob=T, ylim = c(0, .15))
#hist(R0,prob=T)
R <- seq(0,50,.1)
#R<-seq(0,max(R0),1)
lines(R,dbeta.prime(x=R,k1,k2,t1,t2,N), lwd = 3)
lines(R,dbeta.prime2(x=R,k1,k2,t1,t2,N), lwd = 3, col = 2)
legend(x="topright",legend=paste("Pr(R0<1)=",pR0),bty="n")