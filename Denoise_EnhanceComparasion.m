I = imread('Luna_Result_0.2_1000.tif');

subplot(2,3,1);
imshow(I);
title('Original');

I_2 = filter2(fspecial('average',2),I)/255;

subplot(2,3,2);
imshow(I_2);
title('Denoise_1');
I_2 = I_2.*255;
save('I_2.mat','I_2');

I_3 = ordfilt2(I,7,ones(3,4));

subplot(2,3,3);
imshow(I_3);
title('Denoise_2');
save('I_3.mat','I_3');

I_4 = imadjust(I,[0.3,0.7],[]);

subplot(2,3,4);
imshow(I_4);
title('Denoise&Enhance_Comparasion');

I_5 = imadjust(I_2./255,[0.3,0.7],[]);

subplot(2,3,5);
imshow(I_5);
title('Denoise&Enhance_Comparasion');

I_6 = imadjust(I_3,[0.3,0.7],[]);

subplot(2,3,6);
imshow(I_6);
title('Denoise&Enhance_Comparasion');
