#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20g
#SBATCH --time=10:00:00
#SBATCH --job-name=moddotplot_regions_of_interest
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Source environment for ModDotPlot venv
cd /path/to/cardamine_amara_genome_analysis/ModDotPlot # Move to cloned github ModDotPlot repository
source venv/bin/activate

# Paths
subset_haplome_dir=/path/to/cardamine_amara_genome_analysis/SamTools
out_dir=/path/to/cardamine_amara_genome_analysis/ModDotPlot

# Generate identity maps for the chromosomes of interest
moddotplot static -f $subset_haplome_dir/h1rl5_h2rl2.fasta --compare -o $out_dir/rl5vrl2

# Generate identity maps for the blocks of interest
moddotplot static -f $subset_haplome_dir/hap1rl5hap2rl2blocks.fasta --compare -o $out_dir/rl5vrl2block

# Deactivate conda
conda deactivate
