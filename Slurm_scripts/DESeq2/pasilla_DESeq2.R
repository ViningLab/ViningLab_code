
print("Hello DESeq2")

library("DESeq2")

print("")
print( sessionInfo() )
print("")


#.libPaths( c("~/Rconda", .libPaths() ) )
#library("DESeq2")

print("checkpoint1")

pasCts <- system.file("extdata",
                      "pasilla_gene_counts.tsv.gz",
                      package="DESeq2", mustWork=TRUE)
pasAnno <- system.file("extdata",
                       "pasilla_sample_annotation.csv",
                       package="DESeq2", mustWork=TRUE)

#pasCts <- "pasilla/pasilla_gene_counts.tsv.gz"
#pasAnno <- "pasilla/pasilla_sample_annotation.csv"

cts <- as.matrix(read.csv(pasCts,sep="\t",row.names="gene_id"))
coldata <- read.csv(pasAnno, row.names=1)

print("checkpoint2")

coldata <- coldata[,c("condition","type")]
coldata$condition <- factor(coldata$condition)
coldata$type <- factor(coldata$type)

rownames(coldata) <- sub("fb", "", rownames(coldata))
all(rownames(coldata) %in% colnames(cts))
all(rownames(coldata) == colnames(cts))

cts <- cts[, rownames(coldata)]
all(rownames(coldata) == colnames(cts))

print("checkpoint3")

print(cts[1:3, ])
print(coldata)

# library("DESeq2")
# https://rockefelleruniversity.github.io/RU_RNAseq/presentations/singlepage/RU_RNAseq_p2.html
# setClassUnion("ExpData", c("matrix", "SummarizedExperiment"))

print("")
print("checkpoint: DESeqDataSetFromMatrix pre")

dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ condition)
print("checkpoint: DESeqDataSetFromMatrix")
#
dds

#
save(dds, file = "dds_pasilla.RData")



#smallestGroupSize <- 3
#keep <- rowSums(counts(dds) >= 10) >= smallestGroupSize
#dds <- dds[keep,]


#dds$condition <- relevel(dds$condition, ref = "untreated")

#dds <- DESeq(dds)
#res <- results(dds)
#res

##res <- results(dds, name="condition_treated_vs_untreated")
#res <- results(dds, contrast=c("condition","treated","untreated"))



