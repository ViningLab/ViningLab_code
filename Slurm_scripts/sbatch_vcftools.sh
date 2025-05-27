#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_vcftools.sh  
# squeue

#SBATCH --job-name=vcfTls
#SBATCH --error=vcfTls_%A_%a.err
#SBATCH --output=vcfTls_%A_%a.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
#SBATCH --ntasks=1
# SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
# SBATCH --cpus-per-task=8
# SBATCH --array=0-2
#SBATCH --array=0-17

i=${SLURM_ARRAY_TASK_ID}


##### ##### ##### ##### #####

VCFTOOLS="/local/cqls/opt/x86_64/bin/vcftools"

##### ##### ##### ##### #####

files=(../vcfs/*.vcf.gz)
prefix="../vcfs/"
suffix=".vcf.gz"

string=${files[$i]}
my_sample=${string#"$prefix"}
my_sample=${my_sample%"$suffix"}

##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

echo
date

HOST=$(hostname)
echo ‘Running on host: ’ $HOST 

CMD="$VCFTOOLS \
     --gzvcf ../vcfs/$my_sample.vcf.gz \
     --remove-indels \
     --min-alleles 2 --max-alleles 2 \
     --maf 0.2 \
     --max-missing 0.8 \
     --minDP 2 \
     --recode \
     --stdout | gzip -c > $my_sample.recode.vcf.gz"

echo $CMD
# 
eval $CMD

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


# EOF.
