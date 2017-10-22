function [ SCI ] = OutlierDetect( x, K, index, numSample )
%OUTLIERDETECT Summary of this function goes here
%   Detailed explanation goes here

%   INPUT: x is coefficient vector given by algorithm SRC(). K is the
%   number of classes. index is index is a 1*k vector shows the number 
%   of samples in each class from class 1 to class k. numSample is the
%   total number of all training samples.
%   OUTPUT: SCI is value of outlier range in [0, 1]. The smaller it is, the
%   more probabily that it is a outlier.

x_norm1 = norm(x,1);
max_delta_x = -1;
for ii = 1 : K
    idx1 = 1;
    for jj = 1 : ii-1
        idx1 = idx1 + index(jj);
    end
    idx2 = idx1 + index(ii) - 1;
    tempX = x;
    for ll = 1 : numSample
        if ll < idx1 || ll > idx2
            tempX(ll) = 0;
        end
    end
    temp_delta_x = norm(tempX,1);
    if max_delta_x < temp_delta_x
        max_delta_x = temp_delta_x;
    end
end
delta_x = max_delta_x/x_norm1;

SCI = (K*delta_x - 1)/(K - 1);
disp('SCI of current x is: ');
disp(SCI);

end

