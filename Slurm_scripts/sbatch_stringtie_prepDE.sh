#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_stringtie_prepDE.sh  
# squeue

#SBATCH --job-name=prepDE
#SBATCH --error=prepDE_%A.err
#SBATCH --output=prepDE_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
# SBATCH --partition=green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
# SBATCH --cpus-per-task=8
# SBATCH --array=0-9
# SBATCH --array=0-23



HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

CMD="python3 ~/gits/stringtie/prepDE.py3 -i stringtie_gtf/"
echo $CMD
eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

##### ##### ##### ##### #####
# EOF.
