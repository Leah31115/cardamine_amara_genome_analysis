#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20g
#SBATCH --time=24:00:00
#SBATCH --job-name=c_amara_genespace
#SBATCH --output=/share/BioinfMSc/rot3_group1/logs/%x-%j.out
#SBATCH --error=/share/BioinfMSc/rot3_group1/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Activate conda environment
source $HOME/.bash_profile
conda activate genespace4

# Move to the downloaded GENESPACE github working directory
cd /share/BioinfMSc/rot3_group1/GENESPACE

# Run R script for testdata
Rscript c_amara_genespace.r

# Deactivate conda environment
conda deactivate
