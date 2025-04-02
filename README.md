# *Cardamine amara* genome analysis
## Contents
[Overview](#overview) <br/>
[Install conda](#install-conda) <br/>
### Diploid *Cardamine amara*
[Genome annotation](#genome-annotation) <br/>
[Ribosomal RNA annotation](#ribosomal-rna-annotation) <br/>
[Transposonable element annotation](#transposonable-element-annotation) <br/>
[Telomere annotation](#telomere-annotation) <br/>
[Tandem repeat annotation](#tandem-repeat-annotation) <br/>
[Genome visualisation](#genome-visualisation) <br/>
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

### Telomere annotation
[quarTeT](https://github.com/aaranyue/quarTeT) is a centromere and telomere analysis tool. Once the conda environment has been created, as demonstrated in the quarTeT github page, run the [quartet]() script to analyse the telomeres and centromeres in your data.  


### Tandem repeat annotation
The tool [TRASH](https://github.com/vlothec/TRASH) can be used to annotate tandem repeats. Create a conda environment, here we named ours TRASH2, and install TRASH following the TRASH installer steps [here](https://github.com/vlothec/TRASH?tab=readme-ov-file#installation).

### Genome visualisation
The [ModDotPlot](https://github.com/marbl/ModDotPlot?tab=readme-ov-file#about) tool enables genome visualisation by producing an identity heatmap.


### Contributors
- [Josh Young](https://github.com/mbxjy4)
  - Moddotplot
  - QuarTeT
  - EDTA
- [Leah Ellis](https://github.com/Leah31115)
  - Ausustus
  - Moddotplot
  - TRASH
  - Barrnap
- [Shixuan Liu]()
  - Moddotplot  
- Levi Yant, Rhianah Sandean, Denzel Renner
  - Generated *C. amara* haplome assembly fasta files
- Laura Dean
  - GENESPACE code  
