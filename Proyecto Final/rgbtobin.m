clear, close all, clc

imagePath = imread("Letras\A\A.jpg");
imageArray = rgbtogray(imagePath);
binaryImage =im2bw(imagePath,.5);
binaryImage= ~binaryImage; 
% binaryImage = imbinarize(imagePath, 'adaptive', 'ForegroundPolarity', 'dark', 'Sensitivity', 0.4);
% binaryImage = imcomplement(binaryImage); 
figure
subplot(131),imshow(imagePath);
subplot(132),imshow(imageArray/255);
subplot(133),imshow(binaryImage);
