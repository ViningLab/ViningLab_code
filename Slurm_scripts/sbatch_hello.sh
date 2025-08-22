#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_hello.sh  
# squeue

# srun --account=green --partition=green --pty bash

#SBATCH --job-name=sbhello
#SBATCH --error=sbhello_%A.err
#SBATCH --output=sbhello_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
# SBATCH --partition=green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
# SBATCH --cpus-per-task=8
# SBATCH --array=0-9
# SBATCH --array=15-15

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

CMD="Hello SLURM!"
echo $CMD

CMD="sleep 5"
echo $CMD
eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

##### ##### ##### ##### #####
# EOF.
