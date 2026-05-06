#!/bin/bash

inputmap="/home/guest/BIT11/Internship/data"
input="train"

#Use the list of indiv/SNPs that pass the filters during quality control to filter the dataset
keepfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output"
extractfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-SNP-output"

outputmap="/home/guest/BIT11/Internship/Quality-control/"


#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap


# King cutoff of 0.177 to find monozygotic twins, duplicate samples, and first-degree relations
plink2 --pca approx --extract $extractfile --keep $keepfile --bfile $input --memory 4000 --threads 4 --king-cutoff 0.177

mv plink2.* $outputmap