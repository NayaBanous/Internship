#We want to calculate the proportion of cases for the binary phenotypes
pheno <- read.table("/home/guest/BIT11/Internship/data/train.pheno", header = TRUE)
keep <- read.table("/home/guest/BIT11/Internship/Quality-control/4-Keep-indiv-output", header=TRUE)
pheno <- pheno[pheno$FID %in% keep$FID,]


positiveobesity <- pheno[pheno$Trait1==1,]
positivedepression <- pheno[pheno$Trait4==1,]

obesitycases <- 13411/44740
depressioncases <- 8964/44740



