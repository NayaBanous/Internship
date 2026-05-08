#!/bin/bash
#This script is for performing a classic MegaPRS - with clumped SNPs and a random set of individuals - part 1/2
input="train"
inputmap="/home/guest/BIT11/Internship/data"
output="1v2-PP-correlations-output"
outputmap="/home/guest/BIT11/Internship/PRS/Classic-PRS/"

#Use the list of indiv that pass the filters during quality control to filter the dataset
keepfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output"

#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap

#We want to create an extract list with all clumped predictors for all phenotypes
#uncomment following line when running for the first time
cat /home/guest/BIT11/Internship/GWAS/3-Correction-clumping-output*.in > clumping-extract.txt

#We want to download specifications on how to partition the genome into windows
#uncomment following line when running for the first time
wget https://genetics.ghpc.au.dk/doug/berisa.txt

#We want to use 5000 random individuals from our filtered keep file
#uncomment following line when running for the first time
shuf -n 5000 $keepfile > rand.5000

#First we calculate the predictor-predictor correlations
./ldak6.2.linux --calc-cors $output --bfile $input --extract clumping-extract.txt --keep rand.5000 --break-points berisa.txt 

#We can add a parameter so we dont get an error if we want more than 5000 subjects (when you want to use all indiv)
# --allow-many-predictors YES + --keep $keepfile --> results in with-keep-indiv map --> versie 1


#Move all files to outputmap
mv clumping-extract.txt berisa.txt $output* rand.5000 $outputmap