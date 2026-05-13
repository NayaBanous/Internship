#Reading in all GWAS output files
#Files should be placed in the same map as this script

name1="1-Linear-output."
name2 <- c("pheno1.", "pheno2.", "pheno3.", "pheno4.")
name3 <- c("assoc", "summaries", "pvalues", "score", "coeff")

for (x in name2) {
  for (y in name3) {
    title <- paste0(name1, x, y)
    assign(paste0(x,y), read.table(title, header = TRUE, sep = "\t"))
  }
}

#Plotting a Manhattan plot
install.packages("qqman")
library(qqman)

#par(mfrow=c(2,2))
manhattan(pheno1.assoc, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 1", suggestiveline = FALSE)
manhattan(pheno2.assoc, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 2", suggestiveline = FALSE)
manhattan(pheno3.assoc, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 3", suggestiveline = FALSE)
manhattan(pheno4.assoc, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 4", suggestiveline = FALSE)

#Plotting a QQ plot
qq(pheno1.assoc$Wald_P, main="Trait 1")
qq(pheno2.assoc$Wald_P, main="Trait 2")
qq(pheno3.assoc$Wald_P, main="Trait 3")
qq(pheno4.assoc$Wald_P, main="Trait 4")

#Plotting histograms to look at the frequency of p-values
hist(pheno1.assoc$Wald_P, main="Histogram of trait 1 p-values", xlab = "P-value", ylim = range(0,20000)) 
hist(pheno2.assoc$Wald_P, main="Histogram of trait 2 p-values", xlab = "P-value", ylim = range(0,30000))
hist(pheno3.assoc$Wald_P, main="Histogram of trait 3 p-values", xlab = "P-value", ylim = range(0,20000))
hist(pheno4.assoc$Wald_P, main="Histogram of trait 4 p-values", xlab = "P-value", ylim = range(0,16000))

abline(h=0.05*297923, col="blue", lwd=2, lty="dashed") + abline(v=0.05, col="red", lwd=2)
