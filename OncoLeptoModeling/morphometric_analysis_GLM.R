### This script gives part of the morphometric analyses in Vasconcellos et al. (2014).
### First we use principal components analysis (PCA) to obtain orthogonal factors from the morphometric data.
### These factors represent indenpendent morphologic dimensions and we identified the first to be connected with overall size.
### We then use the first component as a predictor for infectious status, while controling for gender (sex) differences.
### This last step is carried out using a binary generalised linear model (GLM) with a logit link function.  
## Copyleft (or the one to blame): Carvalho, LMF (2014).
## last updated: 09/11/2014
library(FactoMineR); library(arm);library(ggplot2)
dataA <- data.frame(read.table("data/plasticity.txt", header = TRUE))
dataN <- data.frame(read.table("data/nymph_plasticity.txt", header = TRUE))
#
dataA$STATUS <- factor(dataA$STATUS)
dataN$STATUS <- factor(dataN$STATUS)

dataA$G <- factor(dataA$G)
dataN$G <- factor(dataN$G)

dataA.na <- na.omit(dataA)
dataN.na <- na.omit(dataN)
#
alpha <- .025
Z <- qnorm(alpha)

ppA <- PCA(dataA.na, quali.sup = 12:13, graph = FALSE)
ppN <- PCA(dataN.na, ncp = 11,quali.sup = 8:10, graph = FALSE)

dtA <- data.frame(ppA$ind$coord, dataA.na[, 12:13])
dtN <- data.frame(ppN$ind$coord,dataN.na[, 8:10])

mA <- bayesglm(STATUS ~ Dim.1 * G, data = dtA, family = "binomial", prior.scale = 1000, prior.df = 7)
pA <- predict(mA, se.fit = TRUE, type = "response")

pAdt <- data.frame(p = pA$fit,
                   lwr = pA$fit-Z*pA$se.fit,
                   upr = pA$fit+Z*pA$se.fit,
                   sex = factor(dataA.na$G, labels = c("Males", "Females")),
                   Size = ppA$ind$coord[, 1])

mN <- bayesglm(STATUS~Dim.1*G, data = dtN, family = "binomial", prior.scale = 1000, prior.df = Inf)
pN <- predict(mN,se.fit = TRUE, type = "response")
pNdt <- data.frame(p = pN$fit,
                   lwr = pN$fit-Z*pN$se.fit,
                   upr = pN$fit+Z*pN$se.fit,
                   sex = factor(dataN.na$G,labels = c("Males","Females")),
                   Size = ppN$ind$coord[, 1])
# Plotting
pdf(file = "figs/morphometry_GLM.pdf")
ggplot(pAdt, aes(x = Size, y = p)) +
  ggtitle("Infection status versus Size") + 
  geom_ribbon(aes(ymin = lwr, ymax = upr, fill = sex), alpha = .2) +
  scale_x_continuous("(transformed) Insect Size", expand = c(0, 0)) +
  scale_y_continuous("Proportion of infected insects", expand = c(0, 0)) + # proportion
  guides(fill = FALSE) + 
  theme_bw() +
  theme(axis.text = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 18, face = "bold"),
        legend.text = element_text(size = 13),
        axis.title = element_text(size = 16, face = "bold")) +
  labs(fill = "sex")+
  geom_line(aes(colour = sex), size = 1)
dev.off()
###
pdf(file = "figs/morphometry_GLM_nymphs.pdf")
ggplot(pNdt, aes(x = Size, y = p)) +
  ggtitle("Infection status versus Size -- Nymphs") + 
  geom_ribbon(aes(ymin = lwr, ymax = upr, fill = sex), alpha = .2) +
  scale_x_continuous("(transformed) Insect Size", expand = c(0, 0)) +
  scale_y_continuous("Proportion of infected insects", expand = c(0, 0)) + # proportion
  guides(fill = FALSE) + 
  theme_bw() +
  theme(axis.text = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 18, face = "bold"),
        legend.text = element_text(size = 13),
        axis.title = element_text(size = 16, face = "bold")) +
  labs(fill = "sex")+
  geom_line(aes(colour = sex), size = 1)
dev.off()