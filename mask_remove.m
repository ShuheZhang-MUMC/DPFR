function img = mask_remove(img_in,mask)
[~,~,m] = size(img_in);
img = img_in;
for k = 1:m
    img(:,:,k) = img_in(:,:,k) .* mask;
end

end