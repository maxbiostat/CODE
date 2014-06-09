# Generating synthetic data
## (hyper)parameters 
## Predictive power for P(t,T) of the posterior mean
M <-100 # number of replicates
a1 <- 30
a2 <- 23
b1 <- 10
b2 <- 15
c1 <- 700
c2 <- .40
# Exploring the data
# TT<-seq(20,40,.1)
K.T <- function(T) c1*exp(-((T-a1)^2)/b1)
r.T <- function(T) c2*exp(-((T-a2)^2)/b2)
verhulst.pred <- function(r, K, t, No) (K)/(1+ ((K-No)/No) * exp (-r*t))
Temp <- c(20, 40)
time <- 40
No <- 10
temp <- seq(Temp[1], Temp[2], 2)
TEMP <- matrix(NA, nrow = time, ncol = length(temp))
tau <- 10
for (t in temp){
  r <- r.T(t)
  K <- K.T(t)
  TEMP[, match(t, temp)] <- verhulst.pred(r, K, 1:time, No) +
    rnorm(time, sd = sqrt(tau))
}
pop <- data.frame(t = rep(1:time, length(temp)),
                  T = sort(rep(temp, time)),
                  P = as.vector(TEMP))
pop_dat <- list(No = No, M = length(pop$P),
                t = pop$t, Temp = pop$T,
                P = pop$P)
################################
###### STAN BLOCK
################################
library(rstan)
set_cppo('fast')
verhulst_code <- '
  data {
    real No; // initial population condition
    int<lower=0> M; // number of observations
    real Temp[M]; // temperatures
    real <lower=0> t[M]; // times
    real P[M]; // trajectories   
}
parameters {
  real a1;
  real a2;
  real <lower=0.1> b1;
  real <lower=0.1> b2; 
  real <lower=0> c1;
  real c2;
  real <lower=0> tau; // P(t,T) variance (precision)
}
model {
  real r[M];
  real K[M];
  real mu[M];
  for(m in 1:M){
    r[m] <- c2*exp(-pow(Temp[m]-a2,2)/b2) ;
    K[m] <- c1*exp(-pow(Temp[m]-a1,2)/b1) ;
    mu[m] <- (K[m])/(1+((K[m]-No)/No)*exp(-r[m]*t[m]));
    P[m] ~ normal(mu[m], tau); // sampling model (likelihood)
  }
  a1 ~ normal(25, 10); // Gaussian Kernel K(T) priors
  a2 ~ normal(25, 10); 
  b1 ~ gamma(4, 2.0E-1);
  b2 ~ gamma(4, 2.0E-1);
  c1 ~ gamma(1.0, 1.0E-3);
  c2 ~ normal(.5, .2);
  tau ~ gamma(0.1, 0.1); // variance conjugate prior
}
'
inits <- function(){
list(a1 = 25, a2 = 25, b1 = 20, b2 = 20, c1 = 2000, c2 = 1, tau = 1E-04)
}
verhulst <- stan(model_code = verhulst_code,data = pop_dat, iter = 1,
                 chains = 1)
library(parallel) 
chains <- 1
posterior <- mclapply(1:chains, mc.cores = chains, FUN = function(chain) { 
  stan(fit=verhulst, data = pop_dat, iter = 50000, chains = 1,
       thin = 10, init = list(inits()), verbose = TRUE, chain_id = chain)
})
posterior <- sflist2stanfit(posterior)
print(posterior[[1]])
#plot(posterior[[1]])
SIM <- posterior[[1]]@sim$samples
tab <- data.frame(
  a1 = SIM[[1]]$a1,
  a2 = SIM[[1]]$a2,
  b1 = SIM[[1]]$b1,
  b2 = SIM[[1]]$b2,
  c1 = SIM[[1]]$c1,
  c2 = SIM[[1]]$c2,
  tau = SIM[[1]]$tau
)
write.table(tab, file = "DATA/posterior_simudata.txt",
            row.names = FALSE, sep = "\t")