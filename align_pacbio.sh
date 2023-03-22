#! /bin/env bash

# This script is intended to be submitted with qsub.
# qsub align_pacbio.sh

# Lines begining with '#' are comments and are not exectuted.
# Lines begining with '#$' are interpreted by the SGE system.

#$ -cwd
#$ -S /bin/bash
#$ -N mm2
#$ -e mm2err
#$ -o mm2out
# $ -q !gbs
# $ -q hoser@hoser
# $ -l mem_free=10G
#$ -V
# $ -h
# $ -t 1-2:1
#$ -pe thread 4

# i=$(expr $SGE_TASK_ID - 1)

# The variable 'NTHREADS' specifies how many threads (cores) the softwares (below) uses.
# The user (i.e., you) must coordinate this with the queuing system with the line '#$ -pe thread' (above).
NTHREADS=4


echo "PATH:"
echo $PATH
echo

##### ##### ##### ##### #####
# User provided materials

# Reference sequence
REF="~/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/GCF_900626175.2_cs10_genomic.fna"

# Multiple input files:
# https://github.com/lh3/minimap2/issues/191

# Sequence library
READS="~/Vining_Lab_nfs4/Users/knausb/PacBioRice/m64013e_210227_222017.hifi_reads.fastq.gz"

# Replace "SAMPLE_NAME" with your sample information.

# RG="@RG\\tID:SAMPLE_NAME\\tSM:SAMPLE_NAME"

SAMPLE_NAME="hemp3"
RG="@RG\\tID:$SAMPLE_NAME\\tSM:$SAMPLE_NAME"
OUTFILE="$SAMPLE_NAME.bam"


##### ##### ##### ##### #####
# Software

# https://github.com/lh3/minimap2
# https://lh3.github.io/minimap2/minimap2.html
MM2="/local/cluster/bin/minimap2"

# https://github.com/samtools/samtools
SAMT="/local/cluster/bin/samtools"

##### ##### ##### ##### #####
# Align reads

# minimap2 options
# -a	Generate CIGAR and output alignments in the SAM format. Minimap2 outputs in PAF by default.
# -R STR	SAM read group line in a format like @RG\\tID:foo\\tSM:bar [].
# -c	Generate CIGAR. In PAF, the CIGAR is written to the ‘cg’ custom tag.

# samtools options
# -b output to bam
# -o outfile name

CMD="$MM2 -R \"$RG\" -ax map-hifi -t $NTHREADS --eqx $REF $READS | $SAMT sort -o $OUTFILE -O BAM -T /data/ -@ $NTHREADS"

date

echo
#
echo $CMD
#
eval $CMD
echo

date

CMD="$SAMT index $OUTFILE"

echo $CMD
#
eval $CMD

date

# EOF.
