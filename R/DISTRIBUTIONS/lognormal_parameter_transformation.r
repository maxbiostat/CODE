### Imagine you are given the mean of a lognormal distribution in real space (m), but it's standard deviation in
### log-space (\sigma).
### You'd like to find the standard deviation in real space, v.
get.real.var <- function(m, sigma){
  ## Takes REAL mean and LOG variance and returns REAL variance
  sigmasq <- sigma^2
  v <- exp(sigmasq + 2*log(m) -1)
  return(v)
}
# get.real.var(m = 1.3E-3, sigma = sqrt(.64))
LogMean <- function(realMean, realSD){
  ## takes REAL mean and REAL standard deviation; returns LOG mean
  realVar <- realSD^2
  mu <- log(realMean/ sqrt(1 + realVar/realMean^2))
  return(mu)
}
LogVar <- function(realMean, realSD){
  ## takes REAL mean and REAL standard deviation; returns LOG variance
  realVar <- realSD^2
  sigmasq <- log(1 + realVar/realMean^2)
  return(sigmasq)
}