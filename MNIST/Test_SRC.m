clear
clc

load('Test_src.mat');

% NOTE that all a,b,c and d can be changed to ANY POSITIVE real number!

% Try to uncomment ONE line range in [14,21], the label is in the
% respective comment region of that line. The ultimate result will be
% shown in command window of Matlab.

a = 10;
b = 20;
c = 30;
d = 40;

% y = [a b 0 0]'; % Label == 1
% y = [a 0 b 0]'; % Label == 2
% y = [a 0 0 b]'; % Label == 3
% y = [0 a b 0]'; % Label == 4
% y = [0 a 0 b]'; % Label == 5
y = [0 0 a b]'; % Label == 6
% y = [a b c d]'; % Outlier Sample 1
% y = [a b c 0]'; % Outlier Sample 2

[ label ] = SRC( A, y, K, index );

%% Output the results

disp('Label for y is: ');
disp(label);