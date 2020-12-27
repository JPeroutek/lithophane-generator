% Lithophane-generator
% main.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.
clc;
clear;
addpath('generators');
addpath('utils');

%% Image loading and processing
% Load the image
img_data = imread('samples/Disney_Train_Photo.jpg');

% Convert to grayscale if necessary
if ndims(img_data) > 2
    img_data = rgb2gray(img_data);
endif

% Normalize to a value [0-1]
normalized_heightmap = fliplr(im2double(img_data)');

% Could possibly go ahead and convert the normalized heightmap to a biased map
%   See `utils/height_with_bias.m`

% Need to come up with a way to select the correct generator
x = rect_flat(normalized_heightmap);
create_stl_ascii('lithophane.stl', 'lith', x);