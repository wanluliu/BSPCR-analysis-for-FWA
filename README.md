# BSPCR-analysis-for-FWA
This is the BSPCR analysis pipeline for BSPCR-seq over the five regions on FWA genes. This is the customized code related to Liu et al., 2021, Nature Communications. 

## Software/Enviornment
1. Samtools - v0.1.19
2. Python - v2.7
3. Bsmap - v2.74
4. Perl - v5.10.1
5. R - v3.5.1

## Reference genome
TAIR10.fa

## Processing data
### For paired end sequencing data
```
gunzip read1.fastq.gz
gunzip read2.fastq.gz
perl genRegion_5fwa_fromfastq.pl read1.fastq read2.fastq
cat Region*read1.fastq > allregion_read1.fastq
cat Region*read2.fastq > allregion_read2.fastq
bsmap -a allregion_read1.fastq -b allregion_read2.fastq -d TAIR10.fa -o allregion.bam -p 4 -w 1 -n 1 -v 0
python methratio_32unit_alt.py -d TAIR10.fa -o allregion_methration.txt -u -S -z allregion.bam
perl contextToType_bsmap_methratio.pl allregion_methration.txt
```
### For single end sequencing data
```
gunzip read.fastq.gz
perl genRegion_5fwa_fromfastq_SE.pl read.fastq
bsmap -a read.fastq -d TAIR10.fa -o read.bam -p 4 -w 1 -n 1 -v 0
python methratio_32unit_alt.py -d TAIR10.fa -o read_methratio.txt -u -S -z read.bam
perl contextToType_bsmap_methratio.pl read_methratio.txt
```
## Plotting
```
./splitregion.sh 
RScript five_fwa_plot_from_methratio.R configure.txt 
```
