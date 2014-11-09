### This script is an auxiliary file to the survival analysis in 'oncosurvival_weibull.R'
## Copyleft (or the one to blame): Carvalho, LMF (2014)
## last updated: 09/11/2014
conf.int.beta <- function(beta, se, alpha){
  ## alpha*100% confidence interval for beta given a se
  lwr <- beta-abs(qnorm(alpha/2))*se
  mean <- beta
  upr <- beta+abs(qnorm(1-alpha/2))*se
  return(c(lwr, mean, upr))}
######################
conf.band.weibull <- function(model, alpha, times,...){# for a model with a factor as covariate only
  pred <- predict(model, type = "linear", se.fit = TRUE)
  betas <- unique(pred$fit)
  ses <- unique(pred$se.fit)
  p <- length(ses)
  out <- vector(p, mode = "list")
  for(i in 1:p){
    beta.conf <- conf.int.beta(betas[i], ses[i], alpha)
    bands <- data.frame(matrix(NA, length(times), 3))
    names(bands)<- c("Lwr", "Mean", "Upr")
    for(t in times){
      bands[t, 1] <- exp(-(t/exp(beta.conf[1]))^1/model$scale)
      bands[t, 2] <- exp(-(t/exp(beta.conf[2]))^1/model$scale)
      bands[t, 3] <- exp(-(t/exp(beta.conf[3]))^1/model$scale)
    }
    out[[i]] <- bands
  }
  return(out)
}