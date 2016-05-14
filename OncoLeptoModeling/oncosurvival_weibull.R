### This script produces the survival analysis presented in Vasconcellos et al. (2014)
### We estimate survival curves for four experimental groups using a Weibull regression model
### The objective is to estimates the curves and test for differences in survival among 
### infected and uninfected adult Oncopeltus males and females 
## Copyleft (or the one to blame): Carvalho, LMF (2014)
## last updated: 09/11/2014
library(survival);library(ggplot2)
source("weibull-reg_aux.R")
survdata <- data.frame(read.csv("data/oncosurv_full.csv", header = TRUE))

survdata.none <- subset(survdata, STRESS == "none")
survdata.none <- survdata.none[order(survdata.none$GROUP), ]
OSurv <- Surv(survdata.none$TIME)
Osurvfit.none <- survfit(OSurv~GROUP, data = survdata.none)
mWei.none <- survreg(OSurv ~ as.factor(GROUP), dist = 'weibull', data = survdata.none)
Times <- 1:100
bands.none <- conf.band.weibull(mWei.none, .05, Times)
bigdt.surv.none <- data.frame(day = rep(Times, 4), rbind(bands.none[[1]], bands.none[[2]],
                                                         bands.none[[3]], bands.none[[4]]),
                  Group = factor(c(rep("Infected females", length(Times)),
                                 rep("Infected males", length(Times)),
                                 rep("Uninfected females", length(Times)),
                                 rep("Uninfected males", length(Times)))
                    ))
###########################
survdata.food <- subset(survdata, STRESS == "food")
survdata.food <- survdata.food[order(survdata.food$GROUP), ]
OSurv <- Surv(survdata.food$TIME)
Osurvfit.food <- survfit(OSurv~GROUP, data = survdata.food)
mWei.food <- survreg(OSurv ~ as.factor(GROUP), dist = 'weibull', data = survdata.food)
bands.food <- conf.band.weibull(mWei.food, .05, Times)
bigdt.surv.food <- data.frame(day = rep(Times, 4), rbind(bands.food[[1]], bands.food[[2]],
                                                         bands.food[[3]], bands.food[[4]]),
                              Group = factor(c(rep("Infected females", length(Times)),
                                               rep("Infected males", length(Times)),
                                               rep("Uninfected females", length(Times)),
                                               rep("Uninfected males", length(Times)))
                              ))
###########################
survdata.water <- subset(survdata, STRESS == "water")
survdata.water <- survdata.water[order(survdata.water$GROUP), ]
OSurv <- Surv(survdata.water$TIME)
Osurvfit.water <- survfit(OSurv~GROUP, data = survdata.water)
mWei.water <- survreg(OSurv ~ as.factor(GROUP), dist = 'weibull', data = survdata.water)
bands.water <- conf.band.weibull(mWei.water, .05, Times)
bigdt.surv.water <- data.frame(day = rep(Times, 4), rbind(bands.water[[1]], bands.water[[2]],
                                                          bands.water[[3]], bands.water[[4]]),
                               Group = factor(c(rep("Infected females", length(Times)),
                                                rep("Infected males", length(Times)),
                                                rep("Uninfected females", length(Times)),
                                                rep("Uninfected males", length(Times)))
                               ))

###########################
###########################
###########################
gg_color_hue <- function(n) {
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}
Cols <- gg_color_hue(4)
###########################
Xs.none <- unlist(lapply(bands.none, function(dt) which.min(abs(dt$Mean-.50))))
tiff("figs/survival_no_stress.tiff", width = 20, height = 10, units = "cm", res = 500)
ggplot(bigdt.surv.none, aes(x = day, y = Mean)) +
  ggtitle("Insect survival - normal conditions") + 
  geom_ribbon(aes(ymin = Lwr, ymax = Upr, fill = Group), alpha = .2) +
  ##
  geom_segment(aes(x = 0, xend = Xs.none[1], y = .5, yend = .5), color = Cols[1], linetype = "dashed") +
  geom_segment(aes(x = Xs.none[1], xend = Xs.none[1], y = 0, yend = .5), color = Cols[1], linetype = "dashed") +
  geom_segment(aes(x = 0, xend = Xs.none[2], y = .5, yend = .5), color = Cols[2], linetype = "dashed") +
  geom_segment(aes(x = Xs.none[2], xend = Xs.none[2], y = 0, yend = .5), color = Cols[2], linetype = "dashed") +
  geom_segment(aes(x = 0, xend = Xs.none[3], y = .5, yend = .5), color = Cols[3], linetype = "dashed") +
  geom_segment(aes(x = Xs.none[3], xend = Xs.none[3], y = 0, yend = .5), color = Cols[3], linetype = "dashed") +
  geom_segment(aes(x = 0, xend = Xs.none[4], y = .5, yend = .5), color = Cols[4], linetype = "dashed") +
  geom_segment(aes(x = Xs.none[4], xend = Xs.none[4], y = 0, yend = .5), color = Cols[4], linetype = "dashed") +
  ##
  scale_x_continuous("Time (days)", expand = c(0, 0)) +
  scale_y_continuous("Survival proportion", expand = c(0, 0)) +
  guides(fill = FALSE) +
  geom_line(aes(colour = Group), size = 1) + 
  theme_bw() +
  theme(axis.text = element_text(size = 16, face = "bold"),
        plot.title = element_text(size = 18, face = "bold"),
        legend.text = element_text(size = 15),
        axis.title = element_text(size = 18, face = "bold"))
dev.off()
###########################
Xs.food <- unlist(lapply(bands.food, function(dt) which.min(abs(dt$Mean-.50))))
tiff("figs/survival_food_stress.tiff", width = 20, height = 10, units = "cm", res = 500)
ggplot(bigdt.surv.food, aes(x = day, y = Mean)) +
  ggtitle("Insect survival - food deprivation") + 
  geom_ribbon(aes(ymin = Lwr, ymax = Upr, fill = Group), alpha = .2) +
  ##
  geom_segment(aes(x = 0, xend = Xs.food[1], y = .5, yend = .5), color = Cols[1], linetype = "dashed") +
  geom_segment(aes(x = Xs.food[1], xend = Xs.food[1], y = 0, yend = .5), color = Cols[1], linetype = "dashed") +
  geom_segment(aes(x = 0, xend = Xs.food[2], y = .5, yend = .5), color = Cols[2], linetype = "dashed") +
  geom_segment(aes(x = Xs.food[2], xend = Xs.food[2], y = 0, yend = .5), color = Cols[2], linetype = "dashed") +
  geom_segment(aes(x = 0, xend = Xs.food[3], y = .5, yend = .5), color = Cols[3], linetype = "dashed") +
  geom_segment(aes(x = Xs.food[3], xend = Xs.food[3], y = 0, yend = .5), color = Cols[3], linetype = "dashed") +
  geom_segment(aes(x = 0, xend = Xs.food[4], y = .5, yend = .5), color = Cols[4], linetype = "dashed") +
  geom_segment(aes(x = Xs.food[4], xend = Xs.food[4], y = 0, yend = .5), color = Cols[4], linetype = "dashed") +
  ##
  scale_x_continuous("Time (days)", expand = c(0, 0), limits =  c(0, 50)) +
  scale_y_continuous("Survival proportion", expand = c(0, 0)) +
  guides(fill = FALSE) +
  geom_line(aes(colour = Group), size = 1) + 
  theme_bw() +
  theme(axis.text = element_text(size = 16, face = "bold"),
        plot.title = element_text(size = 18, face = "bold"),
        legend.text = element_text(size = 15),
        axis.title = element_text(size = 18, face = "bold"))
dev.off()
###########################
# Xs.water <- unlist(lapply(bands.water, function(dt) which.min(abs(dt$Mean-.30))))
tiff("figs/survival_water_stress.tiff", width = 20, height = 10, units = "cm", res = 500)
ggplot(bigdt.surv.water, aes(x = day, y = Mean)) +
  ggtitle("Insect survival - water deprivation") + 
  geom_ribbon(aes(ymin = Lwr, ymax = Upr, fill = Group), alpha = .2) +
  ##
  # geom_segment(aes(x = 0, xend = Xs.water[1], y = .3, yend = .3), color = Cols[1], linetype = "dashed") +
  # geom_segment(aes(x = Xs.water[1], xend = Xs.water[1], y = 0, yend = .3), color = Cols[1], linetype = "dashed") +
  # geom_segment(aes(x = 0, xend = Xs.water[2], y = .3, yend = .3), color = Cols[2], linetype = "dashed") +
  # geom_segment(aes(x = Xs.water[2], xend = Xs.water[2], y = 0, yend = .3), color = Cols[2], linetype = "dashed") +
  # geom_segment(aes(x = 0, xend = Xs.water[3], y = .3, yend = .3), color = Cols[3], linetype = "dashed") +
  # geom_segment(aes(x = Xs.water[3], xend = Xs.water[3], y = 0, yend = .3), color = Cols[3], linetype = "dashed") +
  # geom_segment(aes(x = 0, xend = Xs.water[4], y = .3, yend = .3), color = Cols[4], linetype = "dashed") +
  # geom_segment(aes(x = Xs.water[4], xend = Xs.water[4], y = 0, yend = .3), color = Cols[4], linetype = "dashed") +
  ##
  scale_x_continuous("Time (days)", expand = c(0, 0), limits =  c(0, 15)) +
  scale_y_continuous("Survival proportion", expand = c(0, 0)) +
  guides(fill = FALSE) +
  geom_line(aes(colour = Group), size = 1) + 
  theme_bw() +
  theme(axis.text = element_text(size = 16, face = "bold"),
        plot.title = element_text(size = 18, face = "bold"),
        legend.text = element_text(size = 15),
        axis.title = element_text(size = 18, face = "bold"))
dev.off()