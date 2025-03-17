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
[Genome visualisation](#genome-visualisation)

## Overview
LIFE4136 rotation 3 group project. The aims of this project are to investigate and compare the genomic structure of diploid *Cardamine amara* genomes.

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

### Ribosomal RNA annotation
[Barrnap](https://github.com/tseemann/barrnap) can be used to annotate the *Cardamine amara* ribosomal RNA genes. First, set up a barrnap environment within Ubuntu.
```bash
conda create barrnap
conda activate barrnap
conda install -c bioconda -c conda-forge barrnap
```
Then follow the [source steps](https://github.com/tseemann/barrnap?tab=readme-ov-file#source) to install barrnap.

### Transposonable element annotation


### Telomere annotation


### Tandem repeat annotation
The tool [TRASH](https://github.com/vlothec/TRASH) can be used to annotate tandem repeats. Create a conda environment, here we named ours TRASH2, and install TRASH following the TRASH installer steps [here]([https://github.com/vlothec/TRASH?tab=readme-ov-file#trash-installer](https://github.com/vlothec/TRASH?tab=readme-ov-file#installation)).

### Genome visualisation
The [ModDotPlot](https://github.com/marbl/ModDotPlot?tab=readme-ov-file#about) tool was used to visualise the genome by the identity heatmap.





