% MATLAB Script for generating a Binary ASK sequence with two Amplitude Levels
% The generated sequence can be used for transmission with the
% communications system

format long;

% Clear all variables and close all figures
clear;
close all;

% The number of bits to send - Frame Length
N = 10;

% Generate a random bit stream with preamble of 1011
bit_stream = [1 0 1 1];
bit_stream = [bit_stream round(rand(1,N))];


% Enter the two Amplitudes
% Amplitude for 0 bit
A1 = 0; 

% Amplitude for 1 bit
A2 = 0.85;

% Frequency of Modulating Signal
f = 2000;

% Sampling rate - This will define the resoultion
fs = 40960;
%half = fs/10;

% Time for one bit
%t = 0: 1/half : 1;
bit_period = 0.01;
t = 0: 1/fs : bit_period;

% This time variable is just for plot
time = [];

ASK_signal = [];
Digital_signal = [];

for ii = 1: 1: length(bit_stream)
    
    % The FSK Signal
    ASK_signal = [ASK_signal (bit_stream(ii)==0)*A1*sin(2*pi*f*t)+...
        (bit_stream(ii)==1)*A2*sin(2*pi*f*t)];
    
    % The Original Digital Signal
    Digital_signal = [Digital_signal (bit_stream(ii)==0)*...
        zeros(1,length(t)) + (bit_stream(ii)==1)*ones(1,length(t))];
    
    time = [time t];
    t =  t + bit_period;
   
end
