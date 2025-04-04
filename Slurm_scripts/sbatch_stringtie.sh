#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_stringtie.sh  
# squeue

#SBATCH --job-name=strtie
#SBATCH --error=stringtie_eo/stringtie_%A_%a.err
#SBATCH --output=stringtie_eo/stringtie_%A_%a.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
#SBATCH --array=0-2
# SBATCH --array=3-23

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

HOST=$(hostname)
echo 'Running on host:' $HOST 

##### ##### ##### ##### #####

# https://github.com/gpertea/stringtie

STRINGTIE="/local/cqls/opt/x86_64/bin/stringtie"

ANNOTATIONS="/nfs7/HORT/Vining_Lab/Users/knausb/hop_hemp/Hop_Lillian/combinedGeneModels_minLen100.fullAssembly.repeatFiltered.gff"

##### ##### ##### ##### #####

# Input file containing sample name and FASTQ locations.
FILE=( `cat "samples.txt" `)
IFS=';' read -a arr <<< "${FILE[$i]}"
echo "${arr[1]}"

##### ##### ##### ##### #####


# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

echo
date

HOST=$(hostname)
echo 'Running on host:' $HOST 

DIRECTORY="stringtie_gtf"
if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does not exist, creating it now."
  mkdir $DIRECTORY
fi

DIRECTORY="stringtie_gtf/${arr[0]}"
if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does not exist, creating it now."
  mkdir $DIRECTORY
fi

# To combine individual gtf files into a count table, use prepDE.py.
# The software prepDE.py will expect a directory structure.
# https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual#deseq

CMD="$STRINGTIE \
        -e \
        -G $ANNOTATIONS \
        -p 1 \
        -o stringtie_gtf/"${arr[0]}"/"${arr[0]}"_stringtie.gtf bams/"${arr[0]}"_sorted.bam"

#
echo $CMD
#
eval $CMD


echo
date
echo


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF
