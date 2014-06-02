library(phylotools);library(ape);library(seqinr);library(phangorn)
fbank <- read.dna("~/Dropbox/FMDV_AMERICA/BANCO/Serotype O/banco_aln.fasta",
                  format = "fasta")
#Translate
tbank <- lapply(
  lapply(fbank, function(x) {
  translate(s2c(paste(x, sep = "", collapse = "")))
  })
  , as.SeqFastaAA)
seqinr::write.fasta(tbank,  names = names(tbank), 
                    file.out = "translated.fasta",  open  =  "w",  
                    nbchar  = length(tbank[[1]]))
ttbank <- as.matrix(ape::as.alignment(read.aa("translated.fasta", format = "fasta")))
# Redundancy removal wrapper
red.rm <- function(bank){
  n <- dim(bank)[1];C <- dim(bank)[2]
  grid <- subset(expand.grid(1:n, 1:n), Var1! = Var2)
  ms <- rep(NA, nrow(grid))
  for (i in 1:nrow(grid)){# computing identity scores,  suffers from combinatorial explosion,  though :(
    ms[i] <- sum(bank[grid[i, 1], ] == bank[grid[i, 2], ])
  }
  if(length(which(ms == C)) == 0)stop("No duplicates found")
  selec <- grid[which(ms == C), ] # redundant pairs
  allrd <- sort(unique(selec[, 1]))
  sets <- vector(length(allrd), mode = "list")
  for (j in 1:length(allrd)){ # for each pair
    sets[[j]] <- subset(selec, Var1 == allrd[j])
  }
  rep <- unique(unlist(lapply(sets, min)))# representatives of the "redundant" group
  chs <- setdiff(1:n, setdiff(allrd, rep))
  bankl <- vector(length(chs), mode = "list")
  for(k in 1:length(chs)){bankl[[k]] <- bank[k, ]};names(bankl) <- dimnames(bank[chs, ])[[1]]
  cat(paste("Returning",  length(chs),  "unique sequences"))
  return(invisible(bankl))}
###
# Nucleotide
unqnt <- red.rm(fbank)
seqinr::write.fasta(unqnt,  names = names(unqnt),  file.out = "unique_NT.fasta",
                    open  =  "w",  nbchar  = length(unqnt[[1]]))
# AA seqs
unqaa <- red.rm(ttbank)
seqinr::write.fasta(unqaa,  names = names(unqaa), file.out = "unique_AA.fasta",
                    open  =  "w", nbchar  = length(unqaa[[1]]))