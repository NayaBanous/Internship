#!/bin/bash
#This script is for computing an advanced PRS, where we use all individuals and SNPs after QC, with effect estimates calculated from summary statistics
#We filter indiv on testing QC, and SNPs on training QC as our effect estimates are based on the predictors from training

input="test"
inputmap="/home/guest/BIT11/Internship/data"
output="1-PRS-sumstats-output"
outputmap="/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/"

#Use the list of indiv that pass the filters during quality control to filter the dataset + clumped SNPs
keepfile="/home/guest/BIT11/Internship/PRS/Compute-PRS/Quality-control-testdata/4-Keep-indiv-test-output"
extractfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-SNP-output"

#Scorefile to be used, which contains the estimated effect sizes of the SNPs calculated by linear regression
score1="/home/guest/BIT11/Internship/PRS/Prediction-models/MegaPRS/Output/2-Adv-MegaPRS-output"
score2=".effects"

#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap


#Compute the PRS for each trait with a .effect file from the prediction model computed with MegaPRS 
for n in 1 2 3 4;
do
    scorefile="$score1""$n""$score2"
    ./ldak6.2.linux --calc-scores $output$n --scorefile $scorefile --bfile $input --keep $keepfile --extract $extractfile
done
#We used --PRS-variance YES and --MCMC-solve YES while creating our prediction model, thus we need to add this here too
#However, due to an error in LDAK itself, it is currently not working. Therefore we will keep it out for the monent
#It will lead to additional empty columns. If we wanted to do it properly, we would have to repeat the --megaprs command without --PRS-variance YES


mv $output* $outputmap

 