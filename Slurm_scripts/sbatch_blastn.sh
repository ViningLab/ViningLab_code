#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_blastn.sh  
# squeue

#SBATCH --job-name=blastn
#SBATCH --error=blastn_%A.err
#SBATCH --output=blastn_%A.out
# SBATCH --partition=hoser
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
# SBATCH --cpus-per-task=8
#SBATCH --array=0-9

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

HOST=$(hostname)
echo ‘Running on host: %s\n’ $HOST

BASE_DIR="/nfs4/HORT/Vining_Lab/GENOMES/hemp/private_data/salk/releases/scaffolded"

MYSAMPS=( `ls $BASE_DIR`)

MYSAMPS=(${MYSAMPS[@]//EDTAOut*})
MYSAMPS=(${MYSAMPS[@]//scaffold*})

echo "${MYSAMPS[$i]}"

# SAMPDB="$BASE_DIR/${MYSAMPS[$i]}/blastdb_genomic/${MYSAMPS[$i]}"
SAMPDB="$BASE_DIR/${MYSAMPS[$i]}/blastdb_primary_high_confidence.proteins/${MYSAMPS[$i]}"
echo $SAMPDB

OUTF="${MYSAMPS[$i]}_blast.csv"

# QUERY="cesa_tair.FASTA"
QUERY="autoflower_CsAP2_CsPRR37.fasta"

# 
BLAST="~/bin/ncbi-blast-2.12.0+/bin/blastn"
# BLAST="~/bin/ncbi-blast-2.2.26+/bin/blastp"


##### ##### ##### ##### #####
##### ##### ##### ##### #####

if [ ! -d "$OUTF" ]; then
  echo "[CHECKPOINT] $OUTF does not exist, running new job."

  CMD="$BLAST -query $QUERY \
              -task blastn \
              -db $SAMPDB \
              -evalue 0.001 \
              -num_threads 1 \
              -outfmt '10 qseqid qlen sseqid slen qstart qend sstart send evalue bitscore score length pident nident mismatch positive gapopen gaps ppos sstrand' \
              -perc_identity 90 \
              -qcov_hsp_perc 90 \
              > $OUTF"

#              -mt_mode 1 \              

  echo $CMD
  #
  eval $CMD

fi

# c("qseqid","qlen","sseqid","slen","qstart","qend","sstart","send","evalue","bitscore","score","length","pident","nident","mismatch","positive","gapopen","gaps","ppos","sstrand")

# EOF.
