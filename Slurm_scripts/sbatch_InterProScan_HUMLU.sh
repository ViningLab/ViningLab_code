#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_InterProScan.sh  
# squeue

#SBATCH --job-name=ips
#SBATCH --error=ips_eo/ips_%A.err
#SBATCH --output=ips_eo/ips_%A.out
# SBATCH --account=green
# SBATCH --partition=all.q,green
#SBATCH --partition=all.q
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
# SBATCH --cpus-per-task=16
#SBATCH --cpus-per-task=32


HOST=$(hostname)
echo "Running on host: $HOST"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

IPS="/local/cqls/opt/x86_64/bin/interproscan.sh"

# https://interproscan-docs.readthedocs.io/en/v5/InputFormat.html
# InterProScan 5 supports unaligned sequences only. 
# Sequences should contain only valid IUPAC amino acid or nucleic acid characters.
# In addition gap (‘-‘), period (‘.’), asterisk or underscore symbols are not allowed and should produce warnings and InterProScan will exit immediately.

# MY_FASTA="EH23b.primary_high_confidence.proteins.fasta"
MY_FASTA="hopCascade.fullAssembly.repeatFiltered.proteins.fasta"

CMD="$IPS \
    --output-file-base HUMLU_CAS/HUMLU_CAS \
    --cpu 32 \
    --formats tsv,gff3 \
    --goterms \
    --input $MY_FASTA \
    --iprlookup \
    --pathways \
    --tempdir /scratch \
    --output-tsv-version"


echo $CMD
eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED

# EOF.
