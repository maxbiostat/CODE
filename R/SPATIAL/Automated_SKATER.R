#loading
require(spdep)
bh <- readShapePoly(system.file("etc/shapes/bhicv.shp",package="spdep")[1])
dpad <- data.frame(scale(bh@data[,5:8]))
bh.nb <- poly2nb(bh)
############################################################
############################################################
#explorando os custos e o efeito sobre a MST.
boxplot(dpad);windows()
dpad2 <- data.frame(scale(bh@data[,5:6]))
lcosts <- nbcosts(bh.nb, dpad)
lcosts2 <- nbcosts(bh.nb, dpad2)
nb.w <- nb2listw(bh.nb, lcosts, style="B")
nb.w2 <- nb2listw(bh.nb, lcosts2, style="B")
mst.bh <- mstree(nb.w,5)
mst.bh2 <- mstree(nb.w2,5)
par(mar=c(0,0,0,0))
plot(mst.bh, coordinates(bh), col=2,lwd=1, cex.lab=.7, cex.circles=0.035, fg="blue")
par(new=TRUE);par(mar=c(0,0,0,0))
plot(mst.bh2, coordinates(bh), col=3,lwd=1, cex.lab=.7,lty=2, cex.circles=0.035, fg="blue")
plot(bh, border=gray(.5), add=TRUE);windows()
############################################################
############################################################
res1 <- skater(mst.bh[,1:2], dpad, 2)
res2 <- skater(mst.bh[,1:2], dpad, 2, 200000, bh@data$Pop)
table(res1$groups)
table(res2$groups)
resdiff<-res1;resdiff$groups<-ifelse(res1$groups==res2$groups,1,0)
#par(mar=c(0,0,0,0))
plot(bh, col=heat.colors(4)[res1$groups],main="RES1");windows()
#par(mar=c(0,0,0,0))
plot(bh, col=heat.colors(4)[res2$groups],main="RES2");windows()
#par(mar=c(0,0,0,0))
plot(bh, col=heat.colors(4)[resdiff$groups+1]);Title(";windows()
#plot(resdiff,coordinates(bh), cex.circles=0.035, cex.lab=.7)
###########################################################

