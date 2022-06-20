import numpy as np
import tensorflow as tf
from tensorflow import keras
from keras.models import Sequential
from keras.layers import BatchNormalization
from keras.layers import Conv1D
from keras.layers import MaxPooling1D
from keras.layers import LSTM
from keras.layers import Dense
from keras.layers import Dropout
from keras.callbacks import EarlyStopping

#Import training data
Data = pd.read_excel('Training Data/ASK_signal_filtered.xlsx')
Target = pd.read_excel('Training Data/bit_labels.xlsx')

#Convert to numpy array
data = np.array(Data, dtype=float)
target = np.array(Target, dtype=float)

#Split training data into train and test data
X_train, X_test, y_train, y_test = train_test_split(data, target, test_size = 0.2, random_state = 4)

#Reshape data to fit input of neural network
X_train = X_train.reshape(len(X_train), len(X_train[0]), 1)
X_test = X_test.reshape(len(X_test), len(X_test[0]), 1)

#Define neural network structure
model_conv1d = Sequential()
model_conv1d.add(BatchNormalization())
model_conv1d.add(Conv1D(filters=64, kernel_size=10, padding='same', activation='relu'))
model_conv1d.add(MaxPooling1D(pool_size=10))
model_conv1d.add(LSTM(200, dropout=0.3, recurrent_dropout=0.3))
model_conv1d.add(Dense(200, activation='sigmoid'))
model_conv1d.add(Dropout(0.3))
model_conv1d.add(Dense(1, activation='sigmoid'))
model_conv1d.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

#Define early stopping to stop training when not learning
es = EarlyStopping(monitor='val_loss', mode='min', verbose=1)
#Run network
model_conv1d.fit(X_train, y_train, validation_data=(X_test, y_test), epochs=10, batch_size=50, callbacks=[es])
#Print summary of network
print(model_conv1d.summary())

# Final evaluation of the model
scores = model_conv1d.evaluate(X_test, y_test, verbose=0)
print("Accuracy: %.2f%%" % (scores[1]*100))
