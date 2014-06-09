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
#############
## Now let's construct bands using Monte Carlo sampling from the MCMC posterior and
## the Monte Carlo simulation of the priors
#############
N <- 10000 #replicates
Tp <- seq(10, 40)
Tl <- length(Tp)
####
# K
###
reps.K <- data.frame(matrix(NA,N, Tl)); names(reps.K) <- paste("T", Tp, sep = "")
for (t in 1:Tl){
  cat("% complete=", t/Tl*100, "\n")
  for(i in 1:N){
    c <- sample(posterior$c1,1)
    b <- sample(posterior$b1,1)
    a <- sample(posterior$a1,1)
    #
    reps.K[i,t]<-c*exp(-((Tp[t]-a)^2/b))
  }
}
lims.K <- apply(reps.K, 2, function(x) quantile(x, probs = c(.025, .5, .975), na.rm = TRUE))
lwr.K <- lims.K[1, ]
md.K <- lims.K[2, ]
upr.K <- lims.K[3, ]
##
##
reps.K2 <- data.frame(matrix(NA, N, Tl)); names(reps.K2) <- paste("T", Tp, sep = "")
for (t in 1:Tl){
  cat("% complete=", t/Tl*100, "\n")
  for(i in 1:N){
    c2 <- sample(prior$c1, 1)
    b2 <- sample(prior$b1, 1)
    a2 <- sample(prior$a1, 1)
    #
    reps.K2[i, t] <- c2*exp(-((Tp[t]-a2)^2/b2))
  }
}
lims.K2 <- apply(reps.K2, 2, 
                 function(x) quantile(x, probs = c(.025, .5, .975), na.rm = TRUE))
lwr.K2 <- lims.K2[1, ]
md.K2 <- lims.K2[2, ]
upr.K2 <- lims.K2[3, ]
#
K.bands <- data.frame(temp = Tp, lwr = lwr.K, med = md.K, upr = upr.K, lwr2 = lwr.K2,
                      upr2 = upr.K2)
##
library(ggplot2)
 jpeg(filename = "fig_3A.jpeg",
      width = 10, height = 7, units = "cm", pointsize = 18,
      res = 300 ,
      quality = 100)
 par(cex = 1.5)
ggplot(K.bands, aes(x = temp, y = med)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr), fill = "blue",
              colour = "blue", alpha = .2) +
  geom_ribbon(aes(ymin = lwr2, ymax = upr2), fill = "darkblue", 
              colour="darkblue", alpha = .2, linetype = 2) +
  scale_x_continuous("Temperature (°C)") +
  scale_y_continuous("Carrying capacity") +
  geom_line(size = 1) +
  guides(fill = FALSE, colour = FALSE)+
  theme_bw()  
 dev.off()
###################
###################
reps.r <- data.frame(matrix(NA, N, Tl)); names(reps.r) <- paste("T", Tp, sep = "")
for (t in 1:Tl){
  cat("% complete=", t/Tl*100, "\n")
  for(i in 1:N){
    c <- sample(posterior$c2, 1)
    b <- sample(posterior$b2, 1)
    a <- sample(posterior$a2, 1)
    #
    reps.r[i, t] <- c*exp(-((Tp[t]-a)^2/b))
  }
}
lims.r <- apply(reps.r, 2, function(x) quantile(x, probs = c(.025, .5, .975), na.rm = TRUE))
lwr.r <- lims.r[1, ]
md.r <- lims.r[2, ]
upr.r <- lims.r[3, ]
####
reps.r2 <- data.frame(matrix(NA, N, Tl)); names(reps.r2) <- paste("T", Tp, sep = "")
for (t in 1:Tl){
  cat("% complete=",t/Tl*100,"\n")
  for(i in 1:N){
    c2 <- sample(prior$c2, 1)
    b2 <- sample(prior$b2, 1)
    a2 <- sample(prior$a2, 1)
    #
    reps.r2[i, t] <- c2*exp(-((Tp[t]-a2)^2/b2))
  }
}
lims.r2 <- apply(reps.r2, 2, function(x) quantile(x, probs = c(.025, .5, .975), na.rm = TRUE))
lwr.r2 <- lims.r2[1, ]
md.r2 <- lims.r2[2, ]
upr.r2 <- lims.r2[3, ]
#
r.bands <- data.frame(temp = Tp, lwr = lwr.r, med = md.r, upr = upr.r,
                    lwr2 = lwr.r2, upr2 = upr.r2)
##
 jpeg(filename = "fig_3B.jpeg",
      width = 10, height = 7, units = "cm", pointsize = 18,
      res = 300,
      quality = 100)
 par(cex = 1.5)
ggplot(r.bands, aes(x = temp, y = med)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr), fill = "red", colour = "red", alpha = .2) +
  geom_ribbon(aes(ymin = lwr2, ymax = upr2), fill = "darkred",
              colour = "darkred", alpha = .2, linetype = 2) +
  scale_x_continuous("Temperature (°C)") +
  scale_y_continuous("Growth rate") +
  geom_line(size = 1) +
  guides(fill = FALSE, colour = FALSE)+
  theme_bw()
dev.off()
