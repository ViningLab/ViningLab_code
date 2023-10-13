#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub run_bwa_hic.sh

#$ -cwd # Execute from current working directory.
#$ -S /bin/bash # Use bash.
#$ -N bwa # Job name.
#$ -e bwaerr # Where to redirect standard error.
#$ -o bwaout # Where to redirect standard out.
#$ -q (hoser) # Queue(s), regex style.
# $ -l mem_free=10G # Memory requirement.
#$ -pe thread 4 # Thread requirement.
#$ -V # Export current environment variables.
# $ -h # Submit job with a hold.
# $ -t 1-2:1 # Task array for batch jobs.

# Create a 0-based counter from 1-based SGE.
#i=$(expr $SGE_TASK_ID - 1)

echo "Using shell: "$0
echo "PATH:"
echo $PATH
echo


##### ##### ##### ##### #####
# Report what we ended up with

echo -n "Running on: "
hostname
echo "SGE job id: $JOB_ID"
date
echo

##### ##### ##### ##### #####
# Manage data dir and go there.

ORIG_DIR=`pwd`
DATA_DIR='/data/'$USER'_'$JOB_ID

# if [ ${DATA_DIR: -1} ]; then
#   echo "DATA_DIR is not terminated with a forward slash, adding it now."
#   DATA_DIR=$DATA_DIR"/"
# fi

if [[ "$DATA_DIR" == *\/ ]]; then
  echo "DATA_DIR is terminated with a forward slash, removing it now."
  DATA_DIR=${DATA_DIR::-1}
  echo "yes";
fi

if [ ! -d "$DATA_DIR" ]; then
  echo "$DATA_DIR does not exist, creating it now."
  CMD="mkdir $DATA_DIR"
  echo $CMD
  eval $CMD
fi

cd $DATA_DIR

# We need a full PATH for input files so we can access them from /data.
# GENOME="GCF_900626175.2_cs10_genomic_rehead.fna"
# readlink -f GCF_900626175.2_cs10_genomic_rehead.fna 
GENOME="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/EDTA/GCF_900626175.2_cs10_genomic_rehead.fna"

CMD="EDTA.pl --genome $GENOME --anno 1 --sensitive 1 --threads 1"

# Usage: bwa mem [options] <idxbase> <in1.fq> [in2.fq]
# -t INT        number of threads [1]
# -R STR        read group header line such as '@RG\tID:foo\tSM:bar' [null]
# -o FILE       sam file to output results to [stdout]
# -T INT        minimum score to output [30]
# -q, --min-MQ INT           ...have mapping quality >= INT
# -M            mark shorter split hits as secondary

#CMD="$BWA mem -M -R \"$RG\" $BREF ${arr[1]} ${arr[2]} > sams/${arr[0]}.sam"
CMD="bwa mem -t 4 $REF $FASTQ1 $FASTQ2 | samtools view -@ 4 --bam --with-header > my.bam"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

echo $CMD

# Uncomment the following line to execute/evaluate.
# eval $CMD

# If you need an example output.
# CMD="date > my_date.txt"
# echo $CMD
# eval $CMD

##### ##### ##### ##### #####
# Return to original dir, copy your results.

cd $ORIG_DIR

DEST="."

CMD="rsync -avz $DATA_DIR $DEST"

echo $CMD
eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


# EOF.
