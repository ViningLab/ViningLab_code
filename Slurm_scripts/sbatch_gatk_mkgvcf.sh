#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_gatk_mkgvcf.sh  
# squeue

#SBATCH --job-name=gatk_mkgvcf
#SBATCH --error=gatkerr/gatk_kmgvcf_%A_%a.err
#SBATCH --output=gatkout/gatk_mkgvcf_%A_%a.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
# SBATCH --partition=green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
# SBATCH --cpus-per-task=8
# SBATCH --array=0-9
# SBATCH --array=15-15
# SBATCH --array=0-20%4

# https://stackoverflow.com/a/55431306
# scontrol update ArrayTaskThrottle=<count> JobId=<jobID>

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

# GATK reference
# GREF="gatkref/pinfsc50b.fa"
GREF="~/Vining_Lab_nfs3/GENOMES/hemp/ERBxHO40_23/20210603_dovetail/ERBxHO40_23_C
OMBINED-Hap1_ORE2398_Cannabis_sativa_HiRise/gatkdb/ERBxHO40_23_hirisehap1.fa"

# Samples file
FILE=( `cat "samples.txt" `)
IFS=';' read -a arr <<< "${FILE[$i]}"
echo "${arr[1]}"

##### ##### ##### ##### #####

SAMT="~/bin/samtools-1.9/samtools-1.9/samtools "

# MarkDuplicates (Picard)
# SortSam (Picard)
# https://gatk.broadinstitute.org/hc/en-us/articles/360037225972-MarkDuplicates-
Picard-
# http://broadinstitute.github.io/picard/
# http://broadinstitute.github.io/picard/command-line-overview.html
PICARD="~/bin/picard/picard_2.21.6/picard.jar"

# https://gatk.broadinstitute.org/hc/en-us/sections/360007226651-Best-Practices-
Workflows

GATK="~/bin/gatk4/gatk-4.1.4.1/gatk"
JAVA="/home/bpp/knausb/bin/javadir/jre1.8.0_25/bin/java"

##### ##### ##### ##### #####

# Mark duplicates
CMD="$JAVA -Djava.io.tmpdir=/data/ \
     -jar $PICARD MarkDuplicates \
     I=bams/${arr[0]}_sorted.bam \
     O=bams/${arr[0]}_dupmrk.bam \
     MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=8000 \
     ASSUME_SORT_ORDER=coordinate \
     M=bams/${arr[0]}_marked_dup_metrics.txt"

#date
#echo
echo $CMD
#
#eval $CMD


##### ##### ##### ##### #####


CMD="$GATK --java-options \"-Djava.io.tmpdir=/data/ -Xmx4g\" HaplotypeCaller \
   -R $GREF \
   -I bams/${arr[0]}_dupmrk.bam \
   -O gvcf/${arr[0]}.g.vcf.gz \
   -ERC GVCF"

#   -I $TEMP${arr[0]}_sorted.bam \


echo
echo $CMD
if [[ $EVAL == "TRUE" ]]; then
  eval $CMD
fi
echo



##### ##### ##### ##### #####
# EOF.
