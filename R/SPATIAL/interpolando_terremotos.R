library(gstat)
data(quakes);data<-data.frame(quakes)#data
dt<-data.frame(quakes)#backup
treino<-data[(data[,1]<=-17 & data[,1]>=-19.0 &data[,2]<=182.0 & data[,2]>=180.0),]
plot(data);windows()
PT<-treino;coordinates(PT)=~long+lat
#variogramas empiricos

g<-lm(log(mag)~stations,data=treino);hist(g$residuals);windows()
res=data.frame(long=treino$long,lat=treino$lat,depth=treino$depth,res=g$residuals);coordinates(res)<-~long+lat

#variogramas empiricos
v.glm<-variogram(res~1,data=res,alpha=90);plot(v.glm,main="GLM");windows()
v.d<-variogram(mag~stations,data=PT,alpha=90);plot(v.d,main="DERIVA");windows()

#modelos de variogramas
m.glm = vgm(nugget=0.0015, "Mat", range=.9,psill=0.0017,alpha=90);m.glm2=fit.variogram(v.glm,m.glm);plot(v.glm,m.glm2);windows()
md = vgm(nugget=0.03, "Mat", range=.9,psill=.037,alpha=90);md2=fit.variogram(v.d,md);plot(v.d,md2)

#spatial prediction
grid<-data.frame(long=dt$long,lat=dt$lat,depth=dt$depth);coordinates(grid)<-~long+lat
p<-exp(predict(g,newdata=dt))
k.glm <-krige(res~1, res, grid,model = m.glm2)
k.deriva<-krige(mag~1, PT, grid,model = md2)

##VALIDAÇÃO CRUZADA
COMPCV=data.frame(dt[,c(1:2,4)],KG=p,KGR=p+k.glm$var1.pred,KD=k.deriva$var1.pred)
summary(COMPCV)
ks.test(COMPCV$KGR,COMPCV$mag)
ks.test(COMPCV$KGD,COMPCV$mag)
boxplot(COMPCV[,3:6])
