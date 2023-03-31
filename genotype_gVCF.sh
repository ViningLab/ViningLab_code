#! /bin/env bash

#$ -N gtgvcf
#$ -o gtgvcfout
#$ -e gtgvcferr
#$ -V
#$ -cwd
#$ -S /bin/bash
# $ -q !gbs
#$ -q hoser@hoser
# #$ -l mem_free=2G
# $ -p -10
# #$ -h
# $ -t 50-50:1
# $ -t 5-4921

#i=$(expr $SGE_TASK_ID - 1)

#GATK="~/bin/gatk4/gatk-4.1.4.1/gatk"
GATK="/local/cluster/bin/gatk"

#JAVA="/home/bpp/knausb/bin/javadir/jre1.8.0_25/bin/java"

REF="/home/bpp/knausb/Grunwald_Lab/home/knausb/bjk_pinf_ref/pinf_super_contigs.fa"

echo -n "Running on: "
hostname
echo "SGE job id: $JOB_ID"
date
echo

# https://www.broadinstitute.org/gatk/documentation/article?id=3893
# https://www.broadinstitute.org/gatk/documentation/tooldocs/org_broadinstitute_gatk_engine_CommandLineGATK.php
# https://www.broadinstitute.org/gatk/documentation/tooldocs/org_broadinstitute_gatk_tools_walkers_haplotypecaller_HaplotypeCaller.php
# https://www.broadinstitute.org/gatk/documentation/tooldocs/org_broadinstitute_gatk_tools_walkers_variantutils_GenotypeGVCFs.php

# https://gatk.broadinstitute.org/hc/en-us/articles/360037427071-CombineGVCFs

CMD="$GATK --java-options \"-Djava.io.tmpdir=/data/ -Xmx4g\" CombineGVCFs \
     -R $REF \
     -TMP_DIR /data/ \
     --variant sample1.g.vcf.gz \
     --variant sample2.g.vcf.gz \
     -O cohort.vcf.gz"

#     -L Supercontig_1.$SGE_TASK_ID \

date

echo $CMD
eval $CMD

date


# EOF.
