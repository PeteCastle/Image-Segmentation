[file, path] = uigetfile({'*.jpg;*.png;*.bmp'}, 'Select an image file');
if isequal(file, 0)
    fprintf('No image file selected. Exiting...\n');
    return;
end

image_path = fullfile(path, file);
% Read the image
image = imread(image_path);

% Convert the image to grayscale
gray_image = rgb2gray(image);

% Enhance contrast (optional)
% gray_image = imadjust(gray_image);

% Apply adaptive thresholding
bw_image = imbinarize(gray_image, 'adaptive', 'Sensitivity', 0.5);

% Fill gaps in the binary image
bw_image = imfill(bw_image, 'holes');

% Perform Hough Line Transform to detect lines
[H, T, R] = hough(bw_image);
P = houghpeaks(H, 100, 'threshold', ceil(0.3 * max(H(:))));
lines = houghlines(bw_image, T, R, P, 'FillGap', 20, 'MinLength', 100); % Adjust FillGap and MinLength here

% Draw the detected lines on a copy of the original image
line_image = image;
if ~isempty(lines)
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        line_image = insertShape(line_image, 'Line', xy, 'LineWidth', 2, 'Color', 'green');
    end
end

% Combine the original and line-detected images horizontally
combined_image = [image, line_image];

% Display the result
figure;
imshow(combined_image);
title('Before and After Line Detection Segmentation');
