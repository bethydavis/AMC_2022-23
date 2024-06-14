# Reload paths for set parameters for ease of figure/table creation

# Filter Output Table
filtout12sync <- read.csv(file.path(path_outputs, "FiltoutputTable.csv"))

# Error Rates
err12F <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/5-May02-2024/12Forward_Error.rds")
err12R <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/5-May02-2024/12Reverse_Error.rds")

# Sample Composition
dada12F <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/6-Jun03-2024/12Forward_SampleComp.rds")
dada12R <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/6-Jun03-2024/12Reverse_SampleComp.rds")

# Merged Sequence Table
seqtab <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/6-Jun03-2024/12MergedSampleComp.rds")

# Sequence Table with Chimeras Removed
seqtab12.nochim <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/6-Jun03-2024/12Merged Sequence No Chimera Table.rds")

# Workflow Verification
track12 <- read.csv(file.path(path_outputs, "12S_WorkflowVerification.csv"))

# Assigned Taxonomy Table
all.taxa <- read.csv(file.path(path_outputs, "12SAMC_AssignedTaxa.csv"))

# Initial Phyloseq Object
EX_ps <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/6-Jun03-2024/InitialPhyloseq.rds")

# Decontam Removed Taxa
pstrimmed <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/6-Jun03-2024/DecontamRemoved.rds")

# Cleaned Phyloseq Object
ps12S <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/12S/6-Jun03-2024/CleanPhyloseq.RDS")

# Stacked Bar Function for Cleaned Phyloseq
ps12S.stack <- transform_sample_counts(ps12S, function(x) x / sum(x) )




