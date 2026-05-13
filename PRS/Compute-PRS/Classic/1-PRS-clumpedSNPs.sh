#!/bin/bash
#This script is for computing a classic PRS, where we use all individuals (after QC) and our clumped SNPs (corrected for multiple testing and LD)
#We filter indiv on testing QC, and clumped SNPs on training QC as our effect estimates are based on the predictors from training

input="test"
inputmap="/home/guest/BIT11/Internship/data"
output="1-PRS-clumpedSNPs-output"
outputmap="/home/guest/BIT11/Internship/PRS/Compute-PRS/Classic/Output/"

#Use the list of indiv that pass the filters during quality control to filter the dataset + clumped SNPs
keepfile="/home/guest/BIT11/Internship/PRS/Compute-PRS/Quality-control-testdata/4-Keep-indiv-test-output"
extractclumped="/home/guest/BIT11/Internship/PRS/clumping-extract.txt"

#Scorefile to be used, which contains the estimated effect sizes of the SNPs calculated by linear regression
score1="/home/guest/BIT11/Internship/GWAS/Output/1-Linear-output.pheno"
score2=".score"

#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap


#Compute the PRS for each trait with a .score file from linear regression
for n in 1 2 3 4;
do
    scorefile="$score1""$n""$score2"
    ./ldak6.2.linux --calc-scores $output$n --scorefile $scorefile --bfile $input --keep $keepfile --extract $extractclumped
done

mv $output* $outputmap