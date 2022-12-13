## Collate all files in a directory
## Do a 80:20 split for each file and combine them at the end

search_dir=.

for entry in $(ls "$search_dir" | grep 'log')
do
  echo "Splitting $entry $(($(wc -l < $entry) * 80/100 ))"
  shuf $entry | split -l $(($(wc -l < $entry) * 80/100 ))
  mv xaa "$entry.00"
  mv xab "$entry.01"
done

cat *.00 > train.txt
cat *.01 > test.txt

rm *.00 *.01