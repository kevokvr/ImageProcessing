function result = fixLight(im)
%   Color balance to get rid of the illuminance
%   References: Research a bit about a "Gray World" Algorith
%   https://www.mathworks.com/matlabcentral/fileexchange/40937-gray-world-colour-correction
%   https://web.stanford.edu/~sujason/ColorBalancing/grayworld.html
%   https://www.codeproject.com/Articles/653355/Color-Constancy-Gray-World-Algorithm
%  
    result = uint8(zeros(size(im,1), size(im,2), size(im,3)));       
    R = im(:,:,1);%Red Components of input
    G = im(:,:,2);%Green Components of input
    B = im(:,:,3);%Blue Components of input
   
    meanRed = 1/(mean(mean(R)));%Inverse of average Red component
    meanGreen = 1/(mean(mean(G)));%Inverse of average Green component
    meanBlue = 1/(mean(mean(B)));%Inverse of average Blue component
    
    %Documentation: C = max(A,B) returns an array with the largest elements taken from A or B.
    maxRGB = max(max(meanRed, meanGreen), meanBlue);
    %Take the value and divide by the average of each r,g,b
    meanRed = meanRed/maxRGB;
    meanGreen = meanGreen/maxRGB;
    meanBlue = meanBlue/maxRGB;
    %put those into the result image and times them by orignial because
    %they are scaled
    result(:,:,1) = R*meanRed;
    result(:,:,2) = G*meanGreen;
    result(:,:,3) = B*meanBlue;
end