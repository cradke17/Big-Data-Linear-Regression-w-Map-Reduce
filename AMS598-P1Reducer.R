#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

dir = "/gpfs/scratch/cradke"
setwd("/gpfs/home/cradke")

coefs = read.csv(paste0(dir, "/p1_output.csv"))
coefs = coefs[,2:12]

for(i in 2:25){
  data = read.csv(paste0(dir, "/p", i, "_output.csv"))
  data = data[,2:12]
  coefs = rbind(coefs, data)
}
interval.df = as.data.frame(matrix(nrow=11, ncol=3))
names(interval.df) = c("var", "2.5%", "97.5%")
interval.df$var = names(coefs)
for(i in 1:ncol(coefs)){
  interval.df[i, 2] = as.numeric(quantile(coefs[[i]], probs = 0.025))[1]
  interval.df[i, 3] = as.numeric(quantile(coefs[[i]], probs = 0.975))[1]
}
write.csv(interval.df, file = "intervals.csv")

