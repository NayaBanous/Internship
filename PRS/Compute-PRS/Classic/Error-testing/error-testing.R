#Checking single-SNP PRS test
testtable <- read.table("testing.profile", header = TRUE)
summary(testtable)

#GWAS .score file
score <- read.table("/home/guest/BIT11/Internship/GWAS/Output/1-Linear-output.pheno3.score", header = TRUE)
summary(score)
# We see that the weights differ per p-value threshold for each predictor

#Original run of classic PRS --> checking the .profile file
run <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Classic/Output/1-PRS-clumpedSNPs-output3.profile", header = TRUE)
summary(run)
#We see that all PRS are the same over each profile (thus each p-value threshold) for each indiv
#This is very unlikely as the weights differ, so must the PRS then