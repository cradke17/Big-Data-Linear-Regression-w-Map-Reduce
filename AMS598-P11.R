#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

my.dir = "/gpfs/home/cradke"
data = read.csv("/gpfs/projects/AMS598/Projects/project1/project1_data.csv")
split.size = 4000
sample.size = nrow(data)
bootstrap <- function(data){
  boot.coef = as.data.frame(matrix(nrow = split.size, ncol = 11))
  names(boot.coef) <- c("b0", "b1", "b2", "b3", "b4", "b5", "b6", "b7", "b8", "b9", "b10")
  for(i in 1:split.size){
    boot.sample = data[sample(1:sample.size, sample.size, replace=TRUE),]
    boot.model = lm(y~X1+X2+X3+X4+X5+X6+X7+X8+X9+X10, data = boot.sample)
    for(j in 1:ncol(boot.coef)){
      boot.coef[i, j] = boot.model$coefficients[j]
    }
  }
  return(boot.coef)
}
boot = bootstrap(data)
write.csv(boot, file = "p11_output.csv")
