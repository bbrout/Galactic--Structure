function findCentre(input_image)
%
%  function to find centre of galaxy from jpeg file
%   and it's major axis, minor axis, in pixels and angle of incline
%
% Step 1: Load the image
image = imread(input_image);

% Step 2: Convert to grayscale if needed
if size(image, 3) == 3
    image = rgb2gray(image);
end

% Step 3: get row values
[rows, cols] = size(image);
row_values = (1:rows)';

% Step 4: Calculate weighted average for each column
weighted_avg = zeros(1, cols); % Preallocate the result vector

for col = 1:cols
    column_data = double(image(:, col)); % Get the column data and convert to double for precision
    column_data_sum=sum(column_data);
    weighted_sum = sum(column_data .* row_values); % Weighted sum of the column
    thingy = weighted_sum/column_data_sum;
    weighted_avg(col) = weighted_sum / column_data_sum; % Weighted average
end

% Step 5 number crunch a linear fit
% Assume weighted_avg is already calculated and stored in a column vector Y
Y = weighted_avg' % Ensure Y is a column vector

% Create the design matrix X
X = [ones(cols, 1), (1:cols)'];

% Perform the least squares fit
% Using the formula beta = (X' * X)^(-1) * X' * Y
XT=X';
XTX=XT * X;
XTXINV = inv(XTX);
XTXINVXT=XTXINV*XT;
A=XTXINVXT*Y;
Y_test=X*A;

% display it
Yplot=Y_test';
Xplot=[1:cols];
% Step 1: Read the JPEG image

imshow(image);
hold on; % Retain the current plot so that new plots are added to it

% Plot the line
plot(Xplot,Yplot, 'r-', 'LineWidth', 2); % 'r-' specifies a red solid line, 'LineWidth' specifies the line width
plot(Xplot,weighted_avg,'b-','LineWidth', 2);
% Step 4: Optionally, add labels or title
title('Image with Line Overlay');
xlabel('X-axis');
ylabel('Y-axis');

hold off; % Release the plot hold


endfunction
