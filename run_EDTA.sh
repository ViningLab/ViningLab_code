#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub run_EDTA.sh

#$ -cwd
#$ -S /bin/bash
#$ -N EDTA
#$ -e EDTAerr
#$ -o EDTAout
#$ -q (hoser)
# $ -l mem_free=10G
# $ -pe thread 3
#$ -V
# $ -h
# $ -t 1-2:1

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

if [ ${DATA_DIR: -1} ]; then
  echo "DATA_DIR is not terminated with a forward slash, adding it now."
  DATA_DIR=$DATA_DIR"/"
fi

if [ ! -d "$DATA_DIR" ]; then
  echo "$DATA_DIR does not exist, creating it now."
  CMD="mkdir $DATA_DIR"
  echo $CMD
  eval $CMD
fi

cd $DATA_DIR

##### ##### ##### ##### #####

# Script to activate conda.
# eval "$(/local/cluster/miniconda3_base/bin/conda shell.bash hook)"
# conda activate /local/cluster/EDTA-1.9.6
MYCMD="source /local/cluster/EDTA-1.9.6/activate.sh"
echo $MYCMD
eval $MYCMD

#eval "$(conda shell.bash hook)"
#conda activate /nfs4/HORT/Vining_Lab/Users/talbots/bin/EDTA

# --sensitive   [0|1]   Use RepeatModeler to identify remaining TEs (1) or not (0,
#                       default). This step is slow but MAY help to recover some TEs.
# --anno        [0|1]   Perform (1) or not perform (0, default) whole-genome TE annotation
#                       after TE library construction.

# MY_EDTA="/local/cluster/EDTA-1.9.6/share/EDTA/EDTA.pl"

# We need a full PATH for input files so we can access them from /data.
# GENOME="GCF_900626175.2_cs10_genomic_rehead.fna"
# readlink -f GCF_900626175.2_cs10_genomic_rehead.fna 
GENOME="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/EDTA/GCF_900626175.2_cs10_genomic_rehead.fna"

CMD="EDTA.pl --genome $GENOME --anno 1 --sensitive 1 --threads 1"

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
