# load config file
source("R/config.R")

# Specify file name formats
fnsMF <- list.files(path_rawMF)
fastqsMF <- fnsMF[grepl('.gz$', fnsMF)]
##
fnsMR <- list.files(path_rawMR)
fastqsMR <- fnsMR[grepl('.gz$', fnsMR)]
##
fnsBF <- list.files(path_rawBF)
fastqsBF <- fnsBF[grepl('.gz$', fnsBF)]
##
fnsBR <- list.files(path_rawBR)
fastqsBR <- fnsBR[grepl('.gz$', fnsBR)]

# Set sample names to a vector, remove path and the .gz extension
idMF <- tools::file_path_sans_ext(basename(fastqsMF))
idMF <- tools::file_path_sans_ext(idMF)
##
idMR <- tools::file_path_sans_ext(basename(fastqsMR))
idMR <- tools::file_path_sans_ext(idMR)
##
idBF <- tools::file_path_sans_ext(basename(fastqsBF))
idBF <- tools::file_path_sans_ext(idBF)
##
idBR <- tools::file_path_sans_ext(basename(fastqsBR))
idBR <- tools::file_path_sans_ext(idBR)

# Create another object to list the path to the fastq files
fastqpath_MF <- file.path(path_rawMF, fastqsMF)
fastqpath_MR <- file.path(path_rawMR, fastqsMR)
##
fastqpath_BF <- file.path(path_rawBF, fastqsBF)
fastqpath_BR <- file.path(path_rawBR, fastqsBR)

# FilterandTrim
filtM <- filterAndTrim(file.path(path_rawMF, fastqsMF), file.path(path_filtMF, paste0(idMF, "_filt.fastq.gz")), file.path(path_rawMR, fastqsMR), file.path(path_filtMR, paste0(idMR, "_filt.fastq.gz")), trimLeft = c(21,27), trimRight=c(80), maxN=0, maxEE=c(2,2), verbose=TRUE) 
print("Finished filtering 12S sequences")
##
filtB <- filterAndTrim(file.path(path_rawBF, fastqsBF), file.path(path_filtBF, paste0(idBF, "_filt.fastq.gz")), file.path(path_rawBR, fastqsBR), file.path(path_filtBR, paste0(idBR, "_filt.fastq.gz")), trimLeft = c(20,20), trimRight=c(20,50), maxN=0, maxEE=c(2,2), verbose=TRUE) 
print("Finished filtering COI sequences")

# MANUAL: Save outputs
saveRDS(filtM, "Data/Outputs/06-10-25/12S/InterimObjects/FiltOutput.rds")
saveRDS(filtB, "Data/Outputs/06-10-25/COIB/InterimObjects/FiltOutput.rds")
##
beep(sound = "fanfare")

###########################################


# Set the names for the filtered files we'll be using

# create a list of files in the path
filtnames12Finter <- list.files(path_filt12F, full.names = TRUE)

# Specify I only want the files with the .gz extension
filtnames12F <- filtnames12Finter[grepl('.gz$', filtnames12Finter)]

# Extract just the file name, not the path, and remove the .gz extension. This leaves on the .fastq extension
fastqfilt12F <- tools::file_path_sans_ext(basename(filtnames12F))

# Remove the .fastq extension
names12Ffilt <- tools::file_path_sans_ext(basename(fastqfilt12F))



# Repeat for the other folders

# 12Reverse
filtnames12Rinter <- list.files(path_filt12R, full.names = TRUE)
filtnames12R <- filtnames12Rinter[grepl('.gz$', filtnames12Rinter)]
fastqfilt12R <- tools::file_path_sans_ext(basename(filtnames12R))
names12Rfilt <- tools::file_path_sans_ext(basename(fastqfilt12R))

# BForward
filtnamesBFinter <- list.files(path_filtBF, full.names = TRUE)
filtnamesBF <- filtnamesBFinter[grepl('.gz$', filtnamesBFinter)]
fastqfiltBF <- tools::file_path_sans_ext(basename(filtnamesBF))
namesBFfilt <- tools::file_path_sans_ext(basename(fastqfiltBF))

# BReverse
filtnamesBRinter <- list.files(path_filtBR, full.names = TRUE)
filtnamesBR <- filtnamesBRinter[grepl('.gz$', filtnamesBRinter)]
fastqfiltBR <- tools::file_path_sans_ext(basename(filtnamesBR))
namesBRfilt <- tools::file_path_sans_ext(basename(fastqfiltBR))