#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10g
#SBATCH --time=05:00:00
#SBATCH --job-name=samtools
#SBATCH --output=/share/BioinfMSc/rot3_group1/logs/%x-%j.out
#SBATCH --error=/share/BioinfMSc/rot3_group1/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate samtools

# Make samtools directory in root directory
cd /share/BioinfMSc/rot3_group1/github/cardamine_amara_genome_analysis
mkdir -p Samtools
work_dir=/share/BioinfMSc/rot3_group1/github/cardamine_amara_genome_analysis/Samtools
cd $work_dir

# Copy haplome data to samtools working directory
genome_dir=/share/BioinfMSc/rotation3/cardamine_amara_v0.9
cp $genome_dir/C087_203_mapq_hap1_8.fa $work_dir
cp $genome_dir/C087_203_mapq_hap2_8.fa $work_dir

# Index haplomes
samtools faidx C087_203_mapq_hap1_8.fa
samtools faidx C087_203_mapq_hap2_8.fa

# Filter for chromosomes of interest and combine them together
samtools faidx C087_203_mapq_hap1_8.fa RL_5 > hap1rl5.fa
samtools faidx C087_203_mapq_hap2_8.fa RL_2 > hap2rl2.fa
cat hap1rl5.fa hap2rl2.fa > h1rl5_h2rl2.fasta

# Subset the block of interest from the chromosomes of interest
samtools faidx C087_203_mapq_hap1_8.fa RL_5:16000000-23979000 > hap1_rl5_block.fasta
samtools faidx C087_203_mapq_hap2_8.fa RL_2:8923000-19004000 > hap2_rl2_block.fasta

# Deactivate conda environment
conda deactivate
