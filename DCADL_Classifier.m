function [Acc_Te,labely]=DCADL_Classifier(Y,D,W,Inum,p_num,Gte)
% created by Wen 01/2020
% wtang6@ncsu.edu

u1y_tmp=Y'*D';
%tic;
uy=mat2cell(u1y_tmp,ones(1,Inum).*p_num,size(u1y_tmp,2));
uy=cell2mat(uy');
%toc;
uy_concate=reshape(uy,[],Inum);
Lte=W*(uy_concate);
[~,labely]=max(Lte);
Acc_Te=sum((Gte-labely)==0)./length(labely);
end