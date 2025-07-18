#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_InterProScan.sh  
# squeue

#SBATCH --job-name=ips
#SBATCH --error=ips_eo/ips_%A.err
#SBATCH --output=ips_eo/ips_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16


i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

HOST=$(hostname)
echo "Running on host: $HOST"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

IPS="/local/cqls/opt/x86_64/bin/interproscan.sh"
# MY_FASTA="booth_terpene_pathway_10seq.fasta"
MY_FASTA="booth_terpene_pathway.fasta"

CMD="$IPS \
    --output-file-base tpath10seq/tpath10seq \
    --cpu 16 \
    --formats tsv \
    --goterms \
    --input $MY_FASTA \
    --iprlookup \
    --pathways \
    --tempdir /scratch \
    --output-tsv-version"


echo $CMD
eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF.
