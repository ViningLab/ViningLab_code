#!/bin/env bash

# Submit job as follows.
# sbatch run_busco.sh  
# squeue

#SBATCH --job-name=busco
#SBATCH --error=busco_%A.err
#SBATCH --output=busco_%A.out
# SBATCH --partition=hoser
#SBATCH --ntasks=1
# SBATCH --cpus-per-task=1
#SBATCH --cpus-per-task=4

# busco --list-datasets

#         - chlorophyta_odb10
#         - embryophyta_odb10
#             - liliopsida_odb10
#                 - poales_odb10
#             - eudicots_odb10
#                 - brassicales_odb10
#                 - fabales_odb10
#                 - solanales_odb10

# Lineage
# Eudicots
MYLINEAGE="/nfs3/HORT/Vining_Lab/GENOMES/hemp/CBDRx/GCF_900626175/busco/busco_eudicots/busco_downloads/lineages/eudicots_odb10/"


##### ##### ##### ##### #####

# MYREF="../../rice_hifiasm.bp.hap1.p_ctg.fa"
# MYSAMP="rice_hap1"

# 
MYREF="../braker3_v1/braker.aa"
# 
MYSAMP="PK_braker3_1"

##### ##### ##### ##### #####

date
echo

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

# Script to activate conda.
MYCMD="source /local/cluster/busco/activate.sh"
echo $MYCMD
eval $MYCMD

MYCMD="which busco"
eval $MYCMD
MYCMD="busco --version"
echo

# busco -i [SEQUENCE_FILE] -l [LINEAGE] -o [OUTPUT_NAME] -m [MODE] [OTHER OPTIONS]

# Genome.
# MYCMD="busco -i $MYREF -l $MYLINEAGE -o $MYSAMP -m genome --offline --cpu 1"

# Protein.
MYCMD="busco -i $MYREF -l $MYLINEAGE -o $MYSAMP -m proteins --offline --cpu 4"

echo $MYCMD

#
eval $MYCMD

echo
date


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


# EOF.
