#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10g
#SBATCH --time=01:00:00
#SBATCH --job-name=Pair_chromosomes
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Acivate conda environment
source $HOME/.bash_profile
conda activate samtools

# Make samtools output directory
cd /path/to/cardamine_amara_genome_analysis
mkdir -p Samtools
work_dir=/path/to/cardamine_amara_genome_analysis/Samtools
cd $work_dir

# Copy haplome data to samtools working directory
haplome_data_dir=/path/to/cardamine_amara_haplomes
cp $haplome_data_dir/C087_203_mapq_hap1_8.fa $work_dir
cp $haplome_data_dir/C087_203_mapq_hap2_8.fa $work_dir

# Index haplomes
samtools faidx C087_203_mapq_hap1_8.fa
samtools faidx C087_203_mapq_hap2_8.fa

# Pair each of the 8 chromosomes for both haplomes. Files are outputted in pairs for ModDotPlot
for n in {1..8};
do
    samtools faidx C087_203_mapq_hap1_8.fa RL_${n} > hap1rl${n}.fa
    samtools faidx C087_203_mapq_hap2_8.fa RL_${n} > hap2rl${n}.fa
    cat hap1rl${n}.fa hap2rl${n}.fa > h1rl${n}_h2rl${n}.fasta
done

# Deactivate conda
conda deactivate
