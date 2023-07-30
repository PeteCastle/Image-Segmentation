clc
clear
close all

% Reading input image for edge detection
A = imread('../raw/edgeflower.jpg');

% Convert the image to grayscale
A = rgb2gray(A);

% Edge detection using different methods
B1 = edge(A, 'roberts');
B2 = edge(A, 'sobel');
B3 = edge(A, 'prewitt');
B4 = edge(A, 'log');
B5 = edge(A, 'canny');

% Display of input and output images in a single figure with tabs
figure('Name', 'Edge Detection Results', 'NumberTitle', 'off');

% Original Image
subplot(2, 3, 1);
imshow(A), title('Original Image');

% Edge detection by Roberts Operator
subplot(2, 3, 2);
imshow(B1), title('Edge detection by Roberts Operator');

% Edge detection by Sobel Operator
subplot(2, 3, 3);
imshow(B2), title('Edge detection by Sobel Operator');

% Edge detection by Prewitt Operator
subplot(2, 3, 4);
imshow(B3), title('Edge detection by Prewitt Operator');

% Edge detection by Log Operator
subplot(2, 3, 5);
imshow(B4), title('Edge detection by Log Operator');

% Edge detection by Canny Operator
subplot(2, 3, 6);
imshow(B5), title('Edge detection by Canny Operator');