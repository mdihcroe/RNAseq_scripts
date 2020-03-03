#!/bin/bash

IN_PATH=$1
SPECIES=$2 #mtb, hs
out_folder=${IN_PATH}/hisat_out

source dual_RNA_seq/Mtb/constants.sh

if [ ${SPECIES} = 'mtb' ]; then
	HISAT_INDEX=HISAT_INDEX_MTB
elif [ ${SPECIES} = 'hs' ]; then
	HISAT_INDEX=HISAT_INDEX_HS
else
	echo 'should be mtb or hs'
fi
mkdir ${out_folder}
cd ${out_folder}

for file in ${IN_PATH}/*.fastq
do
	sample_name="$(basename -s .fastq ${file})"
	echo ${sample_name}
    ${HISAT2_PATH} -p 20  -x ${HISAT_INDEX}/genome  -U ${file}  \\
    			-S ${sample_name}.sam  --summary-file ${sample_name}.hisat
done
