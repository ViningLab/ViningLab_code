#! /bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N jfish
#$ -e jferr
#$ -o jfout
#$ -q hoser
# $ -pe thread 4
#$ -pe thread 16
# $ -pe thread 10
# $ -pe thread 20
# #$ -l mem_free=10G
#$ -V
# $ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)

# https://github.com/gmarcais/Jellyfish

# JFISH="/local/cluster/bin/jellyfish_1.0.2"
JFISH="/local/cluster/bin/jellyfish"

# jellyfish_1.0.2 count --help

# 
CMD="$JFISH count -m 21 -s 100 -t 16 ../m64013e_210227_222017.hifi_reads.fasta.gz"

date

echo $CMD
#
eval $CMD

date


# 
CMD="$JFISH histo -o mer.histo mer_counts.jf"

date

echo $CMD
#
eval $CMD

date


# EOF.
