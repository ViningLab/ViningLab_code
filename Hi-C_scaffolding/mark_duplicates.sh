#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub mark_duplicates.sh

# One complete run will require ~30 GB of drive space.

#$ -S /bin/bash # Use bash.
#$ -cwd               # Execute from current working directory.
#$ -V                 # Export current environment variables
#$ -N PA99_mkdups     # Job name.
#$ -e PA99_mkdupserr  # Where to redirect standard error.
#$ -o PA99_mkdupsout  # Where to redirect standard out.
#$ -q (hoser)         # Queue(s), regex style.
# $ -l mem_free=10G   # Memory requirement.
# $ -pe thread 3      # Thread requirement.
.
SAMT="~/bin/samtools-1.9/samtools-1.9/samtools "

# MarkDuplicates (Picard)
# SortSam (Picard)
# https://gatk.broadinstitute.org/hc/en-us/articles/360037225972-MarkDuplicates-Picard-
# http://broadinstitute.github.io/picard/
# http://broadinstitute.github.io/picard/command-line-overview.html
PICARD="/local/cluster/picard"

JAVA="java"

##report versions of softwares

# Java version.
echo "java info"
CMD="$JAVA -version 2>&1"
echo $CMD
eval $CMD
echo

# Picard version.
echo "picard info"
CMD="$JAVA -jar $PICARD MarkDuplicates --version 2>&1"
echo $CMD
eval $CMD
echo

echo "samtools info"
CMD="$SAMT --version"
echo
eval $CMD
echo

# Sort
##first line is basically java creating and using a temp-dir for running the job
CMD="$JAVA -Djava.io.tmpdir=/data/ \
     -jar $PICARD SortSam \
     I=myPA99.bam \
     O=myPA99_sorted.bam \
     TMP_DIR=/data/ \
     SORT_ORDER=coordinate"

date
echo
echo $CMD
eval $CMD
echo
date
echo

# Mark duplicates
CMD="$JAVA -Djava.io.tmpdir=/data/ \
     -jar $PICARD MarkDuplicates \
     I=myPA99_sorted.bam \
     O=myPA99_dupmk.bam \
     MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=8000 \
     ASSUME_SORT_ORDER=coordinate \
     M=myPA99_marked_dup_metrics.txt"

#date
#echo
echo $CMD
eval $CMD
echo
date
echo

##### ##### ##### ##### #####
# Index
#CMD="$SAMT index $TEMP${arr[0]}_sorted.bam"
CMD="$SAMT index myPA99_dupmk.bam"
echo $CMD
eval $CMD
echo
date
echo


# Generate stats to validate the bam.
CMD="$SAMT stats myPA99_dupmk.bam | gzip -c > myPA99_dupmark_stats.txt.gz"
echo $CMD
eval $CMD


# EOF.
