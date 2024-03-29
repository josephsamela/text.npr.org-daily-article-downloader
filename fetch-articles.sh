#!/bin/sh
# Download articles from frontpage of text.npr.org as individual .txt files.

path=$1
address="https://text.npr.org"

for url in $(wget -S -O - $address | grep -oP 'href="\K[^"\047]+(?=["\047])' | grep sId)
do
    article=$(lynx -dump -crawl "$address/$url")
    title=$(echo $article | grep -oP 'Text-Only NPR.org : \K[^\047]+Text-Only NPR.org')
    lynx -dump -crawl "$address/$url" > "$path/$title.txt"
done

rm "$path/Contact NPR Text-Only NPR.org.txt"
rm "$path/Privacy Policy Text-Only NPR.org.txt"
rm "$path/Terms of Use Text-Only NPR.org.txt"
rm "$path/Rights and Permissions Information Text-Only NPR.org.txt"

