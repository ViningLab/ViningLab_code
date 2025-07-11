

library("DESeq2")
# https://rockefelleruniversity.github.io/RU_RNAseq/presentations/singlepage/RU_RNAseq_p2.html
#setClassUnion("ExpData", c("matrix", "SummarizedExperiment"))

countData <- matrix(1:100,ncol=4)
condition <- factor(c("A","A","B","B"))
dds <- DESeqDataSetFromMatrix(countData, DataFrame(condition), ~ condition)

print(dds)

#
save(dds, file = "sim_dds.RData")


