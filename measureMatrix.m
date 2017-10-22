clear
clc

MeasureMatrix = zeros(5,25);
fiveOne = ones(1,5);
for ii = 1 : 5
        for jj = ii : ii+1
            MeasureMatrix(ii,5*(ii-1)+1:5*ii) = fiveOne;
        end
end
MeasureMatrix(1,21:25) = fiveOne;
MeasureMatrix = MeasureMatrix(1:5,:);

Index = randperm(5);
MeasureMatrix = MeasureMatrix(Index,:);

save('MeasureMatrix.mat','MeasureMatrix');