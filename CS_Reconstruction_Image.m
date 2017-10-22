function [ Result, temp_err_rate ] = CS_Reconstruction_Image( Mode, Y, max_alg, maxiter, kk, jj, Add_number, Best_Result )
%CS_RECONSTRUCTION_IMAGE Summary of this function goes here
%   Detailed explanation goes here

% Y = Mode*Best_Result;

temp_err_rate = 10000000000;
[~,lengthResult] = size(Mode);
Result = zeros(lengthResult,1);
for ii = 1 : max_alg
    clc
    disp('Add_number: ');
    disp(Add_number);
    disp('Current ii: ')
    disp(kk);
    disp('Current jj: ');
    disp(jj);
    disp('Current # of trials in current algorithm: ');
    disp(ii);
    [ Error_rate, temp_result ] = nmf_mm_NMX( Mode, Y, maxiter, Best_Result );
    if Error_rate < temp_err_rate
        Result = temp_result;
        temp_err_rate = Error_rate;
    end
end


end

