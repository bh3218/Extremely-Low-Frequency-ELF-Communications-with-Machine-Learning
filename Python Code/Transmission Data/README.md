This folder contains the recordings of the received signals and the bit labels of the transmitted signals at each distance from 0.5m to 5m at 0.5m increments.

Each folder contains the original transmission signal and the corresponding bit labels, labelled 'Transmission data' and 'bit sequence' respectively. 
Within the folder contain a 5V and 10V folder which contain the data of the received signal at that distance and input voltage, as well as the extracted bit sequence signal. These are labelled 'Recording', 'bit_sequence', and 'bits_magnified' respectively.

Excel files containing the invidual bit signals of the received signals used as input to the neural network are too large and cannot be uploaded. 
Use MATLAB "Split_bits.m" file to split the bits magnified files into the separate bits for demodulation using the network.
