# *Cardamine amara* genome analysis
## Contents
[Overview](#overview) <br/>
[Install conda](#install-conda) <br/>
[Clone github repository](#clone-github-repository) <br/>
### Diploid *Cardamine amara* analysis
[Genome annotation](#genome-annotation) <br/>
[Ribosomal RNA annotation](#ribosomal-rna-annotation) <br/>
[Transposonable element annotation](#transposonable-element-annotation) <br/>
[Centromere and Telomere prediction](#centromere-and-telomere-prediction) <br/>
[Tandem repeat annotation](#tandem-repeat-annotation) <br/>
[Genome visualisation](#genome-visualisation) <br/>
Analyse orthology and synteny <br/>
- [Genespace](#genespace)<br/>
  - [Convert gff file to bed file](convert-.gff-to-.bed) <br/>
  - [Generate protein fasta files](generate-protein-fasta-file) <br/>
- [Orthofinder](#orthofinder) <br/>
  - [Filter genome fasta files](#filter-genome-fasta-files) <br/>

[Analyse protein function](#) <br/>

[Contributors](#contributors) <br/>
[References](#references)

## Overview
University of Nottingham module LIFE4136 rotation 3 group project. The aims of this project are to investigate and compare the genomic structure of diploid *Cardamine amara* genomes. Levi Yant and his team provided two *C. amara* haplome assemblies, from one individual, generated from longread pacbio Revio HiFi sequence data, followed by HiC. Each haplome file contained eight scaffolds/chromosomes which were subject to analysis.

## Install conda
If conda is not already installed into Ubuntu, please follow the steps [here](https://docs.conda.io/projects/conda/en/stable/user-guide/install/linux.html) to install conda.

## Clone github repository
Clone this github repository into your working directory.

```bash
git clone https://github.com/Leah31115/cardamine_amara_genome_analysis
cd cardamine_amara_genome_analysis
```

Make a logs directory to store any job submission .out and .error files.
```bash
mkdir logs
```

## Diploid *Cardamine amara*
### Genome annotation
To annotate the entire *Cardamine amara* genome, the [Augustus](https://github.com/Gaius-Augustus/Augustus/tree/master) tool can be used. First, set up an augustus environment within Ubuntu. 
```bash
conda create -n augustus -c bioconda augustus=3.1
conda activate augustus
```
Generate genome annotations using the [augustus_annotate_haplomes.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/augustus_annotate_haplomes.sh) script. Filter the annotations for chromosomes of interest using the commands below. If you wish to filter other chromosomes of interest from the .gff annotation file, adjust the chromosome name (e.g. RL_5 or RL_2) and the file output name accordingly.
```bash
cat c_amara_hap1.gff3 | grep "^RL_5" > aug_hap1_rl5.gff3
cat c_amara_hap2.gff3 | grep "^RL_2" > aug_hap2_rl2.gff3
```

### Ribosomal RNA annotation
[Barrnap](https://github.com/tseemann/barrnap) can be used to annotate the *Cardamine amara* ribosomal RNA genes. First, set up a barrnap environment within Ubuntu.
```bash
conda create -n barrnap -c bioconda -c conda-forge barrnap
conda activate barrnap
```
Follow the [source steps](https://github.com/tseemann/barrnap?tab=readme-ov-file#source) to install barrnap. Then generate an rRNA annotation gff3 file using the [barrnap_annotate_rrna.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/barrnap_annotate_rrna.sh) script.

### Transposonable element annotation
[EDTA](https://github.com/oushujun/EDTA) can be used to obtain a transposable element (TE) annotation in the form of a gff3 file. We installed EDTA using [conda](https://github.com/oushujun/EDTA?tab=readme-ov-file#install-with-condamamba-linux64). To run EDTA, we used the [edta_annotate_te.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/edta_annotate_te.sh) script.  

### Centromere and Telomere prediction
[quarTeT](https://github.com/aaranyue/quarTeT) is a centromere and telomere analysis tool. First create a conda environment, we named ours quarTeT, by following the [steps](https://github.com/aaranyue/quarTeT?tab=readme-ov-file#dependencies) as demonstrated in the quarTeT github page.

#### Centromere prediction
Before quarTeT is used to predict centromere candidates, please generate the TE annotation file from [EDTA](#transposonable-element-annotation) and the genome annotation file from [Augustus](#genome-annotation). Once both of these files are obtained, run the [quarTeT_centrominer.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/quarTeT_centrominer.sh) script to analyse the centromeres in your data.

#### Telomere prediction
Analyse the telomeres, using only your genome fasta files, with the [quarTeT_teloexplorer.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/quarTeT_teloexplorer.sh) script. 

### Tandem repeat annotation
The tool [TRASH](https://github.com/vlothec/TRASH) can be used to annotate tandem repeats. Create a conda environment, here we named ours TRASH2, and install TRASH following the TRASH installer steps [here](https://github.com/vlothec/TRASH?tab=readme-ov-file#installation).

### Analyse orthology and synteny
#### Genespace
[Genespace](https://github.com/jtlovell/GENESPACE) can be used to analyse orthology and synteny within your genome files. Files required to run this tool are genome.bed and protein.fa files. If you do not already have these, please read below which explains how to generate these required files.

Firstly, create a conda environment.
```bash
conda create --name genespace4 orthofinder=2.5.5 mcscanx r-base=4.4.1 r-devtools r-BiocManager bioconductor-biostrings -y
conda activate genespace4
```

Next clone this github and the GENESPACE github into your working directory. Then copy the [c_amara_genespace.r](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/c_amara_genespace.r) and [genespace.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/genespace.sh) scripts to the GENESPACE directory.
```bash
git clone https://github.com/jtlovell/GENESPACE
mv c_amara_genespace.r GENESPACE/
mv genespace.sh GENESPACE/
```

You will also need to copy your protein.fa files and only the first four columns of your .bed files into the GENESPACE directory.
```bash
# Copy protein fasta files
cp /path/to/cardamine_amara_genome_analysis/gffread/hap1.fasta path/to/cardamine_amara_genome_analysis/GENESPACE/peptide
cp /path/to/cardamine_amara_genome_analysis/gffread/hap2.fasta path/to/cardamine_amara_genome_analysis/GENESPACE/peptide

# Copy genome bed files
cd path/to/GENESPACE
mkdir bed
mkdir peptide
cut -f1-4 /path/to/cardamine_amara_genome_analysis/bedtools/hap1.bed > /path/to/cardamine_amara_genome_analysis/GENESPACE/bed/hap1.bed
cut -f1-4 /path/to/cardamine_amara_genome_analysis/bedtools/hap2.bed > /path/to/cardamine_amara_genome_analysis/GENESPACE/bed/hap2.bed
```

Our peptide bed files contained parent gene names. To make the geneID names within the genome bed files match the peptide files, '.t1' was added to the end of each bed file line. If your geneID names match the protein fasta gene names, skip this step. Else, replace the .t1 with whatever suffix is required, providing all gene names have this exact suffix.
```bash
cd path/to/GENESPACE/bed
sed -i "s/$/.t1/" hap1.bed
sed -i "s/$/.t1/" hap2.bed
```

Thank you Laura Dean for sharing the genespace code and script.

##### Convert .gff to .bed
The genome annotation .gff3 file generated from [Augustus](#genome-annotation) can be converted to a .bed file using [bedtools](https://github.com/daler/pybedtools?tab=readme-ov-file). Create a conda bedtools environment using the code:
```bash
conda create -n bedtools python=3.12 anaconda::pandas bioconda::pybedtools
conda activate bedtools
conda install -c bioconda gff2bed
```
Move into the bedtools directory and run the [convert_gff2bed.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/bedtools/convert_gff2bed.sh) script to generate .bed files. Change any root directory paths within the [gff2bed.py](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/bedtools/gff2bed.py) and convert_gff2bed.sh scripts, as needed, to match your working directory.
```bash
cd /path/to/cardamine_amara_genome_analysis/bedtools
sbatch convert_gff2bed.sh
```

##### Generate protein fasta file
The [gffread](https://github.com/gpertea/gffread) tool can be used to translate the genome sequence into a protein fasta file. [Install](https://github.com/gpertea/gffread#installation) gffread as described in their github. If you do not already have a genome annotation file, generate one using [Augustus](#genome-annotation) before running the [gffread.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/gffread.sh) script.

#### Orthofinder
##### Filter genome fasta files
Before using orthofinder, a conda environment must first be set up to use Samtools.
```bash
conda create -n samtools bioconda::samtools
```
[Samtools](https://github.com/samtools/samtools) was used to filter the genome fasta files for the chromosomes of interest (haplome 1 chromosome 5 and haplome 2 chromosome 2) as well as the blocks of interest (BOIs) within these chromosomes using the [samtools.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/samtools.sh) script. 
```bash
sbatch samtools.sh
```
The filtered file outputs from the samtools were supplied to the [Orthofinder](https://github.com/davidemms/OrthoFinder) tool to identify *C. amara* orthologues within the chromosomes of interest and BOIs. Create a conda environment to install Orthofinder following their [github](https://github.com/davidemms/OrthoFinder?tab=readme-ov-file#installing-orthofinder-on-linux) instruction. 

### Genome visualisation
The [ModDotPlot](https://github.com/marbl/ModDotPlot?tab=readme-ov-file#about) tool enables genome visualisation by producing an identity heatmap. [Install](https://github.com/marbl/ModDotPlot?tab=readme-ov-file#installation) ModDotPlot as instructed in their github page. Then move the [moddotplot.sh]() script to the cloned ModDotPlot repository and submit the job to visualise genomes your genomes.
```bash
mv /path/to/cardamine_amara_genome_analysis/moddotplot.sh ModDotPlot/
cd ModDotPlot
sbatch moddotplot.sh
```

### Analyse protein function
BLAST can be used to investigate the potential function of proteins expressed within the genome. This requires a protein fasta file to be already made which is achievable following these [steps](generate-protein-fasta-file). Create a BLAST conda environment.
```bash
conda create -n BLAST bioconda::blast
conda activate BLAST
```
From our Moddotplot data output, we identified blocks of interest (BOI) within the haplome 1 scaffold 5 and haplome 2 scaffold 2. Therefore, we filtered our protein.fa file for these BOI regions using the commands below. Adjust the region of interest values according to your specific areas of interest. Alternatively, you can skip this filter step and run BLAST on the entire protein.fa file if you are interested in the protein function of the entire haplome.
```bash
sed -n '31045,47299p' hap1.fa > hap1_rl5block_protein.fasta
sed -n '26711,44990p' hap2.fa > hap2_rl2block_protein.fasta
```


## Contributors
- [Josh Young](https://github.com/mbxjy4)
  - Moddotplot
  - QuarTeT
  - EDTA
  - Samtools
  - Orthofinder
  - BLAST
  - Gffread
- [Leah Ellis](https://github.com/Leah31115)
  - Ausustus
  - Moddotplot
  - TRASH
  - Barrnap
  - Gffread
  - Bedtools
  - Genespace
- [Shixuan Liu]()
  - Moddotplot  
- Levi Yant, Rhianah Sandean, Denzel Renner
  - Supplied genome sequence data
- Laura Dean
  - Genespace script

## References
