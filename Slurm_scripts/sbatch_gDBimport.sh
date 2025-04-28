# Submit job as follows.
# sbatch sbatch_gDBimport.sh  
# squeue

#SBATCH --job-name=DBimport
#SBATCH --error=gatkerr/gDBimport_%A.err
#SBATCH --output=gatkout/gDBimport_%A.out
# SBATCH --error=gatkerr/gDBimport_%A_%a.err
# SBATCH --output=gatkout/gDBimport_%A_%a.out
#SBATCH --account=green
#SBATCH --partition=all.q,green
# SBATCH --partition=green
#SBATCH --exclude=aspen9,aspen15
# SBATCH --mem-per-cpu=4G
#SBATCH --mem-per-cpu=8G
#SBATCH --ntasks=1
# SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=4
#SBATCH --cpus-per-task=16
#SBATCH --array=0-1
# SBATCH --array=0-2
# SBATCH --array=0-9
# SBATCH --array=15-15

i=${SLURM_ARRAY_TASK_ID}
#CMD="This is array task ${SLURM_ARRAY_TASK_ID}"
#echo $CMD

HOST=$(hostname)
echo "Running on host: $HOST"

##### ##### ##### ##### #####

MY_INTERVALS=( `cat "intervals.list" `)

##### ##### ##### ##### #####

JAVA="/home/bpp/knausb/bin/javadir/jre1.8.0_25/bin/java"
GATK="~/bin/gatk4/gatk-4.1.4.1/gatk"
GREF="~/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Pink_pepper/gatk_dict/GCF_029168945.1_ASM2916894v1_genomic.fna"

##### ##### ##### ##### #####
# GenomicsDBImport
# https://gatk.broadinstitute.org/hc/en-us/articles/360057439331-GenomicsDBImport

# MY_DB="my_database"
# MY_DB="fiber_hemp"
# MY_DB="PinkPepper_gDB_18seq"
MY_DB="PinkPepper_gDB"
MY_DB="${MY_DB}_${MY_INTERVALS[$i]}"

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

# CMD="$GATK --java-options \"-Xmx4g -Xms4g\" \
CMD="$GATK --java-options \"-Xmx8g -Xms8g\" \
       GenomicsDBImport \
       -R $GREF \
       --genomicsdb-workspace-path $MY_DB \
       --batch-size 50 \
       --intervals ${MY_INTERVALS[$i]} \
       --sample-name-map cohort.sample_map \
       --tmp-dir /scratch/ \
       --reader-threads 16"

echo $CMD
#
eval $CMD

#       --intervals intervals.list \

# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


##### ##### ##### ##### #####
# EOF.
