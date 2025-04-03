#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30g
#SBATCH --time=34:00:00
#SBATCH --job-name=quarTeT_centro_camara
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
edta_dir=/share/BioinfMSc/rot3_group1/EDTA/EDTA
augustus_data_dir=/share/BioinfMSc/rot3_group1/Augustus/c_amara

# Predict centromeres for haplome 1
python3 quartet.py CentroMiner -i $genome_dir/C087_203_mapq_hap1_8.fa \
    --TE $edta_dir/C087_203_mapq_hap1_8.fa.mod.EDTA.TEanno.gff3 \
    --gene $augustus_data_dir/c_amara_hap1.gff3 \
    -p hap1_8_centro \
    -t 8

# Predict centromeres for haplome 2
python3 quartet.py CentroMiner -i $genome_dir/C087_203_mapq_hap2_8.fa \
    --TE $edta_dir/C087_203_mapq_hap2_8.fa.mod.EDTA.TEanno.gff3 \
    --gene $augustus_data_dir/c_amara_hap2.gff3 \
    -p hap2_8_centro \
    -t 8

# Deactivate conda environment
conda deactivate

