#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=15g
#SBATCH --time=24:00:00
#SBATCH --job-name=barrnap
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate barrnap

# Move to cloned barrnap github directory
cd /path/to/cardamine_amara_genome_analysis/barrnap/bin

# Paths
haplome_data_dir=/path/to/cardamine_amara_haplomes
out_dir=/path/to/cardamine_amara_genome_analysis/barrnap

# Annotate rRNA genes for haplome 1
./barrnap --quiet \
    --threads 16 \
    --kingdom euk \
    $haplome_data_dir/C087_203_mapq_hap1_8.fa > $out_dir/c_amara_hap1_rrna.gff3

# Annotate rRNA genes for haplome 2
./barrnap --quiet \
    --threads 16 \
    --kingdom euk \
    $haplome_data_dir/C087_203_mapq_hap2_8.fa > $out_dir/c_amara_hap2_rrna.gff3

# Deactivate conda environment
conda deactivate
