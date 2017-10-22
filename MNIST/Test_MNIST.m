clear
clc

%% Configure input data

load('mnist_all.mat');
% A0 = train0(1:1000,:)';
% A1 = train1(1:1000,:)';
% A2 = train2(1:1000,:)';
% A3 = train3(1:1000,:)';
% A4 = train4(1:1000,:)';
% A5 = train5(1:1000,:)';
% A6 = train6(1:1000,:)';
% A7 = train7(1:1000,:)';
% A8 = train8(1:1000,:)';
% A9 = train9(1:1000,:)';
% 
% A = [A0 A1 A2 A3 A4 A5 A6 A7 A8 A9];
% A = double(A);
% K = 10;
% index = [1000 1000 1000 1000 1000 1000 1000 1000 1000 1000];

y = train0(208,:)'; % label
y = double(y);


%% Load input data

load('Input_SRC.mat');
% load('Test_SRC_2.mat');

%% Undersample digital images

Gap = 2;
[~, num] = size(A);
for ii = 1 : num
    [ A_u(:,ii) ] = UnderSample( A(:,ii), Gap );
end
[ y_u ] = UnderSample(y, Gap);

%% Classification

[ label ] = SRC( A_u, y_u, K, index );
% [ label ] = SRC( A, y, K, index );

%% Output the results

disp('Label for y is: ');
disp(label-1);

