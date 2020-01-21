function X=Xnormlize(X)
% Created by Wen 01/2020
% wtang6@ncsu.edu
n = size(X,1);
%[X mu] = center(X);
d = sqrt(sum(X.^2));
d(d == 0) = 1;
X = X./(ones(n,1)*d);

end