#!/bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N rtag1
#$ -e rterr
#$ -o rtout
# $ -q hoser
#$ -pe thread 8
# $ -pe thread 10
# #$ -l mem_free=10G
#$ -V
# #$ -h
# $ -t 1-1:1
# $ -t 2-2:1
# $ -t 3-3:1
# $ -t 4-4:1


# i=$(expr $SGE_TASK_ID - 1)

##### ##### ##### ##### #####

RAGT="/local/cluster/bin/ragtag_scaffold.py"

# usage: ragtag.py scaffold <reference.fa> <query.fa>
REF="~/Vining_Lab_nfs4/GENOMES/hemp/private_data/salk/releases/scaffolded/EH23a/EH23a.softmasked.fasta"
# QUERY="../CBR_1.asm.bp.hap1.p_ctg.gfa.fa"
# QUERY="../CBR_1.asm.bp.hap2.p_ctg.gfa.fa"
QUERY="../CBY_1.asm.bp.hap1.p_ctg.gfa.fa"

CMD="$RAGT $REF $QUERY -o ./ragtag_output -u -t 8"

echo
date

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

#
echo $CMD
# eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


# EOF.
