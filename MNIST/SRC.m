function [ label ] = SRC( A, y, K, index )
%SRC Summary of this function goes here
%   Detailed explanation goes here

%   INPUT is A and y while A A's column is [A_1, A_2, A_3 ... A_k] if there
%   are K classes. Each column of A_i is one sample from class i, the row
%   number of A_i is the number of all samples in class i. y is a column
%   vector of unlabeled test sample. K is the number of classes. index is a 1*k vector
%   shows the number of samples in each class from class 1 to class k.
%   OUTPUT is its expected label from SRC.
%   NOTE that matrix A should be non-negative!

%%   Normalize the columns of A to have unit l2-norm
clc
disp('Normalize step...');
[~, numSample] = size(A);
for ii = 1 : numSample
    A(:,ii) = A(:,ii)/norm(A(:,ii),2);
end

%%  Solve l1-minimization problem
maxalg = 100;
maxiter = 30;
tempErr = 1000000000;
for jj = 1 : maxalg
    [ l1_err, tempResult ] = nmf_mm_NMX( A, y, maxiter, jj );
    if tempErr > l1_err
        Result = tempResult;
        tempErr = l1_err;
    end
end
save('Result.mat','Result');

%%  Outlier detection
disp('Outlier detection step...');
[ SCI ] = OutlierDetect( Result, K, index, numSample );
save('SCI.mat','SCI');

%%  Compute the residuals
classErr = (-1)*ones(1,K);
for kk = 1 : K
    clc
    disp('Class error calculate step...');
    disp('Current class ID: ');
    disp(kk);
    idx1 = 1;
    for ll = 1 : kk-1
        idx1 = idx1 + index(ll);
    end
    idx2 = idx1 + index(kk) - 1;
    tempResult = Result;
    for ll = 1 : numSample
        if ll < idx1 || ll > idx2
            tempResult(ll) = 0;
        end    
    end
    classErr(kk) = norm(y-A*tempResult,2);
end
classErr = classErr/sum(classErr);
save('classErr.mat','classErr')

alfa = 0.5;
SparseRateResult = length(find(abs(Result)>alfa*max(abs(Result))))/(length(Result));
save('SparseRateResult.mat','SparseRateResult');

%%  Calculate results
[~,label] = min(classErr);
clc
disp('The end of algorithm.');
% if SCI < 0.3
%     disp('This is an OUTLIER!');
% end
% if SCI >= 0.3
%     disp('Label for y is: ');
%     disp(label);
% end


end

