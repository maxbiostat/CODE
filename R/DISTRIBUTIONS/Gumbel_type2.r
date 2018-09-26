### Test inverse CDF random variable generation for a type-2 Gumbel distribution
### See also https://arxiv.org/pdf/1403.4630.pdf for the motivation behind U and alpha

U <- 1
alpha <- .1
ap <- 1/2
bp <- -log(alpha)/U

dgumbel2 <- function(x, a, b, log = FALSE){
  ans <- log(a) + log(b) -( a + 1)*x -b*x^-a
    if(!log) ans <- exp(ans)
  return(ans)
}
#
rgumbel2 <- function(n, a, b){
  p <- runif(n)
  x <- (-b/log(p))^(1/a)
    return(x)
}
# X <- rgumbel2(n = 100, a = ap, b = bp)
# q <- quantile(X, .1)
# exp(-bp*q^-ap)
# 
# (-bp/log(1/2))^(1/ap) ## median
# median(X)
# 
# dgumbel2(2, a = ap, b = bp, log = TRUE)
# dgumbel2(2, a = ap, b = bp)
# 
# hist(X, probability = TRUE)
# curve(dgumbel2(x, a = ap, b = bp), 0, max(X), add = TRUE)
# curve(dgumbel2(x, a = ap, b = bp), 0, 10)
# 
# # Y <- rnorm(1e6, 0, sd = 1/sqrt(X))
# # hist(Y)
# curve(dnorm(x, mean = 0, sd = 1/sqrt(X[1])), -5, 5,
#       xlab = expression(gamma), ylab = "Density",
#       main = "Prior on log-population size \n Gumbel")
# for(i in 2:length(X)){
#   curve(dnorm(x, mean = 0, sd = 1/sqrt(X[i]) ), -5, 5, add = TRUE)
# }
# 
# X2 <- rgamma(1e6, shape = 0.001, scale = 1000)
# 
# curve(dnorm(x, mean = 0, sd = 1/sqrt(X2[1])), -5, 5,
#       xlab = expression(gamma), ylab = "Density",
#       main = "Prior on log-population size \n Gamma")
# for(i in 2:length(X)){
#   curve(dnorm(x, mean = 0, sd = 1/sqrt(X2[i]) ), -5, 5, add = TRUE)
# }
# # Y2 <- rnorm(1e6, 0, sd = 1/sqrt(X2))
# # hist(Y2)
# 
# curve(dgumbel2(x, a = ap, b = bp), 0, 10,
#       cex.axis = 1.0, cex.names = 1.5, cex.lab = 1.5,
#       xlab = expression(tau), ylab = "Density", lwd = 2, lty = 2)
# curve(dgamma(x, shape = 0.001, scale = 1000), lwd = 2,  add = TRUE)
# legend(x = "topright", legend = c("Gumbel type II", "Gamma"),
#        bty = "n", cex = 1, lwd = 2, lty = 2:1)
