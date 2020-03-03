#!/bin/bash

IN_PATH=$1
for file in ${IN_PATH}/*.fastq
do
	filename="$(basename -s .fastq ${file})"
	num_reads=$(cat ${file} | grep '@' | wc -l | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')
	echo ${filename} ${num_reads}
done
