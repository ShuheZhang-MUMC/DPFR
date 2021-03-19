% demostration for double-pass fundus reflection model.


clc
clear
addpath('func')
this_path = '';
raw_img = imread([this_path,'degrade_img.png']);
raw_img = double(raw_img)/255;
mask = raw_img(:,:,1) > 0;

a_ = 0.95; % alpha
b_ = 0.55; % beta
w_ = 7;    % window size



%% step 1: illumination correction
img_illu_corr = 1 - correct_illumination(1 - raw_img, a_, w_ );      

%% step 2: dehazing
img_haze_corr =     correct_scattering(img_illu_corr, b_, w_ );             

%% step 3: contrast stretch (CLAHE in L channel)
img_fin_lab = rgb2lab(img_haze_corr);
img_fin_lab(:,:,1) = adapthisteq(img_fin_lab(:,:,1)/100)*100;               
img_fin_rgb = lab2rgb(img_fin_lab);

img_fin_rgb = mask_remove(img_fin_rgb,mask);

figure(1);imshow(raw_img);title('raw image');
figure(2);imshow(img_illu_corr);title('illumination correction');
figure(3);imshow(img_haze_corr);title('dehazed');
figure(4);imshow(img_fin_rgb);title('final');


%imwrite(img_fin_rgb,[this_path,'img_out_dpfr.tif'])




