### This script produces the survival analysis presented in Vasconcellos et al. (2014)
### We estimate survival curves for four experimental groups using a Weibull regression model
### The objective is to estimates the curves and test for differences in survival among 
### infected and uninfected adult Oncopeltus males and females 
## Copyleft (or the one to blame): Carvalho, LMF (2014)
## last updated: 09/11/2014
library(survival);library(ggplot2)
source("weibull-reg_aux.R")
survdata <- data.frame(read.table("data/oncosurv.txt", header = TRUE))

OSurv <- Surv(survdata$TIME)
Osurvfit <- survfit(OSurv~GROUP, data = survdata)
mWei <- survreg(OSurv ~ as.factor(GROUP), dist = 'weibull', data = survdata)


Times <- 1:100
bands <- conf.band.weibull(mWei, .05, Times)
bigdt.surv <- data.frame(day = rep(Times, 4), rbind(bands[[1]], bands[[2]], bands[[3]], bands[[4]]),
                  GROUP = factor(c(rep("Uninfected females", length(Times)),
                                 rep("Infected females", length(Times)),
                                 rep("Uninfected males", length(Times)),
                                 rep("Infected males", length(Times)))
                    ))
##
pdf(file = "figs/survival.pdf")
ggplot(bigdt.surv, aes(x = day, y = Mean)) +
  geom_ribbon(aes(ymin = Lwr, ymax = Upr, fill = GROUP), alpha = .2) +
  scale_x_continuous("Time (days)") +
  scale_y_continuous("Survival proportion") +
  guides(fill = FALSE)+
  geom_line(aes(colour = GROUP),size = 1)
dev.off()