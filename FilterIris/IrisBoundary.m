clc
clear all
close all

I = imread('iris.bmp');
imshow(I,[]);
[X,Y]=size(I);

[E, thresh] = edge(I, 'sobel');
figure, imshow(E, []);

H=zeros(X,Y);

for x=1:X
    for y=1:Y
        if E(x,y)
            for x0=1:X
                for y0=1:Y
                    r = sqrt((x-x0)^2 + (y-y0)^2)
                    H(x0,y0) = H(x0,y0)+ 1;
                end
            end
        end
    end
end

plot(H);


 