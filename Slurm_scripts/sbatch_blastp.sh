#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_blastp.sh  
# squeue

#SBATCH --job-name=blastp
#SBATCH --error=blastp_%A.err
#SBATCH --output=blastp_%A.out
# SBATCH --partition=hoser
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
# SBATCH --cpus-per-task=8
# SBATCH --array=0-9
#SBATCH --array=15-15

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

HOST=$(hostname)
echo ‘Running on host: %s\n’ $HOST

##### ##### ##### ##### #####

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
# QUERY="autoflower_CsAP2_CsPRR37.fasta"
QUERY="AutoflowerCandidates.FASTA"

# BLAST="~/bin/ncbi-blast-2.12.0+/bin/blastn"
# BLAST="~/bin/ncbi-blast-2.2.26+/bin/blastp"
BLAST="/local/cluster/micromamba/envs/ncbi-blast-2.15.0/scripts/blastp"

##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

echo
date

if [ ! -d "$OUTF" ]; then
  echo "[CHECKPOINT] $OUTF does not exist, running new job."

  CMD="$BLAST -query $QUERY \
              -task blastp \
              -db $SAMPDB \
              -evalue 0.001 \
              -mt_mode 1 \
              -num_threads 1 \
              -outfmt '10 qseqid qlen sseqid slen qstart qend sstart send evalue bitscore score length pident nident mismatch positive gapopen gaps ppos sstrand' \
              -qcov_hsp_perc 90 \
              > $OUTF"


  echo $CMD
  echo $CMD
  #
  eval $CMD

fi


echo
date
echo


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# c("qseqid","qlen","sseqid","slen","qstart","qend","sstart","send","evalue","bitscore","score","length","pident","nident","mismatch","positive","gapopen","gaps","ppos","sstrand")

##### ##### ##### ##### #####
# EOF.
