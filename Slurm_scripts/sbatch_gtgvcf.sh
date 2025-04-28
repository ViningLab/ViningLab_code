#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_gtgvcf.sh  
# squeue

#SBATCH --job-name=gtgvcf
#SBATCH --error=gatkerr/gtgvcf_%A_%a.err
#SBATCH --output=gatkout/gtgvcf_%A_%a.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
# SBATCH --partition=green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
# SBATCH --cpus-per-task=8
# SBATCH --array=0-2
# SBATCH --array=0-9
# SBATCH --array=15-15

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"

HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

GREF="~/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Pink_pepper/gatk_dict/GCF_029168945.1_ASM2916894v1_genomic.fna"

JAVA="/home/bpp/knausb/bin/javadir/jre1.8.0_25/bin/java"
GATK="~/bin/gatk4/gatk-4.1.4.1/gatk"

##### ##### ##### ##### #####
# GenomicsDBImport
# https://gatk.broadinstitute.org/hc/en-us/articles/360057439331-GenomicsDBImport

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

#NC_083601.1:1-75645423

CMD="$GATK --java-options \"-Xmx4g\" \
       GenotypeGVCFs \
       -R $GREF \
       -V gendb://my_database \
       -L NC_083601.1:10000-100000 \
       -O vcfs/chr1.vcf.gz"

#
echo $CMD
#
eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


##### ##### ##### ##### #####
# EOF.
