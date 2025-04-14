#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=30g
#SBATCH --time=24:00:00
#SBATCH --job-name=trash
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate trash2

# Move to cloned TRASH github repository
cd /path/to/cardamine_amara_genome_analysis/TRASH

# Make output directories
mkdir -p hap1
mkdir -p hap2

# File paths
haplome_data_dir=/path/to/cardamine_amara_haplomes
out_dir=/path/to/cardamine_amara_genome_analysis/TRASH

# Find regions with tandem repeats
./TRASH_run.sh $haplome_data_dir/C087_203_mapq_hap1_8.fa --o $out_dir/hap1
./TRASH_run.sh $haplome_data_dir/C087_203_mapq_hap2_8.fa --o $out_dir/hap2

# Deactivate conda environment
conda deactivate

