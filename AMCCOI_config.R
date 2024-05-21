# Identify packages to use
packages = list(
  CRAN = c("ggplot2", "vegan", "beepr"),
  bioc = c("BiocManager", "dada2", "phyloseq"),
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

# Set up output folder and version

  # Set version and date for each time the analysis script is run - SET THIS EVERY TIME
versiondate <- c("5-May03-2024/")
  # base output folder
base_outputs <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB"

  # Combine strings to make a new path
output_version <- paste(base_outputs, versiondate, sep = "/")

  # Create version output directory if it doesn't exist - if it does exist, it'll just throw a warning
dir.create(output_version, showWarnings = FALSE)

  # Set version output as the output path for items from this run
path_outputs <- output_version

# Set raw paths
path_rawBF <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/Raw/BF2BR2/Read1"
path_rawBR <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/Raw/BF2BR2/Read2"

# Set filter folder and version
base_filtBF <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/Filtered/BF Forward"
base_filtBR <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/Filtered/BR Reverse"

filtF_version <- paste(base_filtBF, versiondate, sep = "/")
filtR_version <- paste(base_filtBR, versiondate, sep = "/")

dir.create(filtF_version, showWarnings = FALSE)
dir.create(filtR_version, showWarnings = FALSE)

path_filtBF <- filtF_version
path_filtBR <- filtR_version

# Identify metadata and reference database locations
#meta <- read.csv("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/AMCMeta.csv")
# Figure out how to load in fasta's properly
#C:/Users/bydav/Desktop/RefDB_Dev/output/3-May19-2024/COI_REFDB.fasta  

