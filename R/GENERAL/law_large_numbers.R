large.numbers <- function(N,M,m,v,dist="norm",plot=T){ # N = minimum sample size; M = size of the 'population'
 if(dist=="norm"){
   pop <- rnorm(M,m=m,sd=sqrt(v))
 }else{
   if(dist=="expo"){
     pop <- rexp(M,1/m) # disregarding variance
   }
 }
 sample.means <- rep(NA,N)
   for(n in N:M){
     sample.means[match(n,N:M)] <- mean(sample(pop,n,replace=F))
   }
 if(plot){
   plot(N:M, sample.means, type="l", xlab="Sample sizes",ylab="Sample Mean")
   abline(h=mean(pop))
 }
}
large.numbers(N=5,M=100,m=10,v=2,dist="expo")