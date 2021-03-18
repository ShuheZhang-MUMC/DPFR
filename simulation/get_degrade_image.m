clc
clear

img = double(imread('lena_round.png'))/255;
mask = img(:,:,2) > 0; %black mask


[m,n,~] = size(img);
x = linspace(-1,1,n);
y = linspace(-1,1,m)*(m/n);
[x,y] = meshgrid(x,y);

%{
    we use the combination of Gaussian pattern to simulate the 
    uneven illumination and transmission
%}
illumi = 0.7 * exp(-(x.^2+y.^2)/0.8^2);           % illumintion matrix
Transm = 0.5 * exp(-(x.^2+(1.5*y).^2)/1.2^2);     % transmission matrix

imwrite(illumi,'ill_img.png')
imwrite(Transm,'Tra_img.png')

img_fin = zeros(m,n,3);

% double-pass fundus imaging formation
img_fin(:,:,1) = illumi .* (Transm.^2 .* img(:,:,1) + 1 - Transm).*mask; 
img_fin(:,:,2) = illumi .* (Transm.^2 .* img(:,:,2) + 1 - Transm).*mask;
img_fin(:,:,3) = illumi .* (Transm.^2 .* img(:,:,3) + 1 - Transm).*mask;

imwrite(img_fin,'fin_img.png')

