#!/bin/env bash

# This script should be submitted to the queue as follows.
# qsub make_blastdb.sh

#$ -cwd
#$ -S /bin/bash
#$ -N blstdb
#$ -e blstdberr
#$ -o blstdbout
#$ -q hoser
# $ -pe thread 4
# $ -pe thread 10
# $ -pe thread 20
# #$ -l mem_free=10G
#$ -V
# $ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)

##### ##### ##### ##### #####

INFASTA="../GCA_000230575.5_ASM23057v5_genomic.fna"
SNAME="Purple_Kush"
BLAST="/local/cluster/ncbi-blast+/bin/makeblastdb"

CMD="$BLAST -dbtype nucl -in $INFASTA -title $SNAME -out $SNAME"

echo $CMD
#
eval $CMD

# EOF.
