
## DESeq2 is a tool to test RNASeq read count data for differential expression

DESeq2 is available through Bioconductor

https://bioconductor.org/packages/DESeq2/


## Create a conda environment with R and DESeq2

```
bash
conda create --Rconda
conda list -n myenv
conda activate Rconda
conda install conda-forge::zlib
conda install conda-forge::r-base
conda deactivate
```

Links to more information:    
https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html    
https://anaconda.org/conda-forge/zlib    
https://anaconda.org/conda-forge/r-base    


## Create a script to submit to Slurm

```
sbatch sbatch_DESeq2.sh
squeue
```


## Install R packages




## Run a test script


## Run DESeq2 on simulated data



## Run DESeq2 on test data included in DESeq2





