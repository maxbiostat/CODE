# Copyleft (or the one to blame): Carvalho, LMF (2014)
# Last updated: 09/06/2014 
### WARNING: please note that the data set 'Rhodi_temp_data.txt' will be made available soon, due to disclosure issues with another ongoing publication. 
posterior <- data.frame(read.table("DATA/posterior_real.txt", TRUE))
G <- 10000
prior <- data.frame( # prior distributions for r(T) and K(T) parameters
  a1 = rnorm(G, 25, 10),
  b1 = rgamma(G, 4, 1/5),
  c1 = rgamma(G, 1, 1/1000),
  a2 = rnorm(G, 25, 10),
  b2 = rgamma(G, 4, 1/5),
  c2 = rnorm(G, .5, 2)
)
############
N <- 1000 #replicates
temps <-seq(16, 40, .5)
times <- 1:40
No <- 30
priorP <- postP <- array(data = NA, dim = c(length(times), length(temps), N))
M <- function(a1, a2, b1, b2, c1, c2, time, Temp, No){ # deterministic model M(x; \theta)
  K <- c1*exp(- ((Temp-a1)^2)/b1)
  if(K < No){K <- No} # "rejection" step: K cant be greater than N_0
  r <- c2*exp(- ((Temp-a2)^2)/b2)
  P <- (K)/(1+ ((K-No)/No) * exp (-r*time))
  return(P)
}
##
# Sampling 
system.time(
for(rep in 1:N){
  for(temp in temps){
    for(time in times){
      
      postemp <- match(temp, temps)
      postime <- match(time, times)  
      # Sampling from the priors for \mathbf{\theta}
      pr.a1 <- sample(prior$a1,1)
      pr.a2 <- sample(prior$a2,1)
      pr.b1 <- sample(prior$b1,1)
      pr.b2 <- sample(prior$b2,1)
      pr.c1 <- sample(prior$c1,1)
      pr.c2 <- sample(prior$c2,1)
      priorP[postime, postemp, rep] <- M(a1 = pr.a1, a2 = pr.a2, b1 = pr.b1,
                                         b2 = pr.a2, c1 = pr.c1, c2 = pr.c2,
                                         Temp = temp, time = time, No = No)
      # Analogous for the posterior
      pt.a1 <- sample(posterior$a1,1)
      pt.a2 <- sample(posterior$a2,1)
      pt.b1 <- sample(posterior$b1,1)
      pt.b2 <- sample(posterior$b2,1)
      pt.c1 <- sample(posterior$c1,1)
      pt.c2 <- sample(posterior$c2,1)
      postP[postime, postemp, rep] <- M(a1 = pt.a1, a2 = pt.a2, b1 = pt.b1,
                                        b2 = pt.a2, c1 = pt.c1, c2 = pt.c2,
                                        Temp = temp, time = time, No = No)
    }
  }
}
)
# Summarizing
extmean <- function(x,N){ rowMeans(matrix(x, ncol = N))}
extmedian <- function(x,N){apply(matrix(x, ncol = N), 1, median) }
extlwr  <- function(x,N){apply(matrix(x, ncol = N), 1,
                               function(y) quantile(y, probs = .025, na.rm = TRUE) ) }
extupr  <- function(x,N){apply(matrix(x, ncol = N), 1,
                               function(y) quantile(y, probs = .975, na.rm = TRUE) ) }
##
meanpriorP <- apply (priorP, 2, function(w) extmean(w, N = N))
medianpriorP <- apply (priorP, 2, function(w) extmedian(w, N = N))
lwrpriorP <- apply (priorP, 2, function(w) extlwr(w, N = N))
uprpriorP <- apply (priorP, 2, function(w) extupr(w, N = N))
#
meanpostP <- apply (postP, 2, function(w) extmean(w, N = N))
medianpostP <- apply (postP, 2, function(w) extmedian(w, N = N))
lwrpostP <- apply (postP, 2, function(w) extlwr(w, N = N))
uprpostP <- apply (postP, 2, function(w) extupr(w, N = N))
##
dat <- data.frame(read.table("DATA/Rhodi_temp_data.txt",TRUE))
mP <- matrix(dat$P, 35, 10)
postscript("fig_4A.eps", width = 20, height = 4,
           horizontal = TRUE)
par(cex.axis = 2, cex.lab = 2,
    mar = c(4, 6.3, 1, 6.3))
filled.contour(sort(unique(dat$t)), sort(unique(dat$T)), mP,
               xlab = "Time (days)",
               ylab = "Temperature (ºC)",
               color.palette = function(x) rev(heat.colors(x))
               )
dev.off()
postscript("fig_4B.eps", width = 20, height = 4,
           horizontal = TRUE)
par(cex.axis = 2, cex.lab = 2,
    mar = c(4, 6.3, 1, 6.3))
filled.contour(times, temps, meanpostP,
               xlab="Time (days)",
               main ="",
               ylab = "Temperature (ºC)",
               color.palette = function(x)rev(heat.colors(x)))
dev.off()
