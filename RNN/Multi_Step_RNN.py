#  Copyright (c) 2022. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#  Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
#  Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
#  Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
#  Vestibulum commodo. Ut rhoncus gravida arcu.

# !/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on   Apr 30 23:18:43 2022
# @Author:   Zening Ye
# @Email:    zening.ye@gmail.com
# @Project:  Neural Network
# @File:     Multi_Step_RNN.py
# @Software: PyCharm
"""
import tensorflow as tf
from Generator import data_load
from Data import get_data
from Model_Plot import plotlys

# each row represent 0.1 second
# Load Data
df = get_data(0) # 608102_414

# Proportion of data
n = len(df)
train_df = df[0:int(n*0.7)]
val_df = df[int(n*0.7):int(n*0.9)]
test_df = df[int(n*0.9):]

# compile and fit
def cf_multi(model, window, EPOCHS, BATCH_SIZE, lr, early_stop):
    early_stopping = tf.keras.callbacks.EarlyStopping(monitor='val_loss',
                                                      patience=3,
                                                      mode='min')

    model.compile(loss=#tf.keras.losses.BinaryCrossentropy(),
                  tf.keras.losses.BinaryFocalCrossentropy(),
                  optimizer=tf.keras.optimizers.RMSprop(learning_rate=lr),
                  # optimizer=tf.keras.optimizers.Adagrad(learning_rate=lr),
                  # optimizer=tf.keras.optimizers.Adadelta(learning_rate=lr),
                  # optimizer=tf.keras.optimizers.Adam(learning_rate=lr),
                  metrics=['accuracy'])

    if early_stop:
        history = model.fit(window.train, epochs=EPOCHS, batch_size=BATCH_SIZE,
                            validation_data=window.val, shuffle=False, callbacks=early_stopping)
    else:
        history = model.fit(window.train, epochs=EPOCHS, batch_size=BATCH_SIZE,
                            validation_data=window.val, shuffle=False)

    return history


## multi-step prediction
PRED_STEPS = 20
num_features = df.shape[1]
GRU_multi = data_load(input_width=20, label_width=PRED_STEPS, train_df=train_df,val_df=val_df,
                     test_df=test_df, step=PRED_STEPS,label_columns=['behavior'])

# Plot the label for PRED_STEPS
GRU_multi.plot()
GRU_multi

# Define multistep RNN Model
GRU_2 = tf.keras.Sequential([
# Shape [batch, time, features] => [batch, lstm_units].
    # choose unit reasonable to prevent overfitting
    tf.keras.layers.GRU(64, activation='relu',return_sequences=False),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dropout(0.1),
    tf.keras.layers.Dense(PRED_STEPS*num_features,
                          kernel_initializer=tf.initializers.zeros(),activation='sigmoid'),
    tf.keras.layers.Reshape([PRED_STEPS, num_features])
])

# train the model
tf.keras.backend.clear_session()
e_multi = 30
bs_multi = 15
LR = 0.0005
history_2 = cf_multi(GRU_2, GRU_multi,EPOCHS=e_multi,BATCH_SIZE=bs_multi,lr=LR,early_stop=False)

# plot the loss and accuracy
plotlys(history_2, save=False,title='acc_loss_multiple')

multi_val_performance = {}
multi_performance = {}
multi_val_performance['Multi_RNN'] = GRU_2.evaluate(GRU_multi.val)
multi_performance['Multi_RNN'] = GRU_2.evaluate(GRU_multi.test, verbose=0)
# cannot improve accuracy at this moment