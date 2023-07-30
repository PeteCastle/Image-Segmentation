%% Edge Detection Detail
% Load the image
building2 = imread('../raw/windows.jpg');

% Display the original image
imshow(building2);
title('Original Image');

% Convert the image to grayscale
gray_building = rgb2gray(building2);

%% Edge Detection
% Edge Detection options
edge_prewitt = edge(gray_building, 'Prewitt');
edge_roberts = edge(gray_building, 'Roberts');
edge_sobel = edge(gray_building, 'Sobel');

% Visualizing the difference
figure;

subplot('Position',[0.02 0.35 0.3 0.3]);
imshow(edge_prewitt);
title('Prewitt Edge Detection');

subplot('Position',[0.35 0.35 0.3 0.3]);
imshow(edge_roberts);
title('Roberts Edge Detection');

subplot('Position',[0.68 0.35 0.3 0.3]);
imshow(edge_sobel);
title('Sobel Edge Detection');

%% Edge Detection Filled
%Fill holes
figure;

subplot('Position',[0.02 0.35 0.3 0.3]);
imshow(imfill(edge_prewitt,'holes'));
title('Prewitt Edge Detection Filled');

subplot('Position',[0.35 0.35 0.3 0.3]);
imshow(imfill(edge_roberts,'holes'));
title('Roberts Edge Detection Filled');

subplot('Position',[0.68 0.35 0.3 0.3]);
imshow(imfill(edge_sobel,'holes'));
title('Sobel Edge Detection Filled');


%% Image of Owl
% Load the image
owl = imread('../raw/small_owl.jpg');

% Display the original image
imshow(owl);
title('Original Image');

% Convert the image to grayscale
gray_owl = rgb2gray(owl);

%% Sensitivity of the Edge detection method
% Perform edge detection using the Roberts operator and obtain the default threshold value
[edges_roberts, edge_threshold] = edge(gray_owl, 'Roberts');

%%  Sensitivity through threshold value
step_size = 0.0;
sensitivity = edge_threshold + step_size;

edges_prewitt2 = edge(gray_owl, 'Prewitt', sensitivity);
test = imshow(edges_prewitt2);
title(sprintf('Sensitivity: %.03f', sensitivity));

