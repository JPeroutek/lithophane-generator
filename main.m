% Lithophane-generator
% main.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.
clc;
clear;
addpath('generators');
addpath('utils');

##%% Parameters
##% Specified parameters
##thickness_min = .2; % mm
##thickness_max = 3;  % mm
##
##% Calculated parameters
##thickness_delta = thickness_max - thickness_min; % mm

%% Image loading and processing
% Load the image
img_data = imread('IMG_5956.JPG');

% Convert to grayscale
grayscale_img = rgb2gray(img_data);

% Normalize to a value [0-1]
normalized_heightmap = im2double(grayscale_img)';

% Get a heightmap, with appropriate min/max thicknesses
%heightmap = norm_img * thickness_delta + thickness_min;

% Need to come up with a way to select the correct generator
x = rect_flat(normalized_heightmap);
create_stl_ascii('lithophane.stl', 'lith', x);