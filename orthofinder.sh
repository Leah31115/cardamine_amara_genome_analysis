#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=30g
#SBATCH --time=24:00:00
#SBATCH --job-name=orthofinder
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate orthofinder

# Feed a folder containing C. amara haplome contig blocks of interest (BOI) protein fasta file(s) and A. thaliana protein file to OrthoFinder
# Analyse orthology for haplome 1 rl5 (Hap1_rl5) BOI
orthofinder -f /path/to/cardamine_amara_genome_analysis/orthofinder/hap1 -S mmseqs

# Analyse orthology for haplome 2 rl2 (Hap2_rl2) BOI
orthofinder -f /path/to/cardamine_amara_genome_analysis/orthofinder/hap2 -S mmseqs

# Compare both Hap1_rl5 BOI and Hap2_rl2 BOI
orthofinder -f /path/to/cardamine_amara_genome_analysis/orthofinder/hap1_hap2 -S mmseqs

# Deactivate conda environment
conda deactivate
