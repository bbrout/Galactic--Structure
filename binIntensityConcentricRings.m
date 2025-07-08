function binnedData = binIntensityConcentricRings(input_image, col_mid, row_mid, ringWidth,dist)
  
    % Load the image
    image = imread(input_image);
    if size(image, 3) == 3
        image = rgb2gray(image);
    end
    
    % Get the image size
    [rows, cols] = size(image);
    
    % Create a meshgrid for coordinates
    [X, Y] = meshgrid(1:cols, 1:rows);
    
    % Compute distances from the midpoint
    distances = sqrt((X - col_mid).^2 + (Y - row_mid).^2);
    
    % Compute ring indices and exclude pixels outside image boundaries
    ringIndices = ceil(distances / ringWidth);
    ringIndices(distances > min(rows, cols) / 2) = 0;
    
    % Compute intensity values
    intensityValues = double(image(:));
    
    % Initialize the binned data vector
    binnedData = accumarray(ringIndices(:) + 1, intensityValues, [], @sum);  % Add 1 to indices
    
    % Remove the first element (partial ring) if present
    binnedData = binnedData(2:end);

    visualizeRings(input_image, col_mid, row_mid, ringWidth,dist);

    end
