s<-70
n<-500
p<-s/n
conf.p.normal<-c(p-1.96*sqrt((1-p)/n),p+1.96*sqrt((1-p)/n))
N.p<-rnorm(10000,m=p,sd=sqrt((1-p)/n))
hist(N.p,main=expression(paste("Normal approximation for"," ",hat(p))),,xlab=expression(hat(p)))
###Beta distribution for hat(p)
l<-1-qbeta(.975,(n+s)+1,s)
u<-1-qbeta(.025,n-s,s+1)
conf.p.beta<-c(l,u)
conf.p.normal;conf.p.beta
B.p<-rbeta(1000,s + 1/2, n-s + 1/2)
c(quantile(B.p,probs=.025),quantile(B.p,probs=.975))
hist(B.p,main=expression(paste("Beta approximation for"," ",hat(p))),xlab=expression(hat(p)))
####
#Simulation
nsim<-30
T<-1000
n0<-1000
K<-10000
v<-function(t,n0,r,K){K/(1+((K-n0)/n0)*exp(-r*t))}
#######
stoch.verhulst<-function(n0,K,nsim,T,sd,dist.r){
  SIMU<-matrix(NA,ncol=T,nrow=nsim)
  #SIMU[,1]<-n0
    for (s in 1:nsim){
    for( t in 1:T){
      SIMU[s,t]<-rnorm(1,m=v(t=t,n0=n0,r=sample(dist.r,1,replace=T),K=K),sd=sd)
    }
  }
  return(SIMU)
}
SIMU<-stoch.verhulst(n0=n0,K=K,nsim=nsim,T=T,sd=.2*K,dist.r=B.p)
plot(1:T,rep(K,T),type="l",lty=2,lwd=3,col=2,ylim=c(0,K+.2*K),xlab="Time",ylab="Population Size")
for( s in 1:nsim){
  lines(1:T,SIMU[s,],lwd=1,xlab="Time",ylab="Population Size",main="")
  result<-rep(NA,nrow(SIMU))
  for(i in 1:nrow(SIMU)){result[i]<-ifelse(length(which(SIMU[i,]<1))==0,0,1)}
  title(paste("Extinction rate=",sum(result)/nsim))
}