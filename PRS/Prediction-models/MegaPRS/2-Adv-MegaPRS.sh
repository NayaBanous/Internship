#!/bin/bash
#This script is for performing an advanced MegaPRS - with all SNPs (after QC) and a random set of individuals - part 2/2

inputmap="/home/guest/BIT11/Internship/data"
output="2-Adv-MegaPRS-output"
outputmap="/home/guest/BIT11/Internship/PRS/Prediction-models/MegaPRS/Output/"

summ1="/home/guest/BIT11/Internship/GWAS/Output/1-Linear-output.pheno"
summ2=".summaries"
cors="/home/guest/BIT11/Internship/PRS/Prediction-models/MegaPRS/Output/1-Adv-PP-correlations-output"


#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap


#Construct the prediction model for each trait with a summary file
for n in 1 2 3 4;
do
    summary="$summ1""$n""$summ2"
    ./ldak6.2.linux --mega-prs "$output$n" --summary "$summary" --cors $cors --check-sums NO --MCMC-solve YES --PRS-variance YES 
done

#Adjustments after running the basic parameters only
#1) .summaries contains summary statistics for only 297922 of the 297923 predictors; to continue despite this error, use "--check-sums NO"
#2) predictor-predictor correlations with stem /home/guest/BIT11/Internship/PRS/Prediction-models/MegaPRS/Output/1-Adv-PP-correlations-output 
#are a very good match to the summary statistics in /home/guest/BIT11/Internship/GWAS/Output/1-Linear-output.pheno4.summaries 
#(the mean difference in frequencies is 0.0030, while the maximum difference is 0.0208), so we recommend using "--MCMC-solve YES"
#If we are switching models to MCMC, we might as well calculate the PRS variance (only possible with MCMC)

#Move all files to outputmap
mv $output* $outputmap

