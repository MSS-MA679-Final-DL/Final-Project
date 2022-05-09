#  Copyright (c) 2022. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#  Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
#  Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
#  Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
#  Vestibulum commodo. Ut rhoncus gravida arcu.

# !/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on   Apr 22 16:18:43 2022
# @Author:   Zening Ye
# @Email:    zening.ye@gmail.com
# @Project:  Neural Network
# @File:     model_plot.py
# @Software: PyCharm
"""
import matplotlib.pyplot as plt

def plotlys(df_history, save, title):
    fig, (ax1, ax2) = plt.subplots(1,2,figsize=(10, 5))
    ax1.plot(df_history.history['accuracy'], label='accuracy')
    ax1.plot(df_history.history['val_accuracy'], label='validation accuracy')
    ax1.set_xlabel('Epoch')
    ax1.set_ylabel('Accuracy')
    ax1.set_title('Accuracy Over the Epochs')
    ax1.legend(loc='lower right')
    ax2.plot(df_history.history['loss'], label='loss')
    ax2.plot(df_history.history['val_loss'], label='val_loss')
    ax2.set_xlabel('Epoch')
    ax2.set_ylabel('Loss')
    ax2.set_title('Loss Over the Epochs')
    ax2.legend()
    if save == True:
        plt.savefig(title+'.png')
    else: pass
    plt.show()
