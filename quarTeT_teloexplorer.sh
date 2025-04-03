#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30g
#SBATCH --time=24:0:00
#SBATCH --job-name=quarTeT_teloexplorer_camara
#SBATCH --output=/share/BioinfMSc/rot3_group1/logs/%x-%j.out
#SBATCH --error=/share/BioinfMSc/rot3_group1/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate quarTeT

# Move to cloned quarTeT github directory
cd /share/BioinfMSc/rot3_group1/quarTeT/quarTeT

# File paths
genome_dir=/share/BioinfMSc/rotation3/cardamine_amara_v0.9

# Predict telomeres for haplome 1
python3 quartet.py TeloExplorer -i $genome_dir/C087_203_mapq_hap1_8.fa \
    -c plant \
    -m 80 \
    -p hap1_8_telo

# Predict telomeres for haplome 2
python3 quartet.py TeloExplorer -i $genome_dir/C087_203_mapq_hap2_8.fa \
    -c plant \
    -m 80 \
    -p hap1_8_telo

# Deactivate conda environment
conda deactivate

