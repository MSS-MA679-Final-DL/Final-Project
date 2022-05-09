#  Copyright (c) 2022. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#  Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
#  Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
#  Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
#  Vestibulum commodo. Ut rhoncus gravida arcu.

# !/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on   Apr 16 22:54:15 2022
# @Author:   Zening Ye
# @Email:    zening.ye@gmail.com
# @Project:  Neural Network
# @File:     Single_RNN.py
# @Software: PyCharm
"""
# Import Packages, Functions and Class
import tensorflow as tf
from Generator import data_load
from Data import get_data
from C_F import compile_fit
from Model_Plot import plotlys

# each row represent 0.1 second
# Load Data
df = get_data(0) # 608102_414

# Proportion of data
n = len(df)
train_df = df[0:int(n*0.7)]
val_df = df[int(n*0.7):int(n*0.9)]
test_df = df[int(n*0.9):]

# window slice
# 15 row as a window slice
GRU_single = data_load(input_width=15,label_width=15,train_df=train_df,val_df=val_df,
                     test_df=test_df, step=1,label_columns=['behavior'])

GRU_single.train
GRU_single.plot()

# Define single step RNN Model
GRU_1 = tf.keras.models.Sequential([
    tf.keras.layers.GRU(units=64, activation='relu', return_sequences=True,
                        name='GRU_1'),
    tf.keras.layers.Dropout(0.1),
    tf.keras.layers.GRU(units=32, activation='relu', name='GRU_2'),
    tf.keras.layers.Dense(units=64, activation='relu', name='Dense_1'),
    tf.keras.layers.Dense(1, name='Output')
])

# input shape checking
print('Input shape:', GRU_single.example[0].shape)
print('Output shape:', GRU_1(GRU_single.example[0]).shape)

# compile and fit
tf.keras.backend.clear_session() # clear catch
epochs = 20
batch_size = 11
lr = 0.0001
history_1 = compile_fit(GRU_1, GRU_single,EPOCHS=epochs,
                        BATCH_SIZE=batch_size,LR=lr, early_stop=False)

# print the loss for each epoch
print(history_1.history['loss'])

# Plot the prediction
# "save=True" will save a png file to your working direction
plotlys(history_1, save=False,title='acc_loss_single') # accuracy vs val_accuracy plot


# Validation
val_performance = {}
performance = {}
val_performance['GRU_1'] = GRU_1.evaluate(GRU_single.val)
performance['GRU_1'] = GRU_1.evaluate(GRU_single.test, verbose=0)
# GRU_1.summary()


# Plot the network (must install pydot and graphviz)
tf.keras.utils.plot_model(
    GRU_1, dpi=96, to_file='Single_RNN_Architecture.png',
    show_shapes=True, show_layer_names=True,
    expand_nested=False
)

'''
122/122 [==============================] - 0s 3ms/step - loss: 0.3154 - accuracy: 0.9529
'''