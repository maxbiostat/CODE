 f1 <- function(x, n, a) x^n * exp(a*x)
 f2 <- function(x, n, a) x^{n-1} * exp(a*x) 

 sol1 <- function(x, n, a)  (x^n * exp(a*x))/a - (n/a) * integrate(f2, n = n, a = a, 0, Inf)$value
 # analytic solution given by Gradshteyn & Ryzhik
 # works for every a<0
 sol2 <- function(n, a) gamma(n+1) * (1/a)^{n+1}
 # simply recognizing this is the kernel of a gamma fdp
 ####
 a <- -1.5
 n <- 3
 x <- seq(.1,10,.1)
 
 plot(x, f1(x, n, a), type = "l", lwd = 3)
 sol1(x = 10, n = n, a = a)
 sol2 (n, a)
 