% Image Segmentation using Watershed Algorithm
clear;
clc;

%% Reading input
Im = imread('../raw/image.jpg');
[N,M,T] = size(Im); % Image size

%% Initialization
Im1 = rgb2gray(Im); %Convert RGB image to grayscale
Im1 = double(Im1); %Normalizing RGB Values
minI = min(min(Im1)); %Minimum pixel intensity
maxI = max(max(Im1)); %Maximum pixel intensity
J = zeros(N,M); %Will store label of the pixel
curr_label = 1; %Initializing first label value

%% Watershed Algorithm Implementation
for i=minI:maxI %Loop over range of pixel intensities, starting from lowest pixel intensity
    [idx idy] = find(Im1==i); %All pixels with pixel intensity 'i'
    pts = length(idx); %Number of pixels with pixel intensity 'i'
    if(pts==0) %Implies that there are no pixels with intensity 'i'
        continue;
    end
    for j = 1:pts
        lab = get_label(J,N,M,idx(j),idy(j)); %Get label for the pixel
        if(lab == -1) %There are no neighbours marked in the 8-neighbourhood 
            J(idx(j), idy(j)) = curr_label; %We assign a new label to the pixel
            curr_label = curr_label + 1; %Update label that will be assigned to a new region
        else
            J(idx(j), idy(j)) = lab; %Assign label as found in the neighbourhood
        end
    end
end

%% Obtaining Segmented Image
Final_im = zeros(size(Im));
%Since watershed segmntation algorithm leads to formation of many
%segments,but we have only 2 segments in ground truth image, so we apply further filtering and
%combine all segments such that we get only 2 segments
for i = 1:N
    for j = 1:M
        if(J(i,j)<420) %If the assigned label is below 420, make it green
            Final_im(i,j,2) = 128;
        else
            Final_im(i,j,3) = 255; %If the assigned label is above 420, make it blue
        end
    end
end

%% Plotting figures
figure();
imshow(Im); %% Shows original image alongwith initial seed point
title('\fontsize{16}Original Image');

figure();
image(J,'CDataMapping','scaled') %Will assign a color to a pixel according to its label value, and display the generated image
colorbar %Shows color bar alongside the graph 
title('\fontsize{16}Segmented Image using Watershed Algorithm');

figure();
imshow(uint8(Final_im)); %% Shows original image
title('\fontsize{16}Image limited to 2 Segments after further Filtering');

end