#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_hisat2_build.sh  
# squeue

#SBATCH --job-name=hsbuild
#SBATCH --error=hsbuild_%A.err
#SBATCH --output=hsbuild_%A.out
# SBATCH --partition=hoser
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4

##### ##### ##### ##### #####

# http://daehwankimlab.github.io/hisat2/
# https://github.com/DaehwanKimLab/hisat2

#HISAT2="/local/cluster/hisat2-2.2.0/hisat2"
HISAT2="hisat2"

#GENOME="../repeatmodeler/GCA_016165845.1_Cannbio-2_genomic.fna.masked "
#SNAME="Cannbio-2"
GENOME="../repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna.masked"
SNAME="Purpl_Kush"

##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

echo
date

HOST=$(hostname)
echo ‘Running on host: %s\n’ $HOST 

# hisat2-build genome.fa genome
CMD="$HISAT2-build $GENOME $SNAME"

#
echo $CMD
#eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF
