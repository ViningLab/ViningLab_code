

library("DESeq2")
#setClassUnion("ExpData", c("matrix", "SummarizedExperiment"))

countData <- matrix(1:100,ncol=4)
condition <- factor(c("A","A","B","B"))
dds <- DESeqDataSetFromMatrix(countData, DataFrame(condition), ~ condition)

print(dds)

#
save(dds, file = "sim_dds.RData")


