
#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20g
#SBATCH --time=10:00:00
#SBATCH --job-name=moddotplot
#SBATCH --output=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.out
#SBATCH --error=/path/to/cardamine_amara_genome_analysis/logs/%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@email.com

# Source bash profile for ModDotPlot venv
source $HOME/.bash_profile

# Paths
haplome_data_dir=/path/to/cardamine_amara_haplomes
out_dir=/path/to/cardamine_amara_genome_analysis/ModDotPlot

# Generate identity maps for the entire genome
moddotplot static -f $haplome_dir/C087_203_mapq_hap1_8.fa --compare -o $out_dir/haplome1
moddotplot static -f $haplome_dir/C087_203_mapq_hap2_8.fa --compare -o $out_dir/haplome2

# Deactivate conda
conda deactivate
