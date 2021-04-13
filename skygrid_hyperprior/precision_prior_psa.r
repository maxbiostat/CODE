alpha_1 <- 0.001
alpha_2 <- 0.002
alpha_5 <- 0.005
alpha_10 <- 0.01
alpha_100 <- 0.1

par(mfrow = c(1, 2))
curve(dgamma(x, shape = alpha_1, scale = 1000), 0, 10, ylim = c(0, .1), main = "Gamma priors",
            cex.axis = 1.2, cex.lab = 1.5, lwd = 2,
      ylab = "Density", xlab = expression(tau))
curve(dgamma(x, shape = alpha_2, scale = 1000), col = 2, lwd = 2, add = TRUE)
curve(dgamma(x, shape = alpha_5, scale = 1000), col = 3, lwd = 2, add = TRUE)
curve(dgamma(x, shape = alpha_10, scale = 1000), col = 4, lwd = 2, add = TRUE)
curve(dgamma(x, shape = alpha_100, scale = 1000), col = 6, lwd = 2, add = TRUE)
legend(x = "topright", legend = c(
  expression(alpha == 0.001),
  expression(alpha == 0.002),
  expression(alpha == 0.005),
  expression(alpha == 0.01),
  expression(alpha == 0.1)),
  col = c(1, 2, 3, 4, 6), bty = "n", cex = 1.1, lwd = 2
)

( S1 <- qgamma(p = .9, shape = alpha_1, scale = 1000) )
( S2 <- qgamma(p = .9, shape = alpha_2, scale = 1000) )
( S5 <- qgamma(p = .9, shape = alpha_5, scale = 1000) )
( S10 <- qgamma(p = .9, shape = alpha_10, scale = 1000) )
( S100 <- qgamma(p = .9, shape = alpha_100, scale = 1000) )
#### Now the Gumbel stuff
devtools::source_url("https://raw.githubusercontent.com/maxbiostat/CODE/e46bc08f73451c5f6115c8ad93661374484d0eeb/R/DISTRIBUTIONS/Gumbel_type2.r")
p <- .1
( b1 <- -log(p)/1 )
( b2 <- -log(p)/2 )
( b5 <- -log(p)/5 )
( b50 <- -log(p)/50 )
( b100 <- -log(p)/100 )

curve(dgumbel2(x, a = 1/2, b = b1), 0, 10, ylim = c(0, .065), main = "Gumbel priors",
      cex.axis = 1.2, cex.lab = 1.5, lwd = 2,
      ylab = "Density", xlab = expression(tau))
curve(dgumbel2(x, a = 1/2, b = b2), col = 2, lwd = 2, add = TRUE)
curve(dgumbel2(x, a = 1/2, b = b5), col = 3, lwd = 2, add = TRUE)
curve(dgumbel2(x, a = 1/2, b = b50), col = 4, lwd = 2, add = TRUE)
curve(dgumbel2(x, a = 1/2, b = b100), col = 6, lwd = 2, add = TRUE)
legend(x = "topright", legend = c(
  expression(S == 1),
  expression(S == 2),
  expression(S == 5),
  expression(S == 50),
  expression(S == 100)),
  col = c(1, 2, 3, 4, 6, 8), bty = "n", cex = 1.1, lwd = 2
)

ratio <- function(x, a, b, alpha, beta){
  exp(dgamma(x, shape = alpha, scale = beta, log = TRUE)- dgumbel2(x, a, b, log = FALSE))
}
ratio <- Vectorize(ratio)
curve(ratio(x, a = 1/2, b = b1, alpha = alpha_1, beta = 1000), 0 , 10)

get_mode <- function(a, b){
  ( (a*b)/(a + 1) )^(1/a)
}
pgumbel2 <- function(q, a, b, log.p = FALSE){
  ans <- -b*q^-a
  if(!log.p) ans <- exp(ans)
  return(ans)
}