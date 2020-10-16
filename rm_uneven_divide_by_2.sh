#!/bin/bash

IN_PATH=$1
out_folder=${IN_PATH}


for file in ${IN_PATH}/*.aligned_reads.tsv
do
	sample="$(basename -s .tsv ${file})"
	echo $sample
    awk -F "\t" '{ if($2 % 2 == 0) { print $1, "\t", $2/2, "\t", $3} }' ${file} | gzip > ${IN_PATH}/${sample}.gz
done

