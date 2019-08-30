#############################################################
###### Imputation script ####################################
#############################################################

static_data <- read.csv("Data/static_agg_data.csv", header=T, row.names = 1)
print("Static data")
print(dim(static_data))

library(missForest)
library(doParallel)

registerDoParallel(cores = 6)

#imp_static <- missForest(static_data, maxiter = 3, ntree = 10, parallelize = "variable", verbose = TRUE)

#imp_data <- imp_static$ximp

#print(imp_static$OOBerror)

#summary(imp_data)

#saveRDS(imp_data, file = "imp_static.rds")

#############

## Imputation using the mice package

library(mice)

## Define imputation function
impute <- function (fname) {
  
  raw_data <- read.csv(paste0("Analysis/",fname, ".csv"), header=T, row.names = 1)
  print(paste("Imputing", fname,"data"))
  print(dim(raw_data))
  imp_data <- mice(raw_data,m=3,maxit=5,seed=500)
  saveRDS(imp_data, file = paste0("Output/", fname,"mice.rds"))
}

## Files list
files.name <- c("static_agg_data", "braden_agg_perc", "location_agg", 
                "periop_numeric_agg", "periop_yn_agg", "surgical_data_agg", 
                "ts_binary_agg", "ts_numeric_agg")


## Impute all data
#####################
for (i in files.name) {
  impute(i)
}

