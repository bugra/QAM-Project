clear all
close all
clc

fs = 625e3;
Ts = 1/fs;
numberofSamples=210;
fc = 3e3;
wc = 2*pi*fc;
fm = 30e3;
w = 2*pi*fm;
wm = 2*pi*fm;
t = Ts:Ts:(numberofSamples*Ts);
% t=0 : pi/10 : 2*pi ;  
% t=0 : pi/50 : 2*pi ; 
output=int16(sin(wm*t)*2^11)   %8 for 12 bit output.
length(output)
% output=int32(sin(t)*10000/512)   %512 for 6 bit output
plot(output)