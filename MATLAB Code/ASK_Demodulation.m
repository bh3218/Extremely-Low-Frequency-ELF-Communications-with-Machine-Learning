% MATLAB Script of binary non-coherent ASK demodulation code

% Clear all variables and close all figures
clear;
close all;

%Uncomment to import received signal using audioread function
%[data,Fs] = audioread('Location/Filename');

%Rectify the received signal
rectify = data;
for i = 1:length(rectify)
        rectify(i) = abs(rectify(i));
end

%Set the value of the carrier signal
carrier = 2000;
%Set the sampling frequency of the filter to be same as sampling frequency of audio 
fs = Fs;
%Set corner frequency to be carrier frequency
fc = carrier;    
%Calculate lowpass filter taps
[b,a] = butter(10,fc/(fs/2));
%Apply lowpass filter onto the rectified received signal
filtered = filter(b,a,rectify);

%Number of bits in the received signal
bits = 9961;
%Find max value of receievd signal
amplitude = max(filtered);
%Period of one bit
bit_period = 0.01;
%Data samples of one bit rounded 
points = round(fs*bit_period);
%Initialize empty matrix
demodulated = [];

%For each bit integrate the signal and compare to threshold to determine
%value of bit and save to matrix
for i = 1:bits
    if i == 1
        bit = filtered(1:points);
    else
        bit = filtered((i-1)*points:i*points);
    end
    z=trapz(bit);
    if z > points*amplitude/3
        demodulated = [demodulated 1];
    else
        demodulated = [demodulated 0];
    end
end

%Uncomment to use readmatrix function to import transmitter bit sequence to
%MATLAB
%bit_sequence = readmatrix('Location/Filename');

%Initialize counter
incorrect = 0;
%Compare the demodulated bit sequence to transmitted bit sequence and count
%number of incorrectly demodulated bits
for i = 1:length(bit_sequence)
    if bit_sequence(i) ~= demodulated(i)
        incorrect = incorrect + 1;
    end
end










