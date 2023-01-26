library(deSolve)
library(ggplot2)

r <- 1
K <- 1
yini <- .5
param <- c(r, K, yini)
Verhulst <- function(t, y, param){
  dN <- r * y * (1 - (y / K))
  list(dN)
}
times <- seq(from = 0, to = 20, by = 0.2)
result <- as.data.frame(
  ode(y = yini, times = times, func = Verhulst, parms = param)
)
names(result) <- c("time", "N")
head(result)

ggplot(result,
       aes(x = time, y = N)) + 
  geom_line(linewidth = 1) + 
  scale_x_continuous("Time", expand = c(0, 0)) + 
  scale_y_continuous(expression(N(t)), expand = c(0, 0)) + 
  theme_bw(base_size = 16)