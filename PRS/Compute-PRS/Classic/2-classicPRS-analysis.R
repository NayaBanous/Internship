# Reading in the .profile files
trait1 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Classic/Output/1-PRS-clumpedSNPs-output1.profile", header = TRUE)
trait2 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Classic/Output/1-PRS-clumpedSNPs-output2.profile", header = TRUE)
trait3 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Classic/Output/1-PRS-clumpedSNPs-output3.profile", header = TRUE)

# Reading in the phenotype data
pheno <- read.table("/home/guest/BIT11/Internship/data/test.pheno", header = TRUE)
#Filtering the individuals
pheno <- pheno[pheno$FID==trait1$ID1,]

#For continuous traits we will perform linear regression + calculate R²
#for binary traits logistic regression + calculate AUC

#The trait number is based on the order of the traits in train dataset:
# so traits 2 and 3 = continuous
# traits 1 and 4 = binary

################################################################################
#Regression analysis
#First we look at the linear regression
lin2height <- lm(pheno$Height~trait2$Profile_7)
summary(lin2height)

#lin2bmi <- lm(pheno$BMI~trait2$Profile_7)
#summary(lin2bmi)

#lin3height <- lm(pheno$Height~trait3$Profile_7)
#summary(lin3height)

lin3bmi <- lm(pheno$BMI~trait3$Profile_7)
summary(lin3bmi)

#Then we look at logistic regression
library("pROC")
log1obesity <- glm(pheno$Obesity~trait1$Profile_7, family = binomial)
summary(log1obesity)
rocobesity <- roc(response=pheno$Obesity, predictor=trait1$Profile_7)
plot(rocobesity, print.auc=TRUE, col="blue", main="ROC curve - trait 1 as obesity")
abline(a = 0, b = 1, lty = 2, col = "red") 

#log1depression <- glm(pheno$Depression~trait1$Profile_7, family=binomial)
#summary(log1depression)
#rocdepression <- roc(response=pheno$Depression, predictor=trait1$Profile_7)
#plot(rocdepression, print.auc=TRUE, col="blue", main="ROC curve - trait 1 as depression")
#abline(a = 0, b = 1, lty = 2, col = "red") 

#Based on R² and AUC we assume that
#trait 1 = obesity
#trait 2 = height
#trait 3 = bmi

################################################################################
#Plotting of regression analyses: continuous
#Height
plot(trait2$Profile_7, pheno$Height,col="blue", abline(lin2height, col="red"), cex=0.6,
     xlab="PRS", ylab="Height", main="PRS-Height linear regression")
coefficient <- round(coef(lin2height),2)
equation <- paste0("y = ",coefficient[1], " + ", coefficient[2], "x")
text(x=0.8,y=3.2,labels=equation)
abline(v=0)


###############################################
#Bmi
plot(trait3$Profile_7, pheno$BMI,col="blue", abline(lin3bmi, col="red"), cex=0.6,
     xlab="PRS", ylab="BMI", main="PRS-BMI linear regression")
coefficient <- round(coef(lin3bmi),2)
equation <- paste0("y = ",coefficient[1], " + ", coefficient[2], "x")
text(x=0.5,y=3.6,labels=equation)
abline(v=0)

################################################################################
#Plotting of regression analysis: binary 
#Obesity
boxplot(trait1$Profile_7~pheno$Obesity, xlab="Obesity", ylab="PRS", main="PRS-Obesity boxplot", col=c("violet", "darkblue"), names=c("Normal", "Obese"))
ttest <- t.test(trait1$Profile_7~pheno$Obesity)
text(x=1.5, y=0.05, labels="p-value = 0.0009217")

library(ggplot2)
df <- data.frame(trait1$Profile_7, pheno$Obesity)
ggplot(df, aes(x=trait1$Profile_7, colour=factor(pheno$Obesity))) + geom_density(lwd=1.2) +
  labs(x="PRS", title = "Density plot of obesity PRS", y="Density") + 
  theme(plot.title = element_text(hjust = 0.5), legend.position = c(0.9, 0.9)) + 
  scale_color_manual(labels = c("Normal", "Obese"), values = c("violet", "darkblue"), name = "Presence of obesity")

################################################################################