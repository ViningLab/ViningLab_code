# Genome assembly


## Inventory

When we receive data we tend to receive many files which we may be uncertain of their contents or importance.
A good first step is to change the permissions to read only, to prevent ourselves from making errors, and then inventory the files.
Changing the permissions can be done with the `chmod` command.


```
chmod 440 *.fastq.gz
```

Here we've used the `*` as a wildcard to indicate all files that end with '.fastq.gz'.


md5sum,

```
md5sum test.txt > md5sums.txt
SGE_Batch -c "md5sum test.txt > md5sums.txt" -r md0 -q hoser
```


grep -c,

```
zgrep -c "^@SEQ_ID" *.fastq.gz > counts.txt
SGE_Batch -c 'zgrep -c "^@SEQ_ID" *.fastq.gz > counts.txt' -r zg0
```


quast

## Assembly

hifiasm


## Assessment

BUSCO;
quast;
minimap2, dotplotly, pafr, syri + plotsr

## Annotation

braker;
eggnog


## BLAST

https://en.wikipedia.org/wiki/BLAST_(biotechnology)



