%MATLAB Script to apply a bandpass filter onto the received signal
%before the demodulation processes.

% Clear all variables and close all figures
clear;
close all;

%Uncomment and use audioread function to import a .wav file to MATLAB 
%[y, Fs] = audioread('Location\Filename');

%Extract the column of data of interest
data = y(:,1);

%%Set corner frequencies of the band pass filter
fc = [1800 2200];
%Set sampling rate of filter to sampling rate of audio
fs = Fs;

%Calculate the filter taps using the butterworth filter function
[b,a] = butter(1,fc/(fs/2));

%Apply band pass filter onto the imported data
data = filter(b,a,data);

%Magnify the data to range of -0.35 to 0.35 which is a good value range for
%both demodulation methods
magnified = (0.35/max(data)).*data;

