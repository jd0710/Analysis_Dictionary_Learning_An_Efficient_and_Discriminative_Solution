%% Demo for DCADL
% Created by Wen 01/2020
% wtang6@ncsu.edu

close all;clear all; clc;

%%  Patch your image first

load('YaleB.mat')
%xid and yid are respectively the starting coordinates of x and y  
xid=1;yid=1;
%p_size is the patch size
p_size=12;

stride=1;

Xtrain=[];Y=[];l=1;k=1;Gtr=[];Gte=[];L=[];
X=[];
%number of classes
class_num=38;
%number of training samples in each class
sample_num=32;


b0=0;
for cn=1:class_num
    b=find(labelMat(cn,:)==1);
    c=randsample(length(b),length(b));
    a=b(c);

    for i=1:sample_num
        Img=reshape(YaleB{cn,2}(:,a(i)-b0),imSize(1),imSize(2));
        Xtrain=[Xtrain,mygetpatches(Img,xid,yid,p_size,stride)];
        Gtr(l)=cn;
        L(cn,l)=1;
        l=l+1;
    end

    for j=sample_num+1:size(YaleB{cn,2},2)
        Img=reshape(YaleB{cn,2}(:,a(j)-b0),imSize(1),imSize(2));
        Y=[Y,mygetpatches(Img,xid,yid,p_size,stride)];
        Gte(k)=cn;k=k+1;
    end
    b0=b0+length(b);
end

save(['./YaleB_patched.mat'],'Xtrain','Y','L','Gtr','Gte');
disp('Yaleb Finished!');


%% DCADL
clear all;close all;clc;
load('YaleB_patched.mat')
%% Hyper-parameters
% penalty coefficient of sparse reperesentation
lambda1=0.001;
% penalty coefficient of joint classifier
lambda2=0.2; 
% contorler coefficient of pseudo-inverse of dictionary
lambda3=0.1; 
% contorler coefficient of pseudo-inverse of classifier
lambda4=0.1;


%number of atoms, i.e., the dictionary size
anum=50;
%maximum iteratioon
maxIter=23;


%Normalize the training and testing images.
Xtrain=Xnormlize(Xtrain); % training images
Y=Xnormlize(Y);% testing images
p_num=size(Xtrain,2)./length(Gtr); %patch size


%Big memory needed.
fprintf('Training......\n');
tic;
[D,U_concate,W]=DCADL(Xtrain,L,anum,p_num,maxIter,lambda1,lambda2,lambda3,lambda4);
trainingtime=toc;
fprintf('training time = %f\n',trainingtime);

%number of testing images
Inum=size(Gte,2);
tic;
[Acc_Te,labely]=DCADL_Classifier(Y,D,W,Inum,p_num,Gte);
testingtime=toc;
fprintf('testing time = %f\n',testingtime);
fprintf('Classification Accuarcy = %f%% \n',Acc_Te*100);