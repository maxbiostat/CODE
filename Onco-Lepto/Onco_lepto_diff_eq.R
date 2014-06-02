library(deSolve)
oncolepto <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    dE<-  o*A - e*E
    dEp<- op*Ap - ep*Ep
    #
    dS1<-e*E + ep*Ep - m1*S1 - l*(I/N)*S1 - d12*S1
    dS1p<- l*(I/N)*S1 - m1p*S1 - d12p*S1
    #
    dS2<-d12*S1 - m2*S2 - l*(I/N)*S2 - d23*S2
    dS2p<-l*(I/N)*S2 - m2p*S2p - d23p*S2p
    #
    dS3<-d23*S2 - m3*S3 - l*(I/N)*S3 - d34*S3
    dS3p<-l*(I/N)*S3 - m3p*S3p - d34p*S3p
    #
    dS4<-d34*S3 - m4*S4 - l*(I/N)*S4 - d45*S4
    dS4p<-l*(I/N)*S4 - m4p*S4p - d45p*S4p
    #
    dS5<-d45*S4 - m5*S5 - l*(I/N)*S5 - d5A*S5
    dS5p<-l*(I/N)*S5 - m5p*S5p - d5Ap*S5p
    #
    dA<-d5A*S5 - mA*A - l*(I/N)*A 
    dAp<-l*(I/N)*A - mAp*Ap
    #
    dI<-dS1p+dS2p+dS3p+dS4p+dS5p+dAp
    dN<-dI+dS1+dS2+dS3+dS4+dS5+dA
    return(list(c(dE,dEp,dS1,dS1p,dS2,dS2p,dS3,dS3p,dS4,dS4p,dS5,dS5p,dA,dAp,dN,dI)))
  })
}

init <- c(E=100,Ep=80,S1=20,S1p=20,S2=20,S2p=20,S3=20,S3p=20,S4=20,S4p=20,S5=20,S5p=20,A=10,Ap=10,N=400,I=110)
P0<-sum(init)
i<-.45
pe<-.89
parameters <- c(o=.1,op=.1*i,e=pe*.1,ep=pe*i*.1,l=1.2, # oviposition, eclosion and infection (l)
                d12=1/4,d23=1/5,d34=1/4,d45=1/5,d5A=1/8, # development uninfected
                d12p=i*1/4,d23p=i*1/5,d34p=i*1/4,d45p=i*1/5,d5Ap=i*1/8,#development infected
                m1=1/10,m2=1/20,m3=1/30,m4=1/20,m5=1/10,mA=1/30, # mortality uninfected
                m1p=(1/i)*1/10,m2p=(1/i)*1/20,m3p=(1/i)*1/30,m4p=(1/i)*1/20,m5p=(1/i)*1/10,mAp=(1/i)*1/30) # mortality infected
times <- seq(0, 36*30, by = 1)
out <- as.data.frame(ode(y = init, times = times, func = oncolepto, parms = parameters))
head(out);tail(out)
out$time <- NULL
#out$N<-NULL
matplot(times, out, type = "l", xlab = "Time", ylab = "Individuals", main = "Model A")#, lwd = 1, lty = 1, bty = "l", col = 2:4)
#legend(40, 0.7, c("Susceptibles", "Infecteds", "Recovereds"), pch = 1, col = 2:4)