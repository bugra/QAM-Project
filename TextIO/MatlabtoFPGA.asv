%%MATLAB TO FPGA
f=1;
fs=1/100;
t=0:fs:1;
in=2048*sin(2*pi*f*t);
in=floor(in);
[y,i]=max(in); in(i)=2047;
plot(t,in);
% You may specify your own folder for input text file
file_1 = fopen('inputSignal3KHz.txt','w'); 
fprintf(file_1,'%d\n',in);
fclose(file_1);
