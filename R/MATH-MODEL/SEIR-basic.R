library(deSolve)
seir <- function(time,state, parameters) {
  with(as.list(c(state, parameters)), {
   dS <- m*(S+E+I+R) - (b/N)*S*I - m*S 
   dE <- (b/N)*S*I - m*E - e*E
   dI <- e*E - m*I - r*I
   dR <- r*I - m*R
    
    return(list(c(dS,dE, dI, dR)))
  })
}

init <- c(S = 999, I = 1,E=0,R=0)
parameters <- c(b =4.8, e=.5, r = .25, m=.14,N=sum(init))
times <- seq(0, 70, by = 1)
out <- as.data.frame(ode(y = init, times = times, func = seir, parms = parameters))
out$time <- NULL
matplot(times, out, type = "l", xlab = "Time", ylab = "Susceptibles and Recovereds", main = "SEIR -  Model", lwd = 1, lty = 1, bty = "l", col = 2:4)
#legend(40, 0.7, c("Susceptibles", "Infecteds", "Recovereds"), pch = 1, col = 2:4)