#!/bin/bash

#We want to calculate tagging files to use in the SNP-based heritability analysis

input="train"
inputmap="/home/guest/BIT11/Internship/data"

#specify how predictors are scaled
alpha=-0.25

output="1-Tagging-output"
outputmap="/home/guest/BIT11/Internship/SNP-heritability/Output/"

#Use the list of indiv/SNPs that pass the filters during quality control to filter the dataset
#For the individuals, it is not necessary to use the entire dataset, a random file with 5000 samples is enough
#We already have on computed for the MegaPRS prediction model
#To make a new one, uncomment the following line, and replace the keepfile value with rand.5000
# shuf -n 5000 $keepfile > rand.5000
keepfile="/home/guest/BIT11/Internship/PRS/Prediction-models/MegaPRS/rand.5000"
extractfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-SNP-output"


#We move to the map with the data
cd $inputmap


#Calculate tagfile
./ldak6.2.linux --calc-tagging $output --bfile $input --power $alpha --keep $keepfile --extract $extractfile

#Move everything
mv $output* $outputmap

