# Configuration File
## The following lines set package, path, and versioning information for analyzing the raw fastq files

## Identify, Install, and Load Packages 
packages = list(
  CRAN = c("ggplot2", "vegan", "dplyr", "viridis", "ggpubr", "fossil", "paletteer", "tidyverse", "imager", "rmarkdown", "beepr", "stringr"),
  bioc = c("BiocManager", "dada2", "phyloseq", "decontam"),
  github = c()
)

### Manage installations as needed
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

### Load packages from library, quietly
suppressPackageStartupMessages({
  for (p in packages$CRAN) library(p, character.only = TRUE)
  for (p in packages$bioc) library(p, character.only = TRUE)
  for (p in names(packages$github)) library(p, character.only = TRUE)
})


## Set Output Destination
### The output destination is based on a series of modular strings that can be combined for more tidy versioning

### Set the base location:
base <- "Data/Outputs"

### Set the date in YYYY-MM-DD format:
date <- "2025-06-17"

### Set the primer identification:
primerM <- "12S"
primerB <- "COIB"

### Set the type of folder, for figures or interim objects:
interim <- "InterimObjects"
figures <- "Figures"

### Combine the strings to make each of our desired output folders, and create the folders if they donʻt already exist
#### Create output folders for 12S
path_outM <- paste(base, date, primerM, interim, sep = "/")
path_figM <- paste(base, date, primerM, figures, sep = "/")
#### Create output folders for COI
path_outB <- paste(base, date, primerB, interim, sep = "/")
path_figB <- paste(base, date, primerB, figures, sep = "/")

#### Make the directories
dir.create(path_outM, showWarnings = FALSE, recursive = TRUE)
dir.create(path_figM, showWarnings = FALSE, recursive = TRUE)
dir.create(path_outB, showWarnings = FALSE, recursive = TRUE)
dir.create(path_figB, showWarnings = FALSE, recursive = TRUE)


### Load the seqtabNC files- make sure the output versions match
seqtabM_NC <- readRDS("Data/Outputs/2025-06-17/12S/InterimObjects/MergedSeqTab_NoChim.rds")
##
seqtabB_NC <- readRDS("Data/Outputs/2025-06-17/COIB/InterimObjects/MergedSeqTab_NoChim.rds")

### Set the location of the metadata file
meta <- read.csv("Data/Input/AMCMeta.csv", header = TRUE)
