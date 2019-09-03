#############################################################
###### Imputation script ####################################
#############################################################

# surgical_data <- read.csv("Data/surgical_data_agg.csv", header=T, row.names = 1)
#print("Static data")
#print(dim(surgical_data))

#library(missForest)
library(doParallel)

registerDoParallel(cores = 6)

#imp_surgical <- missForest(surgical_data, maxiter = 3, ntree = 10, parallelize = "variable", verbose = TRUE)

#imp_data <- imp_surgical$ximp

#print(imp_surgical$OOBerror)

#summary(imp_data)

#saveRDS(imp_surgical, file = "Output/imp_surgical_miss.rds")

#############

## Imputation using the mice package

library(mice)

## Define imputation function
impute <- function (fname) {
  
  raw_data <- read.csv(paste0("Data/",fname, ".csv"), header=T, row.names = 1)
  print(paste("Imputing", fname,"data"))
  print(dim(raw_data))
  imp_data <- mice(raw_data,m=3,maxit=5,seed=500)
  saveRDS(imp_data, file = paste0("Output/", fname,"mice.rds"))
}

## Files list
files.name <- c( "ts_numeric_agg")


## Impute all data
#####################
for (i in files.name) {
  impute(i)
}

