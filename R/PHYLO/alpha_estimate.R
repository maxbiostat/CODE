n<-function(N1,N2,t){
w1<-N1*(1-1/{2*N2})^t
w2<-N2*(1-exp(-{t/{2*N2}}))  
n<-{N1*w1+N2*w2}/{w1+w2}
return(n)}
#
f<-function(s,N,a,b) {1-exp(-s)}/{1-exp(-2*N*s)}*dgamma(s,a,1/b)
#
s<-seq(0,10,.1)
N1<-50
N2<-100
t<-50
N<-n(N1,N2,t);N
S<-rgamma(10000,a,1/b);summary(S)
plot(s,f(s,N,a,b),type="l",lwd=2,col=3,ylim=c(0,.15))
lines(s,dgamma(s,a,1/b),lwd=2,col=2)
legend(x="topright",legend=c("gamma dist","Eyre-Walker"),col=c(2,3),lwd=2)
f2<-function(s) {1-exp(-s)}/{1-exp(-2*N*s)}*dgamma(s,a,1/b)*2*N
dN<-2
dS<-.1
alpha<-{dN-dS*as.numeric(integrate(f2,lower=0,upper=Inf)$value)}/dN;alpha
