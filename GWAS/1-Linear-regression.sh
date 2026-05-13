#!/bin/bash

input="train"
inputmap="/home/guest/BIT11/Internship/data"
output="1-Linear-output"
outputmap="/home/guest/BIT11/Internship/GWAS/Output/"

#Use the list of indiv/SNPs that pass the filters during quality control to filter the dataset
keepfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output"
extractfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-SNP-output"
#The files are sufficient as there was no further exclusion

#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap

#Perform a single-predictor analysis - linear classical regression
#We have multiple phenotypes, we want to use them all --> --mpheno ALL 
./ldak6.2.linux --linear $output --pheno $input.pheno --mpheno ALL --bfile $input --keep $keepfile --extract $extractfile

#Next we move our resulting files back to our repository map Internship
mv ./$output.* $outputmap
