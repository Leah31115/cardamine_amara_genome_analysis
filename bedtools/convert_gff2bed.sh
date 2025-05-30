#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20g
#SBATCH --time=24:00:00
#SBATCH --job-name=gff2bed
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate bedtools

# Change to working directory
cd /path/to/cardamine_amara_genome_analysis/bedtools

# Convert gff to bed
python gff2bed.py

# Deactivate conda environment
conda deactivate
