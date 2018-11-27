# Welcome to Genome-Analysis-Tutorial Page

This page will help you to learn how to make pipeline based on GATK BestPractice.

From this page, <a href="https://kennethjhan.github.io/Genome-Analysis-Tutorial/resource">https://kennethjhan.github.io/Genome-Analysis-Tutorial/resource</a> you can download resorce file such as reference fasta, samtools, bwa, picard, GATK4, snpEff and raw fastq file.

YES! This tutorial is based on GATK4 which is latest tool from Broad Institute.

I hope everyone learns how to analyze gene data and contributes scientific field.

ENJOY!!
<br><br>

## 1. DOWNLOAD RESOURCES

Download all the resorces from this page.
<a href="https://kennethjhan.github.io/Genome-Analysis-Tutorial/resource">https://kennethjhan.github.io/Genome-Analysis-Tutorial/resource</a>

## 2. INSTALL TOOL
### 2.1. INSTALL BWA

```bash
# 1) Download BWA (bwa-0.7.17.tar.bz2)
wget https://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2

# 2) Extract bwa-0.7.17.tar.bz2
tar xf bwa-0.7.17.tar.bz2

# 3) Install BWA
make

# 4) Confirm Installation
./bwa
Program: bwa (alignment via Burrows-Wheeler transformation)
Version: 0.7.17-r1188
Contact: Heng Li <lh3@sanger.ac.uk>

Usage:   bwa <command> [options]

Command: index         index sequences in the FASTA format
         mem           BWA-MEM algorithm
...

```

### 2.2. INSTALL SAMTOOLS

```bash
# 1) Download Samtools
wget https://downloads.sourceforge.net/project/samtools/samtools/1.9/samtools-1.9.tar.bz2

# 2) Extract samtools-1.9.tar.bz2
tar xf samtools-1.9.tar.bz2

# 3) Install samtools
./configure --prefix=/YOUR/DIRECTORY/TO/INSTALL
make && make install

# 4) Confirm Installation
./samtools

Program: samtools (Tools for alignments in the SAM format)
Version: 1.9 (using htslib 1.9)

Usage:   samtools <command> [options]

Commands:
  -- Indexing
     dict           create a sequence dictionary file
     faidx          index/extract FASTA
...

```

### 2.3. INSTALL Picard

```bash
# 1) Download Picard
wget https://github.com/broadinstitute/picard/releases/download/2.18.17/picard.jar

# 2) Run Picard
java -jar picard.jar

## RUNNING ON JAVA8 (NOT JAVA7)

```

### 2.4. INSTALL GATK4

```bash
# 1) Download GATK4
wget https://github.com/broadinstitute/gatk/releases/download/4.0.11.0/gatk-4.0.11.0.zip

# 2) Extract
unzip gatk-4.0.11.0.zip

# 3) Run GATK4
java -jar gatk-package-4.0.11.0-local.jar

## RUNNING ON JAVA8 (NOT JAVA7)
```

### 2.5. INSTALL SnpEff

```bash
# 1) Download SnpEff
wget https://downloads.sourceforge.net/project/snpeff/snpEff_latest_core.zip

# 2) Extract
unzip snpEff_latest_core.zip

# 3) Run SnpEff
java -jar snpEff.jar

## RUNNING ON JAVA8 (NOT JAVA7)
```
