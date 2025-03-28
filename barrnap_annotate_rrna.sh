#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=24:00:00
#SBATCH --job-name=barrnap
#SBATCH --output=/share/BioinfMSc/rot3_group1/logs/%x-%j.out
#SBATCH --error=/share/BioinfMSc/rot3_group1/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate barrnap

# Move to cloned barrnap github directory
cd /share/BioinfMSc/rot3_group1/barrnap/bin

# Fasta files
c_amara_hap1=/share/BioinfMSc/rotation3/cardamine_amara_v0.9/C087_203_mapq_hap1_8.fa
c_amara_hap2=/share/BioinfMSc/rotation3/cardamine_amara_v0.9/C087_203_mapq_hap2_8.fa

# Output directory
out_dir=/share/BioinfMSc/rot3_group1/barrnap/bin

# Annotate rRNA genes for haplome 1
./barrnap --quiet \
    --threads 16 \
    --kingdom euk \
    $c_amara_hap1 > $out_dir/c_amara_hap1_rrna.gff3

# Annotate rRNA genes for haplome 2
./barrnap --quiet \
    --threads 16 \
    --kingdom euk \
    $c_amara_hap2 > $out_dir/c_amara_hap2_rrna.gff3

# Deactivate conda environment
conda deactivate
