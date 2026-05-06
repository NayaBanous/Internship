#!/bin/bash
#This script is for performing a classic MegaPRS - with clumped SNPs and a random set of individuals - part 2/2

inputmap="/home/guest/BIT11/Internship/data"
output="2-MegaPRS-output"
outputmap="/home/guest/BIT11/Internship/PRS/Classic-PRS/"

summ1="/home/guest/BIT11/Internship/GWAS/1-Linear-output.pheno"
summ2=".summaries"
cors="/home/guest/BIT11/Internship/PRS/Classic-PRS/1v2-PP-correlations-output"


#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap


#Construct the prediction model for each trait with a summary file
for n in 1 2 3 4;
do
    summary="$summ1""$n""$summ2"
    ./ldak6.2.linux --mega-prs "$output$n" --summary "$summary" --cors $cors --MCMC-solve YES --PRS-variance YES
done

#Move all files to outputmap
mv $output* $outputmap