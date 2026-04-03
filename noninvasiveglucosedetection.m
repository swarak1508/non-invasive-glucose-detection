clc;
clear;
close all;

% 1. Read and Display Original
i = imread('/MATLAB Drive/nir images/nir image 1.jpeg');
subplot(2,3,1); imshow(i); title('Original Image');

% 2. Crop (Manual Selection)
final = imcrop(i);
subplot(2,3,2); imshow(final); title('Cropped Image');

% 3. Grayscale and Resize
rg = rgb2gray(final);
x1 = imresize(rg, [256 256]);

% 4. Denoising (Median Filter)
denImg = medfilt2(x1, [3 3]);
subplot(2,3,3); imshow(denImg); title('Denoised Image');

% 5. Contrast Adjustment
% Note: imadjust is critical for bringing out NIR intensity differences
j = imadjust(denImg);
subplot(2,3,4); imshow(j); title('Contrast Enhanced');

% --- THE ACCURACY FIX: ADAPTIVE BINARIZATION ---
% 'Sensitivity' helps detect lighter/darker spots that global binarize misses.
% 'ForegroundPolarity', 'bright' assumes the glucose/sample is lighter than background.
b = imbinarize(j, 'adaptive', 'Sensitivity', 0.55, 'ForegroundPolarity', 'bright');

subplot(2,3,5); imshow(b); title('Target Binary Mask');

% 6. Accurate Pixel Counting
% Use 'sum' on the binary image to count ONLY the white pixels (1s)
whitePixelCount = sum(b(:)); 
totalPixels = numel(b);
areaPercentage = (whitePixelCount / totalPixels) * 100;

% 7. Global Intensity Check (Add this for extra accuracy)
% Sometimes pixel count is same, but brightness changes.
avgIntensity = mean2(j);

% Display Results
disp('--- Extraction Results ---');
disp(['White (Signal) Pixels: ', num2str(whitePixelCount)]);
disp(['Area Coverage: ', num2str(areaPercentage), '%']);
disp(['Average Intensity: ', num2str(avgIntensity)]);

% 8. Histogram of Enhanced Image (Not binary)
% A histogram of the 'j' image shows the distribution of concentrations better
subplot(2,3,6); imhist(j); title('Intensity Histogram');

