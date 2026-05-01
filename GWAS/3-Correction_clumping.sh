#!/bin/bash

input="train"
inputmap="/home/guest/BIT11/data/"
output="3-Correction-clumping-output"
outputmap="/home/guest/BIT11/Internship/GWAS/"

#pmap="/home/guest/BIT11/Internship/GWAS/1-Linear-output.pheno*.pvalues"
pmap1="/home/guest/BIT11/Internship/GWAS/1-Linear-output.pheno"
pmap2=".pvalues"
pvaluethreshold=5e-8

#Use the list of indiv/SNPs that pass the filters during quality control to filter the dataset
keepfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output"
extractfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-SNP-output"
#The files are sufficient as there was no further exclusion

#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap

#Perform clumping in a loop as we have multiple trait files
#./ldak6.2.linux --thin-tops $output --bfile $input --keep $keepfile --extract $extractfile --window-prune 0.05 --window-cm 1 --pvalues $pmap --cutoff $pvaluethreshold

for n in 1 2 3 4;
do
    map="$pmap1""$n""$pmap2"
    ./ldak6.2.linux --thin-tops $output$n --bfile $input --keep $keepfile --extract $extractfile --window-prune 0.05 --window-cm 1 --pvalues $map --cutoff $pvaluethreshold
done

#Move everything to outputmap
mv ./$output* $outputmap