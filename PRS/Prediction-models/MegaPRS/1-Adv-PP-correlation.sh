#!/bin/bash
#This script is for performing an advanced MegaPRS - with all SNPs (after QC) and a random set of individuals - part 1/2
input="train"
inputmap="/home/guest/BIT11/Internship/data"
output="1-Adv-PP-correlations-output"
outputmap="/home/guest/BIT11/Internship/PRS/Prediction-models/MegaPRS/Output/"

#Use the list of indiv that pass the filters during quality control to filter the dataset
extractfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-SNP-output"

#Use a list of random individuals, see README.md
randomkeep="/home/guest/BIT11/Internship/PRS/Prediction-models/MegaPRS/rand.5000"

#We want to download specifications on how to partition the genome into windows --> see README.md
#Command: wget https://genetics.ghpc.au.dk/doug/berisa.txt
berisa="/home/guest/BIT11/Internship/PRS/Prediction-models/MegaPRS/berisa.txt"

#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap


#First we calculate the predictor-predictor correlations
./ldak6.2.linux --calc-cors $output --bfile $input --extract $extractfile --keep $randomkeep --break-points $berisa 

#We can add a parameter so we dont get an error if we want more than 5000 subjects (when you want to use all indiv)
# --allow-many-predictors YES + --keep $keepfile
# keepfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output"

#Move all files to outputmap
mv $output* $outputmap