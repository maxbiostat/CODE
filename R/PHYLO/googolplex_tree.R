### How many taxa should we have to have a googol of possible trees? And a googolplex?
### The code below solves stuff until T(n) = 10^300.
### For a googplex of trees, the answer is roughly a hundredth of a googol or 10^98
ntrees <- function(n, rooted = TRUE){
  ## How many trees of n leaves?
  require(phangorn)  
  if(rooted){
    y <- dfactorial((2*n-3))
  }else{
    y <- dfactorial((2*n-5))
  }
  return(y)
}
###
find.n <- function(y, rooted = TRUE){
  app.y <- function(n, ty){
    if(rooted){
      app <- (n-1)*(log(2*n-2)-1) + .5*log((12*n-11)/(6*n-5))
    }else{
      app <- (n-3)*(log(2*n-6)-1) + .5*log((12*n-35)/(6*n-11))
    }
    return(abs(log(ty)-app))
  }
  res <- optimize(f = app.y, c(3, 1E+8), tol = 1E-8, ty = y)
  cat("(log)Error:", res$objective, "\n")
  return(ceiling(res$minimum))
}
##
find.n(1E+100)
find.n(1E+81)