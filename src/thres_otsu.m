[file, path] = uigetfile({'*.jpg;*.png;*.bmp'}, 'Select an image file');
if isequal(file, 0)
    fprintf('No image file selected. Exiting...\n');
    return;
end
image_path = fullfile(path, file);

% Path to input image is specified and image is loaded with imread command
image1 = imread(image_path);

% Converting the image to grayscale
img = rgb2gray(image1);

% Calculating Otsu threshold
otsu_threshold = graythresh(img);

fprintf('Otsu Threshold Value: %f\n', otsu_threshold);
% Applying Otsu thresholding
thresh1 = imbinarize(img, otsu_threshold);

% Plotting the histogram of the grayscale image
figure;
subplot(2, 2, 1);
imshow(image1);
title('Original Image');

subplot(2, 2, 2);
imshow(thresh1);
title('Otsu Threshold');

subplot(2, 2, 3);
imhist(image1);
title('Histogram of Original Image');
xlabel('Pixel Intensity');
ylabel('Frequency');

% Plotting the histogram of the binary image
binary_img = imbinarize(img, otsu_threshold);
subplot(2, 2, 4);
imhist(binary_img);
title('Histogram of Binary Image');
xlabel('Pixel Intensity');
ylabel('Frequency');

% Adjusting the subplot positions for better visualization
movegui(gcf, 'center');
