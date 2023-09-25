#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub sync_files.sh

#$ -cwd
#$ -S /bin/bash
#$ -N sync
#$ -e syncerr
#$ -o syncout
#$ -q (hoser|bassil)
# $ -pe thread 3
# $ -pe thread 10
# $ -pe thread 20
# #$ -l mem_free=10G
#$ -V
# #$ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)

# From man rsync:
# You can think of  a trailing  /  on  a source as meaning "copy the contents of this direc‐
# tory" as opposed to "copy the directory by name"

SRC="~/Vining_Lab_nfs4/Users/knausb/"
DEST="~/Vining_Lab_nfs7/Users/knausb"

CMD="rsync -avz $SRC $DEST"

echo $CMD

# Uncomment the following line to execute/evaluate.
# eval $CMD

# EOF.
