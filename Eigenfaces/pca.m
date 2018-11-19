clc
clear all
close all
 
%%%%%%%%%%%%%%%%%%%%% TRAINING %%%%%%%%%%%%%%%%%%%%

imlist=dir('./enrolling/*.bmp');  %Images go into imlist, dir list files
im =imread(['./enrolling/',imlist(1).name]); %read images by name
[r,c]=size(im); % r=50 c=50
num_im=length(imlist); %number of images in imlist 
num_p=num_im/2; % num of images divide by two... 
x=zeros(r*c,num_p); % matrix 
im_vector=zeros(r*c,num_im); %matrix 
Mec=zeros(r*c,1); % vector
index=zeros;index2=zeros;
match=zeros(1,20);match2=zeros(1,20); % one row
cmc=zeros(1,20);% one row, 
cmc2=zeros(1,20);% one row, 

%%%%%% convert all images to vector %%%%%%
for i=1:num_im
im =imread(['./enrolling/',imlist(i).name]);
im_vector(:,i)=reshape(im',r*c,1); %reshapes into vector 2500 rows, 1 col
end

%%%%%%%%%%%%%% to get xi and Me%%%%%%%%%%%%%%%%
j=1;
for i=1:5:(num_im-1)   %<--- the it will need to increment differently
x(:,j)=(im_vector(:,i)+im_vector(:,i+1)+im_vector(:,i+2)+im_vector(:,i+3)+im_vector(:,i+4))./5;%<--- needs to be five
Mec(:,1)=Mec(:,1)+im_vector(:,i)+im_vector(:,i+1)+im_vector(:,i+2)+im_vector(:,i+3)+im_vector(:,i+4);
j=j+1;
end
Me=Mec(:,1)./num_im;

%%%%%%%%%%%%%% to get big A %%%%%%%%%%%%%%%%%%%%
for i=1:num_p
a(:,i)=x(:,i)-Me;
end

%%%%%%%%%%%%%% to get eig of A'*A (P2) %%%%%%%%%
ata = a'*a;  
[V D] = eig(ata);
p2 = [];
for i = 1 : size(V,2) 
    if( D(i,i)>1 )
        p2 = [p2 V(:,i)];
    end
end
%%%weight of the training data projected into eigen space%%%%%
wta=p2'*ata;
%% Plot the weights for person 1...
plot(wta(:,1));title('Weights Person 1');



%%%%%%%%%%%%%% to get the Eigenfaces %%%%%%%%%%%%
ef =a*p2;  %here is P you need to use in matching 
[rr,cc]=size(ef);

%%show the eigenface images ...
mon1 = uint8(zeros(100,100,1,20));
for i=1:cc
    eigen = ef(:,i);
    eface(:,:,i) = reshape(eigen,r,c); 
    eface(:,:,i) = eface(:,:,i)'; %flip the image so it appears correctly
    mon1(:,:,:,i) = eface(:,:,i);%need montage
end
figure, montage(mon1);

%% %%%%%%%%%%%%%%%%%%%%%  TESTING  %%%%%%%%%%%%%%%%%%%%%%%%
imlist2=dir('./testing44/*.bmp');
num_imt=length(imlist2);
imt_vector=zeros(r*c,num_imt);


%% Please complete the testing part...
%%%%%% convert all test images to vector %%%%%%
for i=1:num_imt
im =imread(['./testing44/',imlist2(i).name]);
imt_vector(:,i)=reshape(im',r*c,1);
%%%%% get B=y-me %%%%%%%
   %%Please caculate bi=imt_vector(i)-Me;
    b(:,i) = imt_vector(:,i) - Me;
   %%Please culculate wtb=P'*bi;
   P = ef'
   wtb = P * b(:,i);
for ii=1:num_p   %% weight compare wtb and wta(i)
    sum1 = sum((wtb - wta(:,ii)));
    EUD(ii) = sqrt(sum1.^2); 
end
   %%Please find minimum eud's index
[data index(i)] = min(EUD); 

%%%%%%%%%%%%%%%%%%%%%%%  RESULT  %%%%%%%%%%%%%%%%%%%%%%%%
%%% right result by observation is 1 1 2 3 4 %%%%%
%%%%%%%%%%%%%%% CMC calculation (compare with result)%%%%%%%
result=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
    
    if index(i) == result(i)
        match(1) = match(1) + 1;
    else
        [svals, idx] = sort(EUD(:));
        index2(i)=idx(2);
        if index2(i)==result(i)
            match(2)=match(2)+1;
        end
    end
end
  %%Please draw the CMC curve
for i=1:num_imt
    cmc(i)=sum(match(1:i))/num_imt;
end
figure,plot(cmc);title('CMC Curve');
%%%%%%%%%%%%%%% CMC curve plot %%%%%%%
 i=i;
