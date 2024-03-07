#! /bin/env bash

# Submit this script to the SGE system as follows.
# qsub run_braker3.sh
#
# The output directory will be around 2 GB for an 800 Mbp genome (hemp).

#$ -cwd			# Execute from current working directory.
#$ -S /bin/bash		# Use bash.
#$ -N brkr3		# Job name.
#$ -e brkr3err		# Where to redirect standard error.
#$ -o brkr3out		# Where to redirect standard out.
#$ -q (hoser)		# Queue(s), regex style.
# $ -l mem_free=10G	# Memory requirement.
#$ -pe thread 16		# Thread requirement.
#$ -V			# Export current environment variables.
# $ -h			# Submit job with a hold.


##### ##### ##### ##### #####

# Get fresh ~/.gm_key at below link (fill out form for download link).
# http://exon.gatech.edu/GeneMark/license_download.cgi

# On 2023-11-10 it took
# Elapsed: 13hrs 59min 3sec
# to generate the below ERROR.

# Failed to execute: /usr/bin/perl /opt/ETP/bin/gmetp.pl --cfg /nfs7/HORT/Vining_Lab/Users/knausb/braker3_test/braker3/GeneMark-ETP/etp_config.yaml --workdir /nfs7/HORT/Vining_Lab/Users/knausb/braker3_test/braker3/GeneMark-ETP --bam /nfs7/HORT/Vining_Lab/Users/knausb/braker3_test/braker3/GeneMark-ETP/etp_data/ --cores 16 --softmask  1>/nfs7/HORT/Vining_Lab/Users/knausb/braker3_test/braker3/errors/GeneMark-ETP.stdout 2>/nfs7/HORT/Vining_Lab/Users/knausb/braker3_test/braker3/errors/GeneMark-ETP.stderr
# The most common problem is an expired or not present file ~/.gm_key or that GeneMark-ETP didn't receive enough evidence from the input data, in this case, see errors/GeneMark-ETP.stderr!


##### ##### ##### ##### #####

export SINGULARITY_CACHEDIR=/nfs7/HORT/Vining_Lab/knausb/knausb/bin/SingularityCache
export SINGULARITY_BIND=/data:/tmp,/data:/data

# BRAKER3="/nfs4/HORT/Vining_Lab/Users/talbots/bin/Braker3/braker3.sif braker.pl"

##### ##### ##### ##### #####

##### ##### ##### ##### #####
# Report what we ended up with

echo -n "Running on: "
hostname
echo "SGE job id: $JOB_ID"
date
echo


# Seconds since the shell was spawned, reset to zero here.
SECONDS=0

# singularity does not appear to work on vaughn, log in to worker node and try there.q

# singularity shell /nfs4/HORT/Vining_Lab/Users/talbots/bin/Braker3/braker3.sif
# CMD="singularity exec /nfs4/HORT/Vining_Lab/Users/talbots/bin/Braker3/braker3.sif braker.pl --help"
# CMD="singularity exec /nfs4/HORT/Vining_Lab/Users/talbots/bin/Braker3/braker3.sif braker.pl --version"


# BRAKER3="/nfs4/HORT/Vining_Lab/Users/talbots/bin/Braker3/braker3.sif braker.pl"
BRAKER3="/nfs4/HORT/Vining_Lab/Users/talbots/bin/Braker3_05/braker3.sif braker.pl"

CMD="singularity exec $BRAKER3 -version"

echo $CMD
eval $CMD


# Protein files may be obtained from the below link.
# https://bioinf.uni-greifswald.de/bioinf/partitioned_odb11/
# The FASTA file used by braker must be uncompressed!
PROT_SEQ="/nfs7/HORT/Vining_Lab/Users/knausb/OrthoDB/OrthoDB11/Viridiplantae.fa"


# Softmasked genome with no spaces in header.
#GENOME="~/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RepeatModeler/CBDRx-families.fa"
#GENOME="~/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna.masked"

#GENOME="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna.masked"
#GENOME="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna_nospace.fasta"
#GENOME="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/EDTA_v5/knausb_427431/GCF_900626175.2_cs10_genomic_rehead.fna.mod.MAKER.masked"
GENOME="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/EDTA_v5/GCF_900626175.2_cs10_genomic_rehead_softmasked.fna"


#RNASEQ_bam="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600876_sorted.bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600883_sorted.bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600884_sorted.bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600886_sorted.bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600901_sorted.bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600927_sorted.bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600944_sorted.bam"



#RNASEQ_bam=""
RNASEQ_bam="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600876_sorted.bam"
RNASEQ_bam="$RNASEQ_bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600883_sorted.bam"
RNASEQ_bam="$RNASEQ_bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600884_sorted.bam"
RNASEQ_bam="$RNASEQ_bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600886_sorted.bam"
RNASEQ_bam="$RNASEQ_bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600901_sorted.bam"
RNASEQ_bam="$RNASEQ_bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600927_sorted.bam"
RNASEQ_bam="$RNASEQ_bam,/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/SRR10600944_sorted.bam"


#RNASEQ_bam="/home/bpp/knausb/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/RNA_evidence/bams/SRR10600876_sorted.bam,/home/bpp/knausb/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/RNA_evidence/bams/SRR10600883_sorted.bam,/home/bpp/knausb/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/RNA_evidence/bams/SRR10600884_sorted.bam,/home/bpp/knausb/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/RNA_evidence/bams/SRR10600886_sorted.bam,/home/bpp/knausb/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/RNA_evidence/bams/SRR10600901_sorted.bam,/home/bpp/knausb/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/RNA_evidence/bams/SRR10600927_sorted.bam,/home/bpp/knausb/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/RNA_evidence/bams/SRR10600944_sorted.bam"

# BRAKER3 runs on a minimum of 8 processors.

# We need to 'bind' directories containing input files so that they are available within the container.

# Avoid links, subdirectories, tildes.

#MYDIR="/home/bpp/knausb/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/RNA_evidence/bams/"
#MYDIR="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/RNA_evidence/bams/"
#MYDIR="${MYDIR},/home/bpp/knausb/Vining_Lab_nfs7/Users/knausb/OrthoDB/OrthoDB11/"
#MYDIR="${MYDIR},/nfs7/HORT/Vining_Lab/Users/knausb/OrthoDB/OrthoDB11/"
#MYDIR="${MYDIR},/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/Purple_Kush/GCA_000230575.5/repeatmodeler/"
#MYDIR="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence/bams/"

MYDIR="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/RNA_evidence_v2/bams/"


MYDIR="${MYDIR},/nfs7/HORT/Vining_Lab/Users/knausb/OrthoDB/OrthoDB11/"
MYDIR="${MYDIR},/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/EDTA_v5/"
MYDIR="${MYDIR},/nfs4/HORT/Vining_Lab/Users/talbots/bin/Braker3_05/" 


# CMD="singularity exec --bind $MYDIR -B $PWD:$PWD $BRAKER3 \
# --workingdir is relative to $HOME

#OUTDIR="/nfs7/HORT/Vining_Lab/Users/knausb/braker3_test/braker3/"
OUTDIR="/nfs4/HORT/Vining_Lab/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/braker3_v1/"
MYDIR="${MYDIR},${OUTDIR}"

echo $MYDIR

CMD="singularity exec --bind $MYDIR $BRAKER3 \
     --genome=$GENOME \
     --prot_seq=$PROT_SEQ \
     --bam=$RNASEQ_bam \
     --softmasking \
     --gff3 \
     --AUGUSTUS_ab_initio \
     --threads=16 \
     --workingdir=$OUTDIR"


#     --AUGUSTUS_CONFIG_PATH=/nfs4/HORT/Vining_Lab/Users/knausb/augustus_knausb/config/ \
#     --BAMTOOLS_PATH=/local/cluster/bamtools/bin/ \

echo $CMD
eval $CMD


# Report elapsed time.
echo
ELAPSED="Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo $ELAPSED


# EOF.
