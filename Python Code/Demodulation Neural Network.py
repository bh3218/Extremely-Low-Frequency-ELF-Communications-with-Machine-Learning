import numpy as np
import pandas as pd
import tensorflow as tf
from tensorflow import keras
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM
from keras.layers import Dropout
from keras.layers import Conv1D
from keras.layers import MaxPooling1D
from keras.layers import AveragePooling1D
from keras.layers import BatchNormalization
from keras.callbacks import EarlyStopping
from sklearn.model_selection import train_test_split


model_conv1d = Sequential()
model_conv1d.add(BatchNormalization())
model_conv1d.add(Conv1D(filters=64, kernel_size=10, padding='same', activation='relu'))
model_conv1d.add(MaxPooling1D(pool_size=10))
model_conv1d.add(LSTM(200, dropout=0.3, recurrent_dropout=0.3))
model_conv1d.add(Dense(200, activation='sigmoid'))
model_conv1d.add(Dropout(0.3))
model_conv1d.add(Dense(1, activation='sigmoid'))
model_conv1d.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

es = EarlyStopping(monitor='val_loss', mode='min', verbose=1)
model_conv1d.fit(X_train, y_train, validation_data=(X_test, y_test), epochs=10, batch_size=50, callbacks=[es])
print(model_conv1d.summary())
