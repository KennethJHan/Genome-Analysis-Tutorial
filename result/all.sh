#!/bin/bash

sample=$1
reference="/Users/jhan/etc/reference/hg19/ucsc.hg19.fasta"
java="/usr/bin/java"
samtools="/Users/jhan/etc/samtools-1.7/bin/samtools"
picard="/Users/jhan/etc/picard-2.18.17/picard.jar"
gatk="/Users/jhan/etc/gatk-4.0.11.0/gatk-package-4.0.11.0-local.jar"
snpeff="/Users/jhan/etc/snpEff/snpEff.jar"
mills="/Users/jhan/etc/gatk_bundle/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf"

if [ $# -ne 1 ];then
  echo "#usage: sh $0 <sample name>"
  exit
fi

mapping(){
  bwa mem -R "@RG\tID:test\tSM:${sample}\tPL:ILLUMINA" ${ref} ${sample}_1.filt.fastq.gz ${sample}_2.filt.fastq.gz > ${sample}.mapped.sam

  ${samtools} view –Sb ${sample}.mapped.sam > ${sample}.mapped.bam
}

mapped_flagstat(){
  echo "## mapped_flagstat - `date`"
  ${samtools} flagstat ${sample}.mapped.bam
}

make_sort_bam(){
  echo "## make_sort_bam - `date`"
  ${samtools} sort -o ${sample}.mapped.sorted.bam ${sample}.mapped.bam
  ${samtools} index ${sample}.mapped.sorted.bam
}

mark_duplicate(){
  echo "## mark_duplicate - `date`"
  ${java} -jar ${picard} MarkDuplicates \
          I=${sample}.mapped.sorted.bam \
          O=${sample}.mapped.sorted.markdup.bam \
          M=${sample}.markdup.metrics.txt
}

make_markdup_bam_idx(){
  echo "## make_markdup_bam_idx - `date`"
  ${samtools} index ${sample}.mapped.sorted.markdup.bam
}

gatk_recalibrator(){
  echo "## gatk_recalibrator - `date`"
#  ${java} -jar ${gatk} BaseRecalibrator \
#          -I ${sample}.mapped.sorted.markdup.bam \
#          -R ${reference} \
#          --known-sites dbsnp_138.hg19.vcf.gz \
#          --known-sites Mills_and_1000G_gold_standard.indels.hg19.sites.vcf.gz \
#          -o ${sample}.recal_data.table

## java -jar /Users/jhan/etc/gatk-4.0.11.0/gatk-package-4.0.11.0-local.jar IndexFeatureFile --feature-file Mills_and_1000G_gold_standard.indels.hg19.sites.vcf

  ${java} -jar ${gatk} BaseRecalibrator \
          -I ${sample}.mapped.sorted.markdup.bam \
          -R ${reference} \
          --known-sites ${mills} \
          -O ${sample}.recal_data.table

  ${java} -jar ${gatk} ApplyBQSR \
          -R ${reference} \
          -I ${sample}.mapped.sorted.markdup.bam \
          --bqsr-recal-file ${sample}.recal_data.table \
          -O ${sample}.mapped.sorted.markdup.recal.bam

  ${samtools} index ${sample}.mapped.sorted.markdup.recal.bam
}

gatk_haplotypecaller(){
  echo "## gatk_haplotypecaller - `date`"
  ${java} -jar ${gatk} HaplotypeCaller \
          -R ${reference} \
          -I ${sample}.mapped.sorted.markdup.recal.bam \
          -O ${sample}.g.vcf \
          -ERC GVCF

  ${java} -jar ${gatk} GenotypeGVCFs \
          -R ${reference} \
          -V ${sample}.g.vcf \
          -O ${sample}.rawVariants.vcf
}

gatk_variantfilter(){
  echo "## gatk_variantfilter - `date`"
  # Select SNP
  ${java} -jar ${gatk} SelectVariants \
          -R ${reference} \
          -V ${sample}.rawVariants.vcf \
          --select-type-to-include SNP \
          -O ${sample}.rawSNPs.vcf

# Filter SNP
  ${java} -jar ${gatk} VariantFiltration \
          -R ${reference} \
          -V ${sample}.rawSNPs.vcf \
          -filter "QD < 2.0 || FS > 60.0 || MQ < 40.0 ||  MQRankSum < -12.5  ||  ReadPosRankSum < -8.0" \
          --filter-name SNP_FILTER \
          -O ${sample}.rawSNPs.Filtered.vcf

# Select INDEL
  ${java} -jar ${gatk} SelectVariants \
          -R ${reference} \
          -V ${sample}.rawVariants.vcf \
          --select-type-to-include INDEL \
          -O ${sample}.rawINDELs.vcf

# Filter INDEL
  ${java} -jar ${gatk} VariantFiltration \
          -R ${reference} \
          -V ${sample}.rawSNPs.vcf \
          -filter "QD < 2.0  || FS > 200.0 || ReadPosRankSum < -20.0" \
          --filter-name INDEL_FILTER \
          -O ${sample}.rawINDELs.Filtered.vcf

# Combine SNPs and INDELs
  ${java} -jar ${gatk} MergeVcfs \
          -I ${sample}.rawSNPs.Filtered.vcf \
          -I ${sample}.rawINDELs.Filtered.vcf \
          -O ${sample}.Filtered.Variants.vcf

}

snpeff(){
  echo "## snpeff - `date`"
  ${java} -jar -Xmx4g ${snpeff} \
          -v hg19 ${sample}.filtered.variants.vcf > ${sample}.filtered.variants.annotated.vcf
}

#mapping
mapped_flagstat
make_sort_bam
mark_duplicate
make_markdup_bam_idx
gatk_recalibrator
gatk_haplotypecaller
gatk_variantfilter
snpeff

