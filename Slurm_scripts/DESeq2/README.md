
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

## Run a test script

Running a test script is a good way to see if we are incrementally making progress.
We should now be able to submit our script to slurm.
But first we, should make sure it's calling the correct R script.
Our script `sbatch_DESeq2.sh` should include a block of code that appears as follows.

```
#
CMD="Rscript HELLO_DESeq2.R"
# CMD="Rscript instpkgs.R"
# CMD="Rscript sim_DESeq2.R"
# CMD="Rscript pasilla_DESeq2.R"
```

The R script has three lines.
The first line echos a message.
The second line loads the library `DESeq2`.
Note that if DESeq2 is not installed, this line should throw an error.
This is why we begin with it commented out.
The third line reports session information, such as what version of R is being used.
This line will also report the versions of packages that are loaded, which is why we would like to load DESeg2 prior to this reporting.

```
print("Hello DESeq2")
#library("DESeq2")
print( sessionInfo() )
```


## Install R packages

In order to install packages, I modify our `sbatch_DESeq2.sh` script as follows.

```
# CMD="Rscript HELLO_DESeq2.R"
#
CMD="Rscript instpkgs.R"
# CMD="Rscript sim_DESeq2.R"
# CMD="Rscript pasilla_DESeq2.R"
```

This should now call the R script `instpkgs.R` that contains the following R code.

```
options(repos = "https://cloud.r-project.org")
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DESeq2")
```

This sets a repository to install packages from, checks if BiocManager is installed, and installs it if it is not, and installs DESeq2.
We should now be able to rerun our test script above, and include the loading of the library DESeq2 to validate that it is installed and to check what version we are using.


## Run DESeq2 on simulated data

Once we have validated that DESeq2 is installed, we should be able to test it with some simulated data.
We can modify our `sbatch_DESeq2.sh` script to call this script as follows.

```
# CMD="Rscript HELLO_DESeq2.R"
# CMD="Rscript instpkgs.R"
#
CMD="Rscript sim_DESeq2.R"
# CMD="Rscript pasilla_DESeq2.R"
```

We should be able to submit this and see some output.


## Run DESeq2 on test data included in DESeq2

We should now be able to run the 'pasilla' example data that is provided with DESeq2 and is used in the package's example.
We modify our `sbatch_DESeq2.sh` as follows.

```
# CMD="Rscript HELLO_DESeq2.R"
# CMD="Rscript instpkgs.R"
# CMD="Rscript sim_DESeq2.R"
#
CMD="Rscript pasilla_DESeq2.R"
```


## Run DESeq2 using multiple cpus using BiocParallel

DESeq2 may be run using multiple cpus (cores) using BiocParallel.
We can modify our `sbatch_DESeq2.sh` script to call this script as follows.

```
# CMD="Rscript HELLO_DESeq2.R"
# CMD="Rscript instpkgs.R"
# CMD="Rscript sim_DESeq2.R"
#CMD="Rscript pasilla_DESeq2.R"
CMD="Rscript pasilla_BPDESeq2.R"
```

There are 2 locations where we will need to **match** our request for cpus.
In the script `sbatch_DESeq2.sh` we will need to include the following.

```
#SBATCH --cpus-per-task=2
```

And in our R script we will need to include the following.

```
library("BiocParallel")
register(MulticoreParam(2))
```

This should allocate 2 cpus to our job.
We will also need to enable R functions to use multiple cores by including `parallel=TRUE` as a parameter to the function calls where we would like to use more than one cpu.


