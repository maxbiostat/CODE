##################################################################
## Generic code to perform a Monte Carlo study on the frequentist 
## properties of MCMC-based Bayesian estimators
## This code in particular simulates Y = b0 + b1*X1 + b2*X2  where X1~normal(0,1) and X2~bernoulli(1/2)
## and then fits a very simple linear model using Stan
## Copyleft (or the one to blame): Carvalho, LMF (2014)
####################################################################

# you can read specs from files or specify them here
M <- 100  #as.numeric(read.table("rep.txt")) # number of replicates
mc <- 5000 #as.numeric(read.table("mc.txt")) # number of iterations
path <-"/home/max/exemplodaniel"  #as.character(read.table("cam.txt",as.is=T)) # path to save results
nome <-"exemplo1" #as.character(read.table("nome.txt",as.is=T)) # simulation name
freec <- 1 #as.numeric(read.table("freec.txt")) # number of freecores
##  True parameters
b0 <- .5
b1 <- -1
b2 <- 2
tau <- 1
N <- 1000  # number of observations
########################################
############# Generating synthetic data
########################################
data.sets <- vector(M,mode="list")
for (k in 1:M){
cat("Generating data...",k/M*100," % complete","\n")
 x1 <- rnorm(N)
 x2 <- rbinom (N, 1, .5)
 y  <- b0 + b1*x1 + b2*x2 + rnorm(N, m=0, tau)
data.sets[[k]]<- list( Y = y, X1 = x1, X2 = x2, N = N)
}
#lapply(data.sets, function(x) hist(x$Y) )
#lapply(data.sets, function(x) plot( Y ~ X1, data = x) )
#lapply(data.sets, function(x) summary(glm(x$Y ~ x$X1 + x$X2)) )
################################
###### STAN BLOCK
################################
library(rstan)
set_cppo('fast')
linear_code <- '
  data {
    int<lower=0> N; // number of observations    
    real X1[N]; 
    real X2[N]; 
    real Y[N]; // response
}
parameters {
  real b0;  
  real b1;
  real b2;
  real <lower=0> tau; // variance 
}
model {
 real mu[N];
for (n in 1:N){
    mu[n] <- b0 + b1*X1[n] + b2*X2[n];
    Y[n] ~ normal(mu[n], tau); // sampling model (likelihood)
              }    
  b0 ~ normal(0, 1.0E+03);
  b1 ~ normal(0, 1.0E+03);
  b2 ~ normal(0, 1.0E+03);
  tau ~ gamma(0.1,0.1); // variance conjugate prior
}
'
inits <- function(){
list(b0 = 1, b1 = 1, b2 = 1, tau=1E-04)
}
#
linear <- stan(model_code = linear_code, data = data.sets[[1]],# any data set would do
                 iter = 1, chains = 1) # compiled stan model

########################
### Auxiliary functions
########################

summarize<-function(x){ # function to extract estimates from a mcmc
  return(c(m=mean(x), md = median(x), L = quantile(x,.025), U = quantile(x,.975)))
}
##
estimate <- function(x){ # function to perform estimation: for a data set 'x' 
                         # sample from the posterior distribution using mcmc and
                         # then use 'summarize()' to get the estimates and CIs
  mcmc <- stan(fit = linear, data = x, iter = mc, chains = 1,thin = ceiling(mc/200),
             init = list(inits()),verbose = FALSE)@sim$samples[[1]][1:4]
  write.table(mcmc,)
    return(as.data.frame(simplify2array(lapply(mcmc, summarize))))
}
###########################
#### The actual simulation
###########################
library(parallel)
cores <- detectCores()-freec # total minus the reserved cores
simu <- mclapply(data.sets,estimate,mc.cores=cores)
###
means<-medians<-lowers<-uppers<-data.frame(matrix(NA,M,4)) # empty tables to store the results
names(means)<-names(medians)<-names(lowers)<-names(uppers)<-c("b0","b1","b2","tau")
for (c in 1:M){
  means[c,] <- simu[[c]][1,]
  medians[c,] <- simu[[c]][2,]
  lowers[c,] <- simu[[c]][3,]
  uppers[c,] <- simu[[c]][4,]
}
head(means)
hist(means$b0, xlab = expression(beta[0]), main = expression(beta[0]) )
abline(v=b0, lwd = 4, lty = 2)
hist(means$b1, xlab = expression(beta[1]) , main = expression(beta[1]))
abline(v=b1, lwd = 4, lty = 2)
hist(means$b2, xlab = expression(beta[2]) , main = expression(beta[2]))
abline(v=b2, lwd = 4, lty = 2)
##
write.table(means,file=paste(path,"/",nome,"_means.txt",sep=""),row.names=FALSE,sep="\t")
write.table(medians,file=paste(path,"/",nome,"_means.txt",sep=""),row.names=FALSE,sep="\t")
write.table(lowers,file=paste(path,"/",nome,"_lowers.txt",sep=""),row.names=FALSE,sep="\t")
write.table(uppers,file=paste(path,"/",nome,"_uppers.txt",sep=""),row.names=FALSE,sep="\t")