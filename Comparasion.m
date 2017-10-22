clc
clear

%% Load data
load('Current_Luna.mat');
Image = imread('Luna_Result_0.2_1000.tif');
load('I_3.mat');
load('I_2.mat');

%% Calculate PSNR
    
[m, n] = size(Luna);
Original = reshape(Luna,1,m*n);
Image = double(Image);
Reconstructed = reshape(Image,1,m*n);
% Reconstructed = reshape(I_2,1,m*n);
% Reconstructed = reshape(double(I_3),1,m*n);
r = PSNR(Original, Reconstructed);
disp('PSNR between original and reconstructed is: ');
disp(r);