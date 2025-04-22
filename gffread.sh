#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20g
#SBATCH --time=24:00:00
#SBATCH --job-name=gffread
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Move to gffread github cloned directory
cd /path/to/cardamine_amara_genome_analysis/gffread

# Make output directories
mkdir -p hap1
mkdir -p hap2

# Paths
genome_dir=/path/to/cardamine_amara_haplomes
subset_genome_dir=/path/to/cardamine_amara_genome_analysis/SamTools
genome_ann_dir=/path/to/cardamine_amara_genome_analysis/Augustus
out_dir=/path/to/cardamine_amara_genome_analysis/gffread

# Translate CDS regions for haplome 1
./gffread -g $genome_dir/C087_203_mapq_hap1_8.fa $genome_ann_dir/c_amara_hap1.gff3 -C -y $out_dir/hap1/hap1.fa

# Translate CDS regions for haplome 2
./gffread -g $genome_dir/C087_203_mapq_hap2_8.fa $genome_ann_dir/c_amara_hap2.gff3 -C -S -y $out_dir/hap2/hap2.fa

# Translate CDS regions for haplome 1 chromosome 5
./gffread -g $subset_genome_dir/hap1rl5.fa $genome_ann_dir/aug_hap1_rl5.gff -C -y $out_dir/hap1/hap1_rl5_protein.fasta

# Translate CDS regions for haplome 2 chromosome 2
./gffread -g $subset_genome_dir/hap2rl2.fa $genome_ann_dir/aug_hap2_rl2.gff -C -y $out_dir/hap2/hap2_rl2_protein.fasta





