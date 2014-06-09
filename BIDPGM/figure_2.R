# Copyleft (or the one to blame): Carvalho, LMF (2014)
# Last updated: 09/06/2014 
posterior <- data.frame(read.table("DATA/posterior_real.txt",T))
M <- 10000
prior <- data.frame( # prior distributions for r(T) and K(T) parameters
  a1 = rnorm(M, 25, 10),
  b1 = rgamma(M, 4, 1/5),
  c1 = rgamma(M, 1, 1/1000),
  a2 = rnorm(M, 25, 10),
  b2 = rgamma(M, 4, 1/5),
  c2 = rnorm(M, .5, 2)
  )
############
## Prior vs Posterior plots -- Figure 1
jpeg(filename = "fig_2.jpeg",
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
lines(seq(13, 25, .1),  dnorm(seq(13, 25, .1), 20, 10), col = 3, lwd = 4)
legend(x = 13, y = .29, legend =  expression(a[K]), bty = "n", cex = 1.5)

ha2 <- hist(posterior$a2, plot = FALSE)
ha2$counts <- ha2$counts/sum(ha2$counts)
plot(ha2, col = 2, main = "", xlab = expression(a[2]))
lines(seq(25, 28, .1), dnorm(seq(25, 28, .1), 20, 10), col = 3, lwd = 4)
legend(x = 25, y = .4, legend =  expression(a[r]), bty = "n", cex = 1.5)

hb1 <- hist(posterior$b1, plot = FALSE)
hb1$counts <- hb1$counts/sum(hb1$counts)
plot(hb1, col = 2, main = "", xlab = expression(b[K]))
lines(seq(1, 165, .1), dgamma(seq(1, 165, .1), 4, 1/5),col = 3,lwd = 4)
legend(x = 1, y = .37, legend =  expression(b[K]), bty = "n", cex = 1.5)

hb2 <- hist(posterior$b2, plot = FALSE)
hb2$counts <- hb2$counts/sum(hb2$counts)
plot(hb2, col = 2, main = "", xlab = expression(b[r]))
lines(seq(15, 45, .1), dgamma(seq(15,45,.1), 4, 1/5), col = 3, lwd = 4)
legend(x = 17, y = .25, legend =  expression(b[r]), bty = "n", cex = 1.5)

hc1 <- hist(posterior$c1, plot = FALSE)
hc1$counts <- hc1$counts/sum(hc1$counts)
plot(hc1, col = 2, main = "", xlab = expression(c[1]))
lines(seq(500, 1500, 1), dgamma(seq(500, 1500, 1), 1, 1/1000), col = 3,lwd = 4)
legend(x = 680, y = .4, legend =  expression(c[K]), bty = "n", cex = 1.5)

hc2 <- hist(posterior$c2, plot = FALSE)
hc2$counts <- hc2$counts/sum(hc2$counts)
plot(hc2, col = 2, main = "", xlab = expression(c[2]))
lines(seq(0, 1, .01), dnorm(seq(0, 1, .01), .5, 2), col = 3, lwd = 4)
legend(x = .45, y = .35, legend =  expression(c[r]), bty = "n", cex = 1.5)

dev.off()
