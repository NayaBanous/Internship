# The aim of this file is to provide an initial description of the dataset
# Data start with either train or test, with a suffix .fam/.bim/.pheno/.bed

files = list("train.bim", "train.pheno", "train.fam", "test.bim", "test.pheno", "test.fam")
data="/home/guest/BIT11/Internship/data"
outputfile="1-Dataset-description-output.txt"

#Open a connection to write output to a file with sink() and close it
#This was tried outside the loop, but then only the last file info is outputted
#Putting the connection in the loop --> error: sink stack is full
#Easier to use cat()

#Directing the output to a file
for (i in files) {
  datafile <- read.table(paste0(data, i))
  cat(paste0(data, i), "\n", file=outputfile, append=TRUE)
  cat(summary(datafile),"\n",dim(datafile), "\n", file=outputfile, append=TRUE)
}


#In the console the result is clearer
for (i in files) {
  datafile <- read.table(paste0(data, i))
  print(paste0(data, i))
  print(summary(datafile))
  print(dim(datafile))
}

