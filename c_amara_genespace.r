# Load in library
library(GENESPACE)

# Paths
wd <- "/path/to/cardamine_amara_genome_analysis/GENESPACE"
path2mcscanx <- "~/LIFE4137-HPC_practice/exit/envs/genespace4/bin" # Path to your conda environment bin dir

# Initialise the genespace run and set the run parameters
gpar <- init_genespace(
 wd = wd,
 path2mcscanx = path2mcscanx)

# Run genespace
out <- run_genespace(gpar, overwrite = T)

