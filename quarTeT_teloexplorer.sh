#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30g
#SBATCH --time=24:0:00
#SBATCH --job-name=quarTeT_teloexplorer_camara
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate quarTeT

# Move to cloned quarTeT github directory
cd /path/to/cardamine_amara_genome_analysis/quarTeT

# File paths
haplome_data_dir=/path/to/cardamine_amara_haplomes

# Predict telomeres for haplome 1
python3 quartet.py TeloExplorer -i $haplome_data_dir/C087_203_mapq_hap1_8.fa \
    -c plant \
    -m 80 \
    -p hap1_8_telo

# Predict telomeres for haplome 2
python3 quartet.py TeloExplorer -i $haplome_data_dir/C087_203_mapq_hap2_8.fa \
    -c plant \
    -m 80 \
    -p hap1_8_telo

# Deactivate conda environment
conda deactivate

