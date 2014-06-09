# Copyleft (or the one to blame): Carvalho, LMF (2014)
# Last updated: 09/06/2014 
posterior <- data.frame(read.table("DATA/posterior_simudata.txt",T))
M <- 10000
prior <- data.frame( # prior distributions for r(T) and K(T) parameters
  a1 = rnorm(M, 25, 5),
  b1 = rgamma(M, 2, 1/10),
  c1 = rgamma(M, 10, 1/100),
  a2 = rnorm(M, 25, 5),
  b2 = rgamma(M, 2, 1/10),
  c2 = rnorm(M, .5, 2)
)
#### Fixed parameter values
a1 <- 30
a2 <- 23
b1 <- 10
b2 <- 15
c1 <- 700
c2 <- .40
############
# Prior vs Posterior plots -- Figure 1
jpeg(filename = "fig_1.jpeg",
     width = 30, height = 40, units = "cm", pointsize = 18,
     quality = 100, res = 500)
par(mfrow = c(3, 2),
    oma =  c(1, 2, 1, 1),
    mar = c(2, 1, 1, 1),
    cex = 1.2)

ha1 <- hist(posterior$a1, plot = FALSE)
ha1$counts <- ha1$counts/sum(ha1$counts)
plot(ha1, col = 2, main = "",
     xlab = expression(a[K]))
lines(seq(20, 35,.1), dnorm(seq(20, 35, .1), 25, 10), col = 3, lwd = 4)
legend(x = 23, y = .35, legend =  expression(a[K]), bty = "n", cex = 1.5)
abline(v = a1, lwd = 4, lty = 2)

ha2 <- hist(posterior$a2, plot = FALSE)
ha2$counts <- ha2$counts/sum(ha2$counts)
plot(ha2, col = 2, main = "", xlab = expression(a[2]))
lines(seq(10, 30, .1), dnorm(seq(10, 30, .1), 20, 10), col = 3, lwd = 4)
legend(x = 20.5, y = .35, legend =  expression(a[r]), bty = "n", cex = 1.5)
abline(v = a2, lwd = 4, lty = 2)

hb1 <- hist(posterior$b1, plot = FALSE)
hb1$counts <- hb1$counts/sum(hb1$counts)
plot(hb1, col = 2, main = "", xlab = expression(b[K]))
lines(seq(1, 165, .1), dgamma(seq(1, 165, .1), 4, 1/5),col = 3,lwd = 4)
legend(x = 2, y = .16, legend =  expression(b[K]), bty = "n", cex = 1.5)
abline(v = b1, lwd = 4, lty = 2)

hb2 <- hist(posterior$b2, plot = FALSE)
hb2$counts <- hb2$counts/sum(hb2$counts)
plot(hb2, col = 2, main = "", xlab = expression(b[r]))
lines(seq(.1, 45, .1), dgamma(seq(.1, 45, .1), 4, 1/5), col = 3, lwd = 4)
legend(x = 5, y = .16, legend =  expression(b[r]), bty = "n", cex = 1.5)
abline(v = b2, lwd = 4, lty = 2)

hc1 <- hist(posterior$c1, plot = FALSE)
hc1$counts <- hc1$counts/sum(hc1$counts)
plot(hc1, col = 2, main = "", xlab = expression(c[1]))
lines(seq(500, 15000, 1), dgamma(seq(500, 15000, 1), 10, 1/100), col = 3,lwd = 4)
legend(x = 2000, y = .3, legend =  expression(c[K]), bty = "n", cex = 1.5)
abline(v = c1, lwd = 4, lty = 2)

hc2 <- hist(posterior$c2, plot = FALSE)
hc2$counts <- hc2$counts/sum(hc2$counts)
plot(hc2, col = 2, main = "", xlab = expression(c[2]))
lines(seq(0, 1, .01), dnorm(seq(0, 1, .01), .5, 2), col = 3, lwd = 4)
legend(x = .02, y = .39, legend =  expression(c[r]), bty = "n", cex = 1.5)
abline(v = c2, lwd = 4, lty = 2)

dev.off()
