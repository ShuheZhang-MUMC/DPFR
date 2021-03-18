function [ radiance ] = correct_illumination( image, omega, win_size )


if ~exist('omega', 'var')
    omega = 0.95;
end

if ~exist('win_size', 'var')
    win_size = 15;
end

r = 15;
res = 0.001;

[m, n, ~] = size(image);

trans_est = get_transmission_estimate(image, [1,1,1], omega, win_size);
x = guided_filter(rgb2gray(image), trans_est, r, res);
transmission = reshape(x, m, n);

radiance = get_radiance(image, transmission);

end

function radiance = get_radiance(image, transmission)
max_transmission = repmat(max(transmission, 0.1), [1, 1, 3]);
radiance = ((image - 1) ./ max_transmission) + 1;
end
