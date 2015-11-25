#!/bin/bash
## Usage: enter a tree file ($1), how many trees ($2) you want and the output file name ($3)
name=$(echo $1)
ntaxa=$(grep ntax $name |  cut -d'=' -f2 |  sed s/\;//)
# nlines=$(expr 2*$ntaxa + 11)
nlines=`echo "2*$ntaxa + 11" | bc -l`
output=$3
head -n$nlines $name > head.parttree
tail -n$(expr $2 + 1) $name > tail.parttree
cat head.parttree > $output
cat tail.parttree >> $output
blocksize=$(grep "End" $name| wc -l)
if [ "$blocksize" -lt "2" ]; then
	 echo 'End;' >> $output
fi
rm *.parttree 

