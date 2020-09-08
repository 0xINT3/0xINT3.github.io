while read line; do subfinder -d $line | tee $line.txt; done < in-scope.txt 
cat *.txt >> all.txt 
cat all.txt | grep "http://" | tee http.txt 
cat all.txt | grep "https://" | tee https.txt 
cat http.txt | cut -c 8- | tee "http-grep.txt" 
cat https.txt | cut -c 9- | tee "https-grep.txt" 
comm -3 <(sort "http-grep.txt")  <(sort "https-grep.txt" ) > final.txt 
cat final.txt | sed 's/\s.*$//' > finalize.txt 
rm http* 
httpx -l finalize.txt -status-code -silent -mc 200 > final.txt
