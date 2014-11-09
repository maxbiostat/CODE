library(FactoMineR); library(arm);library(ggplot2)
dataA <- data.frame(read.table("data/plasticity.txt", header = TRUE))
dataA$STATUS <- factor(dataA$STATUS)
dataA$G <- factor(dataA$G)
dataA.na <- na.omit(dataA)
ppA <- PCA(dataA.na, quali.sup = 12:13, graph=F)
dtA <- data.frame(ppA$ind$coord, dataA.na[,12:13])
mA <- bayesglm(STATUS ~ Dim.1 * G, data = dtA, family = "binomial", prior.scale = 1000, prior.df = 7)
pA <- predict(mA, se.fit = TRUE, type="response")
alpha <- .025
Z <- qnorm(alpha)
pAdt <- data.frame(p = pA$fit,
                   lwr = pA$fit-Z*pA$se.fit,
                   upr = pA$fit+Z*pA$se.fit,
                   sex = factor(dataA.na$G, labels = c("Males","Females")),
                   Size = ppA$ind$coord[, 1])
# Plotting
pdf(file = "figs/morphometry_GLM.pdf")
ggplot(pAdt, aes(x = Size, y = p)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr, fill = sex), alpha = .2)+
  scale_x_continuous("Insect Size") +
  scale_y_continuous("Probability of being infected") + # proportion
  guides(fill=FALSE)+
  labs(fill="sex")+
  geom_line(aes(colour = sex), size = 1)
dev.off()