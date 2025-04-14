#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=30g
#SBATCH --time=34:00:00
#SBATCH --job-name=quarTeT_centro_camara
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
edta_data_dir=/path/to/cardamine_amara_genome_analysis/EDTA
augustus_data_dir=/path/to/cardamine_amara_genome_analysis/augustus

# Predict centromeres for haplome 1
python3 quartet.py CentroMiner -i $haplome_data_dir/C087_203_mapq_hap1_8.fa \
    --TE $edta_data_dir/C087_203_mapq_hap1_8.fa.mod.EDTA.TEanno.gff3 \
    --gene $augustus_data_dir/c_amara_hap1.gff3 \
    -p hap1_8_centro \
    -t 8

# Predict centromeres for haplome 2
python3 quartet.py CentroMiner -i $haplome_data_dir/C087_203_mapq_hap2_8.fa \
    --TE $edta_data_dir/C087_203_mapq_hap2_8.fa.mod.EDTA.TEanno.gff3 \
    --gene $augustus_data_dir/c_amara_hap2.gff3 \
    -p hap2_8_centro \
    -t 8

# Deactivate conda environment
conda deactivate

