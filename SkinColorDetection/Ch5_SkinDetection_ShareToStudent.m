clc
clear all
close all


% im =imread('face_good.bmp');
%figure,imshow(im);title('face');
im =imread('face_dark.bmp');
im = double(im);



ims1 = (im(:,:,1)>95) & (im(:,:,2)>40) & (im(:,:,3)>20);
ims2 = (im(:,:,1)-im(:,:,2)>15) | (im(:,:,1)-im(:,:,3)>15);
ims3 = (im(:,:,1)-im(:,:,2)>15) & (im(:,:,1)>im(:,:,3));
ims = ims1 & ims2 & ims3;
figure,imshow(ims);title('skin detected before correction');
hist = imhist(ims,2); 
m = histeq(hist);
plot(ims);
plot(m);



 