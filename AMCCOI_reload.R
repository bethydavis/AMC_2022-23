# Reload paths for set parameters for ease of figure/table creation

# Filter Output Table
filtoutB <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB/5-May03-2024/FiltOutput.rds")

# Error Rates
errBF <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB/5-May03-2024/ForwardError.rds")
errBR <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB/5-May03-2024/ReverseError.rds")

# Sample Composition
dadaBF <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB/5-May03-2024/BForward_SampleComp.rds")
dadaBR <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB/5-May03-2024/BReverse_SampleComp.rds")

# Merged Sequence Table
seqtabB <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB/5-May03-2024/BMerged Sequence Table.rds")

# Sequence Table with Chimeras Removed
seqtabB.nochim <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB/5-May03-2024/BMerged Sequence No Chimera Table.rds")

# Workflow Verification
trackB <- read.csv(file.path(path_outputs, "WorkflowVerification.csv"))

# Assigned Taxonomy Table
all.taxa <- read.csv(file.path(path_outputs, "COIAMC_AssignedTaxa.csv"))

# Initial Phyloseq Object
EX_ps <- readRDS("G:/My Drive/2_UMaine FSM - Field Projects/AMC/Data/dataoutputs/COIB/5-May03-2024/InitialPhyloseq.rds")
