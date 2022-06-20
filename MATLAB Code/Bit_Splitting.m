%MATLAB Script to separate the received signal into the signals of each
%individual bit, the separted signals will be used as input for the machine
%learning based demodulation

% Clear all variables and close all figures
clear;
close all;

%Uncomment and use audioread function to import a .wav file to MATLAB 
%[y, Fs] = audioread('Location\Filename');
data = y;

%Define the period of one bit
bit_period = 0.01;
%Number of data samples per bit
points_per_bit = round(Fs*bit_period);
%Initialize empty matrix to store separated signals 
bits = [];
%Number of bits in the received signal
number_of_bits = 9998;

%Split the received signal into each individual bit signal and store into
%bit matrix
for i = 1:number_of_bits
    if i == 1
        bits = [bits; data(1:points_per_bit)];
    else
        if i*points_per_bit < length(data)
            bits = [bits ;data((i-1)*points_per_bit:i*points_per_bit-1)];
        end
        
    end
end
