clc
clear;
close all;
%I=imread('C:\Users\dumpa\OneDrive\Desktop\Road-extraction-from-satellite-images-master\Road_extraction\test\1.jpeg');
[file,path] = uigetfile('*');
I=imread(fullfile(path,file));

figure;
imshow(I);  %2
title('Original image');
 
J=rgb2gray(I);

figure
imshow(J); %2
title('grayscale image');
K=imadjust(J,[0.5 0.9],[]); 

figure;
imshow(K); %3

level = graythresh(K);  
I=im2bw(K,level);     

figure;
imshow(I); %4
title('Binary image after thresholding');


B = medfilt2(I);
figure,imshow(B);  %5
title('median filtered image');


im = bwareafilt(B, [1, 10000]);


figure,imshow(im);  %6
%title('');

BW = bwmorph(im,'remove');
figure,imshow(BW);  %7
title('morphological filtering');

BW1 = edge(BW,'sobel');
figure,imshow(BW1);  %8
title('edge detection(sobel)');

H = vision.AlphaBlender;
J = im2single(J);
BW1 = im2single(BW1);
Y = step(H,J,BW1);
figure
imshow(Y)   %9
title('overlay on grayscale image');


