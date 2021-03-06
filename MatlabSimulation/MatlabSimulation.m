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
audioInput = 4* cos(wm*t);

carrierSignal = cos (2*pi*fc*t);

firstSignalProducer = cos(2*pi*(w/2)*t);
firstSignalProducerPhased = sin(2*pi*(w/2)*t);

firstMixerOutput = audioInput .* firstSignalProducer; 
secondMixerOutput = audioInput .* firstSignalProducerPhased;  

secondSignalProducer = cos(2*pi*((w/2)+fc)*t);
secondSignalProducerPhased = sin(2*pi*((w/2)+fc)*t);

wn= 2*fm/fs;
numeratorofFilter = fir1(1000,wn);
freqz(numeratorofFilter);

lowPassFilterFirstOutput = filter(numeratorofFilter,1,firstMixerOutput);
lowPassFilterSecondOutput = filter(numeratorofFilter,1,secondMixerOutput);

thirdMixerOutput = lowPassFilterFirstOutput .* secondSignalProducer;
fourthMixerOutput = lowPassFilterSecondOutput .* secondSignalProducerPhased;

USB= thirdMixerOutput+fourthMixerOutput;
LSB= thirdMixerOutput-fourthMixerOutput;

%DEMODULATION PART
deFirstMixerOutput = USB .* secondSignalProducer;
deSecondMixerOutput = USB .* secondSignalProducerPhased;

deFirstFilterOutput = filter(numeratorofFilter,1,deFirstMixerOutput);
deSecondFilterOutput = filter(numeratorofFilter,1,deSecondMixerOutput);

deThirdMixerOutput = deFirstFilterOutput .* firstSignalProducer;
deFourthMixerOutput = deSecondFilterOutput .* firstSignalProducer;

deUSB = deThirdMixerOutput+deFourthMixerOutput;
lengthofDeUSB = length(deUSB);
%DEMODULATION PART


lengthofAudioInput = length(audioInput);
lengthofFirstMixerOutput = length(firstMixerOutput);
lengthofSecondMixerOutput = length(secondMixerOutput);
lengthofUSB = length(USB);
lengthofLSB = length(LSB);

lengthofThirdMixerOutput = length(thirdMixerOutput);

NFFTofDeUSB = 2^nextpow2(lengthofDeUSB); 
fftofDeUSB = fft(deUSB,NFFTofDeUSB)/lengthofDeUSB;
fofDeUSB = fs/2*linspace(0,1,NFFTofDeUSB/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(fofDeUSB,2*abs(fftofDeUSB(1:(NFFTofDeUSB/2)+1))) 
title('Single-Sided Amplitude Spectrum of Demodulated of USB')

NFFTofThirdMixerOutput = 2^nextpow2(lengthofThirdMixerOutput); 
fftofThirdMixerOutput = fft(thirdMixerOutput,NFFTofThirdMixerOutput)/lengthofThirdMixerOutput;
fofThirdMixerOutput = fs/2*linspace(0,1,NFFTofThirdMixerOutput/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(fofThirdMixerOutput,2*abs(fftofThirdMixerOutput(1:(NFFTofThirdMixerOutput/2)+1))) 
title('Single-Sided Amplitude Spectrum of Third Mixer Output')

lengthofFourthMixerOutput = length(fourthMixerOutput);

NFFTofFourthMixerOutput = 2^nextpow2(lengthofFourthMixerOutput); 
fftofFourthMixerOutput = fft(fourthMixerOutput,NFFTofFourthMixerOutput)/lengthofFourthMixerOutput;
fofFourthMixerOutput = fs/2*linspace(0,1,NFFTofFourthMixerOutput/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(fofFourthMixerOutput,2*abs(fftofFourthMixerOutput(1:(NFFTofFourthMixerOutput/2)+1))) 
title('Single-Sided Amplitude Spectrum of Fourth Mixer Output')





NFFTofAudioInput = 2^nextpow2(lengthofAudioInput); 
fftofAudioInput = fft(audioInput,NFFTofAudioInput)/lengthofAudioInput;
fofAudioInput = fs/2*linspace(0,1,NFFTofAudioInput/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(fofAudioInput,2*abs(fftofAudioInput(1:(NFFTofAudioInput/2)+1))) 
title('Single-Sided Amplitude Spectrum of Audio Input')

NFFTofFirstMixerOutput = 2^nextpow2(lengthofFirstMixerOutput); 
fftofFirstMixerOutput = fft(firstMixerOutput,NFFTofFirstMixerOutput)/lengthofFirstMixerOutput;
fofFirstMixerOutput = fs/2*linspace(0,1,NFFTofFirstMixerOutput/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(fofFirstMixerOutput,2*abs(fftofFirstMixerOutput(1:(NFFTofFirstMixerOutput/2)+1))) 
title('Single-Sided Amplitude Spectrum of First Mixer Output')


NFFTofSecondMixerOutput = 2^nextpow2(lengthofSecondMixerOutput); 
fftofSecondMixerOutput = fft(secondMixerOutput,NFFTofSecondMixerOutput)/lengthofSecondMixerOutput;
fofSecondMixerOutput = fs/2*linspace(0,1,NFFTofSecondMixerOutput/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(fofSecondMixerOutput,2*abs(fftofSecondMixerOutput(1:(NFFTofSecondMixerOutput/2)+1))) 
title('Single-Sided Amplitude Spectrum of First Mixer Output')

NFFTofUSB = 2^nextpow2(lengthofUSB); 
fftofUSB = fft(USB,NFFTofUSB)/lengthofUSB;
fofUSB = fs/2*linspace(0,1,NFFTofUSB/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(fofUSB,2*abs(fftofUSB(1:(NFFTofUSB/2)+1))) 
title('Single-Sided Amplitude Spectrum of USB')

NFFTofLSB = 2^nextpow2(lengthofLSB); 
fftofLSB = fft(LSB,NFFTofLSB)/lengthofLSB;
fofLSB = fs/2*linspace(0,1,NFFTofLSB/2+1);
% Plot single-sided amplitude spectrum.
figure
plot(fofLSB,2*abs(fftofLSB(1:(NFFTofLSB/2)+1))) 
title('Single-Sided Amplitude Spectrum of LSB')



