require(spdep)
load("M:\\rio_map3.RData")
class(rio@data$CODBAIRRO)<-"num"
class(rio@data$CODBNUM)<-"num"
banco<-data.frame(read.table("M:\\incvet.txt",TRUE))
data_shape<-merge(rio@data,banco,by=c("CODBNUM"))
#################################
data.only<-banco[-20][,3:39]
rio.nb <- poly2nb(rio)
lcosts <- nbcosts(rio.nb, data.only$DEN02)
nb.w <- nb2listw(rio.nb, lcosts, style="B")
mst <- mstree(nb.w,5)
par(mar=c(0,0,0,0))
plot(mst, coordinates(rio), col=2, cex.lab=.7, cex.circles=0.035, fg="blue")
plot(rio, border=gray(.5), add=TRUE)
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
######################################################################################################
#passo 1 - construir, a partir dos grupos, a matriz de adjacencia de uma skater
adj.mat<-function(s){
  g<-s$groups;n<-length(g)
  M<-matrix(NA,ncol=n,nrow=n)
  for (i in 1:n){
    for(j in 1:n){
      M[i,j]<-ifelse(g[i]==g[j],1,0)
    }
  }
return(M)
}
##passo 1.1 - podemos agora comparar duas skaters de forma ingenua (naive), isto é, sem levar em conta a espacialidade (distancia) das diferenças
sk.diff<-function(s1,s2){
M.M<-ifelse(adj.mat(s1)==adj.mat(s2),0,1)  
dg<-sum(diag(M.M))
n<-length(s1$groups)
S<-(sum(M.M)-dg)/(n^2-n)
return(S*100)}
sk.diff(res1,res2)
#passo 2 - obter a matriz de distancias
W<-nb2mat(bh.nb,style='W')
#passo 3 - modificar a sk.diff para acomodar W
skater.diff<-function(s1,s2,W){
  M.M<-ifelse(adj.mat(s1)==adj.mat(s2),0,1)*W  
  dg<-sum(diag(M.M))
  n<-length(s1$groups)
  S<-(sum(M.M)-dg)/(n^2-n)
  return(S*100)}
skater.diff(res1,res2,W)
################################
#avaliando o impacto do tamanho de popmin
#essa etapa consome tempo!
comp<-data.frame()
sP<-seq(100000,1000000,10000)
for (p in sP){
     resa <- skater(mst.bh[,1:2], dpad, 2)
     resb <- skater(mst.bh[,1:2], dpad, 2, p, bh@data$Pop)
     comp[match(p,sP),1]<-p
     comp[match(p,sP),2]<-skater.diff(resa,resb,W)
     comp[match(p,sP),3]<-sk.diff(resa,resb)
}
plot(comp[,1],comp[,2],type="b",col=2,xlab="População",ylab="Dissimilaridade")
plot(comp[,1],comp[,3],type="b",col=3,xlab="População",ylab="Dissimilaridade")
