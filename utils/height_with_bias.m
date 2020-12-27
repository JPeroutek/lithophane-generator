% Lithophane-generator
% utils/height_with_bias.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.
function height = height_with_bias(normalized_height, min_height, max_height)
    height = min_height + (normalized_height * (max_height - min_height));
endfunction