#!/bin/bash
#This script is for performing an Elastic Predict, which uses individual-level data instead of summary statistics, to construct an elastic prediction model

input="train"
inputmap="/home/guest/BIT11/Internship/data"
output="1-Elastic-Predict-output"
outputmap="/home/guest/BIT11/Internship/PRS/Prediction-models/Elastic-Predict/Output/"

#Use the list of indiv/SNPs that pass the filters during quality control to filter the dataset
keepfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output"
extractfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-SNP-output"

#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap

#Construct an indiv-level based prediction model
./ldak6.2.linux --elastic $output --bfile $input --keep $keepfile --extract $extractfile --pheno $input.pheno --mpheno ALL --LOCO NO --max-threads 4

# Add  --skip-cv YES option to train model with 100% of samples, delete to instead use 90%/10% for train/test in cross-validation
#When runnig elastic-predict, it uses cv to decide the best set of parameters (this is the default), then only makes PRS weights for this set. 
#If you skip cv, it instead makes PRS weights for all 10 sets of parameters. Normally we only want one set of PRS weights, so best not to skip cv

#Multiple phenotypes present --> --mpheno ALL to use all


mv $output* $outputmap
