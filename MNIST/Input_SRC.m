clear
clc

A = zeros(100, 1000);
num = 80;
for ii = 1 : 100
    
    IDX = ceil(100*rand(1,num)); % May encounter same IDX entry...
    for jj = 1 : 10
        value = 255*rand(1,num);
        temp = sparse(IDX,ones(1,num),value,100,1);
        A( : , 10*(ii-1)+jj ) = temp;
    end
    if ii == 57 && jj == 10 % ii is y's class index.
        value = 255*rand(1,num);
        temp2 = sparse(IDX,ones(1,num),value,100,1);
        y = temp2;
        save('y.mat','temp');
    end
    
end
K = 100;
index = 10*ones(1,100);

[ label ] = SRC( A, y, K, index );

disp('Label for y is: ');
disp(label);
