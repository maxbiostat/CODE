library(ggplot2)
betaconf<-function(alpha, x, n, a=1, b=1, CP="FALSE"){
  if(CP=="TRUE"){  
    lower <- 1 - qbeta(1-(alpha/2), n + x - 1, x)
    upper <- 1 - qbeta(alpha/2, n - x, x + 1)
  }else{
    lower <- qbeta(alpha/2, a + x, b + n - x)
    upper <- qbeta(1-(alpha/2), a + x, b + n - x)  
  } 
  return(c(lower, upper))
  #CP stands for Clopper-Pearson
  #Default is 'Bayesian' with an uniform prior over p (a=b=1)
}
# The data
outE <- cbind(c(91, 29),c(95, 14))# Eclosion
colnames(outE) <-c("Infected", "Uninfected")
rownames(outE) <-c("Ecloded", "Non-ecloded")
print(outE)
#
outR <- cbind(c(38, 618), c(3, 588)) # Reabsorption
colnames(outR) <- c("Infected", "Uninfected")
rownames(outR) <- c("Reabsorbed", "Vitelogenic")
print(outR)

## Calculating proportions and CIs
a <- b <- 1 # to ease future changes to informative priors
rhoI <- round(outE[1,1]/(outE[1, 1] + outE[2, 1]), 2)
rhoU <- round(outE[1,2]/(outE[1, 2] + outE[2, 2]), 2)
confI <- round(betaconf(.05,outE[1, 1], outE[1, 1] + outE[2, 1]), 2)
confU <- round(betaconf(.05,outE[1, 2], outE[1, 1] + outE[2, 2]), 2)
(c(rhoI, confI))
(c(rhoU, confU))

rho.rI <- round(outR[1,1]/(outR[1, 1] + outR[2, 1]), 2)
rho.rU <- round(outR[1,2]/(outR[1, 2] + outR[2, 2]), 2)
confrI <- round(betaconf(.05,outR[1, 1], outR[1, 1] + outR[2, 1]), 2)
confrU <- round(betaconf(.05,outR[1, 2], outR[1, 2] + outR[2, 2]), 2)
(c(rho.rI, confrI))
(c(rho.rU, confrU))

## Plotting 
xE <- seq(.5, 1, length.out = 100)
yEU <- dbeta(xE, outE[1, 2] + a, b + outE[2, 2])
yEI <- dbeta(xE, outE[1, 1] + a, b + outE[2, 1])
plotdtE <- data.frame(Ex = rep(xE, 2), Ey = c(yEU, yEI),
                     Infectious_status = c(rep("Uninfected", 100), rep("Infected", 100)))

xR <- seq(0, .15, length.out = 100)
yRU <- dbeta(xR, outR[1, 2] + a, b + outR[2, 2])
yRI <- dbeta(xR, outR[1, 1] + a, b + outR[2, 1])
plotdtR <- data.frame(Rx = rep(xR, 2), Ry = c(yRU, yRI),
                     Infectious_status = c(rep("Uninfected", 100), rep("Infected", 100)) )

pdf(file = "figs/eclosion.pdf")
ggplot(plotdtE, aes(x = Ex, y = Ey)) +
  scale_x_continuous("Proportion ecloded") +
  scale_y_continuous("Density") +
  guides(fill=FALSE)+
  geom_line(aes(colour = Infectious_status), size = 1)+
  labs(fill="Infectious status")
dev.off()

pdf(file = "figs/reabsorption.pdf")
ggplot(plotdtR, aes(x = Rx, y = Ry)) +
  scale_x_continuous("Proportion reabsorbed") +
  scale_y_continuous("Density") +
  guides(fill=FALSE)+
  geom_line(aes(colour = Infectious_status), size = 1)+
  labs(fill="Infectious status")
dev.off()