# Welcome to Genome-Analysis-Tutorial Page

Please visit this site to see web version of this git repository.
https://kennethjhan.github.io/Genome-Analysis-Tutorial/ 

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
$ wget https://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2

# 2) Extract bwa-0.7.17.tar.bz2
$ tar xf bwa-0.7.17.tar.bz2

# 3) Install BWA
$ make

# 4) Confirm Installation
$ ./bwa
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
$ wget https://downloads.sourceforge.net/project/samtools/samtools/1.9/samtools-1.9.tar.bz2

# 2) Extract samtools-1.9.tar.bz2
$ tar xf samtools-1.9.tar.bz2

# 3) Install samtools
$ ./configure --prefix=/YOUR/DIRECTORY/TO/INSTALL
$ make && make install

# 4) Confirm Installation
$ ./samtools

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
$ wget https://github.com/broadinstitute/picard/releases/download/2.18.17/picard.jar

# 2) Run Picard
$ java -jar picard.jar

## RUNNING ON JAVA8 (NOT JAVA7)

```

### 2.4. INSTALL GATK4

```bash
# 1) Download GATK4
$ wget https://github.com/broadinstitute/gatk/releases/download/4.0.11.0/gatk-4.0.11.0.zip

# 2) Extract
$ unzip gatk-4.0.11.0.zip

# 3) Run GATK4
$ java -jar gatk-package-4.0.11.0-local.jar

## RUNNING ON JAVA8 (NOT JAVA7)
```

### 2.5. INSTALL SnpEff

```bash
# 1) Download SnpEff
$ wget https://downloads.sourceforge.net/project/snpeff/snpEff_latest_core.zip

# 2) Extract
$ unzip snpEff_latest_core.zip

# 3) Run SnpEff
$ java -jar snpEff.jar

## RUNNING ON JAVA8 (NOT JAVA7)
```


## 3. Reference File Preprocessing
### 3.1. Make BWA Index file

```bash
$ bwa index -a bwtsw ucsc.hg19.fasta
[bwa_index] Pack FASTA... 28.10 sec
[bwa_index] Construct BWT for the packed sequence...
[BWTIncCreate] textLength=6191387966, availableWord=447648912
[BWTIncConstructFromPacked] 10 iterations done. 99999998 characters processed.
[BWTIncConstructFromPacked] 20 iterations done. 199999998 characters processed.
……
[BWTIncConstructFromPacked] 690 iterations done. 6264217232 characters
processed.
[bwt_gen] Finished constructing BWT in 695 iterations.
[bwa_index] 2802.55 seconds elapse.
[bwa_index] Update BWT... 28.60 sec
[bwa_index] Pack forward-only FASTA... 16.69 sec
[bwa_index] Construct SA from BWT and Occ... 1029.86 sec
[main] Version: 0.7.15-r1140
[main] CMD: /Users/jhan/Tools/bwa-0.7.15/bwa index -a bwtsw ucsc.hg19.fasta
[main] Real time: 3929.996 sec; CPU: 3905.257 sec

$ ls -l
-rw-r--r-- 1 jhan staff 3.0G May 9 12:44 ucsc.hg19.fasta
-rw-r--r-- 1 jhan staff 8.4K May 9 13:34 ucsc.hg19.fasta.amb
-rw-r--r-- 1 jhan staff 3.9K May 9 13:34 ucsc.hg19.fasta.ann
-rw-r--r-- 1 jhan staff 2.9G May 9 13:33 ucsc.hg19.fasta.bwt
-rw-r--r-- 1 jhan staff 748M May 9 13:34 ucsc.hg19.fasta.pac
-rw-r--r-- 1 jhan staff 1.5G May 9 13:51 ucsc.hg19.fasta.sa
```

### 3.2. Make FASTA Index file

```bash
$ samtools faidx ucsc.hg19.fasta

$ ls –l
-rw-r--r-- 1 jhan staff 3.5K May 9 14:39 ucsc.hg19.
fasta.fai
```

### 3.3. Make Sequence dictionary

```bash
$ java -jar picard.jar CreateSequenceDictionary REFERENCE=ucsc.hg19.fasta OUTPUT=ucsc.hg19.dict
[Tue May 09 14:53:07 KST 2017] picard.sam.
CreateSequenceDictionary REFERENCE=ucsc.hg19.fasta
OUTPUT=ucsc.hg19.dict TRUNCATE_NAMES_AT_WHITESPACE=true
NUM_SEQUENCES=2147483647 VERBOSITY=INFO QUIET=false
VALIDATION_STRINGENCY=STRICT COMPRESSION_LEVEL=5 MAX_
RECORDS_IN_RAM=500000 CREATE_INDEX=false CREATE_MD5_
FILE=false GA4GH_CLIENT_SECRETS=client_secrets.json
[Tue May 09 14:53:07 KST 2017] Executing as jhan@JOOHYUNui-
MacBook-Pro.local on Mac OS X 10.12.3 x86_64; Java
HotSpot(TM) 64-Bit Server VM 1.8.0_121-b13; Picard version:
2.9.1-SNAPSHOT
[Tue May 09 14:53:25 KST 2017] picard.sam.
CreateSequenceDictionary done. Elapsed time: 0.30 minutes.
Runtime.totalMemory()=660602880

$ ls –l
-rw-r--r-- 1 jhan staff 12K May 9 14:53 ucsc.hg19.dict
```

## 4. Map to Reference
### 4.1. BWA mem : FASTQ to SAM
```bash
$ bwa mem -R "@RG\tID:test\tSM:SRR000982\tPL:ILLUMINA" ucsc.hg19.fasta SRR000982_1.filt.fastq.gz SRR000982_2.filt.fastq.gz > SRR000982.mapped.sam
```

### 4.2. Samtools : SAM to BAM
```bash
$ samtools view –Sb SRR000982.mapped.sam > SRR000982.mapped.bam
```

### 4.3. Samtools sort : Make Sorted BAM
```bash
$ samtools sort –o SRR000982.mapped.sorted.bam SRR000982.mapped.bam

$ samtools view SRR000982.mapped.bam | head
SRR000982.26 131 chrX 26266805
SRR000982.32 65 chr13 75944171
SRR000982.32 129 chrX 138770110
SRR000982.34 115 chr2 190054626
……

$ samtools view SRR000982.mapped.sorted.bam | head
SRR000982.91192 115 chrM
……
SRR000982.186880 65 chrM
SRR000982.434476 115 chr1
SRR000982.434476 179 chr1
# Sort chromosome ordered
```

## 5. Mark Duplicate
### 5.1. Picard MarkDuplicate : Sorted BAM to Markdup BAM
```bash
$ java –jar picard.jar MarkDuplicates I=SRR000982.
mapped.sorted.bam O=SRR000982.mapped.sorted.markdup.bam
M=SRR000982.markdup.metrics.txt
```
Futher resource: https://broadinstitute.github.io/picard/command-lineoverview.html#MarkDuplicates

### 5.2. Samtools index : Make BAM index
```bash
$ samtools index SRR000982.mapped.sorted.markdup.bam
```

## 6. GATK
### 6.1. GATK BaseRecalibrator
```bash
$ java -jar gatk-package-4.x.x.x-local.jar BaseRecalibrator -I SRR000982.mapped.sorted.markdup.bam -R ucsc.hg19.fasta --known-sites dbsnp_138.hg19.vcf.gz --known-sites Mills_and_1000G_gold_standard.indels.hg19.sites.vcf.gz -o SRR000982.recal_data.table

$ java -jar gatk-package-4.x.x.x-local.jar ApplyBQSR -R ucsc.hg19.fasta -I SRR000982.mapped.sorted.markdup.bam --bqsr-recal-file SRR000982.recal_data.table -O SRR000982.mapped.sorted.markdup.recal.bam

$ samtools index SRR000982.mapped.sorted.markdup.recal.bam
```

### 6.2. GATK HaplotypeCaller
```bash
$ java -jar gatk-package-4.x.x.x-local.jar HaplotypeCaller -R ucsc.hg19.fasta -I SRR000982.mapped.sorted.markdup.recal.bam -O SRR000982.g.vcf -ERC GVCF

$ java -jar gatk-package-4.x.x.x-local.jar GenotypeGVCFs -R ucsc.hg19.fasta -V SRR000982.g.vcf -O SRR000982.rawVariants.vcf
```

### 6.3. GATK Variant Filter
```bash
# Select SNP
$ java -jar gatk-package-4.x.x.x-local.jar SelectVariants -R ucsc.hg19.fasta -V SRR000982.rawVariants.vcf --select-type-to-include SNP -O SRR000982.rawSNPs.vcf

# Filter SNP
$ java -jar gatk-package-4.x.x.x-local.jar VariantFiltration -R ucsc.hg19.fasta -V SRR000982.rawSNPs.vcf -filter "QD < 2.0 || FS > 60.0 || MQ < 40.0 ||  MQRankSum < -12.5  ||  ReadPosRankSum < -8.0" --filter-name SNP_FILTER -O SRR000982.rawSNPs.Filtered.vcf

# Select INDEL
$ java -jar gatk-package-4.x.x.x-local.jar SelectVariants -R ucsc.hg19.fasta -V SRR000982.rawVariants.vcf --select-type-to-include INDEL -O SRR000982.rawINDELs.vcf

# Filter INDEL
$ java -jar gatk-package-4.x.x.x-local.jar VariantFiltration -R ucsc.hg19.fasta -V SRR000982.rawSNPs.vcf -filter "QD < 2.0  || FS > 200.0 || ReadPosRankSum < -20.0" --filter-name INDEL_FILTER -O SRR000982.rawINDELs.Filtered.vcf

# Combine SNPs and INDELs
$ java -jar gatk-package-4.x.x.x-local.jar MergeVcfs -I SRR000982.rawINDELs.vcf -I SRR000982.rawINDELs.Filtered.vcf -O SRR000982.Filtered.Variants.vcf

# Detailed Filter options are here. https://software.broadinstitute.org/gatk/documentation/article?id=2806
```

## 7. SnpEff : Annotation
### 7.1. Annotate Variants
```bash
$ java -jar -Xmx4g snpEff.jar -v hg19 SRR000982.filtered.variants.vcf > SRR000982.filtered.variants.annotated.vcf
```






