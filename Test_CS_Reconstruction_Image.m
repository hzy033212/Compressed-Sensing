clear
clc

%% The following are some parameters of this script, and they can be changed according to the results.
alfa = 0.2; % #Real sample dimension/#Real dimension. 
max_alg = 60000; % Number of results reconstruct algorithm get from different initilization of NMF.
maxiter = 30; % Number of iterations for NMF.
option = 1; % See next part.
Add_number = 1; % Add how many reconstruct results to get ultimate results.
% beta = 0.5; % Threadhold of zero elements.

%% There are TWO mode for this test script, option == 1 leads to artificial image mode, and option == 2 leads to Luna(real gray image) mode.
if option == 1
   Test_1 = [
        0 0 0 0 0
        0 0 0 0 0
        0 1 1 1 0
        0 0 0 0 0
        0 0 0 0 0
    ];
    Test_2 = [ 
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 1 0 0 0 0 0
        0 0 0 1 1 1 0 0 0 0
        0 0 0 0 1 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        ];
    Test_2 = 255.*Test_2;
    Test_1 = 255.*Test_1;
    imwrite( uint8(Test_1),'image_1.tif','tif' );
    I1 = imread('image_1.tif');
%     imshow(I1);
    imwrite( uint8(Test_2),'image_2.tif','tif' );
    I2 = imread('image_2.tif');
%     imshow(I2);

    % [m,n] = size(Test_2);
    [m,n] = size(Test_1);
    Mode_Length = m*n;
    Mode_Num = ceil(alfa*Mode_Length);
    tempMode = rand(Mode_Length, Mode_Length);
    tempMode = (orth(tempMode))';
    Mode = tempMode(1:Mode_Num,:);
    Mode = abs(Mode);
    
%     load('MeasureMatrix.mat');
%     Mode = MeasureMatrix;
    
    % Best_Result = reshape(Test_2,Mode_Length,1);
    Best_Result = reshape(Test_1,Mode_Length,1);
    
    %% Construct input Y through Mode and Best_Result
    Y = Mode*Best_Result;

    %% Reconstruction process
    jj = -1; % -1 means that jj here does not mean anything.
    Add_Result = zeros(length(Best_Result),1);
    for ii = 1 : Add_number
        [ Temp_Result, errRate ] = CS_Reconstruction_Image( Mode, Y, max_alg, maxiter, jj, jj, ii, Best_Result );
        Add_result = Add_Result + Temp_Result;
    end
    % Result = Add_result/Add_number;
    Result = (Add_result/max(Add_result))*255;
    Image_result = reshape(Result,m,n);
    
%     for ii = 1 : 25
%         if abs(Result(ii)) < beta*(max(max(abs(Result))))
%             Result(ii) = 0;
%         end
%     end

    %% Show and save raw result
    % subplot(1,2,1), subimage(I1)
    % subplot(1,2,2), subimage(uint8(Image_result))
    imshow(uint8(Image_result));

    imwrite(uint8(Image_result), 'Image_result_Plus.tif','tif');
    save('Image_result_Plus.mat','Image_result');
    
    disp('errRate = ');
    disp(abs(errRate));
    
end

if option == 2

    block = 51;
    %   Get original luna gray image
    Luna_rgb = imread('luna_rgb.jpg');
    Luna = rgb2gray(Luna_rgb);
    Luna = Luna(1:block-1,1:block-1);
    Luna = double(Luna);
    save('Current_Luna.mat','Luna');
    %   Construct mask mode
    Mode_dimension = 5;
    Mode_Length = Mode_dimension*Mode_dimension;
    Mode_Num = ceil(alfa*Mode_Length);
    tempMode = rand(Mode_Length, Mode_Length);
    tempMode = (orth(tempMode))';
    Mode = abs(tempMode(1:Mode_Num,:));
    
%     load('MeasureMatrix.mat');
%     Mode = MeasureMatrix;
    
    %   Reconstruct process (NMF)
    temp = zeros(block-1,block-1);
    final = block - Mode_dimension;
    for kk = 1 : Add_number
        Image_Result = zeros(block-1,block-1);
        for ii = 1 : Mode_dimension : final
            for jj = 1 : Mode_dimension : final
                Best_Result = reshape(Luna(ii:ii+Mode_dimension-1,jj:jj+Mode_dimension-1),Mode_Length,1);
                Y = Mode*Best_Result;
                [ Result, ~ ] = CS_Reconstruction_Image( Mode, Y, max_alg, maxiter, ii, jj, kk, Best_Result );
                Image_Result(ii:ii+Mode_dimension-1,jj:jj+Mode_dimension-1) = reshape(Result,Mode_dimension,Mode_dimension);
            end
        end
        temp = temp + Image_Result;
    end


    Image = (temp/max(max(temp)))*255;
    
    %% Calculate PSNR
    [m, n] = size(Luna);
    Original = reshape(Luna,1,m*n);
    Reconstructed = reshape(Image,1,m*n);
    r = PSNR(Original, Reconstructed);
    disp('PSNR between original and reconstructed is: ');
    disp(r);
    
    
    %% Show image
    imshow(uint8(Image));
    imwrite( uint8(Image),'Luna_Result.tif','tif' );

end

