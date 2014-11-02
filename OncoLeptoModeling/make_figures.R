### This script will produce the figures in Vasconcellos et al. (2014)
### Copyleft (or the one to blame): Carvalho, LMF (2014)
source("oncolepto_params.R")
library(deSolve)
### Our ODE systems 
## No SD
oncolepto <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    dE  <- o*A/2 - pe*e*E # Eggs
    dN1 <- e*E - m1*N1 - d12*N1 # first instar
    dN2 <- d12*N1 - m2*N2 - d23*N2 # second instar
    dN3 <- d23*N2 - m3*N3 - d34*N3 # ...
    dN4 <- d34*N3 - m4*N4 - d45*N4 
    dN5 <- d45*N4 - m5*N5 - d5A*N5
    dA<-d5A*N5 - mA*A # adults
    return(list(c(dE, dN1, dN2, dN3, dN4, dN5, dA)))
  })
}
## Males!=Females ;-) 
oncoleptoSD <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    A <- M + Fe  # adults
    dE <- o*Fe*(M/A) - pe*e*E # Eggs; without mass action
    dN1 <- e*E - m1*N1 - d12*N1 # first instar
    dN2 <- d12*N1 - m2*N2 - d23*N2 # second instar
    dN3 <- d23*N2 - m3*N3 - d34*N3 # ...
    dN4 <- d34*N3 - m4*N4 - d45*N4
    dN5 <- d45*N4 - m5*N5 - pF*d5A*N5 - (1-pF)*d5A*N5 # p turn into females, 1-p in males
    dM <- (1-pF)*d5A*N5 - mM*M
    dFe <- pF*N5 - mF*Fe
    return(list(c(dE, dN1, dN2, dN3, dN4, dN5, dM, dFe)))
  })
}

### Solving them
times <- seq(0, 2*30, by = 1)
  
  
out.ref <- as.data.frame(ode(y = init, times = times,
                             func = oncolepto, parms = parameters))

out.inf <- as.data.frame(ode(y = init, times = times,
                             func = oncolepto, parms = parameters.inf))

out.SD.ref <- as.data.frame(ode(y = initSD, times = times,
                                func = oncoleptoSD, parms = parameters.SD))

out.SD.inf <- as.data.frame(ode(y = initSD, times = times,
                                func = oncoleptoSD, parms = parameters.SD.inf))

out.ref$time <- out.inf$time <- out.SD.ref$time <- out.SD.inf$time <- NULL

# Pop sums
popref <- rowSums(out.ref)
popinf <- rowSums(out.inf)
poprefSD <- rowSums(out.SD.ref)
popinfSD <- rowSums(out.SD.inf)


### Plotting 
pal1 <- c("red", "blue", "green", "black", "darkgreen", "darkmagenta", "dodgerblue2")
pal2 <- c("red", "blue", "green", "black", "darkgreen", "darkmagenta", "dodgerblue2", "goldenrod4")

## WithOUT SD
# Trajectories ratios
tiff("figs/popratios_noSD.tiff", width = 15, height = 10, units = "cm", res = 500)
matplot(times, out.inf/out.ref, type = "l", xlab = "Time (days)", ylab = "Relative population size",
        main = "", lwd = 2, ylim = c(0, 3), lty = 1, cex.axis = 1.5, cex.lab = 1.5,
        bty = "l", col = pal1)
abline(h = 1, lty = 2, lwd = 1)
legend(x = 30, y = 3 , legend = c("Eggs", "Stage_1", "Stage_2", "Stage_3"), 
       lwd = 2, cex = 1, col = pal1[1:3], horiz = FALSE, bty = "n") 
legend(x = 47 , y = 3 , legend = c("Stage_4", "Stage_5", "Adults"),
       lwd = 2, cex = .8, col = pal1[4:7], horiz = FALSE, bty = "n")
dev.off()
# Total population
tiff("figs/totalpop_noSD.tiff", width = 15, height = 10, units = "cm", res = 500)
plot(times, log(popref), col = 3,  lwd = 3, type = "l",
     ylab = "(log)Population size", xlab = "Time (days)", cex.axis = 1.5, cex.lab = 1.5)
lines(times, log(popinf), lwd = 3, col = 2)
legend(x = "topleft", col = c(2, 3), legend = c("Infected", "Uninfected"),
       lwd = 3, bty = "n")
dev.off()

## With SD
# Trajectories ratios
tiff("figs/popratios_SD.tiff", width = 15, height = 10, units = "cm", res = 500)
matplot(times, out.SD.inf/out.SD.ref, type = "l", xlab = "Time (days)", ylab = "Relative population size",
        main = "", lwd = 2, ylim = c(0, 3), lty = 1, cex.axis = 1.5, cex.lab = 1.5,
        bty = "l", col = pal2)
abline(h = 1, lty = 2, lwd = 1)
legend(x = 30, y = 3 , legend = c("Eggs", "Stage_1", "Stage_2", "Stage_3"), 
       lwd = 2, cex = 1, col = pal2[1:3], horiz = FALSE, bty = "n") 
legend(x = 47 , y = 3 , legend = c("Stage_4", "Stage_5", "Males", "Females"),
       lwd = 2, cex = .8, col = pal2[4:8], horiz = FALSE, bty = "n")
dev.off()
# Total population
tiff("figs/totalpop_SD.tiff", width = 15, height = 10, units = "cm", res = 500)
plot(times, log(poprefSD), col = 3,  lwd = 3, type = "l",
     ylab = "(log)Population size", xlab = "Time (days)", cex.axis = 1.5, cex.lab = 1.5)
lines(times, log(popinfSD), lwd = 3, col = 2)
legend(x = "topleft", col = c(2, 3), legend = c("Infected", "Uninfected"),
       lwd = 3, bty = "n")
dev.off()

