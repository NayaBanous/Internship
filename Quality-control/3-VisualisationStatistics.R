#First we want to read in the statistics output data
statfile="/home/guest/BIT11/Internship/Quality-control/Output/2-Basic-statistics-output.stats"
missingfile="/home/guest/BIT11/Internship/Quality-control/Output/2-Basic-statistics-output.missing"

stats_table <- read.table(statfile, sep = "\t", header=TRUE)
missing_table <- read.table(missingfile, sep = "\t", header=TRUE)

summary(stats_table)
summary(missing_table)


print(stats_table[stats_table$A1_Mean<stats_table$MAF,])
#This check shows us that A1 is the more prominent allele
#This is not always the case, sometimes the major and minor allele are mixed in the columns
#In our case it is separated and MAF refers to the frequency of A2

#Check if all call rates and all missing rates are 1 and 0 respectively
print(stats_table[stats_table$Call_Rate!=1,])
print(missing_table[missing_table$Missing_Rate!=0,])


#Filter based on MAF
#First we will have a look at the distribution
MAF_hist <- hist(stats_table$MAF, main ="Distribution of MAF", xlab = "MAF")

MAF_filtered <- stats_table[stats_table$MAF>0.01,]

#Filter based on heterozygosity
#First we will look at the distribution
heterozyg_hist <- hist(missing_table$Heterozygosity_Rate, main = "Distribution of heterozygosity rate", xlab = "Heterozygosity rate")

#Let us have a look at the SD value --> according to Marees et al.
SD <- sd(missing_table$Heterozygosity_Rate)
heteroz_max <- mean(missing_table$Heterozygosity_Rate)+(3*SD)
heteroz_min <- mean(missing_table$Heterozygosity_Rate)-(3*SD)

heterozyg_hist_2 <- hist(missing_table$Heterozygosity_Rate, main = "Distribution of heterozygosity rate +- 3 SD from mean", xlab = "Heterozygosity rate", xlim=range(heteroz_min, heteroz_max))

#We decided to exclude subjects with a heterozygosity rate under 0.325
heterozyg_filtered <- missing_table[missing_table$Heterozygosity_Rate>0.325,]


#Create keep lists for subjects and predictors
#keep_indiv <- list(heterozyg_filtered$IID)
#keep_SNP <- list(MAF_filtered$Predictor)
subject_subset <- subset(heterozyg_filtered, select = c(FID,IID))
write.table(subject_subset, file = "4-Keep-indiv-output",row.names = FALSE, sep = "\t", quote = FALSE)
write.table(MAF_filtered$Predictor, file = "4-Keep-SNP-output",row.names = FALSE, quote = FALSE)
