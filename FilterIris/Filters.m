clc
clear all
close all

im = imread('dylan.jpeg');
im = rgb2gray(im);
noisyim = imnoise(im,'salt & pepper',0.02);
% imshow(noisyim);

%Applying average filter
w=[1 1 1; 1 1 1; 1 1 1]/9; 
im2=imfilter(noisyim,w,'same'); 
% figure,imshow(im2);

% Applying own filter
Vertical = [-1 0 1 ; -2 0 2 ; -1 0 1];
 imx = imfilter(im, Vertical,'same','replicate'); 
%  figure, imshow(imx);

 
 %Applying own filter
 Horizantal = [-1 -2 -1; 0 0 0 ; 1 2 1];
im6 = imfilter(im, Horizantal,'same','replicate');
figure, imshow(im6);
         
%Applying median filter
im3 = medfilt2(noisyim);
% figure, imshow(im3);

%Applying sobel filter
im4 = edge(im,'sobel');
% figure, imshow(im4)

%Applying laplacian
H = fspecial('laplacian',0.5);
lap = imfilter(im,H,'same');
% figure, imshow(lap)


% figure,subplot(2,3,1),imagesc(im2);
% colormap(gray(256));
% axis image; 
% axis off;
% 
% subplot(2,3,2),imagesc(im3);
% colormap(gray(256));
% axis image;
% axis off;
% 
% subplot(2,3,3),imagesc(im4);
% colormap(gray(256));
% axis image;
% axis off;
% 
% subplot(2,3,4),imagesc(lap);
% colormap(gray(256));
% axis image;
% axis off;
% 
% subplot(2,3,5),imagesc(imx);
% colormap(gray(256));
% axis image;
% axis off;
% 
% subplot(2,3,6),imagesc(im6);
% colormap(gray(256));
% axis image;
% axis off;
