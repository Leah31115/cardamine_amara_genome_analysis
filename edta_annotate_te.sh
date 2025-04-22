#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20g
#SBATCH --time=24:00:00
#SBATCH --job-name=EDTA
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate Conda environment
source $HOME/.bash_profile
conda activate EDTA

# Move into cloned EDTA github directory
cd /path/to/cardamine_amara_genome_analysis/EDTA

# Path
haplome_data_dir=/path/to/cardamine_amara_haplomes

# Annotate transposable elements for haplome 1
perl EDTA.pl --genome $haplome_data_dir/C087_203_mapq_hap1_8.fa \
    --overwrite 1 \
    --anno 1 \
    -t 16

# Annotate transposable elements for haplome 2
perl EDTA.pl --genome $haplome_data_dir/C087_203_mapq_hap2_8.fa \
    --overwrite 1 \
    --anno 1 \
    -t 16

# Deactivate conda environment
conda deactivate

