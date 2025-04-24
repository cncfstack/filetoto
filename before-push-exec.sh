#!/bin/bash

cat filelist/* >> allfile.list
rm -f filelist/*
cat allfile.list |awk -F '/' '{print $1"//"$2$3"/"}'|sort|uniq > alldomains
