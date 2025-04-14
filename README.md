# *Cardamine amara* genome analysis
## Contents
[Overview](#overview) <br/>
### Getting started
[Install conda](#install-conda) <br/>
[Clone github repository](#clone-github-repository) <br/>
### Diploid *Cardamine amara* analysis
[Genome annotation](#genome-annotation) <br/>
[Ribosomal RNA annotation](#ribosomal-rna-annotation) <br/>
[Transposonable element annotation](#transposonable-element-annotation) <br/>
[Centromere and Telomere prediction](#centromere-and-telomere-prediction) <br/>
[Tandem repeat annotation](#tandem-repeat-annotation) <br/>
[Genome visualisation](#genome-visualisation) <br/>
[Translate genome](#translate-genome) <br/>
[File converter: gff to bed](#file-converter-gff-to-bed) <br/>
[Analyse protein function](#analyse-protein-function) <br/>
Analyse orthology and synteny <br/>
- [GENESPACE](#genespace)<br/>
- [OrthoFinder](#orthofinder) <br/>
### Acknowledgements
[Contributors](#contributors) <br/>
[References](#references)

## Overview
University of Nottingham module LIFE4136 rotation 3 group project. The aims of this project are to investigate and compare the genomic structure of diploid *Cardamine amara* genomes. Levi Yant and his team provided two *C. amara* haplome assemblies, from one individual, generated from longread pacbio Revio HiFi sequence data, followed by HiC. Each haplome fasta file contained eight scaffolds/chromosomes which were subject to analysis. They also provided the *Arabidopsis thaliana* proteome, a close relative of *C. amara*, in the form of a text file. Before running any commands or submitting any scripts as jobs within Ubuntu, please alter the file paths to your root directory, paths/names of your input data files (*Cardamine amara* haplome fasta files and *A. thaliana* proteome text file), and the script #SBATCH --mail to your email. Note that the two *Cardamine amara* haplome fasta files are essential for all tools used in this github respository whereas an absent *A. thaliana* proteome text file will prevent you from running only the Orthofinder tool for analysis of orthology.

## Getting started
### Install conda
If conda is not already installed into Ubuntu, please follow the steps [here](https://docs.conda.io/projects/conda/en/stable/user-guide/install/linux.html) to install conda.

### Clone github repository
Clone this github repository into your working directory.
```bash
git clone https://github.com/Leah31115/cardamine_amara_genome_analysis
cd cardamine_amara_genome_analysis
```

Make a logs directory to store any job submission .out and .error files.
```bash
mkdir logs
```

## Diploid *Cardamine amara* haplome analysis
### Genome annotation
To annotate the entire *Cardamine amara* genome, the [Augustus](https://github.com/Gaius-Augustus/Augustus/tree/master) tool version 3.5.0 can be used (Stanke *et al.,*, 2013). First, set up an augustus environment. 
```bash
conda create -n augustus -c bioconda augustus=3.1
```
Generate genome annotations using the [augustus_annotate_haplomes.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/augustus_annotate_haplomes.sh) script.
```bash
sbatch augustus_annotate_haplomes.sh
```
Filter the annotations for chromosomes of interest using the commands below. If you wish to filter other chromosomes of interest from the .gff annotation file, adjust the chromosome name (e.g. RL_5 or RL_2) and the file output name accordingly.
```bash
cat c_amara_hap1.gff3 | grep "^RL_5" > aug_hap1_rl5.gff3
cat c_amara_hap2.gff3 | grep "^RL_2" > aug_hap2_rl2.gff3
```

From the identity heatmaps generated from ModDotPlot, the blocks of interest (BOIs) were located within the following regions: hap1_rl5 16,000,000bp-23,979,000bp and hap2_rl2 ~8,923,000bp-19,004,000bp. The gene annotation files were filtered for these regions. If desired, adjust the region values (bp) in the following command to suit your BOI, if it's different to ours.
```bash
awk '$4 >= 15995322 && $4 <= 23990000' aug_hap1_rl5.gff3 > gene_hap1_rl5block.gff
awk '$4 >=  8923034 && $4 <= 19003400' aug_hap2_rl2.gff3 > gene_hap2_rl2block.gff
```

### Ribosomal RNA annotation
[barrnap](https://github.com/tseemann/barrnap) version 1 can be used to annotate the *Cardamine amara* ribosomal RNA genes (Seemann, 2013). First, set up a barrnap environment within Ubuntu.
```bash
conda create -n barrnap -c bioconda -c conda-forge barrnap
conda activate barrnap
```
Follow the [source steps](https://github.com/tseemann/barrnap?tab=readme-ov-file#source) to install barrnap. Then generate an rRNA annotation gff3 file using the [barrnap_annotate_rrna.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/barrnap_annotate_rrna.sh) script.
```bash
sbatch barrnap_annotate_rrna.sh
```

### Transposonable element annotation
[EDTA](https://github.com/oushujun/EDTA) version 2.2.2 can be used to obtain a transposable element (TE) annotation in the form of a gff3 file (Ou *et al.*, 2019). We installed EDTA using [conda](https://github.com/oushujun/EDTA?tab=readme-ov-file#install-with-condamamba-linux64). To run EDTA, we used the [edta_annotate_te.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/edta_annotate_te.sh) script.
```bash
sbatch edta_annotate_te.sh
```

### Centromere and Telomere prediction
[quarTeT](https://github.com/aaranyue/quarTeT) version 1.2.5 was used to analyse analyse the centromeres and telomeres of our haplome data (Lin *et al.*, 2023). First create a conda environment, we named ours quarTeT, by following the [steps](https://github.com/aaranyue/quarTeT?tab=readme-ov-file#dependencies) as demonstrated in the quarTeT github page.

#### Centromere prediction
Before quarTeT is used to predict centromere candidates, please generate the TE annotation file from [EDTA](#transposonable-element-annotation) and the genome annotation file from [Augustus](#genome-annotation). Once both of these files are obtained, run the [quarTeT_centrominer.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/quarTeT_centrominer.sh) script to analyse the centromeres in your data.
```bash
sbatch quarTeT_centrominer.sh
```

#### Telomere prediction
Analyse the telomeres, using only your genome fasta files, with the [quarTeT_teloexplorer.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/quarTeT_teloexplorer.sh) script. 
```bash
sbatch quarTeT_teloexplorer.sh
```
### Tandem repeat annotation
The tool [TRASH](https://github.com/vlothec/TRASH) version 1 can be used to annotate tandem repeats (Wlodzimierz, Hong, and Henderson, 2023). Create a conda environment, here we named ours TRASH2, and install TRASH following the TRASH installer steps [here](https://github.com/vlothec/TRASH?tab=readme-ov-file#installation). Next, submit the (trash.sh)[https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/trash.sh] script as a job.
```bash
sbatch trash.sh
```

### Genome visualisation
The [ModDotPlot](https://github.com/marbl/ModDotPlot?tab=readme-ov-file#about) tool version 0.9.3 enables genome visualisation by producing an identity heatmap (Sweeten, Schatz, and Phillippy, 2024). [Install](https://github.com/marbl/ModDotPlot?tab=readme-ov-file#installation) ModDotPlot as instructed in their github page. Submit the [moddotplot.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/moddotplot.sh) script as a job where the output files will be located in the cloned ModDotPlot github directory.
```bash
sbatch moddotplot.sh
```

### Translate genome
The [gffread](https://github.com/gpertea/gffread) tool version 0.12.7 can be used to translate the genome sequence to generate a protein fasta file (Pertea and Pertea, 2020). [Install](https://github.com/gpertea/gffread#installation) gffread as described in their github. If you do not already have a genome annotation file, generate one using [Augustus](#genome-annotation) before running the [gffread.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/gffread.sh) script using the following command.

```bash
sbatch gffread.sh
```

From our ModDotPlot data output, we identified blocks of interest (BOI) within the haplome 1 scaffold 5 and haplome 2 scaffold 2. Therefore, we filtered our gffread output haplome protein.fa files for these BOI regions using the commands below. Adjust the region of interest values according to your specific areas of interest, if desired.
```bash
sed -n '31045,47299p' hap1.fa > hap1_rl5block_protein.fasta
sed -n '26711,44990p' hap2.fa > hap2_rl2block_protein.fasta
```

The protein fasta files can be supplied to the following tools Genespace, OrthoFinder, and BLAST orthology and synteny analysis.

### File converter: gff to bed
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

### Analyse protein function
[BLASTp](https://github.com/ncbi/blast_plus_docs) version 1 can be used to investigate the potential function of proteins expressed within the genome (Camacho *et al.*, 2009). This requires a protein fasta file to be already made which is achievable following these [steps](generate-protein-fasta-file). Create a BLAST conda environment.
```bash
conda create -n BLAST bioconda::blast
conda activate BLAST
```

### Analyse orthology and synteny
#### GENESPACE
[GENESPACE](https://github.com/jtlovell/GENESPACE) version 1.2.3 can be used to analyse orthology and synteny within your genome files (Lovell *et al.*, 2022). Files required to run this tool are genome.bed and protein.fa files. If you do not already have these files, you can generate .bed files [here](#convert-.gff-to-.bed) and protein.fa files [here](#translate-genome).

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
cd path/to/cardamine_amara_genome_analysis/GENESPACE
mkdir bed
mkdir peptide
cut -f1-4 /path/to/cardamine_amara_genome_analysis/bedtools/hap1.bed > /path/to/cardamine_amara_genome_analysis/GENESPACE/bed/hap1.bed
cut -f1-4 /path/to/cardamine_amara_genome_analysis/bedtools/hap2.bed > /path/to/cardamine_amara_genome_analysis/GENESPACE/bed/hap2.bed
```

Our peptide bed files contained parent gene names. To make the geneID names within the genome bed files match the peptide files, '.t1' was added to the end of each bed file line. If your geneID names match the protein fasta gene names, skip this step. Else, replace the .t1 with whatever suffix is required, providing all gene names have this exact suffix.
```bash
cd path/to/cardamine_amara_genome_analysis/GENESPACE/bed
sed -i "s/$/.t1/" hap1.bed
sed -i "s/$/.t1/" hap2.bed
```

Thank you Laura Dean for sharing the genespace code and script.


#### OrthoFinder
Before using OrthoFinder, [samtools](https://github.com/samtools/samtools) version 1.21 was used to filter the genome fasta files for the chromosomes of interest (haplome 1 chromosome 5 and haplome 2 chromosome 2) as well as the blocks of interest (BOIs) within these chromosomes (Danecek *et al.*, 2021). First, set up a conda environment and then submit the [samtools.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/samtools.sh) script as a job.
```bash
conda create -n samtools bioconda::samtools
sbatch samtools.sh
```
The filtered file outputs from the samtools were supplied to the [Orthofinder](https://github.com/davidemms/OrthoFinder) version 2.5.5 tool to identify *C. amara* orthologues within the chromosomes of interest and BOIs (Emms and Kelly, 2019). Create a conda environment to install Orthofinder following their [github](https://github.com/davidemms/OrthoFinder?tab=readme-ov-file#installing-orthofinder-on-linux) instruction. To run OrthoFinder, you supply a directory containing both the *C. amara* haplome protein fasta file (which can be generated [here](#translate-genome)) and the *A. thaliana* proteome text file. Since our focus is on hap1_rl5 BOI and hap2_rl2_BOI, we supplied the protein fasta files of these regions only. However, the tool is not limited to these areas and you can supply other protein fasta files suited to your interests. Set up the OrthoFinder input directories by copying the necessary data to these individual directories by using the following commands. 

```bash
mkdir orthofinder
mv orthofinder.sh orthofinder/ # move the script into the working directory just for housekeeping
cd orthofinder
# Make directories to supply to OrthoFinder
mkdir hap1
mkdir hap2
mkdir hap1_hap2
# Copy necessary data files to input directories
cp /path/to/Athaliana_447_Araport11.protein.fa  /path/to/cardamine_amara_genome_analysis/orthofinder/hap1
cp /path/to/Athaliana_447_Araport11.protein.fa  /path/to/cardamine_amara_genome_analysis/orthofinder/hap2
cp /path/to/Athaliana_447_Araport11.protein.fa  /path/to/cardamine_amara_genome_analysis/orthofinder/hap1_hap2

cp /path/to/cardamine_amara_genome_analysis/gffread/hap1_rl5block_protein.fasta /path/to/cardamine_amara_genome_analysis/orthofinder/hap1
cp /path/to/cardamine_amara_genome_analysis/gffread/hap2_rl2block_protein.fasta /path/to/cardamine_amara_genome_analysis/orthofinder/hap2

cp /path/to/cardamine_amara_genome_analysis/gffread/hap1_rl5block_protein.fasta /path/to/cardamine_amara_genome_analysis/orthofinder/hap1_hap2
cp /path/to/cardamine_amara_genome_analysis/gffread/hap2_rl2block_protein.fasta /path/to/cardamine_amara_genome_analysis/orthofinder/hap1_hap2
```

Now run the [orthofinder.sh](https://github.com/Leah31115/cardamine_amara_genome_analysis/blob/main/orthofinder.sh) script to identify orthologues.
```bash
sbatch orthofinder.sh
```

## Acknowledgements
### Contributors
- [Josh Young](https://github.com/mbxjy4)
  - ModDotPlot
  - quarTeT
  - EDTA
  - samtools
  - OrthoFinder
  - BLASTp
  - gffread
- [Leah Ellis](https://github.com/Leah31115)
  - Augustus
  - ModDotPlot
  - TRASH
  - barrnap
  - gffread
  - bedtools
  - GENESPACE
- [Shixuan Liu](https://github.com/alysl56)
  - ModDotPlot  
- Levi Yant, Rhianah Sandean, Denzel Renner
  - Supplied *C. amara* genome sequence data and *A. thaliana* proteome data
- [Laura Dean](https://github.com/lldean18)
  - GENESPACE script

### References
- Camacho, C., Coulouris, G., Avagyan, V., Ma, N., Papadopoulos, J., Bealer, K. and Madden, T.L. (2009). BLAST+: architecture and applications. BMC Bioinformatics, 10(1), p.421.
- Danecek, P., Bonfield, J.K., Liddle, J., Marshall, J., Ohan, V., Pollard, M.O., Whitwham, A., Keane, T., McCarthy, S.A., Davies, R.M. and Li, H. (2021). Twelve years of SAMtools and BCFtools. GigaScience, 10(2). doi:https://doi.org/10.1093/gigascience/giab008.
- Emms D.M. & Kelly S. (2019) OrthoFinder: phylogenetic orthology inference for comparative genomics. Genome Biology, 20:238
- Lin, Y., Wang, H., Li, X., Chen, Q., Wu, Y., Zhang, F., Pan, R., Zhang, S., Chen, S., Wang, X., Cao, S., Wang, Y., Yue, Y., Liu, Y. and Yue, J. (2023). quarTeT: a telomere-to-telomere toolkit for gap-free genome assembly and centromeric repeat identification. Horticulture research, 10(8). doi:https://doi.org/10.1093/hr/uhad127.
- Lovell, J.T., Avinash S., Schranz, M.E., Wilson, M., Carlson, J.W., Harkess, A., Emms, D., Goodstein, D.M. and Schmutz, J. (2022). GENESPACE tracks regions of interest and gene copy number variation across multiple genomes. eLife, 11. doi:https://doi.org/10.7554/elife.78526.
- Ou, S., Su, W., Liao, Y., Chougule, K., Agda., J.R.A., Hellinga A.J., Lugo, C.S.B., Elliott, T.A., Ware, D., Peterson, T., Jiang, N., Hirsch, C.N., Hufford, M.B. (2019) Benchmarking transposable element annotation methods for creation of a streamlined, comprehensive pipeline. Genome Biol 20, 275. doi:https://doi.org/10.1186/s13059-019-1905-y
- Pertea, G. and Pertea, M. (2020). GFF Utilities: GffRead and GffCompare. [online] f1000research.com. Available at: https://f1000research.com/articles/9-304/v1.
- Seemann, T. (2013). tseemann/barrnap. [online] GitHub. Available at: https://github.com/tseemann/barrnap. Accessed 14/04/2025.
- Stanke, M., Diekhans, M., Baertsch, R. and Haussler, D. (2008). Using native and syntenically mapped cDNA alignments to improve de novo gene finding. Bioinformatics, [online] 24(5), pp.637–644. doi:https://doi.org/10.1093/bioinformatics/btn013.
- Sweeten, A.P., Schatz, M.C. and Phillippy, A.M. (2024). ModDotPlot—rapid and interactive visualization of tandem repeats. Bioinformatics, [online] 40(8). doi:https://doi.org/10.1093/bioinformatics/btae493
- Wlodzimierz, P., Hong, M. and Henderson, I.R. (2023). TRASH: Tandem Repeat Annotation and Structural Hierarchy. Bioinformatics, [online] 39(5). doi:https://doi.org/10.1093/bioinformatics/btad308.
