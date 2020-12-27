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
    backplane_centerpoint = [floor(m/2) floor(n/2) 0];
    for i = 1:m-1
        for j = 1:n-1
            % On all of the following triangle constructions, the order of the 
            %  vertices matters.
            
            % Create the lithophane from the heightmap
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
                         i   j+1 height_with_bias(heightmap(i, j+1), min_thickness, max_thickness);   ...
                         i+1 j+1 height_with_bias(heightmap(i+1, j+1), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            endif
            
            % Create the LR edges and back plane
            if (i == 1) || (i == m-1) % Check if we are on the L/R edge
                % Create the two edge facets
                verts = [i j   height_with_bias(heightmap(i, j), min_thickness, max_thickness);       ...
                         i j   0; ...
                         i j+1 0];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                % The right edge needs to have the normal facing the other way
                if (i == m-1)
                    verts = flipud(verts);
                endif
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                verts = [i j   height_with_bias(heightmap(i, j), min_thickness, max_thickness);       ...
                         i j+1 0;                                                                      ...
                         i j+1 height_with_bias(heightmap(i, j+1), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                % The right edge needs to have the normal facing the other way
                if (i == m-1)
                    verts = flipud(verts);
                endif
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                % Add a back plane face
                verts = [i j+1 0;   ...
                         i j   0;   ...
                         backplane_centerpoint];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                % The faces touching the right edge need to have the normal 
                %   facing the other way.
                if (i == m-1)
                    verts = flipud(verts);
                endif
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            endif
            
            % Create the TB edges and back plane
            if (j == 1) || (j == n-1) % Check if we are on the T/B edge
                % Create the two edge facets
                verts = [i   j height_with_bias(heightmap(i, j), min_thickness, max_thickness);       ...
                         i   j 0; ...
                         i+1 j 0];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                % The right edge needs to have the normal facing the other way
                if (j == 1)
                    verts = flipud(verts);
                endif
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                verts = [i   j   height_with_bias(heightmap(i, j), min_thickness, max_thickness);       ...
                         i+1 j 0;                                                                      ...
                         i+1 j height_with_bias(heightmap(i+1, j), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                % The right edge needs to have the normal facing the other way
                if (j == 1)
                    verts = flipud(verts);
                endif
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                % Add a back plane face
                verts = [i+1 j 0;   ...
                         i j 0;   ...
                         backplane_centerpoint];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                % The faces touching the right edge need to have the normal 
                %   facing the other way.
                if (j == 1)
                    verts = flipud(verts);
                endif
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            endif
        endfor
    endfor
    
    printf('Face count: %d\n', length(facets));
endfunction
