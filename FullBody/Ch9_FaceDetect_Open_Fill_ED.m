clear all;
close all;
im = imread('kevin.jpg');
% im =fixLight(im)         %Tried to fix some light but didn't work. 
im = double(im);
%% %%%%%%%%%%%%%%%% first step skin detection %%%%%%%%%%%%%%%%%%%%%%%%%
ims1 = (im(:,:,1)>95) & (im(:,:,2)>40) & (im(:,:,3)>20);
ims2 = (im(:,:,1)-im(:,:,2)>15) | (im(:,:,1)-im(:,:,3)>15);
ims3 = (im(:,:,1)-im(:,:,2)>15) & (im(:,:,1)>im(:,:,3));
ims = ims1 & ims2 & ims3;

%figure,imshow(im./255);
%figure,imshow(ims);
%% %%%%%%%%%%%%%%%% second step %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% morphorlogy %%%%%%%%%%%%%%%%%%%%%%%%%
[c,r]=size(ims); %%get pic size

for x= floor(c*0.25):c  %%%% delete the lower half part
    ims(x,:,:)=0;
end

for e=1:floor(r*0.70)    %To delete the left part of the image since the O's 
ims(:,e,:)=0;       % in Google are being detected in face detect
end

%figure,imshow(ims); %%%%%%% delete the small black holes
imf=imfill(ims,'holes');
%figure,imshow(imf);

imo=bwareaopen(imf,50); %%%%%%% area open to delete small lines small objects
%figure,imshow(imo); 

imde=imo;
% SE = strel('square',10);%%%%%%% dilate and erode 
% imde=imdilate(imo,SE);
% %figure,imshow(imde);
% imde=imerode(imde,SE);
% %figure,imshow(imde);

 for i=1:3
imdt(:,:,i)=imde.*im(:,:,i);
end

%figure,imagesc(imdt./255); axis image;axis off; title('Detected Face Image','fontsize',10);
%figure, imshow(imdt./255); 
% 
final = imdt;
figure, imshow(imdt./255);



SE = strel('line',10,0)
% 
% imdt=imdilate(imdt,SE);
% final=imerode(imdt,SE);

final=imclose(imdt,SE); 
figure, imshow(final./255);



% 
% final = fixLight(imdt); 
% 
% ims11 = (final(:,:,1)>95) & (final(:,:,2)>40) & (final(:,:,3)>20);
% ims22 = (final(:,:,1)-final(:,:,2)>15) | (final(:,:,1)-final(:,:,3)>15);
% ims33 = (final(:,:,1)-final(:,:,2)>15) & (final(:,:,1)>final(:,:,3));
% final = ims11 & ims22 & ims33;
% 
% figure, imshow(final); 


i=i;
  