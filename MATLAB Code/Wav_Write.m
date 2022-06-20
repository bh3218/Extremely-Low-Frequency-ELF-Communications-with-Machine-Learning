% MATLAB Script for writing an array to an audio .wav file of specificed
% sampling frequency.

% Clear all variables and close all figures
clear;
close all;

filename = 'Filename.wav';
y = magnified;
Fs = 40960;

audiowrite(filename,y,Fs)
