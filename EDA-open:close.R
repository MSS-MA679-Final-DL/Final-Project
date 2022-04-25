# load package
pacman::p_load(tidyverse,R.matlab,gridExtra)
theme_set(theme_bw())

df_beh <- readMat('Data/Zero_Maze/608102_414/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/608102_414/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()

# combine data
get_data <- function(dta_name1, dta_name2) {
  dta_name1$Average <- rowMeans(dta_name1) # Average of the cell z-score
  dta_name2 <- t(dta_name2)
  colnames(dta_name2) <- c('closed','open')
  df <- cbind(dta_name1,dta_name2)
  return(df)
}

df1 <- get_data(df_zscore,df_beh)

# Z-score and closed plot----------------------------------------------------------
plot_zscore_ns <- function(dta){
  dta %>% ggplot() + 
    geom_col(aes(x=seq(1:nrow(dta)), y = closed*2), col= "blanchedalmond") +
    geom_line(aes(x=seq(1:nrow(dta)), y = Average)) +
    labs(x = 'Reaction Time (ms)', y = 'Z-Score')
}

plot_zscore_ns(df1) + labs(title = 'Reaction time & non-social in 608034_409')


# Z-score and open plot----------------------------------------------------------
plot_zscore_int <- function(dta){
  dta %>% ggplot() + 
    geom_col(aes(x=seq(1:nrow(dta)), y = open*2), col= "lavender") +
    geom_line(aes(x=seq(1:nrow(dta)), y = Average)) +
    labs(x = 'Reaction Time (ms)', y = 'Z-Score')
}

plot_zscore_int(df1) + labs(title = 'Reaction time & interaction in 608034_409')

