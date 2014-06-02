library(ape)# needed to use read/write.dna
to_rename<-read.dna("batch_70.fasta",format="fasta")# reading the fasta file whose seqs will be renamed
new_names<-data.frame(read.table("names_seqs_rabies.txt"))# column file with the new names
renamed<-to_rename
names(renamed)<-new_names$V1 #assuming no label for the new_names data.frame
write.dna(renamed,"rabies_renamed.fasta", format = "fasta")# result