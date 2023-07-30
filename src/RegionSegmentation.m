% MATLAB code for Region Growing and Region based Segmentation
% By comparing every unallocated neighbouring pixels to the region,
% the region is iteratively grown. As a measure of similarity,
% the difference between a pixel's intensity value and the region's mean
% is employed. pixel with the most minimal difference is allocated to
% the appropriate location when measured in this way. When the intensity
% difference between the region mean and the new pixel reaches a specified
% threshold (reg_max), this procedure comes to an end.
close all;
clc;
I = im2double(imread('flower.jpg'));
subplot(1,3,1);imshow(I);title('Original Image');
x=440; y=823; % the position of the seedpoint
reg_max = 0.2; % region maximum intensity (defaults to 0.2)

J = zeros(size(I)); % Output (Region Grown Image)
Isizes = size(I); % Dimensions of input image

reg_mean = I(x,y); % The mean of the segmented region
reg_size = 1; % Number of pixels in region

% Free memory to store neighbours of the (segmented) region
neg_free = 10000; neg_pos=0;
neg_list = zeros(neg_free,3);
pixdist=0; % Distance of the region newest pixel to the regio mean

% Neighbor locations (footprint)
neigb=[-1 0; 1 0; 0 -1;0 1];

% Start region growing until distance between region and posible new pixels
% become higher than a certain treshold
while(pixdist<reg_max && reg_size<numel(I))
    % Add new neighbors pixels
    for j=1:4
        
        % Calculate the neighbour coordinate
        xn = x +neigb(j,1); yn = y +neigb(j,2);
       
        % Check if neighbour is inside or outside the image
        ins=(xn>=1)&&(yn>=1)&&(xn<=Isizes(1))&&(yn<=Isizes(2));
       
        % Add neighbor if inside and not already part of the segmented area
        if(ins&&(J(xn,yn)==0))
                neg_pos = neg_pos+1;
                neg_list(neg_pos,:) = [xn yn I(xn,yn)]; J(xn,yn)=1;
        end
    end
    % Add a new block of free memory
    if(neg_pos+10>neg_free), neg_free=neg_free+10000; neg_list((neg_pos+1):neg_free,:)=0; end
   
    % Add pixel with intensity nearest to the mean of the region, to the region
    dist = abs(neg_list(1:neg_pos,3)-reg_mean);
    [pixdist, index] = min(dist);
    J(x,y)=2; reg_size=reg_size+1;
   
    % Calculate the new mean of the region
    reg_mean= (reg_mean*reg_size + neg_list(index,3))/(reg_size+1);
   
    % Save the x and y coordinates of the pixel (for the neighbour add proccess)
    x = neg_list(index,1); y = neg_list(index,2);
   
    % Remove the pixel from the neighbour (check) list
    neg_list(index,:)=neg_list(neg_pos,:); neg_pos=neg_pos-1;
end

subplot(1,3,2);imshow(J);title('Region Grown Image')
% Make the segmented area as logical matrix
J=J>1;

subplot(1,3,3);imshow(I+J);title('Segmented Image')
impixelinfo;