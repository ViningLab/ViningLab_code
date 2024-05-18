#!/bin/bash

# https://blog.ronin.cloud/slurm-intro/

# Submit to queue as follows.
# sbatch my_slurm.sh

#SBATCH --job-name=singlecpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

# Your script goes here
sleep 30
echo "hello"

# EOF.
