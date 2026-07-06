#!/usr/bin/env bash

# Submit job as follows.
# sbatch sbatch_<job_name>.sh  
# squeue
# scontrol hold job_id

# https://docs.nvidia.com/clara/parabricks/latest/documentation/tooldocs/man_fq2bam.html

# hqavail --gpu --show-full
# salloc --account=boris --partition=boris --gpus-per-node=1 --mem=4000M
# salloc --account=papilio --partition=cqls_gpu
# salloc --account=cqls_gpu --partition=papilio

#salloc --account=cqls_gpu4 --partition=cqls_gpu
#papilio
#cqls-gpu4
#cqls-gpu3


# nvidia-smi
# watch -d -n 0.5 nvidia-smi
# squeue -o"%.7i %.9P %.8j %.8u %.2t %.10M %.6D %C" | less -S
# sinfo -o "%n %e %m %a %c %C" | less

# https://docs.alliancecan.ca/wiki/Using_GPUs_with_Slurm
# https://numba.pydata.org/numba-doc/dev/user/5minguide.html

#SBATCH --job-name=fq2b_gp0
# SBATCH --job-name=dpv_gp1
#SBATCH --error=stdeo/fq2b_%A_%a.err
#SBATCH --output=stdeo/fq2b_%A_%a.out
#SBATCH --account=boris
# SBATCH --account=boris,green
#SBATCH --partition=boris
# SBATCH --partition=all.q,boris,green
#SBATCH --exclude=aspen9
#SBATCH --ntasks=1
# Boris has 512 cores
# SBATCH --cpus-per-task=1
# SBATCH --cpus-per-task=6
# SBATCH --cpus-per-task=12
# SBATCH --cpus-per-task=24
#SBATCH --cpus-per-task=64 # Boris seems to top out at 56
# SBATCH --cpus-per-task=256
#SBATCH --gpus-per-node=1
# SBATCH --mem=16000M
# SBATCH --mem=32000M
#SBATCH --mem=48000M
#SBATCH --array=0-0%1
# SBATCH --array=1-10%1
# SBATCH --array=7-10%1
# SBATCH --array=11-20%1
# SBATCH --array=21-50%1


i=${SLURM_ARRAY_TASK_ID}
CMD="This is array task ${SLURM_ARRAY_TASK_ID}"
echo $CMD
eval $CMD

HOST=$(hostname)
echo "Running on host: $HOST"

# Input file containing sample name and FASTQ locations.
FILE=( `cat "samples.txt" `)
IFS=';' read -a arr <<< "${FILE[$i]}"
echo "${arr[1]}"

##### ##### ##### ##### #####

# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

# https://docs.sylabs.io/guides/latest/user-guide/index.html
# https://docs.sylabs.io/guides/3.5/user-guide/gpu.html

MY_SIF="/nfs4/HORT/Vining_Lab/Users/knausb/singularity_images/clara-parabricks_4.6.0-1.sif"

# MY_SAMPLE="OR-1_S1"
# MY_SAMPLE="OR-2_S2"
# MY_SAMPLE="OR-3_S3"
# MY_SAMPLE="OR-4_S4"

#BASE_DIR="/nfs4/HORT/Vining_Lab/Users/knausb/fiber_hemp/"
BASE_DIR="/nfs5/HORT/Vining_Lab/PROJECTS/hemp/fiber/growing_year_2025_variants/"

#REF_DIR="~/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Pink_pepper/"
#MY_REF="GCF_029168945.1_ASM2916894v1_genomic.fna.gz"
REF_DIR="~/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Pink_pepper/gatk_dict/"
REF_FILE="GCF_029168945.1_ASM2916894v1_genomic.fna"

TEMP_DIR="/scratch/"

# SINGULARITYENV_CUDA_VISIBLE_DEVICES=0 singularity shell --nv ../singularity_images/clara-parabricks_4.6.0-1.sif 

# singularity shell --nv --bind /home/bpp/knausb/Vining_Lab_nfs7/PROJECTS/hemp/fiber/growing_year_2024_variants/MarkDuplicates/bams/:/bamdir ../singularity_images/clara-parabricks_4.6.0-1.sif

SINGULARITYENV_CUDA_VISIBLE_DEVICES=0 singularity shell --nv ~/Vining_Lab_nfs4/Users/knausb/singularity_images/clara-parabricks_4.6.0-1.sif 

# singularity shell --nv ~/Vining_Lab_nfs4/Users/knausb/singularity_images/clara-parabricks_4.6.0-1.sif
# singularity shell --nv --bind /nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/Pink_pepper/bwa_index_genomic:/refdir ~/Vining_Lab_nfs4/Users/knausb/singularity_images/clara-parabricks_4.6.0-1.sif 

#  --bind ${REF_DIR}:/refdir \
#  --bind /scratch:/workdir \
#  --bind $(pwd):/outputdir \
#  --workdir /workdir \
#  ~/Vining_Lab_nfs4/Users/knausb/singularity_images/clara-parabricks_4.6.0-1.sif 


# Select GPU number; zero-based, machine dependent.
#
CMD="export SINGULARITYENV_CUDA_VISIBLE_DEVICES=0"
#CMD="export SINGULARITYENV_CUDA_VISIBLE_DEVICES=1"

echo $CMD
eval $CMD
echo


# --nv   enable experimental Nvidia support
#  -W, --workdir string         working directory to be used for /tmp,
#                               /var/tmp and $HOME (if -c/--contain was
#                               also used)


#CMD="SINGULARITYENV_CUDA_VISIBLE_DEVICES=0 singularity run --nv \
CMD="singularity run --nv \
  --bind ${REF_DIR}:/refdir \
  --bind ${BAM_DIR}:/bamdir \
  --bind /scratch:/workdir \
  --bind $(pwd):/outputdir \
  --workdir /workdir \
  $MY_SIF \
  pbrun fq2bam \
    --ref /ref_dir/${REF_FILE} \
    --in-fq-list IN_FQ_LIST \
    --gpuwrite \
    --gpusort \
    --cigar-on-gpu \
    --fix-mate \
    --bwa-cpu-thread-pool 16 \
    --num-gpus 1 \
    --tmp-dir ${TEMP_DIR} \
    --bwa-options=\"-K 10000000\" \
    --out-bam /{$BAM_DIR}/${OUTPUT_BAM} \
    --out-recal-file /outputdir/${OUTPUT_RECAL_FILE}"


#    --knownSites /workdir/${KNOWN_SITES_FILE} \
#    --in-fq /workdir/${INPUT_FASTQ_1} /workdir/${INPUT_FASTQ_2}  \  
#  --mode shortread \
#  --num-cpu-threads-per-stream 6 \




#  --out-variants /gvcfdir/${MY_GVCF} \
# \
#  --interval NC_083601.1 Cannabis sativa cultivar Pink pepper isolate KNU-18-1 chromosome 1, ASM2916894v1, whole genome shotgun sequence:1-1000000"

# --interval NC_083601.1:1-10000000"
#  --gvcf /gvcfdir/${MY_GVCF}"


echo $CMD
# eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


##### ##### ##### ##### #####
# EOF.
