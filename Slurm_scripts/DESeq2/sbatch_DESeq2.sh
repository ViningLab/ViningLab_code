#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_DESeq2.sh
# squeue

#SBATCH --job-name=DESeq2
#SBATCH --error=DESeq2%A.err
#SBATCH --output=DESeq2%A.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=2

HOST=$(hostname)
echo "Running on host: $HOST"

# https://software.cqls.oregonstate.edu/tips/posts/new-r-guidance/

# bash
# source /local/cluster/micromamba/envs/R-4.3.1/activate.sh
eval "$(/local/cluster/miniconda3_base/bin/conda shell.bash hook)"
CMD="conda activate Rconda"
echo $CMD
eval $CMD

# 
CMD="Rscript HELLO_DESeq2.R"
# CMD="Rscript instpkgs.R"
# CMD="Rscript sim_DESeq2.R"
# CMD="Rscript pasilla_DESeq2.R"

echo $CMD
eval $CMD

# EOF.
