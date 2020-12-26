% Lithophane-generator
% generators/rect_flat.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.

function facets = rect_flat(heightmap, 
                            border=false,     % Should there be a full thickness border?
                            border_width=5,   % mm
                            min_thickness=.2, % mm
                            max_thickness=3,  % mm
                            pixel_density=8)  % px/mm
    if ndims(heightmap) != 2
       error('heightmap should be a 2-dimensional vector of normalized heights'); 
    endif
    facets = struct('n', {}, 'v', {});
    [m,n] = size(heightmap);
    for i = 1:m-1
        for j = 1:n-1
            % On all of the following triangle constructions, the order of the 
            %  vertices matters.
            if mod(i + j, 2) == 0
                verts = [i   j   height_with_bias(heightmap(i, j), min_thickness, max_thickness);     ...
                         i   j+1 height_with_bias(heightmap(i, j+1), min_thickness, max_thickness);   ...
                         i+1 j+1 height_with_bias(heightmap(i+1, j+1), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                verts = [i+1 j   height_with_bias(heightmap(i+1, j), min_thickness, max_thickness);   ...
                         i   j   height_with_bias(heightmap(i, j), min_thickness, max_thickness);     ...
                         i+1 j+1 height_with_bias(heightmap(i+1, j+1), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            else
                verts = [i   j   height_with_bias(heightmap(i, j), min_thickness, max_thickness);     ...
                         i   j+1 height_with_bias(heightmap(i, j+1), min_thickness, max_thickness);   ...
                         i+1 j   height_with_bias(heightmap(i+1, j), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                verts = [i+1 j   height_with_bias(heightmap(i+1, j), min_thickness, max_thickness);   ...
                         i   j+1 height_with_bias(heightmap(i, j+1), min_thickness, max_thickness);     ...
                         i+1 j+1 height_with_bias(heightmap(i+1, j+1), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            endif
        endfor
    endfor
    % Create back plane, and add to facets
    % Create edges, and add to facets
    printf('Face count: %d\n', length(facets));
endfunction