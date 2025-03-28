#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=24:00:00
#SBATCH --job-name=augustus_ann_haplomes
#SBATCH --output=/share/BioinfMSc/rot3_group1/logs/%x-%j.out
#SBATCH --error=/share/BioinfMSc/rot3_group1/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate augustus

# Fasta files
c_amara_hap1=/share/BioinfMSc/rotation3/cardamine_amara_v0.9/C087_203_mapq_hap1_8.fa
c_amara_hap2=/share/BioinfMSc/rotation3/cardamine_amara_v0.9/C087_203_mapq_hap2_8.fa

# Output directory
out_dir=/share/BioinfMSc/rot3_group1/Augustus/c_amara

# Genome annotation for Hap1
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
    $c_amara_hap1 > $out_dir/c_amara_hap1.gff3

# Genome annotation for Hap2
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
    $c_amara_hap2 > $out_dir/c_amara_hap2.gff3

# Deactivate conda environment
conda deactivate
