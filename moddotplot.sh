
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

# Source environment for ModDotPlot venv
cd /path/to/cardamine_amara_genome_analysis/ModDotPlot # Move to cloned github ModDotPlot repository
source venv/bin/activate

# Paths
chromosome_pairs_dir=/path/to/cardamine_amara_genome_analysis/Samtools
out_dir=/path/to/cardamine_amara_genome_analysis/ModDotPlot

# Generate identity maps for the entire genome
for n in {1..8};
do
    moddotplot static -f $chromosome_pairs_dir/h1rl${n}_h2rl${n}.fasta --compare -o $out_dir/chrom${n}
done

# Deactivate conda
conda deactivate
