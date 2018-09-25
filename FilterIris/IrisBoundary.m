clc
clear all
close all
%Kevin Valenzuela
Original = imread('iris.bmp');
Org2Double = double(Original);
Eye = Org2Double(1:2:end,1:2:end);

Horizantal = [-1 -2 -1
                0 0 0 
                 1 2 1];
  
Vertical = [-1 0 1 
             -2 0 2 
             -1 0 1];

temp1 = imfilter(Eye, Horizantal,'same','replicate');
temp2 = imfilter(Eye, Vertical,'same','replicate'); 
EyeEdges = sqrt((temp1.^2+temp2.^2)/2);

r=20;
innercircle=zeros(r*2+1);
innercircle(1,r+1)=1;
innercircle(r*2+1,r+1) = 1;
oneoverR=1/r;

for i=0:oneoverR:pi/2
    y=round(r*cos(i));
    x=round(r*sin(i));
    innercircle(r+1+x,r+1+y)=1;
    innercircle(r+1+x,r+1-y)=1;
    innercircle(r+1-x,r+1+y)=1;
    innercircle(r+1-x,r+1-y)=1;
end

r=20; 
circlesize=r*2+1+6;
center=round(0.5*circlesize);
anothercircle=zeros(r+4);

for i=1:circlesize
    for j=1:circlesize
        if(sqrt((i-center)^2+(j-center)^2) < (r+3)) && (sqrt((i-center)^2+(j-center)^2) > (r+3))
            anothercircle(i,j)=1; 
        end
    end
end

kernel=anothercircle;
eye3=imfilter(EyeEdges,kernel,'same');
[fr,fc]=find(eye3>0.9*max(eye3(:)));
cenrow=round(mean(fr));
cencol=round(mean(fc));

% clearEdgeEye = zeros(size(EyeEdges,1),size(EyeEdges,2));
clearEdgeEye = (EyeEdges >0.6*max(EyeEdges(:)));


for i=j:size(EyeEdges,1)
    for j=1:size(EyeEdges,2)
        if sqrt((i-cenrow)^2+(j-cencol)^2)>25
            clearEdgeEye(i,j)=0;
        end
    end
end

iris = clearEdgeEye;

[r,c]=size(iris);
radius = 30;

for r=1:r
    for c=1:c
        if sqrt((r-68)^2 + (c-92)^2)>radius
            iris(r,c)=0;
        end
    end
end



figure,subplot(2,2,1),imagesc(Eye);
colormap(gray(256));
axis image; 
axis off;

subplot(2,2,2),imagesc(EyeEdges);
colormap(gray(256));
axis image;
axis off;

subplot(2,2,3),imagesc(clearEdgeEye);
colormap(gray(256));
axis image;
axis off;

subplot(2,2,4),imagesc(iris);
colormap(gray(256));
axis image;
axis off;




    
    






 