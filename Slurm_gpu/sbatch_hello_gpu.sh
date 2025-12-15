#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_hello_gpu.sh  
# squeue

# salloc --account=boris --partition=boris --gpus-per-node=1 --mem=4000M
# nvidia-smi
# watch -d -n 0.5 nvidia-smi
# squeue -o"%.7i %.9P %.8j %.8u %.2t %.10M %.6D %C" | less -S
# sinfo -o "%n %e %m %a %c %C" | less

# https://docs.alliancecan.ca/wiki/Using_GPUs_with_Slurm
# https://numba.pydata.org/numba-doc/dev/user/5minguide.html


#SBATCH --job-name=sbhello
#SBATCH --error=sbhello_%A.err
#SBATCH --output=sbhello_%A.out
#SBATCH --account=boris,green
#SBATCH --partition=all.q,boris,green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
#SBATCH --gpus-per-node=1
#SBATCH --mem=4000M


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
