#!/bin/bash

IN_PATH=$1
# SPECIES=$2 #mtb, hs
MODE=$2 # paired; single
STRANDNESS=$3 #non-stranded; forward; reverse

out_folder=${IN_PATH}/hisat_out

source /home/aelizarova/dual_RNA_seq/Mtb/constants.sh

# if [ ${SPECIES} = 'mtb' ]; then
# 	HISAT_INDEX=HISAT_INDEX_MTB
# elif [ ${SPECIES} = 'hs' ]; then
# 	HISAT_INDEX=HISAT_INDEX_HS
# else
# 	echo 'should be mtb or hs'
# fi
mkdir ${out_folder}
cd ${out_folder}

for file in ${IN_PATH}/*_R1_001.fastq.gz
do
	sample_name="$(basename -s _R1_001.fastq.gz ${file})"
	echo ${sample_name}
	if [ ${MODE} = 'single' ]; then
		echo 'run in single-end mode'
	    ${HISAT2_PATH} -p 20  -x ${HISAT_INDEX}/genome  -U ${file} -S ${out_folder}/${sample_name}.sam  --summary-file ${out_folder}/${sample_name}.hisat
	elif [ ${MODE} = 'paired' ]; then
		echo 'run in paired-end mode'
		if [ ${STRANDNESS} = 'forward' ]; then
			echo 'forward-stranded'
		    ${HISAT2_PATH} --rna-strandness FR -p 20 -x ${HISAT_INDEX}/genome  -1 ${file} -2 ${IN_PATH}/${sample_name}_R2_001.fastq.gz \
		    -S ${out_folder}/${sample_name}.sam  --summary-file ${out_folder}/${sample_name}.hisat
		elif [ ${STRANDNESS} = 'reverse' ]; then
			echo 'reverse-stranded'
			${HISAT2_PATH} --rna-strandness RF -p 20 -x ${HISAT_INDEX}/genome  -1 ${file} -2 ${IN_PATH}/${sample_name}_R2_001.fastq.gz \
		    -S ${out_folder}/${sample_name}.sam  --summary-file ${out_folder}/${sample_name}.hisat
		elif [ ${STRANDNESS} = 'non-stranded' ]; then
			echo 'non-stranded'
			${HISAT2_PATH} -p 20 -x ${HISAT_INDEX}/genome  -1 ${file} -2 ${IN_PATH}/${sample_name}_R2_001.fastq.gz \
			-S ${out_folder}/${sample_name}.sam  --summary-file ${out_folder}/${sample_name}.hisat
		fi
	fi
done
