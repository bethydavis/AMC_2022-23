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

### Set the date in MM-DD-YY format:
date <- "06-10-25"

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



## Set Raw, Filtered, and Metadata Locations
### Lastly, we set the paths for where the raw sequence files are, where filtered files should go, and where the metadata sheet is

#### Set raw paths for each set of raw files
path_rawMF <- "Data/Raw/12S/Read1"
path_rawMR <- "Date/Raw/12S/Read2"

path_rawBF <- "Data/Raw/COIB/Read1"
path_rawBR <- "Data/Raw/COIB/Read2"

#### Set folder locations for the filtered sequence files (this once again involves combining strings)
forward <- "Forward"
reverse <- "Reverse"

#### Combine the strings
path_filtMF <- paste(path_outM, forward, sep = "/")
path_filtMR <- paste(path_outM, reverse, sep = "/")

path_filtBF <- paste(path_outB, forward, sep = "/")
path_filtBR <- paste(path_outB, reverse, sep = "/")

#### Create the filter folders if they don't already exist
dir.create(path_filtMF, recursive = TRUE, showWarnings = FALSE)
dir.create(path_filtMR, recursive = TRUE, showWarnings = FALSE)

dir.create(path_filtBF, recursive = TRUE, showWarnings = FALSE)
dir.create(path_filtBR, recursive = TRUE, showWarnings = FALSE)


### Set the location of the metadata file
meta <- read.csv("Data/Input/AMCMeta.csv", header = TRUE)
