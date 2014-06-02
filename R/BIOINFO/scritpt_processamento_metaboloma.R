#####
## Este script extrai de uma tabela bruta aquelas observações que
## tiveram pelo menos uma medição maior que zero numa das replicatas
#####

bruto <- data.frame(read.table("~/VOID/planilha_filipin_pos.csv", T)) # carregando os dados brutos

n <- 2 # numero de replicatas

retorna.filtrado <- function(bruto, n){
  
  ind.mat <- apply(data.frame(bruto[-1] > 0), 2, as.numeric) # matriz indicadora dos dados brutos
  cols <- seq(1, ncol(ind.mat), 2)
  clumped <- data.frame(matrix(NA, ncol = length(cols), nrow = nrow(bruto)))
  
  for(c in cols){
    clumped[,match(c, cols)] <- ind.mat[,c] + ind.mat[,c+1]
  }
  
 ind.clumped <- apply(clumped, 2, function(x) as.numeric( x > 0)) # matriz indicadora dos sistemas
 rrows <- which(rowSums(ind.clumped)> 0)
 
 return(bruto[rrows,])
}
filt <- retorna.filtrado(bruto, n)
summary(filt); nrow(filt)

