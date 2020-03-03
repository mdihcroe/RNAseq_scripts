#!/bin/bash

IN_PATH=$1

source dual_RNA_seq/Mtb/constants.sh

for file in ${IN_PATH}/*.sam
do
	sample_name="$(basename -s .sam ${file})"
	echo ${sample_name}
    samtools view -b -o ${IN_PATH}/${sample_name}.bam ${file} 
done
