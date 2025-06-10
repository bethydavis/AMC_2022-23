# Confirmed libraries:
if(!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("dada2")
install.packages("ggplot2")
install.packages("beepr")

library(dada2)
library(ggplot2)
library(beepr)


# Possible libraries:
library(tinytex)
library(GenomeInfoDbData)
library(ShortRead)
library(phyloseq); packageVersion("phyloseq")
require(tidyr) 
require(dplyr)
library(vegan)
library(RColorBrewer)
library(ggpubr)
library(ggsignif)
require(grid)
library(PerformanceAnalytics) 
library(vegan)
library(lme4) 
library(nlme)
library(lmerTest) 
library(emmeans)
library(viridis)
library(SiMRiv)
library(microbiome)
library("DESeq2")
packageVersion("DESeq2")
library(DescTools)
library(conover.test)
install.packages("devtools")
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)
library(DEGreport)
library(ggfortify)
install.packages("remotes")
remotes::install_github("schuyler-smith/phyloschuyler")
library(phylosmith)
library(ggdendro)




# Important paths:
