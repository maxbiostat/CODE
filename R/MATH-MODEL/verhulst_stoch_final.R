s<-7
n<-500
p<-s/n
#######
s2<-40
n2<- 390
m <-s2/n2  
###Beta distribution for hat(p)
lp <-1-qbeta(.975,(n+s)+1,s)
up <-1-qbeta(.025,n-s,s+1)
conf.p.beta<-c(lp,up);conf.p.beta
B.p<-rbeta(10000,s +1, n-s + 1)
c(quantile(B.p,probs=.025),quantile(B.p,probs=.975))
hist(B.p,main=expression(paste("Beta approximation for"," ",hat(p))),xlab=expression(hat(p)))
####
D.p<-B.p
#Simulation
N<-1000
T<-1000
n0<-1000
K<-10000
v<-function(t,n0,r,K){K/(1+((K-n0)/n0)*exp(-r*t))}
#tt<-1:1000
#P<-v(t=tt,n0=n0,r=p,K=K)
#plot(tt,P,type="l")
#######
plot(1:T,rep(K,T),type="l",lty=2,lwd=3,col=2,ylim=c(0,K+.2*K),xlab="Time",ylab="Population Size")
SIMU<-matrix(NA,ncol=T,nrow=N)
for( s in 1:N){
  SIMU[s,]<-v(t=1:T,n0=n0,r=sample(D.p,1),K=K)
  lines(1:T,SIMU[s,],lwd=1,xlab="Time",ylab="Population Size",main="")
}
###
result<-rep(NA,nrow(SIMU))
for(i in 1:nrow(SIMU)){result[i]<-ifelse(length(which(SIMU[i,]<1))==0,0,1)}
title(paste("Extinction rate=",sum(result)/N))