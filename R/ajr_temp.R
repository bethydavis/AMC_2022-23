library(googledrive)
library(phyloseq)
library(vegan)
library(ggplot2)

# read-in COI
tf <- tempfile(fileext = ".RDS")
d <- drive_download(as_id("1PeLB6Qw_mlu8QKORHdPSS-Or-TLmKSjf"), 
                    path = tf, 
                    overwrite = TRUE)

psCOI <- readRDS(file = d$local_path)
psCOI <- subset_samples(psCOI, Treatment == "LWA")

psCOI_norm <- transform_sample_counts(psCOI, function(x) x / sum(x) )

# remove BLK07 and MB11 because they are outliers
psCOI_mod <- subset_samples(psCOI_norm, 
                            !(rownames(psCOI_norm@otu_table) %in% 
                                c("AMC22_BLK07", "AMC23_MB11")))


# read-in 12S
tf <- tempfile(fileext = ".RDS")
d <- drive_download(as_id("1PGqMF4ylntMXcNTyHQ9KB1t1R2cdMKl8"), 
                    path = tf, 
                    overwrite = TRUE)

ps12 <- readRDS(file = d$local_path)
ps12 <- subset_samples(ps12, Treatment == "LWA")

ps12_norm <- transform_sample_counts(ps12, function(x) x / sum(x) )



# PCOA
JacCOIP <- ordinate(psCOI_mod, method ="PCoA", "jaccard", binary = TRUE)
JacPC <- plot_ordination(psCOI_mod, JacCOIP, type="samples", color="TreatType") 
JacPC + stat_ellipse(geom = "polygon", type = "norm", alpha = 0.4, level = 0.5,
                    aes(fill = TreatType))

# note: we are visualizing the 50% ellipse around the data for each treatment
# type. 50% is not the significance cuttoff we're using (we're using 5%) but 
# just for visualization purposes we're drawing the central tendency at the 50% 
# mark. the permanova gives a p-value with is much less than 0.05

# discussing PCOA graph
# post LWA appears to cluster in top left quad, control and preLWA appear
# clustered in right half...let's do permanova to test significance of that 
# pattern

# PERMANOVA
JacDistCOI <- distance(psCOI_mod, "jaccard", binary = TRUE)
xCOI <- data.frame(sample_data(psCOI_mod))

adonis2(JacDistCOI ~ xCOI$TreatType)

# interpretation of result: significant difference between treatment types (yay!)

# ... repeat above for 12S
Jac12P <- ordinate(ps12_norm, method ="PCoA", "jaccard", binary = TRUE)
JacP12 <- plot_ordination(ps12_norm, Jac12P, type = "samples", color="TreatType")
JacP12 + stat_ellipse(geom = "polygon", type = "norm", alpha = 0.4, level = 0.5,
                      aes(fill = TreatType))

JacDist12 <- distance(ps12_norm, "jaccard", binary = TRUE)
x12 <- data.frame(sample_data(ps12_norm))

adonis2(JacDist12 ~ x12$TreatType)

