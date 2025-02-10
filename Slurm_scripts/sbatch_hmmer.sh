#!/usr/bin/env bash

#SBATCH --job-name=hmmer
#SBATCH --error=hmr_%A.err
#SBATCH --output=hmr_%A.out
# SBATCH --partition=green
#SBATCH --account=green
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
# SBATCH --cpus-per-task=8

HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

HMM="PF01161.hmm"
#SEQDB="/nfs4/HORT/Vining_Lab/GENOMES/hemp/private_data/salk/releases/scaffolded/EH23b/EH23b.primary_high_confidence.proteins.fasta.gz"
SAMPLE="EH23b"
SEQDB="/nfs4/HORT/Vining_Lab/GENOMES/hemp/private_data/salk/releases/scaffolded/"$SAMPLE"/"$SAMPLE".primary_high_confidence.proteins.fasta.gz"

CMD="hmmsearch -o "$SAMPLE"_hmmerout.txt --tblout "$SAMPLE"_tblout.txt $HMM $SEQDB"

echo $CMD
eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

##### ##### ##### ##### #####
# EOF.
