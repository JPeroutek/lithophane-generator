% Lithophane-generator
% utils/facet_norm.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.
function unit_normal = facet_norm(points)
    % Create 2 vectors, take cross-product, then reduce to unit.
    AB = points(2,:) - points(1,:);
    AC = points(3,:) - points(1,:);
    normal_vector = cross(AB,AC);
    unit_normal = normal_vector / norm(normal_vector);
end % function