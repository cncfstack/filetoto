#!/bin/bash -x

find .  -type f > /tmp/sed-file-list

cat /tmp/sed-file-list

curl -fsSL https://raw.githubusercontent.com/cncfstack/filetoto/refs/heads/main/allfile.list -o allfile.list
curl -fsSL https://raw.githubusercontent.com/cncfstack/filetoto/refs/heads/main/alldomains -o alldomains

cat allfile.list|awk -F'https://' '{print "s|"$0"|https://filetoto.cncfstack.com/"$2"|g"}' > toto.sed
cat alldomains|awk -F'https://' '{print "s|"$0"|https://filetoto.cncfstack.com/"$2"|g"}' >> toto.sed

cat toto.sed

# 循环依次处理可能包含外部链接的文件，并进行替换
for file in `cat /tmp/sed-file-list`
do
   sudo sed -i -f toto.sed $file
done
