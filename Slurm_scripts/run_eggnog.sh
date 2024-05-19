#!/bin/env bash

# Submit job as follows.
# sbatch run_eggnog.sh  
# squeue

#SBATCH --job-name=eggnog
#SBATCH --error=eggnog_%A.err
#SBATCH --output=eggnog_%A.out
# SBATCH --partition=hoser
#SBATCH --ntasks=1
# SBATCH --cpus-per-task=1
#SBATCH --cpus-per-task=8


MY_PROTEINS="../braker/PK_hap1_proteins.faa"
ONAME="PK_hap1"

# Eggnog mapper.
EMAPPER="/home/bpp/knausb/Vining_Lab_nfs4/Users/knausb/opt/conda/envs/snowflakes/bin/emapper.py"

# Conda.
CMD="conda activate snowflakes"
#
echo $CMD
#
eval $CMD

CMD="export EGGNOG_DATA_DIR=~/Vining_Lab_nfs4/Users/knausb/opt/eggnog-mapper-data"
echo $CMD
eval $CMD

echo
date

# Implement Eggnog.

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

CMD="$EMAPPER \
    -i $MY_PROTEINS \
    --cpu 8 \
    --decorate_gff yes \
    -o $ONAME"

echo $CMD
eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF.
