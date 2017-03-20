## Implementation based on John Cook's paper: https://www.johndcook.com/quantiles_parameters.pdf
elicit.normal <- function(CI, alpha = .95){
p1 <- (1 - alpha)/2
p2 <- (1 + alpha)/2
x1 <- CI[1]
x2 <- CI[2]
mu.est <- (x1 * qnorm(p = p2) - x2 * qnorm(p = p1))/(qnorm(p = p2) - qnorm(p = p1))
sd.est <- (x2-x1)/(qnorm(p = p2) - qnorm(p = p1))
  return(c(mu.est = mu.est,  sigma.est = sd.est))
}
