#### Let X ~ Uniform(ax, bx) and Y ~ Uniform(ay, by)
#### Implements the density f_Z(z) of Z = Y/X
analytic_Z <- function(z, ax, bx,  ay, by){
  c0 <- all(z > ay/bx, z < by/ax)
  k <- (bx-ax)*(by-ay)
  m <- max(ax, ay/z)
  M <- min(bx, by/z)
  soln <- function(L, U) ((U *abs(U))- (L *abs(L)))/(2*k)
  d0 <- soln(L = m, U = M)
  dens <- c0 * d0 
  return(dens)  
}
analytic_Z <- Vectorize(analytic_Z)

## Uncomment to run
# a_x <- 2
# b_x <- 4
# a_y <- 6
# b_y <- 9
# 
# Y <- runif(1e6, a_y, b_y)
# X <- runif(1e6, a_x, b_x)
# Z <- Y/X
# # curve(analytic_Z(x, ax = a_x, bx = b_x, ay = a_y, by = b_y), lwd = 2, a_y/b_x, b_y/a_x)
# hist(Z, probability = TRUE)
# curve(analytic_Z(x, ax = a_x, bx = b_x, ay = a_y, by = b_y), lwd = 2, a_y/b_x, b_y/a_x, add = TRUE)