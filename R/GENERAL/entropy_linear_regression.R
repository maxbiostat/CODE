x<-1920:2020
y=0.125*x+3+rnorm(length(x))
plot(x,y)
########################################
shannon.entropy <- function(p)
{
  if (min(p) < 0 || sum(p) <= 0)
    return(NA)
  p.norm <- p[p>0]/sum(p)
  -sum(log2(p.norm)*p.norm)
}
#######################################
data<-data.frame(x,y)
#######################################
ent.sample<-function(d,N,n){
 results<-data.frame(matrix(NA,ncol=9,nrow=N));names(results)<-c("Varx","Vary","Ex","Ey","a","b","n","ESx","ESy")  
  for (i in 1:N){
    set<-d[sample(1:nrow(d),n,replace=FALSE),]
    ###########################################
    results[i,1]<-var(set$x)
    results[i,2]<-var(set$y)
    results[i,3]<-shannon.entropy(set$x)
    results[i,4]<-shannon.entropy(set$y)
    results[i,5] <-lm(y~x,set)$coefficients[2]
    results[i,6] <-lm(y~x,set)$coefficients[1]
    results[i,7]<-n
    results[i,8]<-(mean(set$x)-mean(d$x))/sd(d$x)
    results[i,9]<-(mean(set$y)-mean(d$y))/sd(d$y)
  }
return(results)
}
s<-ent.sample(data,N=1000,n=0.1*nrow(data))
plot(s)
plot(Ex~n,s,type="l",col=2,lwd=2)
lines(Ey~n,s,col=3,lwd=2)

