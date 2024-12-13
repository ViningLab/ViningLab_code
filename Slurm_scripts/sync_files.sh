#!/usr/bin/env bash

# Submit job as follows.
# sbatch sync_files.sh  
# squeue

#SBATCH --job-name=sync
#SBATCH --error=sync_%A.err
#SBATCH --output=sync_%A.out
# SBATCH --partition=hoser
#SBATCH --ntasks=1
# SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=8


# From man rsync:
# You can think of  a trailing  /  on  a source as meaning "copy the contents of this direc‐
# tory" as opposed to "copy the directory by name"

SRC="/nfs2/hts/nextseq/241114_VH00571_494_AAGCL2KM5/L1-dual-8bp-0mm"
DEST="/nfs7/HORT/Vining_Lab/RawData/hemp/Illumina/hop_hemp"

CMD="rsync -avz $SRC $DEST"

SECONDS=0

echo $CMD

# Uncomment the following line to execute/evaluate.
eval $CMD

ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF.
