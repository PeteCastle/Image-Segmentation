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

% Applying adaptive thresholding techniques on the input image
sensitivity = 0.4; % Sensitivity value (Adjust this as needed)

thresh1 = adaptthresh(img, sensitivity, 'ForegroundPolarity', 'dark');
imshow(thresh1);
thresh1 = imbinarize(img, thresh1);

thresh2 = adaptthresh(img, sensitivity, 'ForegroundPolarity', 'dark', 'Statistic', 'gaussian');
thresh2 = imbinarize(img, thresh2);

% Calculate histograms of the original and thresholded images
original_hist = imhist(img);
thresholded_hist1 = imhist(thresh1);
thresholded_hist2 = imhist(thresh2);

% Plot the histograms
figure;

subplot(2, 2, 1);
imshow(img);
title('Original Grayscale Image');

subplot(2, 2, 2);
imhist(img);
title('Histogram of Original Image');

subplot(2, 2, 3);
imshow(thresh1);
title('Local Thresholding: Adaptive Mean');

subplot(2, 2, 4);
imhist(thresh1);
title('Histogram of Thresholded Image (Adaptive Mean)');

figure;

subplot(2, 2, 1);
imshow(img);
title('Original Grayscale Image');

subplot(2, 2, 2);
imhist(img);
title('Histogram of Original Image');
xlabel('Pixel Intensity');
ylabel('Frequency');


subplot(2, 2, 3);
imshow(thresh2);
title('Local Thresholding: Adaptive Gaussian');

subplot(2, 2, 4);
imhist(thresh2);
title('Histogram of Thresholded Image (Adaptive Gaussian)');
xlabel('Pixel Intensity');
ylabel('Frequency');



% Adjusting the subplot positions for better visualization
%movegui(gcf, 'center');



%histogram
% 'counts' will contain the number of pixels for each intensity level
% 'intensity_values' will contain the corresponding intensity values
