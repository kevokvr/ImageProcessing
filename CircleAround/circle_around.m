clc
clear all
close all

im=imread('bobby.png');
imshow(im);

grayim=rgb2gray(im);
imshow(grayim);

[r,c]=size(grayim);
radius = 150;

%center = [250,191];

%distance formula for every pixel
for r=1:r
    for c=1:c
        if sqrt((r-192)^2 + (c-250)^2)<radius
            grayim(r,c)=grayim(r,c);
        else
            grayim(r,c)=0;
        end
    end
end

figure, imshow(grayim);

