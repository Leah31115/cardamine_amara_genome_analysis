import pandas as pd
import gff2bed
from pathlib import Path
from pybedtools import BedTool

# File paths
hap1 = Path("/share/BioinfMSc/rot3_group1/Augustus/c_amara/c_amara_hap1.gff3")
hap2 = Path("/share/BioinfMSc/rot3_group1/Augustus/c_amara/c_amara_hap2.gff3")


# Convert gff to bed
h1_data = BedTool(gff2bed.convert(gff2bed.parse(hap1))).saveas("hap1.bed")
h2_data = BedTool(gff2bed.convert(gff2bed.parse(hap2))).saveas("hap2.bed")


