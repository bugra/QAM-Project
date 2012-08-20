clear all
close all
clc
fs = 1e5;
Ts = 1/fs;
numberofSamples=50000;
fc = 3e4;
fm = 5000;
w = fm;
wm = 2*pi*fm;
t = Ts:Ts:(numberofSamples*Ts);%50000 samples
orderofFilter=100;
% wn= 2*fm/fs;
% numeratorofFilter = fir1(100,wn);
% freqz(numeratorofFilter);
% set2int(numeratorofFilter)

b = firrcos(orderofFilter,fc,0,fs,'rolloff','sqrt');
hd = dfilt.dffir(b);
hd.Arithmetic = 'fixed';
hd.InputFracLength = 0; % Integer inputs.
x = ones(100,1);
yfrac = filter(hd,x); % Fractional mode output.
g = set2int(hd);      % Convert to integer coefficients.
yint = filter(hd,x)  % Integer mode output.
freqz(b)