### This script gives part of the morphometric analyses in Vasconcellos et al. (2014).
### These are plots of the principal components analysis (PCA) to obtain orthogonal factors from the morphometric data.
### We plot the first two components and mark the individuals in this 2-D plane of morphometric attributes
## Copyleft (or the one to blame): Carvalho, LMF (2014).
## last updated: 09/11/2014
library(FactoMineR)
source("mod.plot.PCA.R")
## Adults
dataA <- data.frame(read.table("data/plasticity.txt", header = TRUE))
dataA$STATUS <- factor(dataA$STATUS)
dataA$G <- factor(dataA$G)
dataA.na <- na.omit(dataA)
AF <- subset(dataA.na, G==1)[-12]
AM <- subset(dataA.na, G==0)[-12]  
###############################
ppAF <- PCA(AF, quali.sup = 12, graph = FALSE)
pdf(file = "figs/PCA_females.pdf")
mod.plot.PCA(ppAF, axes = c(1, 2), choix = "ind", habillage = 12, col.hab = c("green","red"),
         title = "Adult females", label = "none")
legend(x="topleft", col = c("green", "red"), legend = c("Uninfected", "Infected"), pch = 16, bty = "n")
dev.off()
#
ppAM <- PCA(AM, quali.sup = 12, graph = FALSE)
pdf(file = "figs/PCA_males.pdf")
mod.plot.PCA(ppAM,axes = c(1, 2), habillage = 12, col.hab = c("green","red"),
         title = "Adult males", label = "none")
legend(x="topleft", col = c("green", "red"), legend = c("Uninfected", "Infected"), pch = 16, bty = "n")
dev.off()
###############################
# Now the nymphs
dataN<-data.frame(read.table("data/nymph_plasticity.txt", header = TRUE))
dataN$STATUS<-factor(dataN$STATUS)
dataN$G<-factor(dataN$G)
dataN$D<-factor(dataN$D)
dataN.na<-na.omit(dataN)
NF <- subset(dataN.na, G==1)[-8][-8]
NM <- subset(dataN.na, G==0)[-8][-8]
##
ppNF <- PCA(NF,quali.sup = 8, graph = FALSE)
pdf(file = "figs/PCA_female_nymphs.pdf")
mod.plot.PCA(ppNF,axes = c(1, 2), habillage = 8, col.hab = c("green", "red"),
         title = "Female Nymphs", label = "none")
legend(x = "topleft", col = c("green", "red"), legend = c("Uninfected", "Infected"), pch = 16, bty = "n")
dev.off()
#
ppNM <- PCA(NM, quali.sup = 8, graph = FALSE)
pdf(file = "figs/PCA_male_nymphs.pdf")
mod.plot.PCA(ppNM,axes = c(1, 2), habillage = 8, col.hab = c("green", "red"),
         title = "Male nymphs", label = "none")
legend(x = "topleft", col = c("green", "red"), legend = c("Uninfected", "Infected"), pch = 16, bty = "n")
dev.off()