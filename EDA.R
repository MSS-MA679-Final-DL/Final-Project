# load package
pacman::p_load(tidyverse,R.matlab,gridExtra)
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
# df1_beh_pro_0 <- sum(df1$interaction == 0)/nrow(df1)
# df1_beh_pro_1 <- sum(df1$interaction == 1)/nrow(df1)
# 
# df2_beh_pro_0 <- sum(df1$interaction == 0)/nrow(df2)
# df2_beh_pro_1 <- sum(df1$interaction == 1)/nrow(df2)
# 
# 
# plot_proportion <- function(dta){
#   pp_df <- data.frame(group = c("interacion", "no social"), 
#                       value = c(sum(dta$interaction == 0)/nrow(dta), sum(dta$interaction == 1)/nrow(dta)))
#   ggplot(pp_df, aes(x="", y=value, fill=group)) +
#     geom_bar(stat="identity", width=1) +
#     coord_polar("y", start=0) +
#     geom_text(aes(label = round(value, 3)),
#               position = position_stack(vjust = 0.5)) +
#     scale_fill_brewer() +
#     theme_void()
# }

# plot
# Average Z-score plot
# plot_zscore <- function(dta){
#   dta %>% ggplot(aes(x=seq(1:nrow(dta)), y = Average)) + geom_line() +
#     xlab('Reaction Time (ms)') + ylab('Z-Score')
# }
# 
# plot_zscore(df1) + labs(title = 'Average Reaction time for Mouse in 608034_409 (Dir_Intec)')
# plot_zscore(df2) + labs(title = 'Average Reaction time for Mouse in 608102_412 (Dir_Intec)')
# plot_zscore(df3) + labs(title = 'Average Reaction time for Mouse in 608102_414 (Dir_Intec)')
# plot_zscore(df4) + labs(title = 'Average Reaction time for Mouse in 608102_416 (Dir_Intec)')
# plot_zscore(df5) + labs(title = 'Average Reaction time for Mouse in 608102_417 (Dir_Intec)')
# plot_zscore(df6) + labs(title = 'Average Reaction time for Mouse in 608102_418 (Dir_Intec)')


# Proportion plot
# plot_proportion(df1)
# plot_proportion(df2)
# plot_proportion(df3)
# plot_proportion(df4)
# plot_proportion(df5)
# plot_proportion(df6)


# Z-score and non-social plot----------------------------------------------------------
plot_zscore_ns <- function(dta){
  dta %>% ggplot() + 
    geom_col(aes(x=seq(1:nrow(dta)), y = non_social*2), col= "blanchedalmond") +
    geom_line(aes(x=seq(1:nrow(dta)), y = Average)) +
    labs(x = 'Reaction Time (ms)', y = 'Z-Score')
}

z_ns1 <- plot_zscore_ns(df1) #+ labs(title = 'Reaction time & non-social in 608034_409')
z_ns2 <- plot_zscore_ns(df2) #+ labs(title = 'Reaction time & non-social in 608102_412')
z_ns3 <- plot_zscore_ns(df3) #+ labs(title = 'Reaction time & non-social in 608102_414')
z_ns4 <- plot_zscore_ns(df4) #+ labs(title = 'Reaction time & non-social in 608102_416')
z_ns5 <- plot_zscore_ns(df5) #+ labs(title = 'Reaction time & non-social in 608102_417')
z_ns6 <- plot_zscore_ns(df6) #+ labs(title = 'Reaction time & non-social in 608102_418')

grid.arrange(z_ns1,z_ns2,z_ns3,z_ns4,z_ns5,z_ns6, nrow = 3)

# Z-score and interaction plot----------------------------------------------------------
plot_zscore_int <- function(dta){
  dta %>% ggplot() + 
    geom_col(aes(x=seq(1:nrow(dta)), y = interaction*2), col= "lavender") +
    geom_line(aes(x=seq(1:nrow(dta)), y = Average)) +
    labs(x = 'Reaction Time (ms)', y = 'Z-Score')
}

z_int1 <- plot_zscore_int(df1) #+ labs(title = 'Reaction time & interaction in 608034_409')
z_int2 <- plot_zscore_int(df2) #+ labs(title = 'Reaction time & interaction in 608102_412')
z_int3 <- plot_zscore_int(df3) #+ labs(title = 'Reaction time & interaction in 608102_414')
z_int4 <- plot_zscore_int(df4) #+ labs(title = 'Reaction time & interaction in 608102_416')
z_int5 <- plot_zscore_int(df5) #+ labs(title = 'Reaction time & interaction in 608102_417')
z_int6 <- plot_zscore_int(df6) #+ labs(title = 'Reaction time & interaction in 608102_418')

grid.arrange(z_int1,z_int2,z_int3,z_int4,z_int5,z_int6, nrow = 3)

# Proportion plot - interaction-------------------------------------------------
plot_proportion_int <- function(dta){
  pp_df <- data.frame(group = c("Interacion", "None"), 
                      value = c(sum(dta$interaction == 1)/nrow(dta), sum(dta$interaction == 0)/nrow(dta)))
  ggplot(pp_df, aes(x="", y=value, fill=group)) +
    geom_bar(stat="identity", width=1) +
    coord_polar("y", start=0) +
    geom_text(aes(label = round(value, 3)),
              position = position_stack(vjust = 0.5)) +
    scale_fill_brewer() +
    theme_void()
}

p_int1 <- plot_proportion_int(df1) + 
  labs(title = 'INT_608034_409')
p_int2 <- plot_proportion_int(df2) + 
  labs(title = 'INT_608102_412')
p_int3 <- plot_proportion_int(df3) + 
  labs(title = 'INT_608102_414')
p_int4 <- plot_proportion_int(df4) + 
  labs(title = 'INT_608102_416')
p_int5 <- plot_proportion_int(df5) + 
  labs(title = 'INT_608102_417')
p_int6 <- plot_proportion_int(df6) + 
  labs(title = 'INT_608102_418')

grid.arrange(p_int1,p_int2,p_int3,p_int4,p_int5,p_int6, nrow = 3)

# Proportion plot - non_social--------------------------------------------------
plot_proportion_ns <- function(dta){
  pp_df <- data.frame(group = c("Non_social", "None"), 
                      value = c(sum(dta$non_social == 1)/nrow(dta), sum(dta$non_social == 0)/nrow(dta)))
  ggplot(pp_df, aes(x="", y=value, fill=group)) +
    geom_bar(stat="identity", width=1) +
    coord_polar("y", start=0) +
    geom_text(aes(label = round(value, 3)),
              position = position_stack(vjust = 0.5)) +
    scale_fill_brewer() +
    theme_void()
}

p_ns1 <- plot_proportion_ns(df1) + 
  labs(title = 'NS_608034_409')
p_ns2 <- plot_proportion_ns(df2) + 
  labs(title = 'NS_608102_412')
p_ns3 <- plot_proportion_ns(df3) + 
  labs(title = 'NS_608102_414')
p_ns4 <- plot_proportion_ns(df4) + 
  labs(title = 'NS_608102_416')
p_ns5 <- plot_proportion_ns(df5) + 
  labs(title = 'NS_608102_417')
p_ns6 <- plot_proportion_ns(df6) + 
  labs(title = 'NS_608102_418')

grid.arrange(p_ns1,p_ns2,p_ns3,p_ns4,p_ns5,p_ns6, nrow = 3)

# bar plot - interaction -------------------------------------------------------
count_interaction <- data.frame(x = c("608034_409", "608102_412", "608102_414",
                                      "608102_416", "608102_417", "608102_418",
                                      "608034_409", "608102_412", "608102_414",
                                      "608102_416", "608102_417", "608102_418"),
                                behavior = c(rep("interaction", 6), rep("none", 6)),
                                interaction = c(sum(df1$interaction == 1)/nrow(df1),
                                                sum(df2$interaction == 1)/nrow(df2),
                                                sum(df3$interaction == 1)/nrow(df3),
                                                sum(df4$interaction == 1)/nrow(df4),
                                                sum(df5$interaction == 1)/nrow(df5),
                                                sum(df6$interaction == 1)/nrow(df6),
                                                sum(df1$interaction == 0)/nrow(df1),
                                                sum(df2$interaction == 0)/nrow(df2),
                                                sum(df3$interaction == 0)/nrow(df3),
                                                sum(df4$interaction == 0)/nrow(df4),
                                                sum(df5$interaction == 0)/nrow(df5),
                                                sum(df6$interaction == 0)/nrow(df6)))

ggplot(data = count_interaction, aes(x = x, y = interaction, fill = behavior))+
  geom_col()+
  scale_fill_brewer(palette = "Purples") +
  geom_text(aes(label = round(interaction, 3)), position = position_stack(vjust = 0.5), size = 3) +
  labs(title = "The proportion of interaction for six mouse", x = 'Mouse', y = 'Percentage')


# bar plot - non_social -------------------------------------------------------
count_non_social <- data.frame(x = c("608034_409", "608102_412", "608102_414",
                                     "608102_416", "608102_417", "608102_418",
                                     "608034_409", "608102_412", "608102_414",
                                     "608102_416", "608102_417", "608102_418"),
                               behavior = c(rep("non_social", 6), rep("none", 6)),
                               non_social = c(sum(df1$non_social == 1)/nrow(df1),
                                              sum(df2$non_social == 1)/nrow(df2),
                                              sum(df3$non_social == 1)/nrow(df3),
                                              sum(df4$non_social == 1)/nrow(df4),
                                              sum(df5$non_social == 1)/nrow(df5),
                                              sum(df6$non_social == 1)/nrow(df6),
                                              sum(df1$non_social == 0)/nrow(df1),
                                              sum(df2$non_social == 0)/nrow(df2),
                                              sum(df3$non_social == 0)/nrow(df3),
                                              sum(df4$non_social == 0)/nrow(df4),
                                              sum(df5$non_social == 0)/nrow(df5),
                                              sum(df6$non_social == 0)/nrow(df6)))

ggplot(data = count_non_social, aes(x = x, y = non_social, fill = behavior))+
  geom_col()+
  scale_fill_brewer(palette = "Purples") +
  geom_text(aes(label = round(non_social, 3)), position = position_stack(vjust = 0.5), size = 3) +
  labs(title = "The proportion of non-social for six mouse", x = 'Mouse', y = 'Percentage')


# bar plot 2 - interaction -------------------------------------------------------
count2_interaction <- data.frame(x = c("608034_409", "608102_412", "608102_414",
                                       "608102_416", "608102_417", "608102_418",
                                       "608034_409", "608102_412", "608102_414",
                                       "608102_416", "608102_417", "608102_418"),
                                 behavior = c(rep("Interaction", 6), rep("None", 6)),
                                 interaction = c(sum(df1$interaction == 1),
                                                 sum(df2$interaction == 1),
                                                 sum(df3$interaction == 1),
                                                 sum(df4$interaction == 1),
                                                 sum(df5$interaction == 1),
                                                 sum(df6$interaction == 1),
                                                 sum(df1$interaction == 0),
                                                 sum(df2$interaction == 0),
                                                 sum(df3$interaction == 0),
                                                 sum(df4$interaction == 0),
                                                 sum(df5$interaction == 0),
                                                 sum(df6$interaction == 0)))

ggplot(data = count2_interaction, aes(x = x, y = interaction, fill = behavior))+
  geom_col()+
  scale_fill_brewer(palette = "Purples") +
  geom_text(aes(label = round(interaction, 3)), position = position_stack(vjust = 0.5), size = 3) +
  labs(title = "The count of cell in interaction for six mouse", x = 'Mouse', y = 'Percentage')


# bar plot 2 - non_social -------------------------------------------------------
count2_non_social <- data.frame(x = c("608034_409", "608102_412", "608102_414",
                                      "608102_416", "608102_417", "608102_418",
                                      "608034_409", "608102_412", "608102_414",
                                      "608102_416", "608102_417", "608102_418"),
                                behavior = c(rep("Non_social", 6), rep("None", 6)),
                                non_social = c(sum(df1$non_social == 1),
                                               sum(df2$non_social == 1),
                                               sum(df3$non_social == 1),
                                               sum(df4$non_social == 1),
                                               sum(df5$non_social == 1),
                                               sum(df6$non_social == 1),
                                               sum(df1$non_social == 0),
                                               sum(df2$non_social == 0),
                                               sum(df3$non_social == 0),
                                               sum(df4$non_social == 0),
                                               sum(df5$non_social == 0),
                                               sum(df6$non_social == 0)))

ggplot(data = count2_non_social, aes(x = x, y = non_social, fill = behavior))+
  geom_col()+
  scale_fill_brewer(palette = "Purples") +
  geom_text(aes(label = round(non_social, 3)), position = position_stack(vjust = 0.5), size = 3) +
  labs(title = "The count of cell in non-social for six mouse", x = 'Mouse', y = 'Percentage')
