#!/bin/bash

IN_PATH=$1
out_folder=${IN_PATH}/cutadapt_fastq
adapter_seq=AGATCGGAAGAG

mkdir ${out_folder}

for file in ${IN_PATH}/*_R1_001.fastq.gz
do
	sample_name="$(basename -s _R1_001.fastq.gz ${file})"
	cutadapt -a ${adapter_seq} -A ${adapter_seq} -o ${out_folder}/tr_${sample_name}_R1.fastq -p ${out_folder}/tr_${sample_name}_R2.fastq ${IN_PATH}/${sample_name}_R1_001.fastq.gz ${IN_PATH}/${sample_name}_R2_001.fastq.gz
	echo ${sample_name}' finished'
done