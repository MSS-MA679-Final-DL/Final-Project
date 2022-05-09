#  Copyright (c) 2022. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#  Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
#  Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
#  Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
#  Vestibulum commodo. Ut rhoncus gravida arcu.

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on   Apr 07 10:25:15 2022
# @Author:   Zening Ye
# @Email:    zening.ye@gmail.com
# @Project:  Neural Network
# @File:     Data.py
# @Software: PyCharm
"""

# Import Package
import os
import pandas as pd
import numpy as np
from scipy.io import loadmat

# set up file direction
# change your local path before read the file
os.chdir('/Users/zeningye/Desktop/Class/MSSP/MA 679/Project Mouse')
dir_1 = 'Data/Zero_Maze'
dir_2 = 'Day_1/trial_001_0'

# get the detail of working diretion
file = os.listdir(dir_1)
tt = [os.path.join(dir_1, f, dir_2) for f in file]
tt.pop(3)
tt

''' 
file index: 
['Data/Zero_Maze/608102_414/Day_1/trial_001_0',
 'Data/Zero_Maze/608102_412/Day_1/trial_001_0',
 'Data/Zero_Maze/619541_274/Day_1/trial_001_0',
 'Data/Zero_Maze/616669_251/Day_1/trial_001_0',
 'Data/Zero_Maze/608103_417/Day_1/trial_001_0',
 'Data/Zero_Maze/608103_416/Day_1/trial_001_0',
 'Data/Zero_Maze/608103_418/Day_1/trial_001_0',
 'Data/Zero_Maze/619539_258/Day_1/trial_001_0',
 'Data/Zero_Maze/619539_256/Day_1/trial_001_0',
 'Data/Zero_Maze/619539_257/Day_1/trial_001_0',
 'Data/Zero_Maze/619542_254/Day_1/trial_001_0',
 'Data/Zero_Maze/608034_409/Day_1/trial_001_0',
 'Data/Zero_Maze/619542_255/Day_1/trial_001_0']
'''

# Read data
# Before use get_data() make sure your file order is the same as I listed above,
# if not, run 'tt' and find the correct file (/Zero_Maze/608102_414/Day_1/trial_001_0)


def get_data(file_num):
    dta_zs = loadmat(os.path.join(tt[file_num],'binned_zscore.mat'))
    dta_beh = loadmat(os.path.join(tt[file_num],'binned_behavior.mat'))
    df_zs = pd.DataFrame(dta_zs['binned_zscore'])
    df_beh = pd.DataFrame(dta_beh['binned_behavior']).T
    df_beh.columns = ['close_arm','open_arm']
    df = pd.concat([df_zs, df_beh], axis=1)
    df1 = df.loc[(df["close_arm"] != 0 ) | (df["open_arm"] != 0)]
    df1['behavior'] = np.where(df1['open_arm'] == 1, 1, 0)
    df2 = df1.drop(['close_arm', 'open_arm'], axis = 1)
    return df2

# Demo
# df = get_data(0)