#!/bin/bash

IN_PATH=$1
suffix=fastq.20 #fastq.gz

for file in ${IN_PATH}/*.${suffix}
do
	filename="$(basename -s .${suffix} ${file})"
	num_reads=$(zless ${file} | grep '@' | wc -l | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta')
	echo ${filename} ${num_reads}
done
