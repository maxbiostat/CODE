#### This script takes a big database with lots of genomes and separates CDS  from mRNA sequences
#### it also selects only sequences in the range 600-700 bp
## Copyleft(or the one to blame): Carvalho, LMF (2013)
## last updated: 15/05/2014
library(ape)
#####################
database <- read.dna("Dropbox/FMDV_GENOME/DATA/SELECTED/bioportal_morethan600_ALN.fasta", format = "fasta")
L.vec <- unlist(lapply(database, length))
database.F <- database[which(L.vec > 600 && L.vec < 700)]
database.filt1 <- database[grep("CDS", names(database))]
length(database.filt1)
database.filt1 <- database[setdiff(1:length(database),
                                   grep("mRNA", names(database)))]
length(database.filt1)
database.filt2 <- database[setdiff(1:length(database.filt1),
                                   grep("VP2",names(database.filt1)))]
length(database.filt2)
write.dna(database.F2, file = "Dropbox/FMDV_GENOME/DATA/FMDV_1D_VP1_FILT.fasta", format = "fasta")