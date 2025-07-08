function z = FFTonaxis(x1,y1,x2,y2)
%FITSPIRAL Summary of this function goes here
%   Detailed explanation goes here

imageFile="NGC  4244.gif";

%x1=302;
%y1=254;
%x2=572;
%y2=626;

Igalaxy = imread(imageFile);

I=Igalaxy;

name=imageFile;


figure(1);
image(I);

[token,remain]=strtok(name,'.');
token
remain(1)
remain(2:length(remain))

[last_row,last_col,zmax]=size(I);


begin_row=y1;
end_row=y2;
begin_col=x1;
end_col=x2;

axisLength= round(abs(begin_col-end_col));

rot_factor=sqrt((x2-x1)^2+(y2-y1)^2)/axisLength;

slope=(end_row-begin_row)/(end_col-begin_col);
intercept=begin_row-slope*begin_col;

xminline=begin_col;
xmaxline=end_col;

if (xmaxline<xminline)
  dummy=xminline
  xminline=xmaxline;
  xmaxline=dummy;
end

% load up the major axis of the galaxy

dx = 1;

x = xminline-1;

I2 = double(I);
I3 = double(I);

for (i = 1:axisLength)
	x=x+dx;
        y=slope*x+intercept;
        irow=round(y);
        icol=round(x);
        majorAxis(i)=I2(irow,icol,1);
	I3(irow,icol,1)=0;
end

figure(1);
colormap(gray);
image(I2);
figure(2);
image(I3);
colormap(gray);
image_out3=figure(3);

x_line=[1:length(majorAxis)].*rot_factor;
plot(x_line,majorAxis);

%axis([0 100 0 260]);
title('Pixel Value Across Major Axis');
ylabel('Pixel Value');
xlabel('Pixels');

%now find the troughs and peaks from left to right

[peak ipeak trough itrough]=extrema(majorAxis);


ipeak_sorted = sort(ipeak);
itrough_sorted = sort(itrough);


%find the first and last troughs

start_index=itrough_sorted(1);
last_index=itrough_sorted(length(itrough));

for (i=start_index:last_index)
  maj(i-start_index+1)=majorAxis(i);
end

[peak ipeak trough itrough]=extrema(maj);

ipeak_sorted = sort(ipeak);
itrough_sorted = sort(itrough);

npeak = length(ipeak_sorted);
ntrough = length(itrough_sorted);

first=itrough_sorted(1);
last =itrough_sorted(ntrough);

%  we go through and set all troughs to negative one and all the peaks to positive one
%  and make a sawtooth wave

for (i=1:ntrough-1)
  ibegin= itrough_sorted(i);
  iend  = ipeak_sorted(i);

  m = 2.0/(iend-ibegin);
  bb = -1.0;
  for (j=ibegin:iend)
      ReducedAxis(j)= m*(j-ibegin) + bb;
  end
end

for (i= 1:npeak)
  ibegin=ipeak_sorted(i);
  iend  =itrough_sorted(i+1);  

  m = -2.0/(iend-ibegin);
  bb = 1.0;
  for(j=ibegin:iend)
      ReducedAxis(j) = m*(j-ibegin) + bb;
  end
end

image_out4=figure(4);
x_line=[1:length(ReducedAxis)].*rot_factor;
plot(x_line,ReducedAxis);
title('Pixel Peaks and Troughs as a signal');
xlabel('Pixels');



DeltaS=1;
scale=1;
N=length(ReducedAxis);
T = N*DeltaS; 			%% define time of interval, 3.4 seconds
t = [0:N-1]/N; 			%% define time
t = t*T; 			%% define time in seconds
f = ReducedAxis; 		%%define function, 10 Hz sine wave
p = abs(fft(f))/(N/2); 		%% absolute value of the fft
p = p(1:N/2).^2; 		%% take the power of positve freq. half
freq = ([0:N/2-1]/T)./rot_factor; 		%% find the corresponding frequency in Hz

[Peak Peak_index Trough Trough_index]=extrema(p);
First_Peak_x = 1/freq(Peak_index(1));
First_Peak=p(Peak_index(1));

Second_Peak_x=1/freq(Peak_index(2));
Second_Peak=p(Peak_index(2));

image_out5=figure(5);
plot(1./freq,p);
title('FFT of Signal across Major Axis');
ylabel('Strength of Signal');
xlabel('Wavelength of Signal in Pixels');

stringtext=strcat('\leftarrow',num2str(First_Peak_x));
% Annotate the point 
text(First_Peak_x,First_Peak,'\leftarrow sin(-\pi\div4)',...
text(First_Peak_x,First_Peak,stringtext,...
         'HorizontalAlignment','left')
stringtext=strcat('\leftarrow',num2str(Second_Peak_x));
% Annotate the point 
text(First_Peak_x,First_Peak,'\leftarrow sin(-\pi\div4)',...
text(Second_Peak_x,Second_Peak,stringtext,...
          'HorizontalAlignment','left')
    
u=1./freq;
v=p;

errfft=(sum((f.-abs(ifft(abs(fft(f))))).^2)/length(f))*rot_factor
errfft_norm=errfft/length(f)

image_out_3=strcat(token,'_out_3');
image_out_4=strcat(token,'_out_4');
image_out_5=strcat(token,'_out_5_FFT');

filename_output=strcat(image_out_3,'.eps');
print(image_out3,filename_output,'-deps');

filename_output=strcat(image_out_4,'.eps');
print(image_out4,filename_output,'-deps');

filename_output=strcat(image_out_5,'.eps');
print(image_out5,filename_output,'-deps');

%  
  h=subplot(1,3,1);
  plot(ReducedAxis);
%  
  h=subplot(1,3,2);
  plot(majorAxis);
%  
  subplot(1,3,3);
  plot(1./freq,p); 		%% plot
%  
%  
  [C,maxindex]=max(p);
%  
%  
  lamda = 1./freq(maxindex);
%  
  lam=1./freq.*(1./296 *3*60);
%   
  disp(sprintf(' %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f',lam));
%  
  disp(sprintf('lamda = %0.2f',lamda));
%  
  lamda = lamda/296 *3*60
%  
  z = true;
end