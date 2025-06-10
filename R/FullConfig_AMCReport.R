## CONFIGURATION
# The following lines set package, path, and versioning information for analyzing the raw fastq files

# Identify packages to use
packages = list(
  CRAN = c("ggplot2", "vegan", "dplyr", "dada2", "vegan", "imager", "viridis", "ggpubr", "fossil", "paletteer", "tidyverse", "rmarkdown", "beepr"),
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

# Load phylosmith 
# devtools::install_github('schuyler-smith/phylosmith') # <- to install
library(phylosmith)

# Set up output folder and version

# Set version and date for each time the analysis script is run - set this each time you run the code with different parameters
primer12 <- c("12S")
primerCOI <- c("COI")

versiondate <- c("Aug28-2024/")
# base output folder
base_outputs <- "outputs"


# Combine strings to make a new path
version12 <- paste(primer12, versiondate, sep = "-")
versionC <- paste(primerCOI, versiondate, sep = "-")

output_version12 <- paste(base_outputs, version12, sep = "/")
output_versionC <- paste(base_outputs, versionC, sep = "/")

# Create version output directory if it doesn't exist - if it does exist, it'll just throw a warning
dir.create(output_version12, showWarnings = FALSE)
dir.create(output_versionC, showWarnings = FALSE)

# Set version output as the output path for items from this run
path12_outputs <- output_version12
pathC_outputs <- output_versionC

# Set raw paths for each set of raw files
path_raw12F <- "raw_fastq/fish_12S/Read1"
path_raw12R <- "raw_fastq/fish_12S/Read2"

path_rawBF <- "raw_fastq/invert_COI/Read1"
path_rawBR <- "raw_fastq/invert_COI/Read2"

# Set folder locations for filter files to go into
base_filt12F <- "filter_fastq/forward"
base_filt12R <- "filter_fastq/reverse"

base_filtBF <- "filter_fastq/forward"
base_filtBR <- "filter_fastq/reverse"

# Now  create a versioning name system onto the filter destination - this is helpful if you are testing different filterAndTrim parameters
filt12F_version <- paste(base_filt12F, version12, sep = "/")
filt12R_version <- paste(base_filt12R, version12, sep = "/")

filtBF_version <- paste(base_filtBF, versionC, sep = "/")
filtBR_version <- paste(base_filtBR, versionC, sep = "/")

# Create the filter folders if they don't already exist
dir.create(filt12F_version, recursive = TRUE, showWarnings = FALSE)
dir.create(filt12R_version, recursive = TRUE, showWarnings = FALSE)

dir.create(filtBF_version, recursive = TRUE, showWarnings = FALSE)
dir.create(filtBR_version, recursive = TRUE, showWarnings = FALSE)

# Set the path object for the filter files
path_filt12F <- filt12F_version
path_filt12R <- filt12R_version

path_filtBF <- filtBF_version
path_filtBR <- filtBR_version

# Set the location of the metadata file
meta <- read.csv("components/AMCMeta.csv", header = TRUE)

## RELOAD
# The following commands are to reload previously made objects (which may be useful for troubleshooting or use as checkpoints for re-analysis). To enable them, remove the # symbols - if the command is enabled but the object doesn't exist in the file path, it will give an error and not proceed any farther.

#err12F <- readRDS("outputs/12S-Aug28-2024//12Forward_Error.rds")
#err12R <- readRDS("outputs/12S-Aug28-2024/12Reverse_Error.rds")
#errBF <- readRDS("outputs/COI-Aug28-2024/ForwardError.rds")
#errBR <- readRDS("outputs/COI-Aug28-2024/ReverseError.rds")
#dada12F <- readRDS("outputs/12S-Aug28-2024/12Forward_SampleComp.rds")
#dada12R <- readRDS("outputs/12S-Aug28-2024/12Reverse_SampleComp.rds")
#dadaBF <- readRDS("outputs/COI-Aug28-2024/BForward_SampleComp.rds")
#dadaBR <- readRDS("outputs/COI-Aug28-2024/BReverse_SampleComp.rds")
#seqtab12 <- readRDS("outputs/12S-Aug28-2024/12MergedSampleComp.rds")
#seqtabB <- readRDS("outputs/COI-Aug28-2024/BMerged Sequence Table.rds")
#seqtab12.nochim <- readRDS("outputs/12S-Aug28-2024/12Merged Sequence No Chimera Table.rds")
#seqtabB.nochim <- readRDS("outputs/COI-Aug28-2024/BMerged Sequence No Chimera Table.rds")
#all.taxa12 <- read.csv(file.path(path12_outputs, "12SAMC_AssignedTaxa.csv"), header = TRUE)
#all.taxaC <- read.csv(file.path(pathC_outputs, "COIAMC_AssignedTaxa.csv"), header = TRUE)
#EX_ps12 <- readRDS("outputs/12S-Aug28-2024/InitialPhyloseq.rds")
#EX_psC <- readRDS("outputs/12S-Aug28-2024/InitialPhyloseqUD.rds")
ps_clean12 <- readRDS("outputs/12S-Aug28-2024/DecontamRemoved12.rds")
ps12S <- readRDS("outputs/12S-Aug28-2024/TargetPhyloseq.RDS")
ps_cleanC <- readRDS("outputs/COI-Aug28-2024/DecontamRemovedC.rds")
psCOI <- readRDS("outputs/COI-Aug28-2024/CleanPhyloseq.RDS")

