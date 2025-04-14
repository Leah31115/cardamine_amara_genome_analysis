#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=24:00:00
#SBATCH --job-name=augustus_ann_haplomes
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate augustus

# Make out_dir
mkdir -p augustus

# File paths
haplome_data_dir=/path/to/cardamine_amara_haplomes
out_dir=/path/to/cardamine_amara_genome_analysis/augustus

# Annotate haplome1
augustus --strand=both \
    --gff3=on \
    --protein=on \
    --codingseq=on \
    --introns=on \
    --start=on \
    --stop=on \
    --cds=on \
    --exonnames=on \
    --species=arabidopsis \
    $haplome_data_dir/C087_203_mapq_hap1_8.fa > $out_dir/c_amara_hap1.gff3

# Annotate haplome2
augustus --strand=both \
    --gff3=on \
    --protein=on \
    --codingseq=on \
    --introns=on \
    --start=on \
    --stop=on \
    --cds=on \
    --exonnames=on \
    --species=arabidopsis \
    $haplome_data_dir/C087_203_mapq_hap2_8.fa > $out_dir/c_amara_hap2.gff3

# Deactivate conda environment
conda deactivate
