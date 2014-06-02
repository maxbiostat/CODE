library(deSolve)
sir <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    ds <- -b*s*i # -m*s #-f*s
    di <- b*s*i - a*i
    dr <- a*i 
    return(list(c(ds, di, dr)))
  })
}
init <- c(s =.999, i = 0.001, r=0)
times <- seq(0, 100,1)
c<-5.7
OUT<-vector(1000,mode="list")
betapar<-20;l<-.5
plot(seq(0,1,.001),dbeta(seq(0,1,.001),betapar,betapar),type="l",lwd=2)
for(i in 1:length(OUT)){
p<-rbeta(1,betapar,betapar)*l
parameters <- c(b = c*p, a= 1/3,f=.1)
OUT[[i]]<-as.data.frame(ode(y = init, times = times, func = sir, parms = parameters))[,2:4]
}
###
Ss<-Is<-Rs<-data.frame(matrix(NA,length(OUT),length(times)));names(Ss)<-names(Is)<-names(Rs)<-paste("t=",1:length(times),sep="")
for( t in 1:length(times)){
Ss[,t]<-unlist(lapply(OUT,function(x) x[t,1]))
Is[,t]<-unlist(lapply(OUT,function(x) x[t,2]))
Rs[,t]<-unlist(lapply(OUT,function(x) x[t,3]))
}
Sa<-apply(Ss,2,function(x) quantile(x,probs=c(.025,.5,0.975)))
Ia<-apply(Is,2,function(x) quantile(x,probs=c(.025,.5,0.975)))
Ra<-apply(Rs,2,function(x) quantile(x,probs=c(.025,.5,0.975)))
##
plot(times, Sa[3,],ylim=c(0,1), type = "l", xlab = "Time", ylab = "Susceptibles and Recovereds", main = "SIR Model", lwd = 1, lty = 2, bty = "l", col =2)
lines(times, Sa[1,], lwd = 1, lty = 2, col = 2)
lines(times, Sa[2,], lwd = 1, lty = 1, col = 2)
#
lines(times, Ia[1,], lwd = 1, lty = 2, col = 3)
lines(times, Ia[3,], lwd = 1, lty = 2, col = 3)
lines(times, Ia[2,], lwd = 1, lty = 1, col = 3)
#
lines(times, Ra[1,], lwd = 1, lty = 2, col = 4)
lines(times, Ra[3,], lwd = 1, lty = 2, col = 4)
lines(times, Ra[2,], lwd = 1, lty = 1, col = 4)
legend(x="topright", c("Susceptibles", "Infecteds", "Recovereds"), pch = 1, col = 2:4,cex=.5)
