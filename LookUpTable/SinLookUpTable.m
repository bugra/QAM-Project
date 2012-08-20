clear all
close all
clc

fs = 800e3;
Ts = 1/fs;
numberofSamples=25;
fm = 32e3;
w = 2*pi*fm;
wm = 2*pi*fm;
t = Ts:Ts:(numberofSamples*Ts);
output=int16(sin(wm*t)*2^11)   
length(output)
plot(output)
fid = fopen('32KHzSineLookUpTable.txt', 'w');
fprintf(fid, '%4.0f ,', output);
fclose(fid)