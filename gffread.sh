#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=30g
#SBATCH --time=24:00:00
#SBATCH --job-name=gffread
#SBATCH --output=/share/BioinfMSc/rot3_group1/logs/%x-%j.out
#SBATCH --error=/share/BioinfMSc/rot3_group1/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Move to gffread github cloned directory
cd /share/BioinfMSc/rot3_group1/gffread

# Paths
genome_dir=/share/BioinfMSc/rotation3/cardamine_amara_v0.9
genome_ann_dir=/share/BioinfMSc/rot3_group1/Augustus/c_amara
out_dir=/share/BioinfMSc/rot3_group1/gffread

# Translate CDS regions for haplome 1
./gffread -g $genome_dir/C087_203_mapq_hap1_8.fa $genome_ann_dir/c_amara_hap1.gff3 -C -y $out_dir/hap1.fa

# Translate CDS regions for haplome 2
./gffread -g $genome_dir/C087_203_mapq_hap2_8.fa $genome_ann_dir/c_amara_hap2.gff3 -C -S -y $out_dir/hap2.fa

