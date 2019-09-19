# GATK3 Best Practice Tutorial

Please visit this site to see web version of this git repository.
<br>
<a href="https://kennethjhan.github.io/Genome-Analysis-Tutorial/">https://kennethjhan.github.io/Genome-Analysis-Tutorial/</a>

This page will help you to learn how to make pipeline based on GATK3 BestPractice.

From this page, <a href="https://kennethjhan.github.io/Genome-Analysis-Tutorial/resource">https://kennethjhan.github.io/Genome-Analysis-Tutorial/resource</a> you can download resorce file such as reference fasta, samtools, bwa, picard, GATK3, snpEff and raw fastq file.

YES! This tutorial is based on GATK3 which is stable and wide used tool from Broad Institute.

I hope everyone learns how to analyze gene data and contributes scientific field.

IF YOU WANT GATK4-BEST PRACTICE PIPELINE PLEASE CLICK <a href="https://kennethjhan.github.io/Genome-Analysis-Tutorial/README.md">HERE</a>.

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

### 2.4. INSTALL GATK3

```bash
# 1) Download GATK3
https://software.broadinstitute.org/gatk/download/archive
Download GenomeAnalysisTK-3.8-1-0-gf15c1c3ef.tar.bz2

# 2) Extract
$ tar xf GenomeAnalysisTK-3.8-1-0-gf15c1c3ef.tar.bz2

# 3) Run GATK3
$ java -jar gatk-package-4.0.11.0-local.jar
$ jaga -jar GenomeAnalysisTK.jar

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
## Parameters


## 4. Map to Reference
### 4.1. BWA mem : FASTQ to SAM
```bash
$ bwa mem -R "@RG\tID:test\tSM:${SAMPLE}\tPL:ILLUMINA" ucsc.hg19.fasta ${SAMPLE}_1.filt.fastq.gz ${SAMPLE}_2.filt.fastq.gz > ${SAMPLE}.mapped.sam
```

### 4.2. Samtools : SAM to BAM
```bash
$ samtools view –Sb ${SAMPLE}.mapped.sam > ${SAMPLE}.mapped.bam
```

### 4.3. Samtools sort : Make Sorted BAM
```bash
$ samtools sort –o ${SAMPLE}.sorted.bam ${SAMPLE}.mapped.bam

$ samtools view ${SAMPLE}.mapped.bam | head
${SAMPLE}.26 131 chrX 26266805
${SAMPLE}.32 65 chr13 75944171
${SAMPLE}.32 129 chrX 138770110
${SAMPLE}.34 115 chr2 190054626
……

$ samtools view ${SAMPLE}.sorted.bam | head
${SAMPLE}.91192 115 chrM
……
${SAMPLE}.186880 65 chrM
${SAMPLE}.434476 115 chr1
${SAMPLE}.434476 179 chr1
# Sort chromosome ordered
```

### 4.4 (Optional) Run from 4.1 to 4.3 in one command
```bash
${BWA} mem -R "@RG\tID:test\tSM:${SAMPLE}\tPL:ILLUMINA" ${REFERENCE} ${SAMPLE}_1.filt.fastq.gz ${SAMPLE}_2.filt.fastq.gz | ${SAMTOOLS} view -Sb - | ${SAMTOOLS} sort - > ${SAMPLE}.sorted.bam
```

## 5. Mark Duplicate
### 5.1. Picard MarkDuplicate : Sorted BAM to Markdup BAM
```bash
$ ${JAVA} –jar picard.jar MarkDuplicates I=${SAMPLE}.
sorted.bam O=${SAMPLE}.markdup.bam
M=${SAMPLE}.markdup.metrics.txt
```
Futher resource: https://broadinstitute.github.io/picard/command-lineoverview.html#MarkDuplicates

### 5.2. Samtools index : Make BAM index
```bash
$ samtools index ${SAMPLE}.markdup.bam
```

## 6. GATK
### 6.1. GATK Target Realign
```bash
${JAVA} -jar ${GATK} -T RealignerTargetCreator -R ${REFERENCE} -I ${SAMPLE}.markdup.bam -known ${MILLS} -known ${A1KG} -o ${SAMPLE}.intervals #-L bed
${JAVA} -jar ${GATK} -T IndelRealigner -R ${REFERENCE} -I ${SAMPLE}.markdup.bam -known ${MILLS} -known ${A1KG} -targetIntervals ${SAMPLE}.intervals -o ${SAMPLE}.realign.bam #-L bed
```

### 6.2. GATK BaseRecalibrator
```bash
${JAVA} -jar ${GATK} -T BaseRecalibrator -R ${REFERENCE} -I ${SAMPLE}.realign.bam -knownSites ${MILLS} -knownSites ${A1KG} -knownSites ${DBSNP138} -o ${SAMPLE}.table #-L bed
${JAVA} -jar ${GATK} -T PrintReads -R ${REFERENCE} -I ${SAMPLE}.realign.bam -o ${SAMPLE}.recal.bam -BQSR ${SAMPLE}.table #-L bed
```

### 6.2. GATK HaplotypeCaller, GenotypeGVCFs
```bash
${JAVA} -jar ${GATK} -T HaplotypeCaller -R ${REFERENCE} -I ${SAMPLE}.recal.bam --emitRefConfidence GVCF --dbsnp ${DBSNP138} -o ${SAMPLE}.g.vcf #-L bed
${JAVA} -jar ${GATK} -T GenotypeGVCFs -R ${REFERENCE} -V ${SAMPLE}.g.vcf -o ${SAMPLE}.raw.vcf #-L bed
```

### 6.3. GATK Variant Filter
```bash
# Select SNP
${JAVA} -jar ${GATK} -T SelectVariants -R ${REFERENCE} -V ${SAMPLE}.raw.vcf -o ${SAMPLE}.raw.snp.vcf --selectTypeToInclude SNP

# Filter SNP
${JAVA} -jar ${GATK} -T VariantFiltration -R ${REFERENCE} -V ${SAMPLE}.raw.snp.vcf -o ${SAMPLE}.filtered.snp.vcf --filterExpression "QD < 2.0 || FS > 60.0 || MQ < 40.0 ||  MQRankSum < -12.5  ||  ReadPosRankSum < -8.0" --filterName SNP_FILTER

# Select INDEL
${JAVA} -jar ${GATK} -T SelectVariants -R ${REFERENCE} -V ${SAMPLE}.raw.vcf -o ${SAMPLE}.raw.indel.vcf --selectTypeToInclude INDEL

# Filter INDEL
${JAVA} -jar ${GATK} -T VariantFiltration -R ${REFERENCE} -V ${SAMPLE}.raw.indel.vcf -o ${SAMPLE}.filtered.indel.vcf --filterExpression "QD < 2.0  || FS > 200.0 || ReadPosRankSum < -20.0" --filterName INDEL_FILTER

# Combine SNPs and INDELs
${JAVA} -jar ${GATK} -T CombineVariants -R ${REFERENCE} -V ${SAMPLE}.filtered.snp.vcf -V ${SAMPLE}.filtered.indel.vcf -o ${SAMPLE}.filtered.vcf -genotypeMergeOptions UNSORTED

# Detailed Filter options are here. https://software.broadinstitute.org/gatk/documentation/article?id=2806
```

## 7. SnpEff : Annotation
### 7.1. Annotate Variants
```bash
${JAVA} -jar -Xmx4g ${SNPEFF} -v hg19 ${SAMPLE}.filtered.vcf > ${SAMPLE}.filtered.annotated.vcf
```






