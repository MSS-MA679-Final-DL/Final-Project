#  Copyright (c) 2022. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#  Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
#  Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
#  Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
#  Vestibulum commodo. Ut rhoncus gravida arcu.

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on   Apr 13 23:10:13 2022
# @Author:   Zening Ye
# @Email:    zening.ye@gmail.com
# @Project:  Neural Network
# @File:     C_F.py
# @Software: PyCharm
"""
import tensorflow as tf

def compile_fit(model, window, EPOCHS, BATCH_SIZE, LR, early_stop):
    early_stopping = tf.keras.callbacks.EarlyStopping(monitor='val_loss',
                                                      patience=3,
                                                      mode='min')

    model.compile(loss=tf.keras.losses.BinaryCrossentropy(),
                  optimizer=tf.keras.optimizers.RMSprop(learning_rate=LR),
                  # optimizer=tf.keras.optimizers.Adagrad(),
                  # optimizer=tf.keras.optimizers.Adadelta(),
                  # optimizer=tf.keras.optimizers.Adam(),
                  metrics=['accuracy'])
    if early_stop:
        history = model.fit(window.train, epochs=EPOCHS, batch_size=BATCH_SIZE,
                            validation_data=window.val, shuffle=False, callbacks=[early_stopping])
    else:
        history = model.fit(window.train, epochs=EPOCHS, batch_size=BATCH_SIZE,
                            validation_data=window.val, shuffle=False)

    return history