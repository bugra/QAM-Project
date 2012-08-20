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



%%FPGA TO MATLAB
%You may specify your own folder for output text file
%[sine_hdl]=textread('C:\Documents and Settings\deniz\Desktop\FPGA\prj\textio_tutorial\out.txt','%d');
%figure(1);plot(1:length(sine_hdl),sine_hdl)