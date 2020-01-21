function [D,U,W]=DCADL(X,L,anum,p_num,maxIter,lambda1,lambda2,lambda3,lambda4,Y,Gtr,Gte)
% min_{D,U,W,Q,epsilon1,epsilon2} 1/2||DX_bar-U_bar||_2^2+lambda1||U_hat||_1
%            +lambda2/2||Y-WU_tide||_F^2
%       s.t. ||d_i||_2^2<=1
%
% created by Wen 01/2020
% wtang6@ncsu.edu

rng default

Inum=size(L,2);

%% Initialization
D = rand(anum,size(X,1));
U = zeros(p_num,anum*Inum);
W = rand(size(L,1),p_num*anum);

iter = 0;
alpha=1;
u=zeros(size(D,1),size(X,2));
while iter<=maxIter
    iter = iter + 1;
    
    %update U
    u_tmp=(1-alpha).*u'+alpha.*(X'*D');
    u=mat2cell(u_tmp,ones(1,Inum).*p_num,size(u_tmp,2));
    u=cell2mat(u');
    U_concate=reshape(u,[],Inum);
    U_tmp=U_concate-alpha.*(-lambda2.*W'*L+lambda2.*W'*W*U_concate);
    U=reshape(U_tmp,p_num,[]);
    U = ALst(U, alpha.*lambda1);
    U_concate=reshape(U,[],Inum);
    
    %update W
    W=L*U_concate'*inv(U_concate*U_concate'+eye(size(U_concate,1)).*lambda3);
    
    %update D
    u=mat2cell(U',ones(1,Inum).*anum,size(U,1));
    u=cell2mat(u');
    D=u*X'*inv(X*X'+eye(size(X,1)).*lambda4);
    normd=sqrt(sum(D.^2,2));
    D=D./repmat(normd.*(normd>1)+(normd<=1),1,size(D,2));
    
    %% Accuarcy Tracing
    %     Acc_Tr(iter)=cadl_classifier(X,D,W,lambda1,size(Gtr,2),p_num,Gtr);
    %     Acc_Te(iter)=cadl_classifier(Y,D,W,lambda1,size(Gte,2),p_num,Gte);
    %     disp(Acc_Tr(iter));
    %     disp(Acc_Te(iter));
    
end
U=U_concate;
end
