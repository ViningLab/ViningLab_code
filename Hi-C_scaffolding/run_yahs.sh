#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub run_yahs.sh

#$ -cwd # Execute from current working directory.
#$ -S /bin/bash # Use bash.
#$ -N YAHS # Job name.
#$ -e YAHSerr # Where to redirect standard error.
#$ -o YAHSout # Where to redirect standard out.
#$ -q (hoser) # Queue(s), regex style.
# $ -l mem_free=10G # Memory requirement.
# $ -pe thread 3 # Thread requirement.
#$ -V # Export current environment variables.
# $ -h # Submit job with a hold.

YAHS=""
# samtools faidx reference.
REF=""
HiCBAM=""

CMD="$YAHS --version"
echo $CMD
eval $CMD

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

CMD="$YAHS $REF $HiCBAM"
echo $CMD
eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


# EOF.
