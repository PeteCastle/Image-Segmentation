try_again = 'yes';
 
%Select file
while strcmpi(try_again, 'yes')
    [file, path] = uigetfile({'*.jpg;*.png;*.bmp'}, 'Select an image file');
    if isequal(file, 0)
        fprintf('No image file selected. Exiting...\n');
        return;
    end
    image_path = fullfile(path, file);
 
 
    image = imread(image_path);
 
  
    img = rgb2gray(image);
 
 
    sensitivity = -1;
    while sensitivity < 0 || sensitivity > 1
        sensitivity = input('\nEnter sensitivity value (between 0.00 and 1.00): ');
        if sensitivity < 0 || sensitivity > 1
            fprintf('Invalid sensitivity value. Please enter a value between 0.00 and 1.00.\n');
        end
    end
 
  
    foreground_polarity = '';
    while ~strcmpi(foreground_polarity, 'dark') && ~strcmpi(foreground_polarity, 'bright')
        foreground_polarity = input('Enter foreground polarity (dark or bright): ', 's');
        if ~strcmpi(foreground_polarity, 'dark') && ~strcmpi(foreground_polarity, 'bright')
            fprintf('Invalid foreground polarity. Please enter either ''dark'' or ''bright''.\n');
        end
    end
 
    
    thresh1 = adaptthresh(img, sensitivity, 'ForegroundPolarity', foreground_polarity);
    thresh1 = imbinarize(img, thresh1);
 
   
    figure;
 
    subplot(1, 2, 1);
    imshow(image);
    title('Original Image');
     
 
    subplot(1, 2, 2);
    imshow(thresh1);
    title(sprintf('Local Thresholding: Adaptive Mean\nSens: %.2f, FG Polar : %s', sensitivity, foreground_polarity));
 
  
    try_again = input('Do you want to try again? (yes or no): ', 's');
end
 
fprintf('Exiting...\n');