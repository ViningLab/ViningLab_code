#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_bwa.sh  
# squeue

#SBATCH --job-name=bwa
#SBATCH --error=bwaerr/bwa%A_%a.err
#SBATCH --output=bwaout/bwa%A_%a.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
# SBATCH --partition=green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
# SBATCH --cpus-per-task=1
#SBATCH --cpus-per-task=8
#SBATCH --array=0-4
# SBATCH --array=0-254


i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

# https://github.com/lh3/bwa

BWA="bwa"
SAMT="samtools"

DBPREFIX="~/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Pink_pepper/bwa_index_genomic/Pink_pepper"

# Input file containing sample name and FASTQ locations.
FILE=( `cat "samples.txt" `)
IFS=';' read -a arr <<< "${FILE[$i]}"
echo "${arr[1]}"

# The GATK needs read group info:
# https://software.broadinstitute.org/gatk/guide/article?id=6472
# SM: sample
# LB: library, may be sequenced multiple times
# ID: Read Group Identifier, a unique identifier
# PL: Platform/technology used

RG="@RG\tID:${arr[0]}\tLB:${arr[0]}\tPL:illumina\tSM:${arr[0]}\tPU:${arr[0]}"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

NCPU=8

CMD="$BWA mem -t $NCPU -M -R \"$RG\" $DBPREFIX ${arr[1]} ${arr[2]} | $SAMT view -@ $NCPU -bh > bams/"${arr[0]}".bam"


#
echo $CMD
#
eval $CMD


CMD="$SAMT sort -@ $NCPU bams/${arr[0]}.bam -o bams/${arr[0]}_sorted.bam"

#
echo $CMD
#
eval $CMD

CMD="$SAMT stats bams/${arr[0]}_sorted.bam > bams/${arr[0]}_sorted_stats.txt"

#
echo $CMD
#
eval $CMD

echo
date
echo

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


##### ##### ##### ##### #####
# EOF.
