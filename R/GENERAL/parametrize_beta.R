param.beta<-function(M,V){
  a=((1-M)/M - (1+(1-M)/M)^2*V)/((1+(1-M)/M)^3*V)
  b=((1-M)/M)*a
return(list(a,b))}
# testing, not run
p<-param.beta(.04,1e-04)
mean(rbeta(10000,p[[1]],p[[2]]))
var(rbeta(10000,p[[1]],p[[2]]))

plot(seq(0,1,.01),dbeta(seq(0,1,.01),p[[1]],p[[2]]),type="l")