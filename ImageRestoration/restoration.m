close all 
clc 
clear all

sizex = 256
sizey = 256

im = zeros(sizex, sizey); 
[r,c]=size(im); 

center = im((sizex/2),(sizey/2));
radius = 80; 

for r=1:r
    for c=1:c
        if sqrt((r-(sizex/2))^2 + (c-(sizey/2))^2)<radius
            im(r,c)=0.4;
        else
            im(r,c)=0.7;
        end
    end
end


figure, imshow(im);title('Original Image');  
figure, imhist(im); 

%%J = imnoise(I,'gaussian') adds zero-mean, Gaussian white noise with variance of 0.01 to image I.
gau = imnoise(im,'gaussian',0); 
figure, imshow(gau);title('Gaussian Noise');

denoisedImage = conv2(double(gau), ones(3)/9, 'same');
figure, imshow(denoisedImage);title('Denoised'); 

try2=imgaussfilt(gau,1.5);
figure, imshow(try2);title('imgaussfilt'); 

%uniform noise
a=-0.5
b=0.5
R= a + (b-a)*rand(256,256);
uni = im + R; 
figure, imshow(uni);title('Uniform Noise'); 
figure, imhist(uni); 

%Fix uniform noise
w2=[1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1]/15;
restoruni=imfilter(uni,w2,'same');
figure, imshow(restoruni);title('Restore Uniform'); 

%J = imnoise(I,'salt & pepper', 0.02);
saltpep = imnoise(im, 'salt & pepper',0.02); 
figure , imshow(saltpep);title('Salt and Pepper'); 
figure, imhist(saltpep);

%Median filter to Salt and Pepper 
restoreSP = medfilt2(saltpep);
figure, imshow(restoreSP);title('Median salt and pepper'); 




