#!/bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N brkr2
#$ -e brkr2err
#$ -o brkr2out
#$ -q hoser
#$ -pe thread 8
# $ -pe thread 16
# $ -pe thread 10
# #$ -l mem_free=10G
#$ -V
# #$ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)

##### ##### ##### ##### #####

# https://github.com/Gaius-Augustus/BRAKER
# which braker.pl
# BRAKER="/local/cluster/BRAKER-2.1.5/scripts/braker.pl"
# 
BRAKER="~/gits/BRAKER/scripts/braker.pl"

braker.pl -version

# Ideally a "soft masked" genome.
GENOME="../repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna_nospace.fasta"
GNAME="Purple_Kush2"

# Does not like tilda expansion.
PROT_SEQ="/home/bpp/knausb/Vining_Lab_nfs4/Users/knausb/OrthoDB/proteins_plants_CBDRx.fasta"

##### ##### ##### ##### #####

echo
date

# export ALIGNMENT_TOOL_PATH=/local/cluster/ProtHint/bin
# 
export ALIGNMENT_TOOL_PATH=~/gits/ProtHint/bin
export PROTHINT_PATH=~/gits/ProtHint/bin

CMD="$BRAKER \
     --genome=$GENOME \
     --species=$GNAME \
     --prot_seq=$PROT_SEQ \
     --softmasking \
     --AUGUSTUS_CONFIG_PATH=/nfs4/HORT/Vining_Lab/Users/knausb/augustus_knausb/config/ \
     --epmode \
     --cores=8 \
     --workingdir=braker2"

# --gff3 flag does not appear to accomplish anything here.


#     --hints=$HINTS \
#     --ALIGNMENT_TOOL_PATH=/local/cluster/ProtHint/bin/ \
#        ALIGNMENT_TOOL_PATH=/local/cluster/ProtHint/bin


echo $CMD
eval $CMD

echo
date
echo

# EOF.
