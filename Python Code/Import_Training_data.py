import pandas as pd
from sklearn.model_selection import train_test_split

Data = pd.read_excel('Training Data/1 bit 10000 samples butterworth noisy BP filtered second bit 40960fs 0.01bp random low dB two amp/ASK_signal_filtered.xlsx')
Target = pd.read_excel('Training Data/1 bit 10000 samples butterworth noisy BP filtered second bit 40960fs 0.01bp random low dB two amp/bit_labels.xlsx')

data = np.array(Data, dtype=float)
target = np.array(Target, dtype=float)

X_train, X_test, y_train, y_test = train_test_split(data, target, test_size = 0.2, random_state = 4)

X_train = X_train.reshape(len(X_train), len(X_train[0]), 1)
X_test = X_test.reshape(len(X_test), len(X_test[0]), 1)
