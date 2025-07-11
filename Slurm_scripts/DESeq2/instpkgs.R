
# install.packages()

# .libPaths( c("~/Rconda", .libPaths() ) )

options(repos = "https://cloud.r-project.org")


if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
    #install.packages("BiocManager", lib = "~/Rconda")


#library(BiocManager)
#BiocManager::install("XVector")
#BiocManager::install("SparseArray")
#BiocManager::install("GenomicRanges")
#BiocManager::install("DelayedArray")
#BiocManager::install("SummarizedExperiment")

BiocManager::install("DESeq2")



