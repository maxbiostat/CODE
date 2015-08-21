#!/bin/bash
## Usage: enter a tree file ($1), what's the "end of heading" line ($2) and how many trees ($3) you want and the output file name ($4)
## TODO: find out a way of automatically determining $2
name=$(echo $1)
output=$4
head -n$2 $name > head.parttree
tail -n$(expr $3 + 1) $name > tail.parttree
cat head.parttree > $output
cat tail.parttree >> $output
blocksize=$(grep "End" $name| wc -l)
if [ "$blocksize" -lt "2" ]; then
	 echo 'End;' >> $output
fi
rm *.parttree 

