
## Links

[conda user's guide](https://docs.conda.io/projects/conda/en/latest/user-guide/index.html)    

[CQLS conda tutorial](https://software.cqls.oregonstate.edu/tips/posts/conda-tutorial/)    


## A conda session


The conda system does not appear to work well with csh/tcsh, so we use bash.
This can be accomplished by typing `bash` at the command prompt.
One way to determine if conda is already installed is to quesry it's version.


```
bash
conda --version
```


If this reports a version, then conda must be installed.
If it does not report a version but reports an error, then you probably need to install conda.

Another way to determine if conda is installed, and to determine which environments exist, is to query the environments.

```
(base) knausb@trifolium:~$ conda info --envs
# conda environments:
#
                         /home/knausb/.local/share/r-miniconda
                         /home/knausb/.local/share/r-miniconda/envs/r-reticulate
base                  *  /home/knausb/miniconda3
biopython                /home/knausb/miniconda3/envs/biopython
clang                    /home/knausb/miniconda3/envs/clang
```


The asterisk indicates which environment is active.
These results also report the location where the environment is installed.


If you'd like to activate an environment 

```
(base) knausb@trifolium:~$ conda activate biopython
(biopython) knausb@trifolium:~$ 
```

Note that the prompt has changed on my system, but this may be system specific.


If you wish to exit from conda you can deactivate it.


```
(biopython) knausb@trifolium:~$ conda deactivate
(base) knausb@trifolium:~$ conda deactivate
knausb@trifolium:~$ 
```


Note that the first `deactivate` command backed out of the `biopython` environment and retunred us to the `base` environment.
The second `deactivate` command exited from conda.
This can be seen in the prompt.


## Create a new environment

Frequently a project will require you to start by creating a new environment.
This new environment may have specific software, or specific versions of a software, needed for your project.
Here we see how to create a new environment.

Typically it is good to check what envirenments you have already created.
Sometimes you may find that you've previously created one that you need.

```
conda info --envs
```

This should list the environments that are available.

```
conda create --name snowflakes biopython
```

This should create an environment named 'snowflakes' and has as a dependency the package 'biopython'.
While installing 'biopython' it should also install all the dependencies of 'biopython.'


Once you have created an environment you may decide that you no longer need it.
The following command will remove the environment named 'snowflakes'.

```
conda env remove -n snowflakes
```



