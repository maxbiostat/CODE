#######
## Script to perform the simulation study proposed in Carvalho, Struchiner & Bastos (2014)
# This piece of code is supposed to be run in conjunction with the 'run_simulation_study.sh' script
# If you want to specify the simulation specs here instead, mofication is straigthforward
# Copyleft (or the one to blame): Carvalho, LMF (2014)
# Last updated: 09/06/2014 
#######
# Generating synthetic data
# reading specs from files 
M   <-   as.numeric(read.table("rep.txt")) # number of replicates
mc   <-   as.numeric(read.table("mc.txt")) # number of iterations
path   <-   as.character(read.table("cam.txt", as.is = T))
nome   <-   as.character(read.table("nome.txt", as.is = T))
freec   <-   as.numeric(read.table("freec.txt"))
##
## (hyper)parameters
a1   <-   30
a2   <-   23
b1   <-   10
b2   <-   15
c1   <-   700
c2   <-   .40
# Exploring the data
# TT  <-  seq(20, 40, .1)
 K.T  <-  function(T) c1*exp(- ((T-a1)^2)/b1)
 r.T  <-  function(T) c2*exp(- ((T-a2)^2)/b2)
 verhulst.pred  <-  function(r, K, t, No) (K)/(1+ ((K-No)/No) * exp (-r*t))
# plot(TT, K.T(TT), type = "l")
# plot(TT, r.T(TT), type = "l")
##
Temp  <-  c(22, 40) # temperature range
time  <-  35 # final time
No  <-   10 # initial population condition
####
data.sets  <-  vector(M, mode = "list")
for (k in 1:M){
cat("Generating data...", k/M*100, " % complete", "\n")
temp  <-  seq(Temp[1], Temp[2], 2)
TEMP  <-  matrix(NA, nrow = time, ncol = length(temp))
tau  <-  10
for (t in temp){
  r  <-  r.T(t)
  K  <-  K.T(t)
  TEMP[, match(t, temp)]  <-  verhulst.pred(r, K, 1:time, No)+rnorm(time, sd = sqrt(tau))
}
pop  <-  data.frame(t = rep(1:time, length(temp)), T = sort(rep(temp, time)), P = as.vector(TEMP))
data.sets[[k]]  <-   list(No = No, M = length(pop$P), t = pop$t, Temp = pop$T, P = pop$P)
}
################################
###### STAN BLOCK
################################
library(rstan)
set_cppo('fast')
verhulst_code   <-   '
  data {
    real No; // initial population condition
    int<lower = 0> M; // number of observations
    real Temp[M]; // temperatures
    real <lower = 0> t[M]; // times
    real P[M]; // trajectories   
}
parameters {
  real a1;
  real a2;
  real <lower = 0.1> b1;
  real <lower = 0.1> b2; 
  real <lower = 0> c1;
  real c2;
  real <lower = 0> tau; // P(t, T) variance (precision)
}
model {
  real r[M];
  real K[M];
  real mu[M];
  for(m in 1:M){
    r[m]   <-   c2*exp(-pow(Temp[m]-a2, 2)/b2) ;
    K[m]   <-   c1*exp(-pow(Temp[m]-a1, 2)/b1) ;
    mu[m]  <-  (K[m])/(1+((K[m]-No)/No)*exp(-r[m]*t[m]));
    P[m] ~ normal(mu[m],  tau); // sampling model (likelihood)
  }
  a1 ~ normal(25, 10); // Gaussian Kernel K(T) priors
  a2 ~ normal(25, 10); 
  b1 ~ gamma(4, 2.0E-1);
  b2 ~ gamma(4, 2.0E-1);
  c1 ~ gamma(70,  1.0E-1);
  c2 ~ normal(.5, .2);
  /* c2 ~ gamma(0.3,  1); */
  tau ~ gamma(0.1, 0.1); // variance conjugate prior
}
'
######
## END OF STAN BLOCK
######
inits   <-   function(){
list(a1 = 25, a2 = 25, b1 = 20, b2 = 20, c1 = 1000, c2 = 1, tau = 1E-04)
}
#
verhulst   <-   stan(model_code  =  verhulst_code, data  = data.sets[[2]],  iter  =  1,  chains  =  1)
summarize  <-  function(x){
  return(c(m = mean(x), md = median(x), L = quantile(x, .025), U = quantile(x, .975)))
}
#
estimate  <-  function(x){
  mcmc  <-  stan(fit = verhulst,  data  =  x,  iter = mc, chains  =  1, thin = ceiling(mc/200), 
             init = list(inits()), verbose  =  FALSE)@sim$samples[[1]][1:7]
  write.table(mcmc, )
    return(as.data.frame(simplify2array(lapply(mcmc, summarize))))}
#
library(parallel)
cores  <-  detectCores()-freec
simu  <-  mclapply(data.sets, estimate, mc.cores = cores)
###
means  <-  medians  <-  lowers  <-  uppers  <-  data.frame(matrix(NA, M, 7))
names(means)  <-  names(medians)  <-  names(lowers)  <-  names(uppers)  <-  c("a1", "a2", "b1", "b2", "c1", "c2", "tau")
for (c in 1:M){
  means[c, ]  <-  simu[[c]][1, ]
  medians[c, ]  <-  simu[[c]][2, ]
  lowers[c, ]  <-  simu[[c]][3, ]
  uppers[c, ]  <-  simu[[c]][4, ]
}
head(means)
##
write.table(means, file = paste(path, "/", nome, "_means.txt", sep = ""), row.names = FALSE, sep = "\t")
write.table(medians, file = paste(path, "/", nome, "_means.txt", sep = ""), row.names = FALSE, sep = "\t")
write.table(lowers, file = paste(path, "/", nome, "_lowers.txt", sep = ""), row.names = FALSE, sep = "\t")
write.table(uppers, file = paste(path, "/", nome, "_uppers.txt", sep = ""), row.names = FALSE, sep = "\t")
####
## Analysis block
####
parameters   <-   c( a1 = 30,  a2 = 23,  b1 = 10,  b2 = 15,  c1 =  700,  c2 = .40,  tau = sqrt(10) )
#bias function
Bias   <-   function(d, par, scale = FALSE){
  bias   <-   rep(NA,  ncol(d) )
  names(bias)   <-   names(d)
  if( !length(par) =  = ncol(d) ){
    stop("parameter vector is of the wrong dimension")}
  
  for (i in 1:ncol(d)){
    if(scale){
      bias[i]   <-   ( (mean(d[,  i])-par[i])^2 )/par[i] # scaled bias
    }else{
      bias[i]   <-   ( mean(d[,  i])-par[i] )^2 # unnormalized bias
    }
  }
  return(bias)}

biasmean  <-  Bias(means, parameters, scale = TRUE)
biasmedian  <-  Bias(medians, parameters, scale = TRUE)
# CIs
ci  <-  vector(ncol(lowers), mode = "list");names(ci)  <-  names(lowers)
for (i in 1:ncol(lowers)){
  ci[[i]]  <-  data.frame(L = lowers[, i], U = uppers[, i])
}
Cover   <-   function(d,  p) apply(d,  1,  function(x) ifelse(p > x[1] && p < x[2],  1,  0)) # if p \in [L, U] =  1
coverages   <-   mse.m   <-   mse.md   <-   rep(NA,  ncol(lowers))

for (i in 1:ncol(lowers)){
  coverages[i]   <-   mean(Cover(ci[[i]],  p = parameters[i]))
  mse.m[i]   <-   mean((means[,  i]-parameters[i])^2)
  mse.md[i]   <-   mean((medians[,  i]-parameters[i])^2)
}
#
tab   <-   data.frame( true = parameters, mean = colMeans(means),  median = colMeans(medians), 
                  bm = biasmean,  bmd = biasmedian,  mse.m,  mse.md,  coverage = coverages )
write.table(tab, file = paste(path, "/", "results",  "_",  nome, "_", M, ".log",  sep = ""), sep = "\t")
q(save = "no")
