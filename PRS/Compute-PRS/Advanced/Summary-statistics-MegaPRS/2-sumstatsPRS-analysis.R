trait1 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output1.profile", header = TRUE)
trait2 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output2.profile", header = TRUE)
trait3 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output3.profile", header = TRUE)
trait4 <- read.table("/home/guest/BIT11/Internship/PRS/Compute-PRS/Advanced/Summary-statistics-MegaPRS/Output/1-PRS-sumstats-output4.profile", header = TRUE)

pheno <- read.table("/home/guest/BIT11/Internship/data/test.pheno", header = TRUE)
#Filtering the individuals
pheno <- pheno[pheno$FID==trait1$ID1,]

#As we only need one column from the .effects files, we will create data.frames
trait1 <- data.frame(trait1$Profile_1,  pheno$Obesity)
trait2 <- data.frame(trait2$Profile_1,  pheno$Height)
trait3 <- data.frame(trait3$Profile_1,  pheno$BMI)
trait4 <- data.frame(trait4$Profile_1,  pheno$Depression)

####################################################################################
#Regression analysis
lin2height <- lm(trait2$pheno.Height~trait2$trait2.Profile_1)
summary(lin2height)

lin3bmi <- lm(trait3$pheno.BMI~trait3$trait3.Profile_1)
summary(lin3bmi)

library("pROC")
log1obesity <- glm(trait1$pheno.Obesity~trait1$trait1.Profile_1, family = binomial)
summary(log1obesity)
rocobesity <- roc(response=trait1$pheno.Obesity, predictor=trait1$trait1.Profile_1)
plot(rocobesity, print.auc=TRUE, col="blue", main="ROC curve - trait 1 as obesity")
abline(a = 0, b = 1, lty = 2, col = "red") 

log4depr <- glm(trait4$pheno.Depression~trait4$trait4.Profile_1, family = binomial)
summary(log4depr)
rocdepr <- roc(response=trait4$pheno.Depression, predictor=trait4$trait4.Profile_1)
plot(rocdepr, print.auc=TRUE, col="blue", main="ROC curve - trait 4 as depression")
abline(a = 0, b = 1, lty = 2, col = "red") 

#Additional check to make sure that we used the best possible models
summary(lm(trait3$pheno.BMI~trait2$trait2.Profile_1))
summary(lm(trait2$pheno.Height~trait3$trait3.Profile_1))

roctest <- roc(response=trait4$pheno.Depression, predictor=trait1$trait1.Profile_1)
plot(roctest, print.auc=TRUE)

roctest <- roc(response=trait1$pheno.Obesity, predictor=trait4$trait4.Profile_1)
plot(roctest, print.auc=TRUE)
##################################################################################
#Visualisation
#height
plot(trait2$trait2.Profile_1, trait2$pheno.Height,col="blue", abline(lin2height, col="red"), cex=0.6,
     xlab="PRS", ylab="Height", main="PRS-Height linear regression")
coefficient <- round(coef(lin2height),2)
equation <- paste0("y = ",coefficient[1], " + ", coefficient[2], "x\nR² = 0.2046")
text(x=1.5,y=3.2,labels=equation)
abline(v=0)

##Making strata based on the percentiles
quant <- quantile(trait2$trait2.Profile_1, c(0.2, 0.4, 0.6, 0.8))
trait2$Percentile[trait2$trait2.Profile_1 <= quant[1]] <- "0-20"
trait2$Percentile[quant[1]<trait2$trait2.Profile_1 & trait2$trait2.Profile_1<= quant[2]] <- "21-40"
trait2$Percentile[quant[2]<trait2$trait2.Profile_1 & trait2$trait2.Profile_1<= quant[3]] <-"41-60"
trait2$Percentile[quant[3]<trait2$trait2.Profile_1 & trait2$trait2.Profile_1<= quant[4]] <-"61-80"
trait2$Percentile[quant[4]<trait2$trait2.Profile_1] <- "81-100"

library(ggplot2)
ggplot(trait2, aes(Percentile, pheno.Height)) +
  geom_boxplot(color="darkblue", fill="lightblue") +
  labs(y="Height", x="PRS percentile", title = "Height - PRS percentiles boxplot")  + 
  theme(plot.title = element_text(hjust = 0.5))
  

#Bmi
plot(trait3$trait3.Profile_1, trait3$pheno.BMI,col="blue", abline(lin3bmi, col="red"), cex=0.6,
     xlab="PRS", ylab="BMI", main="PRS-BMI linear regression")
coefficient <- round(coef(lin3bmi),2)
equation <- paste0("y = ",coefficient[1], " + ", coefficient[2], "x\nR² = 0.05469")
text(x=0.8,y=3.6,labels=equation)
abline(v=0)

##Making strata based on the percentiles
quant <- quantile(trait3$trait3.Profile_1, c(0.2, 0.4, 0.6, 0.8))
trait3$Percentile[trait3$trait3.Profile_1 <= quant[1]] <- "0-20"
trait3$Percentile[quant[1]<trait3$trait3.Profile_1 & trait3$trait3.Profile_1<= quant[2]] <- "21-40"
trait3$Percentile[quant[2]<trait3$trait3.Profile_1 & trait3$trait3.Profile_1<= quant[3]] <-"41-60"
trait3$Percentile[quant[3]<trait3$trait3.Profile_1 & trait3$trait3.Profile_1<= quant[4]] <-"61-80"
trait3$Percentile[quant[4]<trait3$trait3.Profile_1] <- "81-100"

ggplot(trait3, aes(Percentile, pheno.BMI)) +
  geom_boxplot(color="darkblue", fill="lightblue") +
  labs(y="BMI", x="PRS percentile", title = "BMI - PRS percentiles boxplot")  + 
  theme(plot.title = element_text(hjust = 0.5))

#Obesity
boxplot(trait1$trait1.Profile_1~trait1$pheno.Obesity, xlab="Obesity", ylab="PRS", main="PRS-Obesity boxplot", col=c("violet", "darkblue"), names=c("Normal", "Obese"))
ttest <- t.test(trait1$trait1.Profile_1~trait1$pheno.Obesity)
text(x=1.5, y=0.3, labels="p-value = 2.497e-11")

library(ggplot2)
df <- data.frame(trait1$trait1.Profile_1, trait1$pheno.Obesity)
ggplot(df, aes(x=trait1$trait1.Profile_1, colour=factor(trait1$pheno.Obesity))) + geom_density(lwd=1.2) +
  labs(x="PRS", title = "Density plot of obesity PRS", y="Density") + 
  theme(plot.title = element_text(hjust = 0.5), legend.position = c(0.9, 0.9)) + 
  scale_color_manual(labels = c("Normal", "Obese"), values = c("violet", "darkblue"), name = "Presence of obesity")

#Depression
boxplot(trait4$trait4.Profile_1~trait4$pheno.Depression, xlab="Depression", ylab="PRS", main="PRS-Depression boxplot", col=c("violet", "darkblue"), names=c("Normal", "Depressed"))
ttest2 <- t.test(trait4$trait4.Profile_1~trait4$pheno.Depression)
text(x=1.5, y=0.1, labels="p-value = 0.1708")

library(ggplot2)
df2 <- data.frame(trait4$trait4.Profile_1, trait4$pheno.Depression)
ggplot(df2, aes(x=trait4$trait4.Profile_1, colour=factor(trait4$pheno.Depression))) + geom_density(lwd=1.2) +
  labs(x="PRS", title = "Density plot of depression PRS", y="Depression") + 
  theme(plot.title = element_text(hjust = 0.5), legend.position = c(0.9, 0.9)) + 
  scale_color_manual(labels = c("Normal", "Depressed"), values = c("violet", "darkblue"), name = "Presence of depression")
