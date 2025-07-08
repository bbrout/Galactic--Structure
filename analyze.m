function [theta]=analyze(imagefile)
  % function to get vital points from picture of galaxy
  % using weighted average of pixels throughout
picture=imread(imagefile);
figure(1);
clf;
imshow(picture);

 rowmax=size(picture)(1);
 colmax=size(picture)(2);

 pic2=max_intense(picture);

 pic3=cleanit(pic2,10);

 a=changepic(pic3);
 
figure(2);
 imshow(pic2);
 figure(3);
 imshow(pic3);
 

% now to invert and find m and b for y=mx+b
%find beginnig and ending of the galaxy

%sum the columns
coltest=sum(a);
for ii = 1:length(coltest)
    if coltest(ii)~=0
        col_begin = ii;
        break
    end
end
for ii = col_begin:length(coltest)
    if coltest(ii)==0
        col_end = ii-1;
        break
    end
end

% Step 3: get row values
[rows, cols] = size(a);
row_values = (1:rows)';

num_cols=col_end-col_begin+1;

% Step 4: Calculate weighted average for each column
weighted_avg = zeros(1, col_end-col_begin+1); % Preallocate the result vector

for col = col_begin:col_end
    column_data = double(a(:, col)); % Get the column data and convert to double for precision
    column_data_sum=sum(column_data);
    weighted_sum = sum(column_data .* row_values); % Weighted sum of the column
    weighted_avg_test(col) = weighted_sum / column_data_sum; % Weighted average
end

for ii = col_begin:col_end
  weighted_avg(ii-col_begin+1)=weighted_avg_test(ii);
end

% Step 5 number crunch a linear fit
% Assume weighted_avg is already calculated and stored in a column vector Y
Y = weighted_avg'; % Ensure Y is a column vector

% Create the design matrix X
X = [ones(num_cols, 1), (1:num_cols)'];
% Perform the least squares fit
% Using the formula beta = (X' * X)^(-1) * X' * Y
XT=X';
XTX=XT * X;
XTXINV = inv(XTX);
XTXINVXT=XTXINV*XT;
A=XTXINVXT*Y;
Y_test=X*A;

Y_test(1,1)
X(1,2)
col_begin
row_begin=Y_test(1,1)
col_end=col_begin+length(X)(1,1)
row_end=Y_test(length(Y_test),1)

%we adjust the y-intercept to match the image
m=A(2,1); % slope
b=A(1,1)-m*col_begin;  % y-intercept at column 0 rather than at column col_begin

A(1,1)=b;

X2=[ones(cols,1), (1:cols)'];
Y2_test=X2*A;

% display it
Yplot=Y_test';
Xplot=[col_begin:col_end];
Y2plot=Y2_test';
X2plot=[1:cols];
hold on; % Retain the current plot so that new plots are added to it

% Plot the line
plot(X2plot,Y2plot,'g-','LineWidth',2);
plot(Xplot,weighted_avg,'b-','LineWidth', 2);
plot(Xplot,Yplot, 'r-', 'LineWidth', 2); % 'r-' specifies a red solid line, 'LineWidth' specifies the line width
% Step 4: Optionally, add labels or title
title('Image with Line Overlay');
xlabel('X-axis');
ylabel('Y-axis');
hold off; % Release the plot hold

% now to re-adjust the axis for the original image
 a=changepic(picture);
%find middle of galaxy

col_mid=round((col_begin+col_end)/2.);
row_mid=round(m*col_mid+b);

%find the minimum intensity
cut_off=a(col_mid,row_mid)/45.;

%row_begin=b+m*col_begin;
%row_end=b+m*col_end;

%now for the major axis
%start at middle and work outwardly

figure(1);
hold on;
pause on;
for ii=col_mid:colmax
  jj=round(b+m*ii);
   if a(ii,jj)<cut_off
    break
  endif
endfor

col_end=ii;
row_end=jj;
col_begin=2.*col_mid-col_end;
row_begin=2.*row_mid-row_end;

%now for the minor axis
m=-1/m; %change the slope tyo perpendicular
b=row_mid-m*col_mid; % change y-intercept
%start at middle and work outwardly
for ii=col_mid:colmax
  jj=round(b+m*ii);
  if jj>rowmax
    break
  endif
  if a(jj,ii)<cut_off
    break
  endif
endfor
hold off;

galbend_col=ii;
galbbegin_col=2*col_mid-ii;
galbend_row=jj;
galbbegin_row=2*row_mid-jj;

%let's plot this

xplot=[col_begin,col_end];
yplot=[row_begin,row_end];;

figure(1);
%hold on
%plot(xplot,yplot, 'g-', 'LineWidth', 2);
%xplot=[galbbegin_col,galbend_col];
%yplot=[galbbegin_row,galbend_row];;
%plot(xplot,yplot, 'g-', 'LineWidth', 2);
%hold off

% radius of major axis
dist=sqrt((col_end-col_mid+1)^2+(row_end-row_mid+1)^2);
% use 5 rings
num_rings=5;

theta=[row_mid,col_mid];
ringWidth=round(dist/num_rings);
y = binIntensityConcentricRings('ESO 289-g10.jpeg', col_mid, row_mid, ringWidth,dist);

y=y(1:num_rings,1);
x=[1:num_rings];
figure(4);
bar(y);
title('Luminosity vs Radial Distance');
xlabel('Radial Distance (each ring)');
ylabel('Total Luminosity (pixel values)');
filename=[imagefile ".eps"]
saveas(4, filename);
return;