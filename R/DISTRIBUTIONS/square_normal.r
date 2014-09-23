dsqnorm <- function(x, mu = 0, sd = 1) {
  exp(-(x-2*abs(mu)*sqrt(x))/(2*sd^2))/(2*sqrt(2*pi*x)*sd*exp(mu^2/(2*sd^2)))
}
Te <- 132
mu1 <- 25
mu2 <- Te-mu1
sd <- 5
X <- rnorm(10000, m = mu2, s = sd)
hist(X)
hist(X^2, prob = TRUE, main = expression(Y == X^2), xlab = "Y")
domain <- seq(range(X^2)[1], range(X^2)[2], .1)
lines(domain, dsqnorm(x = domain, mu = mu2, sd = sd), lwd = 3)
integrate(dsqnorm, mu = mu2, sd = sd, 0, Inf)