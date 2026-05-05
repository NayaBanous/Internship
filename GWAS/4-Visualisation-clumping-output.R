#Reading in GWAS output files, only 1-3, file 4 is NA

name1="1-Linear-output."
name2 <- c("pheno1.", "pheno2.", "pheno3.")
name3="assoc"

for (x in name2) {
  title <- paste0(name1, x, name3)
  assign(paste0(x,name3), read.table(title, header = TRUE, sep = "\t"))
}

#Reading in clumping output files = predictors to keep
name4="3-Correction-clumping-output"
name5 <- c(1:3)
name6=".in"

for (x in name5) {
  title <- paste0(name4, x, name6)
  assign(paste0("list",x,name6), read.table(title, header = FALSE))
}

#Filtering association files to only contain predictors from clumping output files
df1 <- pheno1.assoc[pheno1.assoc$Predictor %in% list1.in$V1,]
df2 <- pheno2.assoc[pheno2.assoc$Predictor %in% list2.in$V1,]
df3 <- pheno3.assoc[pheno3.assoc$Predictor %in% list3.in$V1,]

############################################################################################

#Plotting a Manhattan plot
#install.packages("qqman")
library(qqman)
library(ggplot2)

manhattan(df1, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 1- after clumping", suggestiveline = FALSE)
manhattan(df2, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 2- after clumping", suggestiveline = FALSE)
manhattan(df3, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 3- after clumping", suggestiveline = FALSE)

#Plotting a QQ plot
qq(df1$Wald_P, main="Trait 1- after clumping")
qq(df2$Wald_P, main="Trait 2- after clumping")
qq(df3$Wald_P, main="Trait 3- after clumping")

#Plotting histograms to look at the frequency of p-values
hist(df1$Wald_P, main="Histogram of trait 1 p-values - after clumping", xlab = "P-value") 
hist(df2$Wald_P, main="Histogram of trait 2 p-values - after clumping", xlab = "P-value")
hist(df3$Wald_P, main="Histogram of trait 3 p-values - after clumping", xlab = "P-value")

###########################################################################################

#Plotting the original manhattan plots from the .assoc files, and highlighting the clumped predictors

manhattan(pheno1.assoc, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 1", suggestiveline = FALSE, highlight = list1.in$V1)
manhattan(pheno2.assoc, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 2", suggestiveline = FALSE, highlight = list2.in$V1)
manhattan(pheno3.assoc, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 3", suggestiveline = FALSE, highlight = list3.in$V1)
