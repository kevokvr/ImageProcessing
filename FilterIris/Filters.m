clc
clear all
close all

im = imread('dylan.jpeg');
im = rgb2gray(im);
noisyim = imnoise(im,'salt & pepper',0.02);
imshow(noisyim);

%Applying average filter
w=[1 1 1; 1 1 1; 1 1 1]/9; 
im2=imfilter(noisyim,w,'same'); 
figure,imshow(im2);

%Applying median filter
im3 = medfilt2(noisyim);
figure, imshow(im3);

%Applying sobel filter
im4 = edge(im,'sobel');
figure, imshow(im4)

%Applying laplacian
H = fspecial('laplacian',0.5);
lap = imfilter(im,H,'same');
figure, imshow(lap)
