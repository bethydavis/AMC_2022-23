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

  # Set primer
  # Set version and date for each time the analysis script is run - SET THIS EVERY TIME
versiondate <- c("5-May02-2024/")
  # base output folder
base_outputs <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S"

  # Combine strings to make a new path
output_version <- paste(base_outputs, versiondate, sep = "/")

  # Create version output directory if it doesn't exist - if it does exist, it'll just throw a warning
dir.create(output_version, showWarnings = FALSE)

  # Set version output as the output path for items from this run
path_outputs <- output_version

# Set raw paths
path_raw12F <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/Raw/12S/Read1"
path_raw12R <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/Raw/12S/Read2"

# Set filter folder and version
base_filt12F <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/Filtered/12S Forward"
base_filt12R <- "G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/Filtered/12S Reverse"

filtF_version <- paste(base_filt12F, versiondate, sep = "/")
filtR_version <- paste(base_filt12R, versiondate, sep = "/")

# Create filter folders if they don't already exist, and set the path object
dir.create(filtF_version, showWarnings = FALSE)
dir.create(filtR_version, showWarnings = FALSE)

path_filt12F <- filtF_version
path_filt12R <- filtR_version


# Identify metadata and reference database locations
meta <- read.csv("C:/Users/bydav/Desktop/AMCMeta.csv")
refDB_12S <- 'C:/Users/bydav/Desktop/a04_REFDBdada.fasta'