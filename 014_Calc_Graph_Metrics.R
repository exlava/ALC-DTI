#!/usr/bin/env Rscript


resdir <- '/home/ozgun/AnV/Alcohol/Stats/Network/'
setwd(resdir)

# Global Stats
# Read in Global metrics results file 
Global.Metrics <- read.csv('Global_Metrics.csv')
# Extract Global metrics from column names. First two cols are Subject and Group, adjust according to your "Global_Metrics.csv" file.
Globals <- colnames(Global.Metrics)[c(-1,-2)]

# Create an empty dataframe for Global stats results
Global_stats <- data.frame(matrix(nrow = 2, ncol = length(Globals)))
colnames(Global_stats) <- Globals
rownames(Global_stats) <- c('p.value', 't.value')

# Do the stats
for (metric in Globals) {
  stats <- t.test(Global.Metrics[,metric] ~ Group, data = Global.Metrics)
  
  Global_stats['p.value',metric] <- stats$p.value
  Global_stats['t.value',metric] <- stats$statistic
  
}

# Save results
write.csv(Global_stats, 'Stats_Global.csv')






# Nodal Stats
Nodals <- c('N_BC', 'N_DC', 'N_EL')
ROIs <- c("lAMY", "rAMY", "lINS", "rINS", "lBNS", "rBNS", "lHIP", "rHIP", "lHYP", "rHYP", "lPFC", "rPFC")


# Create an empty dataframe for Nodal stats results
Nodal_stats <- data.frame(matrix(nrow = length(Nodals), ncol = length(ROIs)))
colnames(Nodal_stats) <- ROIs
rownames(Nodal_stats) <- Nodals

# Do the stats
for (metric in Nodals) {
  H <- read.csv(paste0(metric,".csv"))

  for (i in 3:14) {
    stats <- t.test(H[,i] ~ Group, data = H)
    Nodal_stats[metric, colnames(H)[i]] <- stats$p.value
  }
  
}

# Save results
write.csv(Nodal_stats, paste0('Stats_Nodal.csv'))
