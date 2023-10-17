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

# for paired-end FASTQ reads alignment
# hisat2 -x genome -1 reads_1.fq -2 read2_2.fq -S output.sam


#CMD="$HISAT2 -x $GENOME \

CMD="$HISAT2 -x $SNAME \
     -p 8 \
     -1 ${arr[1]} \
     -2 ${arr[2]} \
     --rg-id ${arr[0]} \
     --rg ID:${arr[0]} \
     --rg LB:${arr[0]} \
     --rg PL:illumina \
     --rg SM:${arr[0]} \
     --rg PU:${arr[0]} | $SAMT view -@ 8 -bh -S - > bams/${arr[0]}.bam"


#     --rg $RG | $SAMT view -bh > bams/${arr[0]}.bam"
#     -S ${arr[0]}.sam \
#
echo $CMD
#
eval $CMD


echo
date
echo

CMD="$SAMT sort -@ 8 bams/${arr[0]}.bam -o bams/${arr[0]}_sorted.bam"

#
echo $CMD
#
eval $CMD

echo
date
echo

CMD="$SAMT stats bams/${arr[0]}_sorted.bam > bams/${arr[0]}_sorted_stats.txt"

#
echo $CMD
#
eval $CMD


echo
date
echo


# EOF.
