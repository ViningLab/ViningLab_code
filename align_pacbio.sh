#! /bin/env bash

# Lines begining with '#' are comments and are not exectuted.
# Lines begining with '#$' are interpreted by the SGE system.

#$ -cwd
#$ -S /bin/bash
#$ -N align
#$ -e align0err
#$ -o align0out
# $ -q !gbs
# $ -q hoser@hoser
# $ -l mem_free=10G
#$ -V
# $ -h
# $ -t 1-2:1

i=$(expr $SGE_TASK_ID - 1)

echo "PATH:"
echo $PATH
echo

##### ##### ##### ##### #####
# User provided materials

# Reference sequence
REF="~/Vining_Lab_nfs4/GENOMES/hemp/public_databases/NCBI/CBDRx/GCF_900626175/GCF_900626175.2_cs10_genomic.fna"

# Sequence library
READS="~/Vining_Lab_nfs4/Users/knausb/PacBioRice/m64013e_210227_222017.hifi_reads.fastq.gz"

# Replace "SAMPLE_NAME" with your sample information.
# RG="@RG\\tID:SAMPLE_NAME\\tSM:SAMPLE_NAME"

SAMPLE_NAME="hemp3"
RG="@RG\\tID:$SAMPLE_NAME\\tSM:$SAMPLE_NAME"


##### ##### ##### ##### #####
# Software

# https://github.com/lh3/minimap2
# https://lh3.github.io/minimap2/minimap2.html
MM2="/local/cluster/bin/minimap2"

# https://github.com/samtools/samtools
SAMT="/local/cluster/bin/samtools"

##### ##### ##### ##### #####
# Align reads


# minimap2 -R "@RG\\tID:SAMPLE_NAME\\tSM:SAMPLE_NAME" -a -x asm5 $CASTLE_REF $PACBIO_READS -o aligned_reads.sam
# minimap2 -R "@RG\\tID:SAMPLE_NAME\\tSM:SAMPLE_NAME" -c -ax map-hifi ref.fa pacbio-ccs.fq.gz > aln.sam

# minimap2 options
# -a	Generate CIGAR and output alignments in the SAM format. Minimap2 outputs in PAF by default.
# -R STR	SAM read group line in a format like @RG\\tID:foo\\tSM:bar [].
# -c	Generate CIGAR. In PAF, the CIGAR is written to the ‘cg’ custom tag.

# samtools options
# -b output to bam
# -o outfile name

# CMD="$MM2 -R \"$RG\" -c -ax map-hifi $REF $READS | $SAMT view -b -o aligned_reads.bam"
CMD="$MM2 -R \"$RG\" -c -ax map-hifi $REF $READS | $SAMT view -b -o $SAMPLE_NAME.bam"

date

echo
#
echo $CMD
#
eval $CMD
echo

date


# EOF.
