#!/bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N busco
#$ -e buscerr
#$ -o buscout
#$ -q hoser
# $ -pe thread 4
# $ -pe thread 10
# #$ -l mem_free=10G
#$ -V
# #$ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)

##### ##### ##### ##### #####


# busco --list-datasets

#     - viridiplantae_odb10
#         - chlorophyta_odb10
#         - embryophyta_odb10
#             - liliopsida_odb10
#                 - poales_odb10
#             - eudicots_odb10
 #                - brassicales_odb10
 #                - fabales_odb10
 #                - solanales_odb10

# Lineage
# Eudicots
MYLINEAGE="/nfs3/HORT/Vining_Lab/GENOMES/hemp/CBDRx/GCF_900626175/busco/busco_eudicots/busco_downloads/lineages/eudicots_odb10/"


##### ##### ##### ##### #####

MYREF="../../rice_hifiasm.bp.hap1.p_ctg.fa"
MYSAMP="rice_hap1"

##### ##### ##### ##### #####

date
echo


# Script to activate conda.
MYCMD="source /local/cluster/busco/activate.sh"
echo $MYCMD
eval $MYCMD

MYCMD="which busco"
eval $MYCMD
MYCMD="busco --version"
echo

# busco -i [SEQUENCE_FILE] -l [LINEAGE] -o [OUTPUT_NAME] -m [MODE] [OTHER OPTIONS]
#busco -i ../GCF_900626175.2_cs10_genomic.fna -l eudicots_odb10 -o cbdrx_busco -m genome 


MYCMD="busco -i $MYREF -l $MYLINEAGE -o $MYSAMP -m genome --offline --cpu 1"

echo $MYCMD

#
eval $MYCMD

echo
date


# EOF.
