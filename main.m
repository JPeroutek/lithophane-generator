% Lithophane-generator
% main.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.
clc;
clear;

tic;

addpath('generators');
addpath('utils');

%% Image loading and processing
% Load the image
printf('Loading image...\n');
img_data = imread('samples/Disney_Train_Photo.jpg');

% Convert to grayscale if necessary
if ndims(img_data) > 2
    img_data = rgb2gray(img_data);
end % if

% Normalize to a value [0-1]
normalized_heightmap = fliplr(im2double(img_data)');

% Darker spots should be thicker, so we invert the heightmap
normalized_heightmap = 1 - normalized_heightmap;

% Could possibly go ahead and convert the normalized heightmap to a biased map
%   See `utils/height_with_bias.m`

printf('Estimating %d faces...\n', estimate_face_count(size(img_data)));
printf('Beginning mesh generation...\n');
% Need to come up with a way to select the correct generator
x = rect_flat(normalized_heightmap);
create_stl_binary('lithophane.stl', 'lith', x);
toc