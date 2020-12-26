function unit_normal = facet_norm(points)
    % Create 2 vectors, take cross-product, then reduce to unit.
    AB = points(2,:) - points(1,:);
    AC = points(3,:) - points(1,:);
    normal_vector = cross(AB,AC);
    unit_normal = normal_vector / norm(normal_vector);
endfunction