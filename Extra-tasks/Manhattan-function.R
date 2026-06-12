#We want to make a stand-alone function that generates a Manhattan plot, only requires input data
#Currently this is how we make the plot
library(qqman)
pheno1.assoc <- read.table("/home/guest/BIT11/Internship/GWAS/Output/1-Linear-output.pheno1.assoc", header = TRUE)
manhattan(pheno1.assoc, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main="Trait 1", suggestiveline = FALSE)


#We want to make it easier than having to write it fully out
my_manhattan <- function(file.assoc, title="Manhattan plot") {
  if (!endsWith(file.assoc, ".assoc")) {
    stop("Input must be an .assoc file.")
  }
  #install.packages("qqman")
  library(qqman)
  file <- read.table(file.assoc, header = TRUE)
  manhattan(file, chr = "Chromosome", bp="Basepair", snp="Predictor", p="Wald_P", main=title, suggestiveline = FALSE)
}
