#Reading in the files
#Files should be placed in the same map as this script
eigenval <- read.table("plink2.eigenval", col.names = "Eigenvalue per PC")

header.eigenvec <- c("FID","IID","PC1","PC2","PC3","PC4","PC5",	"PC6","PC7","PC8","PC9","PC10")
eigenvec <- read.table("plink2.eigenvec", header = FALSE, sep = "\t", col.names = header.eigenvec)

king.cutoff.in.id <- read.table("plink2.king.cutoff.in.id", header = FALSE,sep = "\t", col.names= c("FID","IID"))

#Plotting PC1 and PC2
plot(eigenvec$PC1,eigenvec$PC2, xlab = "PC1", ylab = "PC2", main = "PCA")
