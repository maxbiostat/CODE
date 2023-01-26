logistic_map <- function(x, lambda){
  # new.x <- lambda*x*(1-x)
  new.x <- exp(log(lambda) + log(x) + log1p(-x))
    return(new.x)
}
get_final <- function(x0, tfinal, lambda){
  out <- rep(NA, tfinal)
  out[1] <- x0
  for(t in  2:tfinal){
    out[t] <- logistic_map(x = out[t-1],
                                  lambda = lambda)
  } 
  return(out[tfinal])
}
##############################
##############################
Nsteps <- 100
times <- 1:Nsteps

parameter <- 2.3
ini.x <- .5

plot(population~times, type = "l", lwd = 3,
     xlab = "Time", ylab = "Population size X(t)")

lls <- seq(0, 4, length.out = 1000)
xfs <- sapply(lls, function(l) get_final(x0 = ini.x, tfinal = 200, lambda = l)) 

plot(xfs~lls, type = "p", pch = 16, 
     xlab = expression(lambda), ylab = "X_final")
