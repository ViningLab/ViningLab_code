#!/bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N hisat2
#$ -e hserr
#$ -o hsout
#$ -q hoser
#$ -pe thread 8
# $ -pe thread 10
# #$ -l mem_free=10G
#$ -V
# #$ -h
#$ -t 1-7:1
# $ -t 1-1:1
# $ -t 2-2:1
# $ -t 3-3:1

#
i=$(expr $SGE_TASK_ID - 1)

##### ##### ##### ##### #####

# http://daehwankimlab.github.io/hisat2/
# https://github.com/DaehwanKimLab/hisat2

#HISAT2="/local/cluster/hisat2-2.2.0/hisat2"
#SAMT="~/bin/samtools-1.11/samtools"
HISAT2="hisat2"
SAMT="samtools"

#GENOME="../repeatmodeler/GCA_016165845.1_Cannbio-2_genomic.fna.masked "
#SNAME="Cannbio-2"
GENOME="../repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna.masked"
SNAME="Purpl_Kush"

# Input file containing sample name and FASTQ locations.
FILE=( `cat "samples.txt" `)
IFS=';' read -a arr <<< "${FILE[$i]}"
echo "${arr[1]}"

#RG="@RG\tID:${arr[0]}\tLB:${arr[0]}\tPL:illumina\tSM:${arr[0]}\tPU:${arr[0]}"

##### ##### ##### ##### #####

echo
date

# hisat2-build genome.fa genome
CMD="$HISAT2-build $GENOME $SNAME"

#echo $CMD
#eval $CMD


echo
date

# EOF.
