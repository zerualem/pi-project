



static_data <- read.csv("Analysis/static_agg_data.csv", header=T, row.names = 1)
print(dim(static_data))

library(missForest)
library(doParallel)

registerDoParallel(cores = 6)

imp_static <- missForest(static_data, maxiter = 3, ntree = 10, parallelize = "variable", verbose = TRUE)

imp_data <- imp_static$ximp

print(imp_static$OOBerror)

summary(imp_data)

saveRDS(imp_data, file = "imp_static.rds")
