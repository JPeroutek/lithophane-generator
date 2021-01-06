% Lithophane-generator
% utils/estimate_face_count_flat.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.

% Estimates the number of faces for a given image size
function face_count = estimate_face_count_flat(img_size)
    perimeter = sum(2 * (img_size - 1));
    area = (img_size(1) - 1) * (img_size(2) - 1);
    face_count = (3 * perimeter) + (2 * area);
end % function
