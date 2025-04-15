#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=15g
#SBATCH --time=48:00:00
#SBATCH --job-name=blast_haplome_BOIs
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate BLAST

# Make output directory
cd /path/to/cardamine_amara_genome_analysis
mkdir -p BLAST

# Paths
haplome_protein_dir=/path/to/gffread
out_dir=/path/to/cardamine_amara_genome_analysis/BLAST

# BLAST protein sequence for the block of interest in haplome1
blastp -query $haplome_protein_dir/hap1/hap1_rl5block_protein.fasta \
    -db nr \
    -remote \
    -out $out_dir/h1rl5blockgenenames.txt \
    -outfmt "6 qseqid sseqid pident length evalue bitscore stitle" \
    -max_target_seqs 1 \
    -entrez_query "Viridiplantae[Organism]"

# BLAST protein sequence for the block of interest in haplome2
blastp -query $haplome_protein_dir/hap2/hap2_rl2block_protein.fasta \
    -db nr \
    -remote \
    -out $out_dir/h2rl2blockgenenames.txt \
    -outfmt "6 qseqid sseqid pident length evalue bitscore stitle" \
    -max_target_seqs 1 \
    -entrez_query "Viridiplantae[Organism]"

# Deactivate conda
conda deactivate
