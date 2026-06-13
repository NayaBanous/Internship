#!/bin/bash

#General input for all three methods
input="test"
inputmap="/home/guest/BIT11/Internship/data"
outputmap="/home/guest/BIT11/Internship/Extra-tasks/Output/"

traits=(1 2 3 4)

output1="1-PRS-clumpedSNPs-output"
output2="1-PRS-sumstats-output"
output3="1-PRS-indivlevel-output"

keepfile="/home/guest/BIT11/Internship/PRS/Compute-PRS/Quality-control-testdata/4-Keep-indiv-test-output"
extractfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-SNP-output"

#Specific for classic PRS
clumpfile1="/home/guest/BIT11/Internship/GWAS/Output/3-Correction-clumping-output"
clumpfile2=".in"

score1="/home/guest/BIT11/Internship/GWAS/Output/1-Linear-output.pheno"
score2=".score"

#Specific for MegaPRS
score3="/home/guest/BIT11/Internship/PRS/Prediction-models/MegaPRS/Output/2-Adv-MegaPRS-output"
score4=".effects"

#Specific for Elastic Predict
score5="/home/guest/BIT11/Internship/PRS/Prediction-models/Elastic-Predict/Output/1-Elastic-Predict-output.pheno"

###############################################################################################
#Compute the PRS for each trait 

cd $inputmap

for n in "${traits[@]}";
do
    clumpfile="$clumpfile1""$n""$clumpfile2"
    scorefile="$score1""$n""$score2"
    ./ldak6.2.linux --calc-scores $output1$n --scorefile $scorefile --bfile $input --keep $keepfile --extract $clumpfile

    scorefile="$score3""$n""$score4"
    ./ldak6.2.linux --calc-scores $output2$n --scorefile $scorefile --bfile $input --keep $keepfile --extract $extractfile

    scorefile="$score5""$n""$score4"
    ./ldak6.2.linux --calc-scores $output3$n --scorefile $scorefile --bfile $input --keep $keepfile --extract $extractfile
done

mv $output1* $output2* $output3* $outputmap
######################################################################################################################

