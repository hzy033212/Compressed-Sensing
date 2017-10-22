function [ Error_rate, Result ] = nmf_mm_NMX( X, Y, maxiter, jj )

% Input parameter: Best_Result is what is the desired output while X
% satisfies that Y = X*Best_Result. Both Y and Best_Result are column
% vectors. Output is one measure of distance from real result to
% Best_Result.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User adjustable parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% maxiter = 30; % This is the bigger, the better, BUT NOT VERY MUCH!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define matrix Y that satisfy Y = X*Best_Result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Y = X*Best_Result;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize random W and H
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[n,m] = size(X); % Note that for an ill-posed problem, n SHOULD be much less than m!
W = rand(n,n);
H = rand(n,m);
% wh = reshape(W*H,1,n*m);
% x = reshape(X,1,n*m);
% alfa = sqrt((wh*x')/(x*x')/(10^2));
% W = alfa*W;
% H = alfa*H;

for iter=1:maxiter
    % Euclidean multiplicative method
    H = H.*(W'*X)./((W'*W)*H+eps);
    W = W.*(H*X')'./(W*(H*H')+eps);
    clc
    disp('l1-minimization step...');
    disp('Current alg#:');
    disp(jj);
    disp('iter=');
    disp(iter);
end

% Calculate result
V = W'*X*H';
inv_X = (H'/V)*W';
Result = inv_X*Y;

% Error_rate = norm(Result-Best_Result,'fro')/norm(Best_Result,'fro'); % The smaller,the better!
option = 1;
Error_rate = criteria(Result,option); 

end

