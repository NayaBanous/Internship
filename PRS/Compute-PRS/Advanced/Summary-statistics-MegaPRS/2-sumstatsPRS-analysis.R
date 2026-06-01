trait1 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output1.profile", header = TRUE)
trait2 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output2.profile", header = TRUE)
trait3 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output3.profile", header = TRUE)
trait4 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output4.profile", header = TRUE)

pheno <- read.table("/home/guest/BIT11/Internship/data/test.pheno", header = TRUE)
#Filtering the individuals
pheno <- pheno[pheno$FID==trait1$ID1,]

library("pROC")
analysis1 <- glm(pheno$Depression~trait1$Profile_7)
summary(analysis1)

roccurve <- roc(response=pheno$Obesity, predictor=trait1$Profile_7)
plot(roccurve, print.auc=TRUE)
