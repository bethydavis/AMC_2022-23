# Identify packages to use
packages = list(
  CRAN = c("ggplot2", "vegan", "dplyr", "vegan", "viridis", "ggpubr", "fossil", "paletteer"),
  bioc = c("BiocManager", "phyloseq"),
  github = c()
)

# Manage installations as needed
installed = installed.packages() |> rownames()
for (pkg in packages$CRAN){
  if (!pkg %in% installed) install.packages(pkg, repos = "https://cloud.r-project.org/", update = FALSE)
  
}
for (pkg in packages$bioc){
  if (!pkg %in% installed) BiocManager::install(pkg, update = FALSE)
  
}
for (pkg in names(packages$github)){
  if (!pkg %in% installed) remotes::install_github(file.path(packages$github[pkg], pkg), update = FALSE)
}

# Load packages from library, quietly
suppressPackageStartupMessages({
  for (p in packages$CRAN) library(p, character.only = TRUE)
  for (p in packages$bioc) library(p, character.only = TRUE)
  for (p in names(packages$github)) library(p, character.only = TRUE)
})

path_outputs <- "C:/Users/bydav/Desktop/ThesisFigs/AMC"

# Cleaned Phyloseq Object
psCOI <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB/5-May03-2024/CleanPhyloseq.RDS")
psCOI <- subset_samples(psCOI, Treatment%in%c("LWA"))

# Stacked Bar Function for Cleaned Phyloseq
psCOI.stack <- transform_sample_counts(psCOI, function(x) x / sum(x) )

# Cleaned Phyloseq Object
ps12 <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/6-Jun03-2024/CleanPhyloseq.RDS")
ps12 <- subset_samples(ps12, Treatment%in%c("LWA"))

# Stacked Bar Function for Cleaned Phyloseq
ps12.stack <- transform_sample_counts(ps12, function(x) x / sum(x) )

# Use the following for cleaner plots - pay attention to taxonomic rank
psCOI.class = tax_glom(psCOI, taxrank="Class", NArm=FALSE)
ps12.class = tax_glom(ps12, taxrank="Class", NArm=FALSE)

psCOI.fam = tax_glom(psCOI, taxrank="Family", NArm=FALSE)
ps12.fam = tax_glom(ps12, taxrank="Family", NArm=FALSE)

psCOI.sp = tax_glom(psCOI, taxrank="Species", NArm=FALSE)
ps12.sp = tax_glom(ps12, taxrank="Species", NArm=FALSE)

meltCOI <- melt_phyloseq(psCOI)
melt12 <- melt_phyloseq(ps12)
meltCOIun <- subset(meltCOI, Abundance > "0")
melt12un <- subset(melt12, Abundance > "0")

# Separate phyloseq objects for LWA only (excluding the survey region)
