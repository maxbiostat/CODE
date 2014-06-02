### This script takes a big database with lots of VP1 sequences and exports subsamples of only sertypes A and O
## Copyleft(or the one to blame): Carvalho, LMF (2014)
## last updated: 15/05/2014
library(ape)
metadata <- data.frame(read.table("~/Dropbox/TERA/DATA/WORLD_FMDV/info_data_1811.txt", TRUE))
database <- read.dna("~/Dropbox/TERA/DATA/WORLD_FMDV/batch_WRLDFMD_ALN_GAPFREE_GEO.fasta", format = "fasta")
#########
metaA<- subset(metadata, SEROTYPE == "A") # extract the GenBankIDs of the serotype O sequences
whichA <- metaA$ACCN
posA <- vector(length = length(whichA))
for (a in whichA){
  j <- match(a, whichA)
  posA[j] <- grep(a, row.names(database))
}
databaseA <- database[posA, ]
#########
metaO<- subset(metadata, SEROTYPE == "O") # extract the GenBankIDs of the serotype O sequences
whichO <- metaO$ACCN
posO <- vector(length = length(whichO))
for (o in whichO){
  i <- match(o, whichO)
  posO[i] <- grep(o, row.names(database))
}
databaseO <- database[posO, ]

write.table(metaA, file = "~/Dropbox/TERA/DATA/WORLD_FMDV/meta_A.txt", sep = "\t", row.names = FALSE)
write.dna(databaseA, file = "~/Dropbox/TERA/DATA/WORLD_FMDV/world_A.fasta", format = "fasta")

write.table(metaO, file = "~/Dropbox/TERA/DATA/WORLD_FMDV/meta_O.txt", sep = "\t", row.names = FALSE)
write.dna(databaseO, file = "~/Dropbox/TERA/DATA/WORLD_FMDV/world_O.fasta", format = "fasta")