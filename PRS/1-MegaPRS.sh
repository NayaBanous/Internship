#!/bin/bash

input="train"
inputmap="/home/guest/BIT11/data/"
output1="1-PP-correlations-output"
#output2="1-MegaPRS-output"
outputmap="/home/guest/BIT11/Internship/PRS/"

#Use the list of indiv that pass the filters during quality control to filter the dataset
keepfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output"


#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap

#We want to create an extract list with all clumped predictors for all phenotypes
cat /home/guest/BIT11/Internship/GWAS/3-Correction-clumping-output*.in > clumping-extract.txt

#We want to download specifications on how to partition the genome into windows
wget https://genetics.ghpc.au.dk/doug/berisa.txt


#First we calculate the predictor-predictor correlations
./ldak6.2.linux --calc-cors $output1 --bfile $input --extract clumping-extract.txt --keep $keepfile --break-points berisa.txt --allow-many-samples YES
#We add the last parameter so we dont get an error as we have more than 5000 subject


#Move all files to outputmap
mv clumping-extract.txt berisa.txt $output1* $outputmap