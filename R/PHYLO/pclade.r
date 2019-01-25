# pclade <- function(k, n){
## Formula from Prickett 2005; seems wrong
#   if(k < 2 || k > n -1){
#     return(1)
#   }else{
#     inds.a <- 2:k
#     A <- prod(2*inds.a -3)
#     inds.b <- (k+1):n
#     B <- prod(2*inds.b-2*k -1)
#     C <- prod(2*(2:n) -3)#ape::howmanytrees(n)
#     return(A * B/C)
#   }
# }
# pclade <- function(k, n){
# ## Formula from Brown 1994  
#   if(k < 2 || k > n -1){
#     return(1)
#   }else{
#   inds <- 1:(n-k)
#    C <- {2*factorial(k)*factorial(n-k)*factorial(n-k-1)}/{factorial(n)*factorial(n-1)}
#    S <- sum({inds*factorial(n-inds-1)}/{factorial(n-inds-k)})
#   return(C*S)
#   }
# }
################################################################################################
############################## Clade probability stuff ; based on Zhu, Degnan and Steel (2011)
################################################################################################
pclade <- function(k, n){
  ## Lemma 4.2 in Zhu, 2011
  if(k < 2 || k > n -1){
    return(1)
  }else{
    return({ 2*n/(k * (k + 1))  }*  1/choose(n, k) ) 
  }
}
# N <- 5
# sapply(2:(N-1), function(i) pclade(i, n =  N))
Rn <- function(x, y, n){
  ## This implementation automatically takes care of both cases: A \in B or B \in A
  m <- min(x, y)
  M <- max(x, y)
  return(
    {4*n/(m * (m + 1) * (M + 1)) } * 1/choose(n = n, k = M) * 1/choose(n = M, k = m)
  )
}
#
Gn <- function(a, b, n){
  return(
    n/(a*b*(a + 1) * (b + 1)) -
    {a*(a + 1) + b* (b + 1) + a*b}/{a*b * (a + 1) *(b + 1) *(a + b + 1)} + 
      1/((a + b) * ( (a + b)^2- 1))
  )
}
#
rn <- function(a, b, n){
  K <- {4 * factorial(a) * factorial(b) * factorial(n - a - b)}/factorial(n-1)
  return(K * Gn(a, b, n))
}
#
pclades <- function(a, b, n, case = 1){
  ## Theorem 4.5 in Zhu, 2011 [TheoPopBio]
  ans <- switch (case,
                 "1" = pclade(a, n), ## A == B
                 "2" = Rn(a, b, n = n), ## A \in B
                 "3" = Rn(a, b, n = n), ## B \in A
                 "4" = 2/(n-1) * 1/choose(n = n, k = a), ## intersect(A, B) = NULL and a + b = n 
                 "5" = rn(a, b, n), ## intersect(A, B) = NULL and a + b < n 
                 "6" = 0 ## A and B are incompatible
  )
  return(ans)
}
#
make_all_clades <- function(n){
  tips <- paste("t", 1:n,  sep = "")
  inner <- 2:(n-1)
  # Pos <- lapply(inner, function(k) combn(n, k))
  Pos <- lapply(inner, function(k) gRbase::combnPrim(n, k))
  AllClades <- lapply(Pos,
                      function(cn) {
                        apply(cn, 2, function(x) paste("{", paste("t", x, collapse = ",", sep = "") , "}",sep = ""))
                      } ) 
  ans <- unlist(AllClades)
  if(length(ans) != 2^n-n-2) stop("Did not generate the correct number of clades")
  return(ans)
}
#
get_clade_elements <- function(x){
  y <- gsub("\\{", "", gsub("\\}", "", x))
  strsplit(y, ",")[[1]]
}
#
get_clade_size <- function(x){
  length(get_clade_elements(x))
}
#
compatible <- function(x, y){
  x.el <- get_clade_elements(x)
  y.el <- get_clade_elements(y)
  sx <- length(x.el)
  sy <- length(y.el)
  Inters <- intersect(x.el, y.el)
  invCond <- length(Inters) > 0 && length(Inters) != min(sx, sy)
  return(!invCond)
}
# compatible(x = "{t1,t2}", y = "{t1,t3,t4}")
# compatible(x = "{t1,t2}", y = "{t1,t2,t4}")
prob_clade <- function(clade, n){
  size <- length(get_clade_elements(clade))
  pclade(k = size, n = n)
}
#
joint_clades <- function(c1, c2, n, verbose = FALSE){
  c1.el <- get_clade_elements(c1)
  c2.el <- get_clade_elements(c2)
  a <- length(c1.el)
  b <- length(c2.el)
  if(identical(sort(c1.el), sort(c2.el))){
    Case <- 1
  }else{
    if(!compatible(c1, c2)){
      Case <- 6
    }else{
      Inters <- intersect(c1.el, c2.el)
      if(length(Inters) > 0){
        Case <- 2
      }else{
        if(a + b == n){
          Case <- 4
        }else{
          Case <- 5
        }
      }
    }
  }
  if(verbose)  cat("case", Case, "\n")
  return(pclades(a = a, b = b, n = n, case = Case))
}
# joint_clades(c1 = "{t1,t2}", c2 = "{t1,t2}", n = 5) ## case 1
# joint_clades(c1 = "{t1,t2}", c2 = "{t1,t2,t4}", n = 5) ## case 2/3
# joint_clades(c1 = "{t1,t2}", c2 = "{t3,t4,t5}", n = 5) ## case 4
# joint_clades(c1 = "{t1,t2}", c2 = "{t3,t4}", n = 5) ## case 5
# joint_clades(c1 = "{t1,t2}", c2 = "{t1,t3,t4}", n = 5) ## case 6
rho_clades <- function(c1, c2, n){
  c1.el <- get_clade_elements(c1)
  c2.el <- get_clade_elements(c2)
  a <- length(c1.el)
  b <- length(c2.el)
  pAB <- joint_clades(c1 = c1, c2 = c2, n = n)
  pA <- pclade(k = a, n = n)
  pB <- pclade(k = b, n = n)  
  covariance <- (pAB - pA*pB)
  rho <- covariance/(sqrt(pA * (1-pA) * pB * (1-pB)))
  # return(rho)  
  return(data.frame(pi = pA, pj = pB, pij = pAB, cov = covariance, rho = rho))
}
# rho_clades(c1 = "{t1,t2}", c2 = "{t1,t2}", n = 5) ## case 1
# rho_clades(c1 = "{t1,t2}", c2 = "{t1,t2,t4}", n = 5) ## case 2/3
# rho_clades(c1 = "{t1,t2}", c2 = "{t3,t4,t5}", n = 5) ## case 4
# rho_clades(c1 = "{t1,t2}", c2 = "{t3,t4}", n = 5) ## case 5
# rho_clades(c1 = "{t1,t2}", c2 = "{t1,t3,t4}", n = 5) ## case 
make_clade_corr_grid <- function(n, diagonal = FALSE){
  Clades <- make_all_clades(n)
  K <- length(Clades)
  if(diagonal){
    posGrid <- subset(expand.grid(1:K, 1:K), Var1 <= Var2) 
  }else{
    posGrid <- subset(expand.grid(1:K, 1:K), Var1 < Var2)
  }
  Rho <- parallel::mclapply(1:nrow(posGrid),
                            function(i) rho_clades(c1 = Clades[[posGrid[i, 1]]],
                                                   c2 = Clades[[posGrid[i, 2]]], n = n),
                            mc.cores = 3)
  names(posGrid) <- c("i", "j")
  return(cbind(posGrid, data.table::rbindlist(Rho)))
}
#
make_clade_joint_mat <- function(n){
  Grid <- make_clade_corr_grid(n = n)
  K <- 2^n-n-2
  M <- matrix(0, ncol = K, nrow = K)
  for(k in 1:nrow(Grid)) M [Grid[k, ]$i, Grid[k, ]$j] <- Grid[k, ]$pij
  M <- M + t(M)
  return(M)
}
#
make_clade_cov_mat <- function(n){
  Grid <- make_clade_corr_grid(n = n, diagonal = TRUE)
  K <- 2^n-n-2
  M <- matrix(0, ncol = K, nrow = K)
  for(k in 1:nrow(Grid)) M [Grid[k, ]$i, Grid[k, ]$j] <- Grid[k, ]$cov
  Diag <- diag(M)
  M <- M + t(M)
  diag(M) <- Diag
  return(M)
}
#
make_clade_corr_mat <- function(n){
  Grid <- make_clade_corr_grid(n = n)
  K <- 2^n-n-2
  M <- matrix(0, ncol = K, nrow = K)
  for(k in 1:nrow(Grid)) M [Grid[k, ]$i, Grid[k, ]$j] <- Grid[k, ]$rho
  M <- M + t(M)
  diag(M) <- 1
  return(M)
}
#
min_corr <- function(n){## returns the minimum possible correlation for a given number of taxa
  pp <- pclade(2, n)
  return(
    - pp^2/sqrt(pp^2 * (1-pp)^2)
  )
}
min_corr <- Vectorize(min_corr)
#
max_corr <- function(n){
  kk <- floor(n/2) + 1
  pA <- pclade(kk, n)
  pB <- pclade(kk-1, n)
  pp <- pclades(kk, kk-1, n, case = 5)
  return(
    ( pp-pA*pB )/ sqrt(pA *(1-pA) * pB *(1-pB))
  )
}
max_corr <- Vectorize(max_corr)
