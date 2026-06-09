In order to be able to estimate effect sizes and compute PRS, we need a few additional files.
When running the scripts in the PRR/MegaPRS/ map for the first time, the following commands must be run first in bash.

######
1) We want to download specifications on how to partition the genome into windows --> needed for MegaPRS effect size estimation
wget https://genetics.ghpc.au.dk/doug/berisa.txt

2) We want to use 5000 random individuals from our filtered keep file located in the Quality-control map--> needed for MegaPRS effect size estimation
keepfile="/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output"
shuf -n 5000 $keepfile > rand.5000
######