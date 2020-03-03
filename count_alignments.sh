#!/bin/bash

IN_PATH=$1
TYPE=$2 #NSS (non-strand-specific) or SS (strand-specific)

echo ${TYPE}
if [ ${TYPE} = 'SS' ]; then
	out_folder=${IN_PATH}/../counts
	STRANDED='yes'
elif [ ${TYPE} = 'NSS' ]; then
	out_folder=${IN_PATH}/../counts_non_strand_specific
	STRANDED='no'
fi
echo ${STRANDED}
source dual_RNA_seq/Mtb/constants.sh

mkdir ${out_folder}
cd ${out_folder}

for file in ${IN_PATH}/*.bam
do
	sample_name="$(basename -s .bam ${file})"
	echo ${sample_name}
	echo 'counting unique alignments...'
    htseq-count  --stranded ${STRANDED} -f bam  ${file}  ${ANNOTATION_GTF}  >  ${sample_name}.uniq.counts
    echo 'counting all alignments...'
    htseq-count  --nonunique all --stranded ${STRANDED} -f bam  ${file}  ${ANNOTATION_GTF}  >  ${sample_name}.all.counts
done