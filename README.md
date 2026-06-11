# Internship
This is the repository for the BIT11 internship (2025-2026) at the QGG in Aarhus.

It will include all code files related to the internship. 

This README provides an overview of all bash scripts with LDAK commands with their required input files and expected output files.
We only specify the kind of files needed. Keep in mind that the variables still need to be adapted for each user.

## General input
For all arguments a parameter --bfile will be required, this is followed by the prefix of the dataset inputfiles. 
E.g. for --bfile we need a data.bim, data.bed, and data.fam file. We provide the prefix "data", and LDAK will be able to find all necessary datafiles with the correct suffixes by itself.

A keep- and extract-file refer to the files created in 3-VisualisationStatistics.R. These files provide respectively the individuals and SNPs that passed the QC and are eligible for further analysis. In 3-VisualisationStatistics.R these files were created after checking and filtering for missingness, heterozygosity and MAF. Additionally, the keep-file should also undergo filtering to exclude related subjects and ethnic outliers. 

### Quality-control
2-CalculateStatistics.sh
>input: 
    - PLINK1 binary dataset
>output: 
    - .missing
    - .progress
    - .stats

6-PCA-PLINK2.sh
>input:
    - PLINK1 binary dataset
    - keepfile
    - extractfile
>output:
    - plink2.eigenval
    - plink2.eigenvec
    - plink2.king.cutoff.in.id
    - plink2.king.cutoff.out.id
    - plink2.log

### GWAS
1-Linear-regression.sh
>input: 
    - PLINK1 binary dataset
    - keepfile
    - extractfile
    - .pheno
>output:
    - phenoX.assoc
    - phenoX.coeff
    - phenoX.pvalues
    - phenoX.score
    - phenoX.summaries
    - .progress

3-Correction-clumping.sh
>input: 
    - PLINK1 binary dataset
    - keepfile
    - extractfile
    - .pvalues --> from 1-Linear-regression.sh
>output:
    - .in
    - .out
    - .progress
    - .trivial

### PRS - Prediction models - !! use new keepfile from testing data QC
1-Adv-PP-correlation.sh
>input: 
    - PLINK1 binary dataset
    - extractfile
    - 5000 randomized individuals from keepfile
    - genome partitioning instructions
>output:
    - .cors.bim
    - .cors.bin
    - .cors.root
    - .cors.windows
    - .progress

2-Adv-MegaPRS.sh
>input: 
    - .summaries --> from 1-Linear-regression.sh
    - .cors.x files --> from 1-Adv-PP-correlation.sh
>output:
    - .best
    - .cors
    - .effects
    - .frequency.check
    - .ind.hers
    - .parameters
    - .probs
    - .progress

1-Elastic-Predict.sh
>input: 
    - PLINK1 binary dataset
    - keepfile
    - extractfile
    - .pheno
>output:
    - .hers
    - .parameters
    - .phenoX.accuracy
    - .phenoX.coeff
    - .phenoX.effects
    - .phenoX.probs
    - .progress
    - .structure

### PRS - Compute PRS - !! use new keepfile from testing data QC
1-PRS-clumpedSNPs.sh
>input: 
    - PLINK1 binary dataset
    - keepfile
    - .in --> from 3-Correction-clumping.sh
    - .score --> from 1-Linear-regression.sh
>output:
    - .profile
    - .progress

1-PRS-sumstats.sh
>input: 
    - PLINK1 binary dataset
    - keepfile
    - extractfile
    - .effects --> from 2-Adv-MegaPRS.sh
>output:
    - .profile
    - .progress

1-PRS-indivlevel.sh
>input: 
    - PLINK1 binary dataset
    - keepfile
    - extractfile
    - .effects --> from 1-Elastic-Predict.sh
>output:
    - .profile
    - .progress

### SNP-heritability
1-Tagging.sh
>input: 
    - PLINK1 binary dataset
    - keepfile
    - extractfile
>output:
    - .matrix
    - .tagging
    - .progress

3-Sumhers.sh
>input: 
    - .tagging
    - .matrix
    - .summaries
>output:
    - .cats
    - .cross
    - .enrich
    - .extra
    - .hers
    - .ind.hers
    - .ind.hers.positive
    - .labels
    - .overlap
    - .progress
    - .share
    - .taus
    - (.cats.liab) --> only binary traits
    - (.factor) --> only binary traits
    - (.hers.liab) --> only binary traits
   