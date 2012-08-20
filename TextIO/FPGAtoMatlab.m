clc 
clear all
close all

Fs=800e3;
[dout]=textread('C:\Project\Projectnew\cosine32KHzddsout.txt','%d');
lengthofDout=length(dout);
NFFTofDout = 2^nextpow2(lengthofDout); % Next power of 2 from length of y
YofDout = fft(dout,NFFTofDout)/lengthofDout;
fofDout = Fs/2*linspace(0,1,NFFTofDout/2+1);
% plot(t,dout)
figure
plot(fofDout,2*abs(YofDout(1:NFFTofDout/2+1))) 
title('Single-Sided Amplitude Spectrum of Dout')
xlabel('Frequency (Hz)')
ylabel('Dout')
figure
plot(dout)