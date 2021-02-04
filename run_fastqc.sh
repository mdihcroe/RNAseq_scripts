#!/bin/bash

IN_PATH=$1
out_folder=${IN_PATH}/fastqc

mkdir ${out_folder}

for file in ${IN_PATH}/*.fastq.20
do
	sample="$(basename -s .fastq.20 ${file})"
	
    mkdir ${out_folder}/${sample}
	fastqc ${file} --outdir=${out_folder}/${sample}
done

