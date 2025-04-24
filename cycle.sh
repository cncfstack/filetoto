#!/bin/bash -x

path=$1

find $path  -type f > /tmp/sed-file-list

cat /tmp/sed-file-list

cat allfile.list|awk -F'https://' '{print "s|"$0"|https://filetoto.cncfstack.com/"$2"|g"}' > /tmp/toto.sed
cat alldomains|awk -F'https://' '{print "s|"$0"|https://filetoto.cncfstack.com/"$2"|g"}' >> /tmp/toto.sed
cat special.list >> /tmp/toto.sed


# 循环依次处理可能包含外部链接的文件，并进行替换
for file in `cat /tmp/sed-file-list`
do
    file -b $file |grep "ASCII text"
    if [ $? -ne 0 ];then
        echo "not ASCII text, Just Skip: $file"
	continue
    fi
   sudo sed -i -f /tmp/toto.sed $file
done
