clc
clear all
close all
 
%%%%%%%%%%%%%%%%%%%%% TRAINING %%%%%%%%%%%%%%%%%%%%

imlist=dir('./enroll/*.png');  %Images go into imlist, dir list files
im =imread(['./enroll/',imlist(1).name]); %read images by name
[r,c]=size(im); % r=50 c=50
num_im=length(imlist); %number of images in imlist (8)
num_p=num_im/2; % num of images divide by two... (4)
x=zeros(r*c,num_p); % matrix of 2500 row,  4 cols
im_vector=zeros(r*c,num_im); %matrix of 2500 rows, 8 cols
Mec=zeros(r*c,1); % vector 2500 rows, 1 column
index=zeros;index2=zeros;
match=zeros(1,10);match2=zeros(1,10); % one row, 10 columns
cmc=zeros(1,10);% one row, 10 columns
cmc2=zeros(1,10);% one row, 10 columns

%%%%%% convert all images to vector %%%%%%
for i=1:num_im
im =imread(['./enroll/',imlist(i).name]);
im_vector(:,i)=reshape(im',r*c,1); %reshapes into vector 2500 rows, 1 col
end

%%%%%%%%%%%%%% to get xi and Me%%%%%%%%%%%%%%%%
j=1;
for i=1:2:(num_im-1)
x(:,j) = (im_vector(:,i) + im_vector(:,i+1))./2;
Mec(:,1)=Mec(:,1) + im_vector(:,i) + im_vector(:,i+1);
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
%% Plot the weights for person 1 2 3 4...
% plot(wta(:,1));title('Weights Person 1');
% figure,plot(wta(:,2));title('Weights Person 2'); 
% figure,plot(wta(:,3));title('Weights Person 3');
% figure,plot(wta(:,4));title('Weights Person 4');


%%%%%%%%%%%%%% to get the Eigenfaces %%%%%%%%%%%%
ef =a*p2;  %here is P you need to use in matching 
[rr,cc]=size(ef);

%%show the eigenface images ...
% for i=1:cc
%     eigen = ef(:,i);
%     eface(:,:,i) = reshape(eigen,r,c); 
%     eface(:,:,i) = eface(:,:,i)'; %flip the image so it appears correctly
%     figure, imshow(eface(:,:,i)); 
%     title('Eigen Face');
% end


%% %%%%%%%%%%%%%%%%%%%%%  TESTING  %%%%%%%%%%%%%%%%%%%%%%%%
imlist2=dir('./testing/*.png');
num_imt=length(imlist2);
imt_vector=zeros(r*c,num_imt);


%% Please complete the testing part...
%%%%%% convert all test images to vector %%%%%%
for i=1:num_imt
im =imread(['./testing/',imlist2(i).name]);
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
result=[1 1 2 3 4];
    
    if index(i) == result(i)
        match(i) = match(i) + 1;
    else
        [svals, idx] = sort(EUD(:));
        index2(i)=idx(2);
        if index2(i)==result(i)
            match(i)=match(i)+1;
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








