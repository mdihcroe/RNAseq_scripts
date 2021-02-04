#!/bin/bash

IN_PATH=$1
filter_short_reads=/home/aelizarova/tools/RNAseq_scripts/filter_short_reads.sh
min_length=20

for file in ${IN_PATH}/*_R1.fastq
do
	sample_name="$(basename -s _R1.fastq ${file})"
	bash ${filter_short_reads} ${IN_PATH}/${sample_name}_R1.fastq ${IN_PATH}/${sample_name}_R2.fastq ${min_length}

	echo ${sample_name}' finished'
done