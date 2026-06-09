#!/bin/bash

tagfile="/home/guest/BIT11/Internship/SNP-heritability/Output/1-Tagging-output.tagging"
matrix="/home/guest/BIT11/Internship/SNP-heritability/Output/1-Tagging-output.matrix"
output="3-Sumhers-output"
outputmap="/home/guest/BIT11/Internship/SNP-heritability/Output/"

summary1="/home/guest/BIT11/Internship/GWAS/Output/1-Linear-output.pheno"
summary2=".summaries"

#Create arrays with the trait numbers. For binary we will use the traitnumber as key, and case-proportion as value
continuous=(2 3)
declare -A binary=(["1"]=0.3 ["4"]=0.2)
declare -A binaryprevalence=(["1"]=0.16 ["4"]=0.057)


inputmap="/home/guest/BIT11/Internship/data"

#LDAK is in inputmap
cd $inputmap

#Calculate snp-heritability for each continuous trait
for n in "${continuous[@]}";
do
    summary="$summary1""$n""$summary2"
    ./ldak6.2.linux --sum-hers $output$n --tagfile $tagfile --summary $summary --matrix $matrix --cutoff 0.01
done

#Calculate snp-heritability for each binary trait
for key in "${!binary[@]}";
do
    summary="$summary1""$key""$summary2"
    ./ldak6.2.linux --sum-hers $output$key --tagfile $tagfile --summary $summary  --ascertainment ${binary[$key]} --prevalence ${binaryprevalence[$key]} --matrix $matrix --cutoff 0.01
done


mv $output* $outputmap


