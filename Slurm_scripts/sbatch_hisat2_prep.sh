#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_hisat2_prep.sh  
# squeue

#SBATCH --job-name=hsprep
#SBATCH --error=hsprep_%A.err
#SBATCH --output=hsprep_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4

##### ##### ##### ##### #####

# http://daehwankimlab.github.io/hisat2/
# https://github.com/DaehwanKimLab/hisat2

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

CMD="agat_convert_sp_gff2gtf.pl --gff ../combinedGeneModels_minLen100.fullAssembly.repeatFiltered.gff -o hopCascade.gtf"

echo $CMD
#eval $CMD

GTF="hopCascade.gtf"
# CMD="python hisat2_extract_splice_sites.py $GTF > splicesites.txt"
CMD="hisat2_extract_splice_sites.py $GTF > splicesites.txt"

echo $CMD
#
eval $CMD

# CMD="python hisat2_extract_exons.py $GTF > exons.txt"
CMD="hisat2_extract_exons.py $GTF > exons.txt"

echo $CMD
#
eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


# EOF.
