% MATLAB Script for generating training data for the machine learning based
% demodulation. Two bit sequences are generated and a bandpass filter is
% applied onto it to simulate the transient effect. The second bit signal
% is then extracted as a single training sample. This is repeated with 
% varying parameters and noise to create many samples.

format long;

% Clear all variables and close all figures
clear;
close all;

% The number of bits to send - Frame Length
N = 2;

% Sampling rate - This will define the resoultion
fs = 40960;

% Time for one bit
bit_period = 0.01;
t = 0: 1/fs : bit_period;

% Upper and lower bound of max amplitude of generated signals of 1 bit
lower = 0.3;
upper = 0.7;

% Number of training samples to be generated
samples = 1;

% Initialize arrays for training samples
training_data = zeros(length(t)*N/2, samples);
bit_data = zeros(N/2, samples);

for iii = 1:samples
    time = [];
    ASK_signal = [];
    
    %Generate random bit sequences
    bit_stream = round(rand(1,N));
    
    % Enter the two Amplitudes
    A2 = (upper-lower)*rand(1,1) + lower;
    % Amplitude for 0 bit
    %12th of 1 bit max amplitude proves to give the best training results
    A1 = A2/12; 

    % Frequency of Modulating Signal
    f = randi([1000 3000], 1);

    for ii = 1: 1: length(bit_stream)
    
        % The ASK Signal
        ASK_signal = [ASK_signal (bit_stream(ii)==0)*A1*sin(2*pi*f*t)+...
            (bit_stream(ii)==1)*A2*sin(2*pi*f*t)];
    
        time = [time t];
        t =  t + bit_period;
   
    end

    % Signal to noise ratio
    Es_N0_dB = randi([5 40]);

    %AWGN
    ASK_signal = awgn(ASK_signal, Es_N0_dB);

    %Corner frequencies of the band pass filter
    fc = [1800 2200];

    %Calculate bandpass filter taps
    [b,a] = butter(1,fc/(fs/2));

    %Apply bandpass filter onto current generated sample
    ASK_signal_filtered = filter(b,a,ASK_signal);

    %Store second bit of current generated training sample along with 
    % other training samples in matrix
    training_data(:, iii) = ASK_signal_filtered(1,length(ASK_signal_filtered)/2 + 1:length(ASK_signal_filtered));
    bit_data(:, iii) = bit_stream(1, length(bit_stream)/2 + 1:length(bit_stream));
    
end


