for file in *.trees
do
name=$(echo $file)
parts=${name//./}
size=${#parts[@]}
stem0=${parts[size-1]}
stem=${stem0//trees/}
~/BEASTv1.8.2/bin/treeannotator -burninTrees 5000 $file $stem.tree
echo "$file is done"
done

