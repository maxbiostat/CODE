require(spdep)
bh <- readShapePoly(system.file("etc/shapes/bhicv.shp",package="spdep")[1])
dpad <- data.frame(scale(bh@data[,5:8]))
bh.nb <- poly2nb(bh)
lcosts <- nbcosts(bh.nb, dpad)
nb.w <- nb2listw(bh.nb, lcosts, style="B")
mst.bh <- mstree(nb.w,5)
res1 <- skater(mst.bh[,1:2], dpad, 4)
res2 <- skater(mst.bh[,1:2], dpad, 4, 200000, bh@data$Pop)
table(res1$groups)
table(res2$groups)
######################################################################################################
#Criando uma metrica para comparar duas SKATERs

#passo 1 - construir, a partir dos grupos, a matriz de gruparidade de uma skater
group.mat<-function(s){
  g<-s$groups;n<-length(g)
  M<-matrix(NA,ncol=n,nrow=n)
  for (i in 1:n){
    for(j in 1:n){
      M[i,j]<-ifelse(g[i]==g[j],0,1)
    }
  }
  return(M)
}
##passo 1.1 - podemos agora comparar duas skaters de forma ingenua (naive), isto é, sem levar em conta a espacialidade (distancia) das diferenças
sk.diff<-function(s1,s2){
  M.M<-abs(group.mat(s1)-group.mat(s2))
  n<-length(s1$groups)
  S<-(sum(M.M))/(n^2)
  return(1-S)}
sk.diff(res1,res2)
#passo 2 - obter a matriz de distancias
W<-nb2mat(bh.nb,style='W')#;W<-W/98
#passo 3 - modificar a sk.diff para acomodar W
skater.diff<-function(s1,s2,W){
  M.M<-abs(group.mat(s1)-group.mat(s2))*W
  n<-length(s1$groups)
  S<-(sum(M.M))/(n^2)*sum(W)
  return(1-S)}
skater.diff(res1,res2,W)
######################################################################################
#testando a consistencia
inv<-function (M) ifelse(M==1,0,1)
sk.diff.mod<-function(s1,s2,W){
  M.M<-abs(group.mat(s1)-inv(group.mat(s1)))
  n<-length(s1$groups)
  S<-(sum(M.M))/(n^2)
  return(1-S)}
sk.diff.mod(res1,res2,W)
#
skater.diff.mod<-function(s1,s2,W){
  M.M<-abs(group.mat(s1)-inv(group.mat(s1)))*W
  n<-length(s1$groups)
  S<-(sum(M.M))/(n^2)*sum(W)
  return(1-S)}
skater.diff.mod(res1,res2,W)
######################################################################################
#estudando uma nova metrica
compg<-data.frame()
nk<-seq(1,98,1)
for (k in nk){
  ska<- skater(mst.bh[,1:2], dpad, k-1)#
  S<-(98^2 -sum(group.mat(ska)))/98^2
  compg[match(k,nk),1]<-k
  compg[match(k,nk),2]<-S
  }
plot(compg,type="b",pch=19)
B<-nb2mat(bh.nb,style='B')
skater.diff.cont<-function(s1,s2,B){
  M.M<-abs(group.mat(s1)-group.mat(s2))
  corresp<-ifelse(M.M==B & M.M==1,1,0)
  n<-length(s1$groups)
  S<-(sum(corresp))/(sum(B))
  return(1-S)}
resa <- skater(mst.bh[,1:2], dpad, 0)
resb <- skater(mst.bh[,1:2], dpad, 1)
skater.diff.cont(resa,resb,B)
##########################################################################
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@####
compk.cont<-data.frame()
nk<-seq(1,98,1)
for (k in nk){
     resa <- skater(mst.bh[,1:2], dpad, 0)
     resb <- skater(mst.bh[,1:2], dpad, k-1)#,200000, bh@data$Pop)
     compk.cont[match(k,nk),1]<-k
     compk.cont[match(k,nk),2]<-skater.diff.cont(resa,resb,B)
}
plot(compk.cont[,1],compk.cont[,2],type="b",col=2,xlab="numero de particoes",ylab="Dissimilaridade",main="Contiguidade");windows()
names(compk.cont)<-c("k","p")
library(nls2)
nls2(p~l*exp(-l*k),data=compk.cont,start=c(c=0.88,l=0.028))
plot(compk.cont[,1],compk.cont[,2],type="b",col=2,xlab="numero de particoes",ylab="Dissimilaridade",main="Contiguidade")
lines(0.88277*exp(-0.02875*1:98))#;windows()
##########################################################################
##########################################################################
#avaliando o impacto do tamanho de popmin
#essa etapa consome tempo!
comp<-data.frame()
sP<-seq(1000,1000000,10000)
for (p in sP){
  resa <- skater(mst.bh[,1:2], dpad, 4)
  resb <- skater(mst.bh[,1:2], dpad, 4, p, bh@data$Pop)
  comp[match(p,sP),1]<-p
  comp[match(p,sP),2]<-skater.diff(resa,resb,W)
  comp[match(p,sP),3]<-sk.diff(resa,resb)
}
plot(comp[,1],comp[,2],type="b",col=2,xlab="População",ylab="Dissimilaridade")#;windows()
plot(comp[,1],comp[,3],type="b",col=3,xlab="População",ylab="Dissimilaridade")#;windows()
plot(comp[,2],comp[,3],col="blue",ylab="Não-Regularizado",xlab="Regularizado")#;windows()
##########################################################################
 compk<-data.frame()
nk<-seq(1,98,1)
for (k in nk){
  resa <- skater(mst.bh[,1:2], dpad, 1)
  resb <- skater(mst.bh[,1:2], dpad, k-1)#,200000, bh@data$Pop)
  compk[match(k,nk),1]<-k
  compk[match(k,nk),2]<-skater.diff(resa,resb,W)
  compk[match(k,nk),3]<-sk.diff(resa,resb)
}
plot(compk[,1],compk[,2],type="b",col=2,xlab="numero de parti??es",ylab="Dissimilaridade");windows()
plot(compk[,1],compk[,3],type="b",col=3,xlab="numero de parti??es",ylab="Dissimilaridade");windows()
plot(compk[,2],compk[,3],col="blue",ylab="Não-Regularizado",xlab="Regularizado")
