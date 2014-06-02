library(deSolve)
oncolepto <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
   A<-M+F  
   dE<- o*F*(M/A) - e*E # mass action male/female
   #dE<- o*F - e*E # w/o mass action
   dS1<-e*E - m1*S1 - d12*S1
   dS2<-d12*S1 - m2*S2 - d23*S2
   dS3<-d23*S2 - m3*S3 - d34*S3
   dS4<-d34*S3 - m4*S4 - d45*S4
   dS5<-d45*S4 - m5*S5 - ps*S5 - (1-ps)*S5
   dM<-(1-ps)*S5 - mM*M
   dF<- ps*S5 - mF*F
    return(list(c(dE,dS1,dS2,dS3,dS4,dS5,dM,dF)))
  })
}

init <- c(E=100,S1=20,S2=50,S3=50,S4=30,S5=100,M=10,F=30)
pe<-.89
ps<-.55
parameters <- c(o=5,e=pe*5,ps=ps, # oviposition and eclosion
                d12=1/4,d23=1/3,d34=1/3,d45=1/7, # development uninfected
                m1=1/10,m2=1/20,m3=1/30,m4=1/20,m5=1/20,mM=1/20,mF=1/30)
times <- seq(0, 4*30, by = 1)
out <- as.data.frame(ode(y = init, times = times, func = oncolepto, parms = parameters))
out$time <- NULL
pal<-c("red","blue","green","black","darkgreen","darkmagenta","dodgerblue2","goldenrod4")
matplot(times, out, type = "l", xlab = "Time", ylab = "Individuals", main = "Simple Demographic Model with Sexual Dimorphism ", lwd = 2, lty = 1, bty = "l", col = pal,ylim=c(0, max(out)+.2*max(out)))
legend(x="topleft", c("Eggs", "Stage_ 1", "Stage_2","Stage_3","Stage_4","Stage_5","Males","Females"), lwd = 2,cex=.35, col = pal,horiz=T,bty="n")