#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_hisat2.sh  
# squeue

#SBATCH --job-name=hs
#SBATCH --error=hs_%A.err
#SBATCH --output=hs_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
#SBATCH --ntasks=1
# SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
#SBATCH --cpus-per-task=8
#SBATCH --array=0-9

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

##### ##### ##### ##### #####

# http://daehwankimlab.github.io/hisat2/
# https://github.com/DaehwanKimLab/hisat2

#HISAT2="/local/cluster/hisat2-2.2.0/hisat2"
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




##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

echo
date

HOST=$(hostname)
echo ‘Running on host: %s\n’ $HOST 

CMD="$HISAT2 -x $SNAME \
     -p 8 \
     -1 ${arr[1]} \
     -2 ${arr[2]} \
     --rg-id ${arr[0]} \
     --rg LB:${arr[0]} \
     --rg PL:illumina \
     --rg SM:${arr[0]} \
     --rg PU:${arr[0]} \
     --dta | $SAMT view  -@ 8 -bh -S - > bams/${arr[0]}.bam"
     
#
echo $CMD
#eval $CMD


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


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF
