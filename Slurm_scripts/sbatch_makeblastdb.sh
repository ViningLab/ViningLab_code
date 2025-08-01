#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_makeblastdb.sh  
# squeue

#SBATCH --job-name=mkbdb
#SBATCH --error=mkbdb_%A.err
#SBATCH --output=mkbdb_%A.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

FASTA="hopCascade.fullAssembly.repeatFiltered.proteins.fasta"
TITLE="hopCascade"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

#  CMD="gunzip -c ../${MYSAMPS[$i]}.softmasked.fasta.gz | makeblastdb -in -  -dbtype nucl -title ${MYSAMPS[$i]} -out ${MYSAMPS[$i]}"

CMD="makeblastdb -in $FASTA -dbtype prot -title $TITLE -out $TITLE"

echo $CMD
eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF.
