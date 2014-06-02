require(spdep)
bh <- readShapePoly(system.file("etc/shapes/bhicv.shp",package="spdep")[1])
dpad <- data.frame(scale(bh@data[,5:8]))
bh.nb <- poly2nb(bh)
lcosts <- nbcosts(bh.nb, dpad)
nb.w <- nb2listw(bh.nb, lcosts, style="B")
mst.bh <- mstree(nb.w,5)
par(mar=c(0,0,0,0))
plot(mst.bh, coordinates(bh), col=2, cex.lab=.7, cex.circles=0.035, fg="blue")
plot(bh, border=gray(.5), add=TRUE)
res1 <- skater(mst.bh[,1:2], dpad, 2)
res2 <- skater(mst.bh[,1:2], dpad, 2, 200000, bh@data$Pop)
res3 <- skater(mst.bh[,1:2], dpad, 2, 3, rep(1,nrow(bh@data)))
table(res1$groups)
table(res2$groups)
table(res3$groups)
par(mar=c(0,0,0,0))
plot(res1, coordinates(bh), cex.circles=0.035, cex.lab=.7)
res1b <- skater(res1, dpad, 1)
table(res1$groups)
table(res1b$groups)
plot(res1b, coordinates(bh), cex.circles=0.035, cex.lab=.7,groups.colors=colors()[(1:length(res1b$ed))*10])
plot(bh, col=heat.colors(4)[res1b$groups])
title("SKATER")
dev.off()
######################################################################################################
compute.time<-function(nb,N){
COMP<-data.frame(matrix(NA,ncol=2,nrow=N));names(COMP)<-c("Mean","CV")
for (n in 1:N){
sis.ini<-data.frame()
for (i in 1:98){
sis.ini[i,1]<-i
sis.ini[i,2]<-system.time(mstree(nb.w,i))[3]
}
COMP[n,1]<-mean(sis.ini[,2])
COMP[n,2]<-sd(sis.ini[,2])/mean(sis.ini[,2])
}
return(COMP)
}

TIME<-compute.time(nb.w,500)
summary(TIME)
quantile(TIME$Mean,prob=c(.05,.95))
quantile(TIME$CV,prob=c(.05,.95))
