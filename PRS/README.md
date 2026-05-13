In order to be able to estimate effect sizes and compute PRS, we need a few additional files.
When running the scripts in the PRR/ map for the first time, the following commands must be run first in bash.

######
1) We want to create an extract list with all clumped predictors for all phenotypes --> needed for the classic PRS computation with the GWAS scores
cat /home/guest/BIT11/Internship/GWAS/Output/3-Correction-clumping-output*.in > clumping-extract.txt

2) We want to download specifications on how to partition the genome into windows --> needed for MegaPRS effect size estimation
wget https://genetics.ghpc.au.dk/doug/berisa.txt

3) We want to use 5000 random individuals from our filtered keep file --> needed for MegaPRS effect size estimation
shuf -n 5000 $keepfile > rand.5000
######