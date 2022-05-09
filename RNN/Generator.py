#  Copyright (c) 2022. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#  Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
#  Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
#  Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
#  Vestibulum commodo. Ut rhoncus gravida arcu.

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on   Apr 13 16:39:16 2022
# @Author:   Zening Ye
# @Email:    zening.ye@gmail.com
# @Project:  Neural Network
# @File:     Generator.py
# @Software: PyCharm
"""
import numpy as np
import random
import matplotlib.pyplot as plt
import tensorflow as tf

class data_load():

  def __init__(self, input_width, label_width, step,
               train_df, val_df, test_df,
               label_columns=None):

    # Store the raw data.
    self.train_df = train_df
    self.val_df = val_df
    self.test_df = test_df

    # Work out the label column indices.
    self.label_columns = label_columns
    if label_columns is not None:
      self.label_columns_indices = {name: i for i, name in
                                    enumerate(label_columns)}
    self.column_indices = {name: i for i, name in
                           enumerate(train_df.columns)}

    # Work out the window parameters.
    self.input_width = input_width
    self.label_width = label_width
    self.step = step

    self.total_window_size = input_width + step

    self.input_slice = slice(0, input_width)
    self.input_indices = np.arange(self.total_window_size)[self.input_slice]

    self.label_start = self.total_window_size - self.label_width
    self.labels_slice = slice(self.label_start, None)
    self.label_indices = np.arange(self.total_window_size)[self.labels_slice]

  def __repr__(self):
    return '\n'.join([
        f'Total window size: {self.total_window_size}',
        f'Input indices: {self.input_indices}',
        f'Label indices: {self.label_indices}',
        f'Label column name(s): {self.label_columns}'])

  # Split the windows
  def split_window(self, num_cell):
      inputs = num_cell[:, self.input_slice, :]
      labels = num_cell[:, self.labels_slice, :]
      if self.label_columns is not None:
          labels = tf.stack(
              [labels[:, :, self.column_indices[name]] for name in self.label_columns],
              axis=-1)

      inputs.set_shape([None, self.input_width, None])
      labels.set_shape([None, self.label_width, None])

      return inputs, labels

  # Create tensorflow dataset
  def make_dataset(self, data):
      data = np.array(data)
      ds = tf.keras.utils.timeseries_dataset_from_array(
          data=data,
          targets=None,
          sequence_length=self.total_window_size,
          sequence_stride=1,
          # shuffle=True,`
          batch_size=10,)
      ds = ds.shuffle(1000, reshuffle_each_iteration=True)
      ds = ds.map(self.split_window)
      return ds

  # Return data for fitting
  @property
  def train(self):
      return self.make_dataset(self.train_df)

  @property
  def val(self):
      return self.make_dataset(self.val_df)

  @property
  def test(self):
      return self.make_dataset(self.test_df)

  @property
  def example(self):
      """Get and cache an example batch of `inputs, labels` for plotting."""
      result = getattr(self, '_example', None)
      if result is None:
          # No example batch was found, so get one from the `.train` dataset
          result = next(iter(self.train))
          # And cache it for next time
          self._example = result
      return result

  # Plot
  # show the first three variable value in your time setting
  def plot(self, model=None, plot_col='behavior', max_subplots=3):
      inputs, labels = self.example
      plt.figure(figsize=(12, 8))
      plot_col_index = self.column_indices[plot_col]
      max_n = min(max_subplots, len(inputs))
      for n in range(max_n):
          plt.subplot(max_n, 1, n + 1)
          plt.ylabel(f'{plot_col} [normed]')
          plt.plot(self.input_indices, inputs[n, :, plot_col_index],
                   label='Inputs', marker='.', zorder=-10)

          if self.label_columns:
              label_col_index = self.label_columns_indices.get(plot_col, None)
          else:
              label_col_index = plot_col_index

          if label_col_index is None:
              continue

          plt.scatter(self.label_indices, labels[n, :, label_col_index],
                      edgecolors='k', label='Labels', c='#2ca02c', s=64)
          # change prediction into 0-1
          if model is not None:
              predictions = model(inputs)
              plt.scatter(self.label_indices, predictions[n, :, label_col_index],
                          marker='X', edgecolors='k', label='Predictions',
                          c='#ff7f0e', s=64)

          if n == 0:
              plt.legend()
      plt.xlabel('Time [s]')
      plt.show()

# data_load.make_dataset = make_dataset
# data_load.split_window = split_window
# data_load.train = train
# data_load.val = val
# data_load.test = test
# data_load.example = example
# data_load.plot = plot