## ----echo=FALSE, include=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE, warning = FALSE
)

## ----loadPackage, echo=FALSE,results='hide'-----------------------------------
library(flowCore)

## ----ReadFiles, echo=TRUE, results='markup'-----------------------------------
file.name <- system.file("extdata","0877408774.B08", 
                         package="flowCore")
x <- read.FCS(file.name, transformation=FALSE)
summary(x)

## ----SearchKeywords, echo=TRUE, results='markup'------------------------------
keyword(x,c("$P1E", "$P2E", "$P3E", "$P4E"))

## ----PrintSummary, echo=TRUE, results='markup'--------------------------------
summary(read.FCS(file.name))

## ----PrintSummary2, echo=TRUE,results='markup'--------------------------------
summary(read.FCS(file.name,transformation="scale")) 

## ----ReadFiles2, echo=TRUE,results='markup'-----------------------------------
read.FCS(file.name,alter.names=TRUE) 

## ----ReadFiles3, echo=TRUE, results='markup'----------------------------------
x <- read.FCS(file.name, column.pattern="-H") 
x 

## ----ReadFiles4, echo=TRUE, results='markup'----------------------------------
lines <- sample(100:500, 50)
y <- read.FCS(file.name, which.lines = lines) 
y 

## ----Frames1, echo=TRUE, results='markup'-------------------------------------
fcs.dir <- system.file("extdata",
                       "compdata",
                       "data",
                       package="flowCore")
frames <- lapply(dir(fcs.dir, full.names=TRUE), read.FCS)
fs <- as(frames, "flowSet")
fs
sampleNames(fs)

## ----Frames2, echo=TRUE,results='markup'--------------------------------------
names(frames) <- sapply(frames, keyword, "SAMPLE ID")
fs <- as(frames, "flowSet")
fs
sampleNames(fs)

## ----metaData, echo=TRUE, results='markup'------------------------------------
phenoData(fs)$Filename <- fsApply(fs,keyword, "$FIL")
pData(phenoData(fs))

## ----ReadFlowSet, echo=TRUE,results='markup'----------------------------------
fs <- read.flowSet(path = fcs.dir)

## ----fsApply1, echo=TRUE, results='markup'------------------------------------
fsApply(fs, each_col, median)

## ----fsApply2, echo=TRUE,results='markup'-------------------------------------
fsApply(fs,function(x) apply(x, 2, median), use.exprs=TRUE)

## ----Plot, echo=TRUE, results='hide'------------------------------------------
library(ggcyto)
autoplot(x, "FL1-H", "FL2-H")


autoplot_bjk <- function(x, sample1 = NULL, sample2 = NULL){
  my_df <- as.data.frame(exprs(x))
  if( is.null(sample2) ){
    my_df <- my_df[, c(sample1), drop = FALSE]
    names(my_df) <- c("sample1")
    
    p <- ggplot( data = my_df, mapping = aes( x = sample1 ))
    p <- p + geom_histogram( binwidth = 10 )
  }
  if( !is.null(sample2) ){
    my_df <- my_df[, c(sample1, sample2)]
    names(my_df) <- c("sample1", "sample2")
  
    p <- ggplot( data = my_df, mapping = aes( x = sample1, y = sample2 ))
    #p <- p + geom_bin2d( binwidth = 200 )
    #p <- p + geom_bin2d( bins = 60 )
    #p <- p + geom_hex( binwidth = 200 )
    p <- p + geom_hex( bins = 40 )
    p <- p + ylab( sample2 )
  }
  
#  p <- p + scale_fill_viridis_b( )
#  p <- p + scale_fill_viridis_b( begin = 0.1, end = 0.99, option = "C" )
  p <- p + scale_fill_viridis_c( begin = 0.1, end = 0.99, option = "C" )
  p <- p + theme_bw()
  p <- p + xlab( sample1 )

  p
}

p <- autoplot_bjk(x, "FL1-H", "FL2-H")
p

## ----Plot2, echo=TRUE, results='hide'-----------------------------------------
#autoplot(x, "FL1-H")

autoplot_bjk(x, "FL1-H")


## ----Plot3, echo=TRUE, results='hide'-----------------------------------------
fs <- read.flowSet(path = system.file("extdata", 
                                      package = "flowCore"), 
                   pattern = "\\.")
#autoplot(fs, "FL1-H", "FL2-H")
autoplot_bjk(fs[[1]], "FL1-H", "FL2-H")
autoplot_bjk(fs[[2]], "FL1-H", "FL2-H")
autoplot_bjk(fs[[3]], "FL1-H", "FL2-H")

## ----Comp, echo=TRUE, results='markup'----------------------------------------
# Install data package at below link.
# https://doi.org/doi:10.18129/B9.bioc.flowWorkspaceData
fcsfiles <- list.files(pattern = "CytoTrol", 
                       system.file("extdata", 
                                   package = "flowWorkspaceData"),
                       full = TRUE)
fs <- read.flowSet(fcsfiles)
x <- fs[[1]]
comp_list <- spillover(x)
comp_list
comp  <- comp_list[[1]]

## ----Comp2, echo=TRUE, results='markup'---------------------------------------
x_comp <- compensate(x, comp)

## ----Comp3, echo=TRUE, results='markup'---------------------------------------
comp <- fsApply(fs, function(x) spillover(x)[[1]], simplify=FALSE)
fs_comp <- compensate(fs, comp)

## ----CompViz, echo=TRUE, results='markup'-------------------------------------
library(gridExtra)
transList <- estimateLogicle(x, c("V450-A","V545-A"))
# p1 <- autoplot(transform(x, transList), "V450-A", "V545-A") +
#       ggtitle("Before")
# p2 <- autoplot(transform(x_comp, transList), "V450-A", "V545-A") +
#       ggtitle("Before")
# grid.arrange(as.ggplot(p1), as.ggplot(p2), ncol = 2)

autoplot_bjk(transform(x, transList), "V450-A", "V545-A")
autoplot_bjk(transform(x_comp, transList), "V450-A", "V545-A")

## ----Comp4, echo=TRUE, results='markup'---------------------------------------
library(flowStats)
fcs.dir <- system.file("extdata", "compdata", "data",
                       package="flowCore")
frames <- lapply(dir(fcs.dir, full.names=TRUE), read.FCS)
names(frames) <- c("UNSTAINED", "FL1-H", "FL2-H", "FL4-H", "FL3-H")
frames <- as(frames, "flowSet")
comp <- spillover(frames, unstained="UNSTAINED", patt = "-H",
                  fsc = "FSC-H", ssc = "SSC-H", 
                  stain_match = "ordered")
comp

## ----Comp5, echo=TRUE, results='markup'---------------------------------------
sampleNames(frames)
comp <- spillover(frames, unstained="UNSTAINED", patt = "-H",
                  fsc = "FSC-H", ssc = "SSC-H", 
                  stain_match = "regexpr")
comp

## ----Comp6, echo=TRUE, results='markup'---------------------------------------
comp_match <- system.file("extdata", "compdata", "comp_match",
                          package="flowCore")
# The matchfile has a simple format
writeLines(readLines(comp_match))
control_path <- system.file("extdata", "compdata", "data",
                            package="flowCore")
# Using path rather than pre-constructed flowSet
matched_fs <- spillover_match(path=control_path, 
                              fsc = "FSC-H", ssc = "SSC-H", 
                              matchfile = comp_match)
comp <- spillover(matched_fs, fsc = "FSC-H", ssc = "SSC-H", 
                  prematched = TRUE)

## ----Transfo1, echo=TRUE, results='hide'--------------------------------------
fs <- read.flowSet(path=system.file("extdata", "compdata", "data",
                   package="flowCore"), name.keyword="SAMPLE ID")
# autoplot(transform(fs[[1]],
#                    `FL1-H`=log(`FL1-H`),
#                    `FL2-H`=log(`FL2-H`)
#                    ),
#          "FL1-H","FL2-H")

autoplot_bjk(transform(fs[[1]],
                   `FL1-H`=log(`FL1-H`),
                   `FL2-H`=log(`FL2-H`)
),
"FL1-H","FL2-H")

## ----Transfo2, results='hide'-------------------------------------------------
# autoplot(transform(fs[[1]],
#                    log.FL1.H=log(`FL1-H`),
#                    log.FL2.H=log(`FL2-H`)
#                    ),
#          "log.FL1.H", "log.FL2.H")

autoplot_bjk(transform(fs[[1]],
                   log.FL1.H=log(`FL1-H`),
                   log.FL2.H=log(`FL2-H`)
),
"log.FL1.H", "log.FL2.H")

## ----Transfo3, echo=TRUE------------------------------------------------------
aTrans <- truncateTransform("truncate at 1", a=1)
aTrans

## ----Transfo4, echo=TRUE,results='markup'-------------------------------------
transform(fs,`FL1-H`=aTrans(`FL1-H`))

## ----Transfo4.1, echo=TRUE,results='markup'-----------------------------------
f1 <- function(fs,...){
  transform(fs, ...)[,'FL1-H']
}

f2 <- function(fs){
  aTrans <- truncateTransform("truncate at 1", a=1)
  f1(fs, `FL1-H` = aTrans(`FL1-H`))
}
res <- try(f2(fs), silent = TRUE)
res

## ----Transfo4.2, echo=TRUE,results='markup'-----------------------------------
myTrans <- transformList('FL1-H', aTrans)
transform(fs, myTrans)

## ----rectGate, echo=TRUE, results='markup'------------------------------------
rectGate <- rectangleGate(filterId="Fluorescence Region", 
                          "FL1-H"=c(0, 12), "FL2-H"=c(0, 12))

## ----echo=TRUE,results='markup'-----------------------------------------------
result = filter(fs[[1]],rectGate)
result

## ----Summary3, echo=TRUE, results='markup'------------------------------------
summary(result)
summary(result)$n
summary(result)$true
summary(result)$p

## ----SummarFilter, echo=TRUE, results='markup'--------------------------------
summary(filter(fs[[1]], 
               kmeansFilter("FSC-H"=c("Low", "Medium", "High"),
                                     filterId="myKMeans")))

## ----echo=TRUE,results='markup'-----------------------------------------------
filter(fs,rectGate)

## ----Norm2Filter1, echo=TRUE, results='markup'--------------------------------
#autoplot(fs[[1]], "FSC-H", "SSC-H")
autoplot_bjk(fs[[1]], "FSC-H", "SSC-H")
# Forward Scatter and Side Scatter

## ----Norm2Filter2, echo=TRUE, results='markup'--------------------------------
library(flowStats)
morphGate <- norm2Filter("FSC-H", "SSC-H", filterId="MorphologyGate", 
                         scale=2)
smaller <- Subset(fs, morphGate)
fs[[1]]
smaller[[1]]

## ----Split, echo=TRUE, results='markup'---------------------------------------
split(smaller[[1]], kmeansFilter("FSC-H"=c("Low","Medium","High"),
                                 filterId="myKMeans"))

## ----Split2, echo=TRUE, results='markup'--------------------------------------
split(smaller, kmeansFilter("FSC-H"=c("Low", "Medium", "High"),
                            filterId="myKMeans"))

## ----CombineFilter, echo=TRUE, results='markup'-------------------------------

rectGate & morphGate
rectGate | morphGate
!morphGate


## ----Summary5, echo=TRUE, results='markup'------------------------------------
summary(filter(smaller[[1]],rectGate %&% morphGate))

## ----Transfo5, echo=TRUE,results='markup'-------------------------------------
tFilter <- transform("FL1-H"=log,"FL2-H"=log)
tFilter

## ----TectGate3, echo=TRUE, results='markup'-----------------------------------
rect2 <- rectangleGate(filterId="Another Rect", "FL1-H"=c(1,2), 
"FL2-H"=c(2,3)) %on% tFilter
rect2

## ----Plot6,echo=TRUE, results='hide'------------------------------------------
#autoplot(tFilter %on% smaller[[1]], "FL1-H","FL2-H")
autoplot_bjk(tFilter %on% smaller[[1]], "FL1-H","FL2-H")

## ----loadData-----------------------------------------------------------------
library(flowWorkspace)
fcsfiles <- list.files(pattern = "CytoTrol",
                       system.file("extdata", 
                                   package = "flowWorkspaceData"),
                       full = TRUE)
fs <- read.flowSet(fcsfiles)


## ----createGatingSet----------------------------------------------------------
gs <- GatingSet(fs)
gs

## ----getComp, echo=FALSE------------------------------------------------------
gs_manual <- load_gs(list.files(pattern = "gs_manual",
                                system.file("extdata", package = "flowWorkspaceData"),
                                full = TRUE))
comp <- gh_get_compensations(gs_manual[[1]])

## ----Compensate---------------------------------------------------------------
comp
gs <- compensate(gs, comp)
fs_comp <- getData(gs)

## ----nodes--------------------------------------------------------------------
gs_get_pop_paths(gs)

## ----addTrans-----------------------------------------------------------------
biexpTrans <- flowJo_biexp_trans(channelRange=4096, maxValue=262144
                          , pos=4.5,neg=0, widthBasis=-10)
chnls <- parameters(comp)
tf <- transformerList(chnls, biexpTrans)

# or use estimateLogicle directly on GatingHierarchy 
# object to generate transformerList automatically:
# tf <- estimateLogicle(gs[[1]], chnls)

gs <- transform(gs, tf)

## ----plotTrans,echo=TRUE, results='hide'--------------------------------------
# p1 <- autoplot(fs_comp[[1]], "B710-A") + ggtitle("raw")
# p2 <- autoplot(gs_cyto_data(gs)[[1]], "B710-A") + 
#           ggtitle("trans") + 
#           ggcyto_par_set(limits = "instrument")
# grid.arrange(as.ggplot(p1), as.ggplot(p2), ncol = 2)
autoplot_bjk(fs_comp[[1]], "B710-A") + ggtitle("raw")
autoplot_bjk(gs_cyto_data(gs)[[1]], "B710-A") + 
  ggtitle("trans") + xlim(0, 4e3)
#+   ggcyto_par_set(limits = "instrument")



## ----addGate-nonDebris--------------------------------------------------------
rg1 <- rectangleGate("FSC-A"=c(50000, Inf), filterId="NonDebris")
gs_pop_add(gs, rg1, parent = "root")
gs_get_pop_paths(gs)
# gate the data
recompute(gs)

## ----plotGate,echo=TRUE, results='hide'---------------------------------------
#autoplot(gs, "NonDebris")
autoplot_bjk(gs_cyto_data(gs)[[1]], "NonDebris")

## ----plotGate-density,echo=TRUE, results='hide'-------------------------------
ggcyto(gs, aes(x = `FSC-A`)) + geom_density() + geom_gate("NonDebris")

## ----getStats1----------------------------------------------------------------
gh_pop_get_stats(gs[[1]], "NonDebris")#counts
gh_pop_get_stats(gs[[1]], "NonDebris", type = "percent")#proportion

## ----addGate-singlets---------------------------------------------------------
# add the second gate
mat <- matrix(c(54272,59392,259071.99382782
                ,255999.994277954,62464,43008,70656
                ,234495.997428894,169983.997344971,34816)
              , nrow = 5)
colnames(mat) <-c("FSC-A", "FSC-H")
mat
pg <- polygonGate(mat)
gs_pop_add(gs, pg, parent = "NonDebris", name = "singlets")

# add the third gate
rg2 <- rectangleGate("V450-A"=c(2000, Inf))
gs_pop_add(gs, rg2, parent = "singlets", name = "CD3")
gs_get_pop_paths(gs)


## ----addQuadGate--------------------------------------------------------------
qg <- quadGate("B710-A" = 2000, "R780-A" = 3000)
gs_pop_add(gs, qg, parent="CD3", names = c("CD8", "DPT", "CD4", "DNT"))
gs_pop_get_children(gs[[1]], "CD3")
# gate the data from "singlets"
recompute(gs, "singlets")

## ----plotgs, eval=FALSE-------------------------------------------------------
#  plot(gs)

## ----plotwfdo, echo=FALSE, results='hide'-------------------------------------
if(suppressWarnings(require(Rgraphviz))){
    plot(gs)
}else{
    plot(1,1, type="n", axes=FALSE, ann=FALSE)
    text(1,1,"Need to install Rgraphviz")
}

## ----plotGateAll, results='hide'----------------------------------------------
autoplot(gs[[1]])

## ----getData------------------------------------------------------------------
fs_nonDebris <- getData(gs, "NonDebris")
fs_nonDebris 
nrow(fs_nonDebris[[1]])
nrow(fs[[1]])

## ----getStats2----------------------------------------------------------------
gs_pop_get_count_fast(gs)

## ----Rm-----------------------------------------------------------------------
Rm('CD3', gs)
gs_get_pop_paths(gs)
Rm('NonDebris', gs)
gs_get_pop_paths(gs)

## ----openCyto-nonDebris-------------------------------------------------------
if(require(openCyto)){
thisData <- getData(gs)
nonDebris_gate <- fsApply(thisData,
                          function(fr)
                            openCyto:::.mindensity(fr, channels = "FSC-A"))
gs_pop_add(gs, nonDebris_gate, parent = "root", name = "nonDebris")
recompute(gs)
}

## ----openCyto-singletGate-----------------------------------------------------
if(require(openCyto)){
thisData <- getData(gs, "nonDebris") #get parent data
singlet_gate <- fsApply(thisData,
                        function(fr)
                          openCyto:::.singletGate(fr, channels =c("FSC-A", "FSC-H")))
gs_pop_add(gs, singlet_gate, parent = "nonDebris", name = "singlets")
recompute(gs)
}

## ----openCyto-CD3-------------------------------------------------------------
if(require(openCyto)){
thisData <- getData(gs, "singlets") #get parent data
CD3_gate <- fsApply(thisData,
                    function(fr)
                      openCyto:::.mindensity(fr, channels ="V450-A"))
gs_pop_add(gs, CD3_gate, parent = "singlets", name = "CD3")
recompute(gs)
}

## ----openCyto-Tsub------------------------------------------------------------
if(require(openCyto)){
thisData <- getData(gs, "CD3") #get parent data
Tsub_gate <- fsApply(thisData,
                     function(fr)
                      openCyto::quadGate.seq(fr,
                            channels = c("B710-A", "R780-A"),
                            gFunc = 'mindensity')
                    )
gs_pop_add(gs, Tsub_gate, parent = "CD3", names = c("CD8", "DPT", "CD4", "DNT"))
recompute(gs)
}

## ----plotALL-openCyto, results='hide'-----------------------------------------
autoplot(gs[[1]])

