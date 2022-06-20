import numpy as np
import pandas as pd

#Import received signal and transmitted bit sequence
bits = pd.read_excel('Transmission Data/0.5m/Split bits_magnified_0.5m_5V_2000Hz_9965bits_40960fs_0.01bp.xlsx')
bit_sequence = pd.read_excel('Transmission Data/0.5m/5V/bit sequence_0.5m_2000Hz_9965bits_40960fs_0.01bp.xlsx')

#Convert to numpy arrays
bits = np.array(bits, dtype=float)
bit_sequence = np.array(bit_sequence, dtype=float)

#Reshape data for input to network
x_input = bits
x_input = x_input.reshape(len(x_input), len(x_input[0]), 1)
#Run data through network to demodulate bits
y = model_conv1d.predict(x_input, verbose=1)

#Decide if demodulated bit is 0 or 1 
bit_results = y
for i in range(len(bit_results)):
  if bit_results[i] > 0.5:
    bit_results[i] = 1
  else:
    bit_results[i] = 0

#Compare demodulated bits to transmitted bits     
correct = 0
positions = []
for i in range(len(bit_results)):
  if bit_results[i] == bit_sequence[i]:
    correct = correct + 1
  else:
    positions.append(i)

#Calculate BER
BER = (len(bit_results)-correct)/len(bit_results)
