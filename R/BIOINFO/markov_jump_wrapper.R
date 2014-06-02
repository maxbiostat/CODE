MJ.gen <- function(states, from, to, file){
  options(useFancyQuotes ="0X22")
  K <- length(unique(states))
  mjmatrix.b <- rep(0, K^2)
  grid <- subset(expand.grid(states, states), Var1!=Var2) 
  blocks <- vector("list",  nrow(grid))
  for (i in 1:nrow(grid)){   
    mjmatrix <- mjmatrix.b 
    mjmatrix[i+1] <- 1
    blocks[i] <- paste(
      paste("<parameter id=", dQuote(paste("from", grid[i, 1], "to", grid[i, 2], sep="_")), sep="")
      , "value=", 
      dQuote(paste(as.vector(mjmatrix), collapse=" ")), 
      paste("/>"),            
      sep=" ")    
  }
  if(!missing(from)){
    froms <- vector("list", length(from))
    for (j in 1:length(from)){
      mjmatrix <- matrix(mjmatrix.b, ncol=K)
      mjmatrix[match(from[j], states), ] <- 1
      diag(mjmatrix) <- 0 
      mjmatrix <- as.vector(mjmatrix)
      froms[j] <- paste(
        paste("<parameter id=", dQuote(paste("from", from[j], sep="_")), sep="")
        , "value=", 
        dQuote(paste(as.vector(mjmatrix), collapse=" ")), 
        paste("/>"),            
        sep=" ")
    }
  } else{froms <- NULL}
  if(!missing(to)){
    tos <- vector("list", length(to))
    for (z in 1:length(to)){
      mjmatrix <- matrix(mjmatrix.b, ncol=K)
      mjmatrix[, match(to[z], states)] <- 1
      diag(mjmatrix) <- 0
      mjmatrix <- as.vector(mjmatrix)
      tos[z] <- paste(
        paste("<parameter id=", dQuote(paste("to", to[z], sep="_")), sep="")
        , "value=", 
        dQuote(paste(as.vector(mjmatrix), collapse=" ")), 
        paste("/>"),            
        sep=" ")
    }
  }else{tos <- NULL}  
  write(c(unlist(blocks), unlist(froms), unlist(tos)), file)
}
#states <- c("Arg", "Bol", "Bra", "Col", "Ecu", "Par", "Per", "Uru", "Ven")
#states <- c("SR", "CR", "HU", "DE", "SW", "FI", "RU")
states <- c("CEN", "GA", "LA", "PE", "SA_1", "SA_2")
MJ.gen(states, from = states, to = states, file = "MJ_blocks_Gonzalo.xml")