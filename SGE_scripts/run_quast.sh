#!/bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N qst
#$ -e qsterr
#$ -o qstout
#$ -q hoser
# $ -pe thread 4
# #$ -l mem_free=10G
#$ -V
# $ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)

##### ##### ##### ##### #####
# 

# $ which quast.py
# /local/cluster/bin/quast.py

CMD="quast.py --threads 1 ../m64013e_210227_222017.hifi_reads.fasta.gz"

date

echo $CMD
# eval $CMD

date


# EOF.
