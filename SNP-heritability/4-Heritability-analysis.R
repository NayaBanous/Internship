#Calculate log likelihood ratio
#LRT = -2 * ln(likelihood H0 / likelihood HA) = -2 * (logl H0 - logl HA) = 2 * (logl HA - logl H0)

extra1 <- read.table("3-Sumhers-output1.extra")
extra2 <- read.table("3-Sumhers-output2.extra")
extra3 <- read.table("3-Sumhers-output3.extra")
extra4 <- read.table("3-Sumhers-output4.extra")

LRT1 <- 2*(as.numeric(extra1[7,2]) - as.numeric(extra1[6,2]))
P1 <- pchisq(LRT1, df=1, lower.tail = FALSE)

LRT2 <- 2*(as.numeric(extra2[7,2]) - as.numeric(extra2[6,2]))
P2 <- pchisq(LRT2, df=1, lower.tail = FALSE)

LRT3 <- 2*(as.numeric(extra3[7,2]) - as.numeric(extra3[6,2]))
P3 <- pchisq(LRT3, df=1, lower.tail = FALSE)

LRT4 <- 2*(as.numeric(extra4[7,2]) - as.numeric(extra4[6,2]))
P4 <- pchisq(LRT4, df=1, lower.tail = FALSE)

####################################################################################
#Calculate R² for binary traits to compare to heritability
trait1 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output1.profile", header = TRUE)
trait4 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output4.profile", header = TRUE)

pheno <- read.table("/home/guest/BIT11/Internship/data/test.pheno", header = TRUE)
#Filtering the individuals
pheno <- pheno[pheno$FID==trait1$ID1,]

#As we only need one column from the .effects files, we will create data.frames
trait1 <- data.frame(trait1$Profile_1,  pheno$Obesity)
trait4 <- data.frame(trait4$Profile_1,  pheno$Depression)


#Regression analysis
lin1 <- lm(trait1$pheno.Obesity~trait1$trait1.Profile_1)
summary(lin1)

lin4 <- lm(trait4$pheno.Depression~trait4$trait4.Profile_1)
summary(lin4)
