clc;
clear;
close all;
% Read the image (use the correct path)
i = imread('MATLAB Drive/nir images/nir image 1.jpg');
% Display the original image
subplot(3,3,1);
imshow(i);
title('Original Image');
% Crop the image (you may need to manually select the cropping region)
final = imcrop(i);
% Display the cropped image
subplot(3,3,2);
imshow(final);
title('Cropped Image');
% Convert to grayscale and resize
rg = rgb2gray(final);
x1 = imresize(rg, [256 256]);
% Apply median filter for denoising
denImg = medfilt2(x1);
% Display the denoised image
subplot(3,3,3);
imshow(denImg);
title('Denoised Image');
% Adjust contrast
j = imadjust(denImg);
% Display the contrast-adjusted image
subplot(3,3,4);
imshow(j);
title('Contrast Image');
% Convert to binary image
b = imbinarize(j);
% Display the binary image
subplot(3,3,5);
imshow(b);
title('Binary Image');
% Count the number of pixels in the binary image
numberofpixels = numel(b);
disp(['Number of pixels in the binary image: ', num2str(numberofpixels)]);
% Calculate and display the histogram of the binary image
[pixelCounts, greyLevels] = imhist(b);
numberofpixelsInHistogram = sum(pixelCounts);
disp(['Number of pixels from histogram: ', num2str(numberofpixelsInHistogram)]);


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
