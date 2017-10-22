function [ undersampled ] = UnderSample( original, a )
%UNDERSAMPLE Summary of this function goes here
%   Detailed explanation goes here
%   Note original is a row vector

long = length(original);
dim = sqrt(long);
original_mat = reshape(original,dim,dim);
undersampled_mat = original_mat([1:a:dim], [1:a:dim]);
[x,y] = size(undersampled_mat);
undersampled = reshape(undersampled_mat,x*y,1);

end

