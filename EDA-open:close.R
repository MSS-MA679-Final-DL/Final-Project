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
df1 <- df1[-which(df1$closed == 0  & df1$open == 0),]

# Z-score and closed plot----------------------------------------------------------
plot_zscore_ns <- function(dta){
  dta %>% ggplot() + 
    geom_col(aes(x=seq(1:nrow(dta)), y = closed*2), col= "blanchedalmond") +
    geom_line(aes(x=seq(1:nrow(dta)), y = Average)) +
    labs(x = 'Frequency (hz)', y = 'Z-Score')
}

plot_zscore_ns(df1)


# Z-score and open plot----------------------------------------------------------
plot_zscore_int <- function(dta){
  dta %>% ggplot() + 
    geom_col(aes(x=seq(1:nrow(dta)), y = open*2), col= "lavender") +
    geom_line(aes(x=seq(1:nrow(dta)), y = Average)) +
    labs(x = 'Frequency (hz)', y = 'Z-Score')
}

plot_zscore_int(df1)


# density ----------------------------------------------------------------------
plot_density <- function(dta){
  dta %>% ggplot() + 
    geom_density(aes(x = Average), fill = "pink")
}

plot_density(df1)


# Proportion plot - closed-------------------------------------------------
plot_proportion_closed <- function(dta){
  pp_df <- data.frame(group = c("closed", "Open"), 
                      value = c(sum(dta$closed == 1)/nrow(dta), sum(dta$closed == 0)/nrow(dta)))
  ggplot(pp_df, aes(x="", y=value, fill=group)) +
    geom_bar(stat="identity", width=1) +
    coord_polar("y", start=0) +
    geom_text(aes(label = round(value, 3)),
              position = position_stack(vjust = 0.5)) +
    scale_fill_brewer() +
    theme_void()
}

plot_proportion_closed(df1) + 
  labs(title = 'INT_608102_414')

# bar plot - non_social -------------------------------------------------------
df_beh <- readMat('Data/Zero_Maze/608034_409/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/608034_409/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df2 <- get_data(df_zscore,df_beh)
df2 <- df2[-which(df2$closed == 0  & df2$open == 0),]
df_beh <- readMat('Data/Zero_Maze/608102_412/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/608102_412/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df3 <- get_data(df_zscore,df_beh)
df3 <- df3[-which(df3$closed == 0  & df3$open == 0),]
df_beh <- readMat('Data/Zero_Maze/608103_416/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/608103_416/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df4 <- get_data(df_zscore,df_beh)
df4 <- df4[-which(df4$closed == 0  & df4$open == 0),]
df_beh <- readMat('Data/Zero_Maze/608103_417/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/608103_417/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df5 <- get_data(df_zscore,df_beh)
df5 <- df5[-which(df5$closed == 0  & df5$open == 0),]
df_beh <- readMat('Data/Zero_Maze/608103_418/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/608103_418/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df6 <- get_data(df_zscore,df_beh)
df6 <- df6[-which(df6$closed == 0  & df6$open == 0),]
df_beh <- readMat('Data/Zero_Maze/616669_251/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/616669_251/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df7 <- get_data(df_zscore,df_beh)
df7 <- df7[-which(df7$closed == 0  & df7$open == 0),]
df_beh <- readMat('Data/Zero_Maze/619539_256/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/619539_256/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df8 <- get_data(df_zscore,df_beh)
df8 <- df8[-which(df8$closed == 0  & df8$open == 0),]
df_beh <- readMat('Data/Zero_Maze/619539_257/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/619539_257/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df9 <- get_data(df_zscore,df_beh)
df9 <- df9[-which(df9$closed == 0  & df9$open == 0),]
df_beh <- readMat('Data/Zero_Maze/619539_258/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/619539_258/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df10 <- get_data(df_zscore,df_beh)
df10 <- df10[-which(df10$closed == 0  & df10$open == 0),]
df_beh <- readMat('Data/Zero_Maze/619541_274/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/619541_274/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df11 <- get_data(df_zscore,df_beh)
df11 <- df11[-which(df11$closed == 0  & df11$open == 0),]
df_beh <- readMat('Data/Zero_Maze/619542_254/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/619542_254/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df12 <- get_data(df_zscore,df_beh)
df12 <- df12[-which(df12$closed == 0  & df12$open == 0),]
df_beh <- readMat('Data/Zero_Maze/619542_255/Day_1/Trial_001_0/binned_behavior.mat')$binned.behavior %>% as.data.frame()
df_zscore <- readMat('Data/Zero_Maze/619542_255/Day_1/Trial_001_0/binned_zscore.mat')$binned.zscore %>% as.data.frame()
df13 <- get_data(df_zscore,df_beh)
df13 <- df13[-which(df13$closed == 0  & df13$open == 0),]

count_zero <- data.frame(x = c(1:13),
                               behavior = c(rep("closed", 13), rep("open", 13)),
                               record = c(sum(df1$closed == 1)/nrow(df1),
                                          sum(df2$closed == 1)/nrow(df2),
                                          sum(df3$closed == 1)/nrow(df3),
                                          sum(df4$closed == 1)/nrow(df4),
                                          sum(df5$closed == 1)/nrow(df5),
                                          sum(df6$closed == 1)/nrow(df6),
                                          sum(df7$closed == 1)/nrow(df7),
                                          sum(df8$closed == 1)/nrow(df8),
                                          sum(df9$closed == 1)/nrow(df9),
                                          sum(df10$closed == 1)/nrow(df10),
                                          sum(df11$closed == 1)/nrow(df11),
                                          sum(df12$closed == 1)/nrow(df12),
                                          sum(df13$closed == 1)/nrow(df13),
                                          sum(df1$closed == 0)/nrow(df1),
                                          sum(df2$closed == 0)/nrow(df2),
                                          sum(df3$closed == 0)/nrow(df3),
                                          sum(df4$closed == 0)/nrow(df4),
                                          sum(df5$closed == 0)/nrow(df5),
                                          sum(df6$closed == 0)/nrow(df6),
                                          sum(df7$closed == 0)/nrow(df7),
                                          sum(df8$closed == 0)/nrow(df8),
                                          sum(df9$closed == 0)/nrow(df9),
                                          sum(df10$closed == 0)/nrow(df10),
                                          sum(df11$closed == 0)/nrow(df11),
                                          sum(df12$closed == 0)/nrow(df12),
                                          sum(df13$closed == 0)/nrow(df13)))

ggplot(data = count_zero, aes(x = x, y = record, fill = behavior))+
  geom_col()+
  scale_fill_brewer(palette = "Purples") +
  geom_text(aes(label = round(record, 3)), position = position_stack(vjust = 0.5), size = 3) +
  labs(title = "The proportion the mouse is in the closed/open arm for 15 mice", x = 'Mouse', y = 'Percentage')




