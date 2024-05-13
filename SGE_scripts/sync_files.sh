#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub sync_files.sh

#$ -cwd # Execute from current working directory.
#$ -V # Export current environment variables.
#$ -S /bin/bash # Use bash.
#$ -N sync # Job name.
#$ -e syncerr # Where to redirect standard error.
#$ -o syncout # Where to redirect standard out.
#$ -q (hoser) # Queue(s), regex style.
# $ -l mem_free=10G # Memory requirement.
# $ -pe thread 3 # Thread requirement.
# $ -h # Submit job with a hold.
# $ -t 1-2:1 # Task array for batch jobs.

# Create a 0-based counter from 1-based SGE.
#i=$(expr $SGE_TASK_ID - 1)


# From man rsync:
# You can think of  a trailing  /  on  a source as meaning "copy the contents of this direc‐
# tory" as opposed to "copy the directory by name"

SRC="~/Vining_Lab_nfs4/Users/knausb/"
# SRC="username@files.cgrb.oregonstate.edu:~/Vining_Lab_nfs4/Users/knausb/"
DEST="~/Vining_Lab_nfs7/Users/knausb"

CMD="rsync -avz $SRC $DEST"
# CMD="rsync -avz -e 'ssh -p 22' $SRC $DEST"

SECONDS=0

echo $CMD

# Uncomment the following line to execute/evaluate.
# eval $CMD

ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF.
