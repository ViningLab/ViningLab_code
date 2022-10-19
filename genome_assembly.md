# Genome assembly


## Inventory

When we receive data we tend to receive many files which we may be uncertain of their contents or importance.
A good first step is to change the permissions to read only, to prevent ourselves from making errors, and then inventory the files.
Changing the permissions can be done with the `chmod` command.


```
chmod 440 *.fastq.gz
```

Here we've used the `*` as a wildcard to indicate all files that end with '.fastq.gz'.


The program md5sum (https://en.wikipedia.org/wiki/Md5sum) is a method to create a unique identifier for files.
When files are posted on a server a file containing md5sum values can be included.
After downloading files new md5sum values can be created for the downloaded files.
These can be compared to the values posted on the server.
If the vcalues are identical it indicates that the files should be identical.
Deviations from identical indicate a problem.
Below is an example of how to calculate md5sum values at the command line as well as using `SGE_Batch`.


```
md5sum test.txt > md5sums.txt
SGE_Batch -c "md5sum test.txt > md5sums.txt" -r md0 -q hoser
```


The program `grep` is a very useful tool.
We can use it to find lines in a file that contain a query or search term.
If we use the `-c` flag it will count the lines containing this query.
A FASTQ file (https://en.wikipedia.org/wiki/FASTQ_format) has an ID line that begins with `@` followed by a sequence identifier.
By counting these lines we can inventory the number of sequence reads in a FASTQ file.
Below is an example of using grep to count sequence reads at the command line as well as using `SGE_Batch`.


```
zgrep -c "^@SEQ_ID" *.fastq.gz > counts.txt
SGE_Batch -c 'zgrep -c "^@SEQ_ID" *.fastq.gz > counts.txt' -r zg0
```

FASTQC    
quast    


## K-mer analyses

The analysis of k-mers attempts to make inferences by cutting sequences into subsequences of length 'k'.
For example, if we choose a k-mer size of 21 bp we will cut the input sequences up into sequences that are all 21 bp long.
We can then count the abundance of each of these k-mers.
This can provides an estimate of sequencing depth of the (relatively unique fraction of the) genome.
We have used 'jellyfish' to count k-mers and 'GenomeScope' to visualize these results.
The program 'yak' is another k-mer counting software.


- jellyfish https://github.com/gmarcais/Jellyfish ; https://github.com/zippav/Jellyfish-2
- GenomeScope http://qb.cshl.edu/genomescope/

- yak https://github.com/lh3/yak


## Assembly

hifiasm


## Assessment

- BUSCO
- quast
- minimap2, dotplotly, pafr, syri + plotsr
- RagTag scaffolding https://github.com/malonge/RagTag
- Merquery - trio binning https://github.com/marbl/merqury


## Annotation

braker;
eggnog


## BLAST

https://en.wikipedia.org/wiki/BLAST_(biotechnology)



