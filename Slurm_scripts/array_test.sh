#!/bin/bash

# Submit job as follows.
# sbatch array_test.sh  
# squeue

#SBATCH --job-name=myarrayjob
#SBATCH --partition=hoser
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=0-9

CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

sleep 10
echo $CMD
# eval $CMD

# EOF.
