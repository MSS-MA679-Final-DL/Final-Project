# load package
pacman::p_load(tidyverse,R.matlab)
theme_set(theme_bw())
#-------------------------------------------------------------------------------
# Direct Interaction

# Read data
# 608034_409/Day_1/Trial_001_0
df_beh1 <- readMat('Data/Dir_Interact/608034_409/Day_1/Trial_002_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore1 <- readMat('Data/Dir_Interact/608034_409/Day_1/Trial_002_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()

# 608102_412/Day_1/Trial_002_0
df_beh2 <- readMat('Data/Dir_Interact/608102_412/Day_1/Trial_002_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore2 <- readMat('Data/Dir_Interact/608102_412/Day_1/Trial_002_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()

# 608102_414/Day_1/Trial_002_0
df_beh3 <- readMat('Data/Dir_Interact/608102_414/Day_1/Trial_002_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore3 <- readMat('Data/Dir_Interact/608102_414/Day_1/Trial_002_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()

# 608103_414/Day_1/Trial_002_0
df_beh4 <- readMat('Data/Dir_Interact/608103_416/Day_1/Trial_002_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore4 <- readMat('Data/Dir_Interact/608103_416/Day_1/Trial_002_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()

# 608103_417/Day_1/Trial_002_0
df_beh5 <- readMat('Data/Dir_Interact/608103_417/Day_1/Trial_002_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore5 <- readMat('Data/Dir_Interact/608103_417/Day_1/Trial_002_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()

# 608103_418/Day_1/Trial_002_0
df_beh6 <- readMat('Data/Dir_Interact/608103_418/Day_1/Trial_002_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore6 <- readMat('Data/Dir_Interact/608103_418/Day_1/Trial_002_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
#-------------------------------------------------------------------------------

# combine data
get_data <- function(dta_name1, dta_name2) {
  dta_name1$Average <- rowMeans(dta_name1) # Average of the cell z-score
  dta_name2 <- t(dta_name2)
  colnames(dta_name2) <- c('interaction','non_social')
  df <- cbind(dta_name1,dta_name2)
  return(df)
}

df1 <- get_data(df_zscore1,df_beh1)
df2 <- get_data(df_zscore2,df_beh2)
df3 <- get_data(df_zscore3,df_beh3)
df4 <- get_data(df_zscore4,df_beh4)
df5 <- get_data(df_zscore5,df_beh5)
df6 <- get_data(df_zscore6,df_beh6)


# proportion of the each data
df1_beh_pro_0 <- sum(df1$interaction == 0)/nrow(df1)
df1_beh_pro_1 <- sum(df1$interaction == 1)/nrow(df1)

# plot
# Average Z-score plot
plot_zscore <- function(dta){
  dta %>% ggplot(aes(x=seq(1:nrow(dta)), y = Average)) + geom_line() +
    xlab('Reaction Time (ms)') + ylab('Z-Score')
}

plot_zscore(df1) + labs(title = 'Average Reaction time for Mouse in 608034_409 (Dir_Intec)')
plot_zscore(df2) + labs(title = 'Average Reaction time for Mouse in 608102_412 (Dir_Intec)')
plot_zscore(df3) + labs(title = 'Average Reaction time for Mouse in 608102_414 (Dir_Intec)')
plot_zscore(df4) + labs(title = 'Average Reaction time for Mouse in 608102_416 (Dir_Intec)')
plot_zscore(df5) + labs(title = 'Average Reaction time for Mouse in 608102_417 (Dir_Intec)')
plot_zscore(df6) + labs(title = 'Average Reaction time for Mouse in 608102_418 (Dir_Intec)')


# Proportion plot
