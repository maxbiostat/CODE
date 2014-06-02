library(deSolve)
verhulst <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    dP <- r*P*(1-(P/K))
   return(list(c(dP)))
  })
}
K<-1000
r<-0.14
No<-100
init <- c(P=No)
parameters <- c(r,K)
times <- seq(0, 70, by = 1)
out <- as.data.frame(ode(y = init, times = times, func = verhulst, parms = parameters))
out$time <- NULL
out$analytic<-K/(1+((K-No)/No)* exp(-r*times) )
matplot(times, out,type = "l", xlab = "Time", ylab = "Population", main = "Verhulst Logistic Growth Model", lwd = 2, lty = 1, bty = "l", col = c("red","blue"))
legend(x="right",legend=c("Analytic","Lsoda"),col=c("blue","red"),lwd=2)
