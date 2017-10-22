function [ Error_rate ] = criteria( Result, option )
%CRITERIA Summary of this function goes here
%   Detailed explanation goes here

% Mode_Length = length(Best_Result);
% if option == 1
%     Error_rate = norm(Result-Best_Result,'fro')/norm(Best_Result,'fro');
% end
if option == 1 % l2-norm
    Error_rate = norm(Result,'fro');
end
if option == 2 % l1-norm
    Error_rate = norm(Result,1);
end
if option == 3 % l0-norm
    alfa = 0;
    Error_rate = length(find(abs(Result)>alfa*max(abs(Result))));
end
if option == 4 % Sparsity
    long = length(Result);
    DCT_matrix = dctmtx(long);
    sparse = DCT_matrix*Result; % Note it satiesfies that Sparse = DCT*Result !
    Error_rate = norm(sparse,1);
end

end

