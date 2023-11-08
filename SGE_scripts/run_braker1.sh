#!/bin/env bash

#$ -cwd
#$ -S /bin/bash
#$ -N brkr1
#$ -e brkr1err
#$ -o brkr1out
#$ -q hoser
#$ -pe thread 8
# $ -pe thread 16
# $ -pe thread 10
# #$ -l mem_free=10G
#$ -V
# #$ -h
# $ -t 1-2:1

#i=$(expr $SGE_TASK_ID - 1)

##### ##### ##### ##### #####

# http://daehwankimlab.github.io/hisat2/
# https://github.com/DaehwanKimLab/hisat2

# Run RNA_bam and OrthoDB (FASTA) seperately
# Then combine both runs with TSEBRA.

# To run with protein sequences
#
# braker.pl [OPTIONS] --genome=genome.fa --species=speciesname \
#     --prot_seq=proteins.fa
# braker.pl [OPTIONS] --genome=genome.fa --species=speciesname \
#     --hints=prothint_augustus.gff


# https://github.com/Gaius-Augustus/BRAKER
# which braker.pl
BRAKER="/local/cluster/BRAKER-2.1.5/scripts/braker.pl"

braker.pl -version

# Ideally a "soft masked" genome.
#GENOME="~/Vining_Lab_nfs3/GENOMES/hemp/CBDRx/GCF_900626175/RepeatModeler/GCF_900626175.2_cs10_genomic.fna.masked"
#GENOME="../../CBDRx_hisat2/GCF_900626175.2_cs10_genomic.fna.masked"
#GENOME="GCF_900626175.2_cs10_genomic.fna_nospace.fasta"
#GENOME="../repeatmodeler/ERBxHO40_23_hirisehap1.masked"
#GNAME="ERBxHO40_23_hirisehap1a"
#GENOME="../repeatmodeler/CBR_1.asm.bp.hap1.p_ctg.gfa.fa.masked"
#GNAME="CBR_hap1a"

#GENOME="../RepeatModeler_softmask/GCA_003417725.2_ASM341772v2_genomic.fna.masked"
#GENOME="../RepeatModeler_softmask/GCA_003417725.2_ASM341772v2_genomic.fna_nospace.fasta"
#GNAME="Finola1"

#GENOME="../repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna.masked"
GENOME="../repeatmodeler/GCA_000230575.5_ASM23057v5_genomic.fna_nospace.fasta"
GNAME="Purple_Kush1"

#RNASEQ_bam="../CBDRx_hisat2/bams/SRR10600876_sorted.bam,../CBDRx_hisat2/bams/SRR10600883_sorted.bam,../CBDRx_hisat2/bams/SRR10600884_sorted.bam,../CBDRx_hisat2/bams/SRR10600886_sorted.bam,../CBDRx_hisat2/bams/SRR10600901_sorted.bam,../CBDRx_hisat2/bams/SRR10600927_sorted.bam,../CBDRx_hisat2/bams/SRR10600944_sorted.bam"
#RNASEQ_bam="../RNA_evidence/bams/ERVxH040-21-earlyflower_sorted.bam,../RNA_evidence/bams/ERVxH040-21-foliage12-12light-reextract_sorted.bam,../RNA_evidence/bams/ERVxH040-21-foliage_sorted.bam,../RNA_evidence/bams/ERVxH040-21-lateflower-reextract_sorted.bam,../RNA_evidence/bams/ERVxH040-21-roots_sorted.bam,../RNA_evidence/bams/ERVxH040-21-shoottips_sorted.bam"

RNASEQ_bam="../RNA_evidence/bams/SRR10600876_sorted.bam,../RNA_evidence/bams/SRR10600883_sorted.bam,../RNA_evidence/bams/SRR10600884_sorted.bam,../RNA_evidence/bams/SRR10600886_sorted.bam,../RNA_evidence/bams/SRR10600901_sorted.bam,../RNA_evidence/bams/SRR10600927_sorted.bam,../RNA_evidence/bams/SRR10600944_sorted.bam"

##### ##### ##### ##### #####

# Get fresh ~/.gm_key at below link (fill out form for download link).
# http://exon.gatech.edu/GeneMark/license_download.cgi

echo
date

CMD="$BRAKER \
     --species=$GNAME \
     --genome=$GENOME \
     --bam=$RNASEQ_bam \
     --AUGUSTUS_CONFIG_PATH=/nfs4/HORT/Vining_Lab/Users/knausb/augustus_knausb/config/ \
     --BAMTOOLS_PATH=/local/cluster/bamtools/bin/ \
     --softmasking \
     --cores=8 \
     --workingdir=braker1"

echo $CMD
eval $CMD

echo
date
echo


# EOF.
