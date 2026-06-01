#!/bin/bash

input="test"
inputmap="/home/guest/BIT11/Internship/data"
output="testing"
outputmap="/home/guest/BIT11/Internship/PRS/Compute-PRS/Classic/Error-testing"

#Use the list of indiv that pass the filters during quality control to filter the dataset + clumped SNPs
keepfile="/home/guest/BIT11/Internship/PRS/Compute-PRS/Quality-control-testdata/4-Keep-indiv-test-output"
extractfile="/home/guest/BIT11/Internship/PRS/Compute-PRS/Classic/Error-testing/snp"

#Scorefile to be used, which contains the estimated effect sizes of the SNPs calculated by linear regression
score="/home/guest/BIT11/Internship/GWAS/Output/1-Linear-output.pheno3.score"


#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap


./ldak6.2.linux --calc-scores $output --scorefile $score --bfile $input --keep $keepfile --extract $extractfile

mv $output* $outputmap

 