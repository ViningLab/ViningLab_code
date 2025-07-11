
## DESeq2 is a tool to test RNASeq read count data for differential expression

DESeq2 is available through Bioconductor

https://bioconductor.org/packages/DESeq2/


## Create a conda environment with R and DESeq2

One way to get an installation of DESeq on a system is to use conda.
Below are the commands I used to create a conda environment for myself.
If you have never used conda on your system, you may need to set it up first.
This may require consultation of your system documentation or communication with your system administrator.
Once this environment is set up, we can use it through our shell script that we submit to slurm below.

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
https://software.cqls.oregonstate.edu/    


## Create a script to submit to Slurm

In order to submit jobs to slurm, we will create a bash script.
This script will accomplish the following.

- Specify the number of cpus a job will require
- Activate our conda environment
- Call our R script

Once we have the script we can submit it as follows.

```
sbatch sbatch_DESeq2.sh
squeue
```


## Install R packages




## Run a test script


## Run DESeq2 on simulated data



## Run DESeq2 on test data included in DESeq2





