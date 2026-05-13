#!/bin/bash

##### WARNING: script was not used due to a too large memory requirement for our data ######


inputmap="/home/guest/BIT11/Internship/data"
input="train"

#Use the list of indiv/SNPs that pass the filters during quality control to filter the dataset
keepfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output"
extractfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-SNP-output"

#PCA argument required additional parameters to provide a kinship matrix and to specify the number of axes
#According to the LDAK-website, usually 20 dimensions are sufficient
kinfile="5-Kinship-matrix-output"
axes=20
output="5-PCA-output"
outputmap="/home/guest/BIT11/Internship/Quality-control/Output/"

#####################################################################################################################

#The data is too big to be in our Internship map, as it cannot get uploaded to github
#For this reason the scripts will include a cd towards the map where the ldak tool and data is available
cd $inputmap

#To perform a PCA, we first need to calculate a kinship matrix
#As we have dummy data, we will scale the predictors based on the observed variance, as the HWE is not applicable
./ldak6.2.linux --calc-kins-direct $kinfile --bfile $input --extract $extractfile --keep $keepfile --power -.25 --hwe-stand NO --kinship-raw YES

#Perform a PCA as the main argument
./ldak6.2.linux --pca $output --grm $kinfile --axes $axes 

#Next we move our resulting files back to our repository map Internship
mv ./$output.* $outputmap
mv ./$kinfile.* $outputmap