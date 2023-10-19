#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub mark_duplicates.sh

# One complete run will require ~30 GB of drive space.

#$ -S /bin/bash       # Use bash.
#$ -cwd               # Execute from current working directory.
#$ -V                 # Export current environment variables
#$ -N mkdups          # Job name.
#$ -e mkdupserr       # Where to redirect standard error.
#$ -o mkdupsout       # Where to redirect standard out.
#$ -q (hoser)         # Queue(s), regex style.
# $ -l mem_free=10G   # Memory requirement.
# $ -pe thread 3      # Thread requirement.

MY_SAMPLE_NAME="myPA99"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

# SAMT="~/bin/samtools-1.9/samtools-1.9/samtools"
SAMT="samtools"

# MarkDuplicates (Picard)
# SortSam (Picard)
# https://gatk.broadinstitute.org/hc/en-us/articles/360037225972-MarkDuplicates-Picard-
# http://broadinstitute.github.io/picard/
# http://broadinstitute.github.io/picard/command-line-overview.html
PICARD="/local/cluster/picard"

JAVA="java"

# Report versions of software.

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
     I="$MY_SAMPLE_NAME".bam \
     O="$MY_SAMPLE_NAME"_sorted.bam \
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
     I="$MY_SAMPLE_NAME"_sorted.bam \
     O="$MY_SAMPLE_NAME"_dupmk.bam \
     MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=8000 \
     ASSUME_SORT_ORDER=coordinate \
     M="$MY_SAMPLE_NAME"_marked_dup_metrics.txt"

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
CMD="$SAMT index "$MY_SAMPLE_NAME"_dupmk.bam"
echo $CMD
eval $CMD
echo
date
echo


# Generate stats to validate the bam.
CMD="$SAMT stats "$MY_SAMPLE_NAME"_dupmk.bam | gzip -c > "$MY_SAMPLE_NAME"_dupmark_stats.txt.gz"
echo $CMD
eval $CMD


# EOF.
