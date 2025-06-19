# Load config file
source("R/01_config.R")

# Isolate files ending in .gz
fastqsMF <- list.files(path_rawMF, pattern = "\\.fastq.gz$")
fastqsMR <- list.files(path_rawMR, pattern = "\\.fastq.gz$")
##
fastqsBF <- list.files(path_rawBF, pattern = "\\.fastq.gz$")
fastqsBR <- list.files(path_rawBR, pattern = "\\.fastq.gz$")

# To prepare the filtered sequence names, all we need to do is swap _MR# for _MF#
idMF <- gsub("_MR1", "_MF1", fastqsMF)
idMR <- gsub("_MR2", "_MF2", fastqsMR)
##
idBF <- gsub("_BR1", "_BF1", fastqsBF)
idBR <- gsub("_BR2", "_BF2", fastqsBR)

# Recommended for first time trimming: plot quality profile plots
  # Raw sequence files may have quality issues, so plot random files instead of an aggregate
  
#path_fastMF <- file.path(path_rawMF, fastqsMF)
#plot(QualityProfile(path_fastMF[6]))

  # Do this as many times as you like to get an idea of how to trim and be sure to change path_fast for which primer and direction you want to examing

# FilterandTrim
  # The indexes and adapters have been removed from the sequence files, but the original primers are still attached
  # 12S MiFish region: ~170 (average length of 170, as measured by source paper)
    # 12S Forward primer: 21 - GTCGGTAAAACTCGTGCCAGC
    # 12S Reverse primer: 27 - CATAGTGGGGTATCTAATCCCAGTTTG
    # Trim both forward and reverse after 220 for quality dip
  # BF2/BR2 COI Region: ~420 bp - this is longer than the cycle length, but should still provide 260bp of overlap
    # BF2 primer length: 20 -  GCHCCHGAYATRGCHTTYCC 
    # BR2 primer length: 20 -  TCDGGRTGNCCRAARAAYCA 
    # Given a desired score of 25+, trim reverse after 250 and forward after 280
  
filtM <- filterAndTrim(file.path(path_rawMF, fastqsMF), file.path(path_filtMF, idMF), file.path(path_rawMR, fastqsMR), file.path(path_filtMR, idMR), trimLeft = c(21,27), trimRight=c(80), maxN=0, maxEE=c(2,2), verbose=TRUE) 
##
filtB <- filterAndTrim(file.path(path_rawBF, fastqsBF), file.path(path_filtBF, idBF), file.path(path_rawBR, fastqsBR), file.path(path_filtBR, idBR), trimLeft = c(20,20), trimRight=c(20,50), maxN=0, maxEE=c(2,2), verbose=TRUE) 

# Optional: plot quality scores of the aggregated filtered sequence files

#plotQualityProfile(path_filtMF, aggregate = TRUE)
#plotQualityProfile(path_filtMR, aggregate = TRUE)
##
#plotQualityProfile(path_filtBF, aggregate = TRUE)
#plotQualityProfile(path_filtBR, aggregate = TRUE)

  # If you choose to do this, it WILL take a while
#beep(sound = "fanfare")

# MANUAL: Save objects for future reference (just in case)
saveRDS(filtM, "Data/Outputs/2025-06-17/12S/InterimObjects/FiltOutput.rds")
##
saveRDS(filtB, "Data/Outputs/2025-06-17/COIB/InterimObjects/FiltOutput.rds")

beep(sound = "fanfare")

# Prepare for Sequence Tables:
  # Create a list of files in the path
filtMF <- list.files(path_filtMF, pattern = "\\.fastq.gz$", full.names = TRUE)
filtMR <- list.files(path_filtMR, pattern = "\\.fastq.gz$", full.names = TRUE)
##
filtBF <- list.files(path_filtBF, pattern = "\\.fastq.gz$", full.names = TRUE)
filtBR <- list.files(path_filtBR, pattern = "\\.fastq.gz$", full.names = TRUE)

# Dereplicate
derepMF <- derepFastq(filtMF, verbose=TRUE)
derepMR <- derepFastq(filtMR, verbose=TRUE)
##
derepBF <- derepFastq(filtBF, verbose=TRUE)
derepBR <- derepFastq(filtBR, verbose=TRUE)

beep(sound = "fanfare")

# Estimate errors
errMF <- learnErrors(derepMF, multithread = FALSE, randomize = TRUE)
errMR <- learnErrors(derepMR, multithread = FALSE, randomize = TRUE)
##
errBF <- learnErrors(derepBF, multithread = FALSE, randomize = TRUE)
errBR <- learnErrors(derepBR, multithread = FALSE, randomize = TRUE)

# MANUAL: Save objects for future reference (just in case)
saveRDS(errMF, "Data/Outputs/2025-06-17/12S/InterimObjects/Forward_Error.rds")
saveRDS(errMR, "Data/Outputs/2025-06-17/12S/InterimObjects/Reverse_Error.rds")
##
saveRDS(errBF, "Data/Outputs/2025-06-17/COIB/InterimObjects/Forward_Error.rds")
saveRDS(errBR, "Data/Outputs/2025-06-17/COIB/InterimObjects/Reverse_Error.rds")

# Generate and save error plots
ggsave("Forward_ErrorPlot.png", path = path_figM, plotErrors(errMF, nominalQ = TRUE), width = 6, height = 4, units = "in") 
ggsave("Reverse_ErrorPlot.png", path = path_figM, plotErrors(errMR, nominalQ = TRUE), width = 6, height = 4, units = "in") 
##
ggsave("Forward_ErrorPlot.png", path = path_figB, plotErrors(errBF, nominalQ = TRUE), width = 6, height = 4, units = "in") 
ggsave("Reverse_ErrorPlot.png", path = path_figB, plotErrors(errBR, nominalQ = TRUE), width = 6, height = 4, units = "in") 

beep(sound = "fanfare")

# Infer sample composition
dadaMF <- dada(derepMF, err = errMF, multithread = FALSE)
dadaMR <- dada(derepMR, err = errMR, multithread = FALSE)
##
dadaBF <- dada(derepBF, err = errBF, multithread = FALSE)
dadaBR <- dada(derepBR, err = errBR, multithread = FALSE)

# Notification
beep(sound = "fanfare")

# MANUAL: Save objects for future reference (just in case)
saveRDS(dadaMF, "Data/Outputs/2025-06-17/12S/InterimObjects/Forward_SampleComp.rds")
saveRDS(dadaMR, "Data/Outputs/2025-06-17/12S/InterimObjects/Reverse_SampleComp.rds")
##
saveRDS(dadaBF, "Data/Outputs/2025-06-17/COIB/InterimObjects/Forward_SampleComp.rds")
saveRDS(dadaBR, "Data/Outputs/2025-06-17/COIB/InterimObjects/Reverse_SampleComp.rds")

# Make sequence tables
mergeM <- mergePairs(dadaMF, path_filtMF, dadaMR, path_filtMR, verbose=TRUE)
##
mergeB <- mergePairs(dadaBF, path_filtBF, dadaBR, path_filtBR, verbose=TRUE)

# Turn into a sequence table
seqtabM <- makeSequenceTable(mergeM)
##
seqtabB <- makeSequenceTable(mergeB)

# Remove chimeras
seqtabM_NC <- removeBimeraDenovo(seqtabM, method = "consensus", multithread = FALSE, verbose = TRUE)
##
seqtabB_NC <- removeBimeraDenovo(seqtabB, method = "consensus", multithread = FALSE, verbose = TRUE)

# MANUAL: Save objects for future reference (just in case)
saveRDS(seqtabM, "Data/Outputs/2025-06-17/12S/InterimObjects/MergedSampleComp.rds")
saveRDS(seqtabM_NC, "Data/Outputs/2025-06-17/12S/InterimObjects/MergedSeqTab_NoChim.rds")
##
saveRDS(seqtabB, "Data/Outputs/2025-06-17/COIB/InterimObjects/MergedSampleComp.rds")
saveRDS(seqtabB_NC, "Data/Outputs/2025-06-17/COIB/InterimObjects/MergedSeqTab_NoChim.rds")

# Workflow Verification
# Set function
getN <- function(x) sum(getUniques(x))

# Combine read numbers for post-filtering steps
trackM <- cbind(sapply(dadaMF, getN), sapply(dadaMR, getN), sapply(mergeM, getN), rowSums(seqtabM_NC))
##
trackB <- cbind(sapply(dadaBF, getN), sapply(dadaBR, getN), sapply(mergeB, getN), rowSums(seqtabB_NC))

# Set column names
colnames(trackM) <- c("denoisedF", "denoisedR", "merged", "nonchim")
##
colnames(trackB) <- c("denoisedF", "denoisedR", "merged", "nonchim")

# Clean each dataframe of tracking information and prepare for merging
FtrackM <- as.data.frame(filtM)
FtrackM$Sample <- row.names(FtrackM)
row.names(FtrackM) <- NULL
FtrackM$Sample <- gsub("_MR1.fastq.gz", "", FtrackM$Sample)
FtrackM <- FtrackM %>% select(Sample, everything())

trackM <- as.data.frame(trackM)
trackM$Sample <- row.names(trackM)
row.names(trackM) <- NULL
trackM$Sample <- gsub("_MF1.fastq.gz", "", trackM$Sample)
trackM <- trackM %>% select(Sample, everything())
##
FtrackB <- as.data.frame(filtB)
FtrackB$Sample <- row.names(FtrackB)
row.names(FtrackB) <- NULL
FtrackB$Sample <- gsub("_BR1.fastq.gz", "", FtrackB$Sample)
FtrackB <- FtrackB %>% select(Sample, everything())

trackB <- as.data.frame(trackB)
trackB$Sample <- row.names(trackB)
row.names(trackB) <- NULL
trackB$Sample <- gsub("_BF1.fastq.gz", "", trackB$Sample)
trackB <- trackB %>% select(Sample, everything())

# Merge tracking dfs
WVM <- merge(FtrackM, trackM, by = "Sample")
##
WVB <- merge(FtrackB, trackB, by = "Sample")

# Plot filter trends
WVMplot <- ggplot(as.data.frame(WVM)) + 
  geom_point(aes(row.names(WVM), reads.in), color = "gold", size = 2.5) +
  geom_point(aes(row.names(WVM), reads.out), color = "yellowgreen") +
  geom_point(aes(row.names(WVM), denoisedF), color = "darkgreen") +
  geom_point(aes(row.names(WVM), denoisedR), color = "blue") +
  geom_point(aes(row.names(WVM), merged), color = "darkblue") +
  geom_point(aes(row.names(WVM), nonchim), color = "purple", size = 2.5) +
  theme_bw() + 
  theme(axis.text.x = element_blank()) +
  ggtitle("Workflow Progression for AMC 12S Reads") + labs(x = "Sample", y = "Number of Reads")
##
WVBplot <- ggplot(as.data.frame(WVB)) + 
  geom_point(aes(row.names(WVB), reads.in), color = "gold", size = 2.5) +
  geom_point(aes(row.names(WVB), reads.out), color = "yellowgreen") +
  geom_point(aes(row.names(WVB), denoisedF), color = "darkgreen") +
  geom_point(aes(row.names(WVB), denoisedR), color = "blue") +
  geom_point(aes(row.names(WVB), merged), color = "darkblue") +
  geom_point(aes(row.names(WVB), nonchim), color = "purple", size = 2.5) +
  theme_bw() + 
  theme(axis.text.x = element_blank()) +
  ggtitle("Workflow Progression for AMC COI Reads") + labs(x = "Sample", y = "Number of Reads")

# Save plots and df results
ggsave("WVM_plot.png", plot = WVMplot, path = path_figM, width = 6, height = 4, units = "in")
write.csv(WVM, file.path(path_outM, "WorkflowVerification.csv"))
##
ggsave("WVB_plot.png", plot = WVBplot, path = path_figB, width = 6, height = 4, units = "in")
write.csv(WVB, file.path(path_outB, "WorkflowVerification.csv"))