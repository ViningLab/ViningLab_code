# Genome assembly


## Inventory

When we receive data we tend to receive many files which we may be uncertain of their contents or importance.
A good first step is to change the permissions to read only, to prevent ourselves from making errors, and then inventory the files.
Changing the permissions can be done with teh `chmod` command.


```
chmod 440 *.fastq.gz
```

Here we've used the `*` as a wildcard to indicate all files that end with '.fastq.gz'.




grep -c,
md5sum,
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



