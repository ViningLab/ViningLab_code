

## Software installation


### EDTA

Install mamba (takes > 1 hour).

https://bioconda.github.io/faqs.html#speedup-option-1-use-mamba

```
conda install mamba -n base -c conda-forge
```

https://github.com/oushujun/EDTA?tab=readme-ov-file#install-with-condamamba-linux64

```
conda create -n EDTA
conda activate EDTA
mamba install -c conda-forge -c bioconda edta
```




## Genome annotation

1 - Prepare reference

```
PREFIX="PrKu_"
/home/bpp/knausb/gits/hempy/bin/fasta_reheader.py myGENOME.fa $PREFIX
```


2 - Repeat identification and masking: EDTA


```
GENOME="/local/cluster/EDTA-1.9.6/share/EDTA/test/genome.fa"
EDTA.pl --genome $GENOME --anno 1 --sensitive 1 --threads 16
```

Check standard out for the following message.

```
TE annotation using the EDTA library has finished! Check out:
...
```


3 - Softmasking


```
~/bin/bedops/bin/convert2bed --input=gff --do-not-sort < ./knausb_427432/GCA_000230575.5_ASM23057v5_genomic_rehead.fna.mod.EDTA.TEanno.gff3 > GCA_000230575.5_ASM23057v5_genomic_rehead.bed

bedtools maskfasta -soft -fi GCA_000230575.5_ASM23057v5_genomic_rehead.fna -bed GCA_000230575.5_ASM23057v5_genomic_rehead.bed -fo GCA_000230575.5_ASM23057v5_genomic_rehead_softmasked.fna
```




4 - RNA evidence: hisat2


```
$HISAT2-build $GENOME $SNAME
```


```
CMD="$HISAT2 -x $SNAME \
     -p 8 \
     -1 ${arr[1]} \
     -2 ${arr[2]} \
     --rg-id ${arr[0]} \
     --rg ID:${arr[0]} \
     --rg LB:${arr[0]} \
     --rg PL:illumina \
     --rg SM:${arr[0]} \
     --rg PU:${arr[0]} | $SAMT view -bh -S - > bams/${arr[0]}.bam"
```



5 - Structural annotation: braker3


```
CMD="singularity exec --bind $MYDIR $BRAKER3 \
     --genome=$GENOME \
     --prot_seq=$PROT_SEQ \
     --bam=$RNASEQ_bam \
     --softmasking \
     --gff3 \
     --AUGUSTUS_ab_initio \
     --threads=16 \
     --workingdir=$OUTDIR"
```


6 - Repeat identification and masking round 2: EDTA


```
GENOME="/local/cluster/EDTA-1.9.6/share/EDTA/test/genome.fa"

EDTA.pl --genome $GENOME --anno 1 --sensitive 1 --threads 16 --cds $CDS
```

Check standard out for the following message.

```
TE annotation using the EDTA library has finished! Check out:
...
```


7 - Softmasking


```
~/bin/bedops/bin/convert2bed --input=gff --do-not-sort < ./knausb_427432/GCA_000230575.5_ASM23057v5_genomic_rehead.fna.mod.EDTA.TEanno.gff3 > GCA_000230575.5_ASM23057v5_genomic_rehead.bed

bedtools maskfasta -soft -fi GCA_000230575.5_ASM23057v5_genomic_rehead.fna -bed GCA_000230575.5_ASM23057v5_genomic_rehead.bed -fo GCA_000230575.5_ASM23057v5_genomic_rehead_softmasked.fna
```


8 - Structural annotation: braker3 round 2


```
CMD="singularity exec --bind $MYDIR $BRAKER3 \
     --genome=$GENOME \
     --prot_seq=$PROT_SEQ \
     --bam=$RNASEQ_bam \
     --softmasking \
     --gff3 \
     --AUGUSTUS_ab_initio \
     --threads=16 \
     --workingdir=$OUTDIR"
```




9 - Functional annotation


```
CMD="$EMAPPER \
    -i $MY_PROTEINS \
    --cpu 8 \
    --decorate_gff yes \
    -o $ONAME"
```







