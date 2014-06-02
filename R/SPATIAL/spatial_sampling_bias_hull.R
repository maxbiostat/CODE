library(cluster);library(edesign)
#####################################
sh.ent<- function(p)
{
  if (min(p) < 0 || sum(p) <= 0)
    return(NA)
  p.norm <- p[p>0]/sum(p)
  -sum(log2(p.norm)*p.norm)
}
#####################################
X<-seq(0,1,0.002)
x<-sample(X,10,replace=T)
y<-sample(X,10,replace=T)
z<-sample(X,10,replace=T)
##################
s<-data.frame(x,y,z)
hull.s<-ellipsoidhull(as.matrix(s),tol=.01,maxit=50000)
v.s<-volume(hull.s)
ent<-sh.ent(x)+sh.ent(y)+sh.ent(z)
r.ent<-.25*sh.ent(x)+.25*sh.ent(y)+.5*sh.ent(z)
############################
entro.simu<-function(X,Y,Z,p,nsim){
P<-min(c(length(X),length(Y),length(Z)))*p
X<-X/max(X);Y<-Y/max(Y);Z<-max(Z)
E<-data.frame(matrix(NA,ncol=3,nrow=nsim));names(E)<-c("E(X)","rE(X)","V")
for (n in 1:nsim){
x<-sample(X,P,replace=T)
y<-sample(X,P,replace=T)
z<-sample(X,P,replace=T)
E[n,1]<-sh.ent(x)+sh.ent(y)+sh.ent(z)
E[n,2]<-.25*sh.ent(x)+.25*sh.ent(y)+.5*sh.ent(z)
E[n,3]<-volume(ellipsoidhull(as.matrix(data.frame(x,y,z)),tol=.01,maxit=50000))
}
return(E)
}
EE<-entro.simu(X=X,Y=X,Z=X,p=.2,nsim=1000)
plot(EE)
#################
ees<-list()
for (p in seq(.2,.9,0.01)){
ees[[match(p,seq(.2,.9,0.01))]]<-entro.simu(X=X,Y=X,Z=X,p=p,nsim=1000)$V
}
####
eeE<-list()
for (p in seq(.2,.9,0.01)){
eeE[[match(p,seq(.2,.9,0.01))]]<-entro.simu(X=X,Y=X,Z=X,p=p,nsim=1000)[,1]
}
#################################
plot(seq(.2,.9,0.01),lapply(ees,mean),type="l",ylim=c(.55,.85),lwd=2,xlab=expression(rho[sample]),ylab="Volume of the Hull")
lines(seq(.2,.9,0.01),lapply(ees,function(x) quantile(x,prob=.25)),lwd=2,lty=2)
lines(seq(.2,.9,0.01),lapply(ees,function(x) quantile(x,prob=.75)),lwd=2,lty=2)
legend(x="bottomright",legend=c("Median","Quartiles"),lty=c(1,2),lwd=2);windows()

plot(seq(.2,.9,0.01),lapply(eeE,mean),type="l",lwd=2,xlab=expression(rho[sample]),ylab="Entropy")
lines(seq(.2,.9,0.01),lapply(eeE,function(x) quantile(x,prob=.25)),lwd=2,lty=2)
lines(seq(.2,.9,0.01),lapply(eeE,function(x) quantile(x,prob=.75)),lwd=2,lty=2)
legend(x="bottomright",legend=c("Median","Quartiles"),lty=c(1,2),lwd=2);windows()
###

plot(lapply(ees,mean),lapply(eeE,mean),pch=16,xlab="Volume",ylab="Entropy")
points(lapply(ees,function(x) quantile(x,prob=.25)),lapply(eeE,function(x) quantile(x,prob=.25)),pch=16,col=2)
points(lapply(ees,function(x) quantile(x,prob=.75)),lapply(eeE,function(x) quantile(x,prob=.75)),pch=16,col=3)
legend(x="bottomright",legend=c("Mean","1Q","3Q"),pch=rep(16,3),col=c(1,2,3))

