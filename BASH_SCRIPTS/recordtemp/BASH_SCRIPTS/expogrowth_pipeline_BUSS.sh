#!/bin/bash
# For a certain interval of growth rates, simulate a set of three partitions of 500 bases each, under HKY 1.0.

for g in -1.0 -1.5 -1.0 -0.5 -0.1 0.01 0.1 0.5 1.0 1.5 2.0 2.5 3.0 5.0 7.5 10.0 
  do
java -Xmx4000m -Djava.library.path=/home/max/lib -jar /home/max/filip/buss.jar -taxaSet ~/filip/taXa.txt -from 1 -to 500 -every 1 -demographicModel exponentialGrowthRate -exponentialGrowthRateParameterValues 1000 $g -branchSubstitutionModel HKY -HKYsubstitutionParameterValues 1.0 : -taxaSet ~/filip/taXa.txt -from 501 -to 1000 -every 1 -demographicModel exponentialGrowthRate -exponentialGrowthRateParameterValues 1000 $g -branchSubstitutionModel HKY -HKYsubstitutionParameterValues 2.0 : -taxaSet ~/filip/taXa.txt -from 1001 -to 1500 -every 1 -demographicModel exponentialGrowthRate -exponentialGrowthRateParameterValues 1000 $g -branchSubstitutionModel HKY -HKYsubstitutionParameterValues 3.0 : ~/filip/sillypipeline/sequences_$g.fasta
 done

