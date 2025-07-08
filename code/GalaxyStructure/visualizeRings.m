function visualizeRings(input, col_mid, row_mid, ringWidth,dist)
  

    % Check if the input is a filename or image data
    if ischar(input)
        image = imread(input);
    else
        image = input;
    end
    
    % Convert to grayscale if the image is in color
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    
    % Display the image
    figure(1);
    %imshow(image);
    hold on;
    
    % Define the radius and plot the rings
 %   max_distance = ceil(sqrt(col_mid^2 + row_mid^2));
    num_rings = dist/ringWidth;
    
    for i = 1:num_rings
        viscircles([col_mid, row_mid], i * ringWidth,"Linewidth",1, 'EdgeColor', 'r');
    end
    hold off;
end

