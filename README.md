# *Cardamine amara* genome analysis
## Contents
[Overview](#overview) <br/>
[Install conda](#install-conda) <br/>
### Diploid *Cardamine amara* analysis
[Genome annotation](#genome-annotation) <br/>
[Ribosomal RNA annotation](#ribosomal-rna-annotation) <br/>
[Transposonable element annotation](#transposonable-element-annotation) <br/>
[Centromere and Telomere prediction](#centromere-and-telomere-prediction) <br/>
[Tandem repeat annotation](#tandem-repeat-annotation) <br/>
[Genome visualisation](#genome-visualisation) <br/>
Analyse orthology and synteny <br/>
- [Genespace]()<br/>
  - [Generate protein fasta files]() <br/>
  - [Convert gff file to bed file]() <br/>
- [Orthofinder]() <br/>
[Contributors](#contributors)

## Overview
University of Nottingham module LIFE4136 rotation 3 group project. The aims of this project are to investigate and compare the genomic structure of diploid *Cardamine amara* genomes. Levi Yant and his team provided two assembled *C. amara* haplome fasta files, each containing eight scaffolds/chromosomes, for analysis.

## Install conda
If conda is not already installed into Ubuntu, please follow the steps [here](https://docs.conda.io/projects/conda/en/stable/user-guide/install/linux.html) to install conda.

## Diploid *Cardamine amara*
### Genome annotation
To annotate the entire *Cardamine amara* genome, the [Augustus](https://github.com/Gaius-Augustus/Augustus/tree/master) tool can be used. First, set up an augustus environment within Ubuntu. 
```bash
conda create augustus
conda activate augustus
conda install -c bioconda augustus=3.1
```
Generate genome annotations using the [augustus_annotate_haplomes.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/augustus_annotate_haplomes.sh) script.

### Ribosomal RNA annotation
[Barrnap](https://github.com/tseemann/barrnap) can be used to annotate the *Cardamine amara* ribosomal RNA genes. First, set up a barrnap environment within Ubuntu.
```bash
conda create barrnap
conda activate barrnap
conda install -c bioconda -c conda-forge barrnap
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

Next clone this github and the GENESPACE github into your working directory. Then copy the c_amara_genespace.r and c_amara_data.sh scripts to the GENESPACE directory
```bash
git clone https://github.com/jtlovell/GENESPACE
git clone https://github.com/Leah31115/cardamine_amara_genome_analysis
cd cardamine_amara_genome_analysis
cp c_amara_genespace.r path/to/GENESPACE
cp c_amara_data.sh path/to/GENESPACE
```

You will also need to copy your protein.fa files and only the first four columns of your .bed files into the GENESPACE directory.
```bash
# Copy protein fasta files
cp path/to/hap1.fasta path/to/GENESPACE/peptide
cp path/to/hap2.fasta path/to/GENESPACE/peptide

# Copy genome bed files
cd path/to/GENESPACE
mkdir bed
mkdir peptide
cut -f1-4 path/to/cardamine_amara_genome_analysis/bedtools/hap1.bed > path/to/GENESPACE/bed/hap1.bed
cut -f1-4 path/to/cardamine_amara_genome_analysis/bedtools/hap2.bed > path/to/GENESPACE/bed/hap2.bed
```

Our peptide bed files contained parent gene names. To make the geneID names within the genome bed files match the peptide files, '.t1' was added to the end of each bed file line. If your geneID names match the protein fasta gene names, skip this step. Else, replace the .t1 with whatever suffix is required, providing all gene names will have exactly this suffix.
```bash
cd path/to/GENESPACE/bed
sed -i "s/$/.t1/" hap1.bed
sed -i "s/$/.t1/" hap2.bed
```

Thank you Laura Dean for providing genespace example code.
##### Convert .gff to .bed

##### Generate protein fasta file

#### Orthofinder

### Genome visualisation
The [ModDotPlot](https://github.com/marbl/ModDotPlot?tab=readme-ov-file#about) tool enables genome visualisation by producing an identity heatmap.


### Contributors
- [Josh Young](https://github.com/mbxjy4)
  - Moddotplot
  - QuarTeT
  - EDTA
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
- Laura Dean
