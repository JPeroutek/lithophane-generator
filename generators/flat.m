% Lithophane-generator
% generators/flat.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.
function facets = flat(heightmap, varargin)
    % handle the optional arguments
    n_varargs = length(varargin);
    if n_varargs > 3
        error('generators/rect_flat: Too many arguments provided.');
    end
    % The default values
    opt_args = {.2 3 8};
    opt_args(1:n_varargs) = varargin;
    % Place the values into named variables
    [min_thickness, max_thickness, pixel_density] = opt_args{:};
    % mm             mm             px/mm
    
    if ndims(heightmap) ~= 2
       error('heightmap should be a 2-dimensional vector of normalized heights'); 
    end % if
    
    facets = struct('n', {}, 'v', {});
    [m,n] = size(heightmap);
    backplane_centerpoint = [floor(m/2) floor(n/2) 0];
    for i = 1:m-1
        for j = 1:n-1
            % On all of the following triangle constructions, the order of the 
            %  vertices matters.
            
            % Create the lithophane from the heightmap
            if mod(i + j, 2) == 0
                verts = [i+1 j+1 height_with_bias(heightmap(i+1, j+1), min_thickness, max_thickness); ...
                         i   j+1 height_with_bias(heightmap(i, j+1), min_thickness, max_thickness);   ...
                         i   j   height_with_bias(heightmap(i, j), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                verts = [i+1 j+1 height_with_bias(heightmap(i+1, j+1), min_thickness, max_thickness); ...
                         i   j   height_with_bias(heightmap(i, j), min_thickness, max_thickness);     ...
                         i+1 j   height_with_bias(heightmap(i+1, j), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            else
                verts = [i+1 j   height_with_bias(heightmap(i+1, j), min_thickness, max_thickness);   ...
                         i   j+1 height_with_bias(heightmap(i, j+1), min_thickness, max_thickness);   ...
                         i   j   height_with_bias(heightmap(i, j), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                verts = [i+1 j+1 height_with_bias(heightmap(i+1, j+1), min_thickness, max_thickness); ...
                         i   j+1 height_with_bias(heightmap(i, j+1), min_thickness, max_thickness);   ...
                         i+1 j   height_with_bias(heightmap(i+1, j), min_thickness, max_thickness)];
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            end % if
            
            % Create the Left edges and back plane
            if (i == 1)  % Check if we are on the Left edge                
                % Create the two edge facets
                verts = [i j   height_with_bias(heightmap(i, j), min_thickness, max_thickness);       ...
                         i j   0; ...
                         i j+1 0];
                         
                % The left edge needs to have the normal facing the other way
                verts = flipud(verts);
                         
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                %%%%%%%%%%%%%%%%
                
                verts = [i j   height_with_bias(heightmap(i, j), min_thickness, max_thickness);       ...
                         i j+1 0;                                                                      ...
                         i j+1 height_with_bias(heightmap(i, j+1), min_thickness, max_thickness)];
                
                % The left edge needs to have the normal facing the other way
                verts = flipud(verts);
                
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                %%%%%%%%%%%%%%%%
                
                % Add a back plane face
                verts = [i j+1 0;   ...
                         i j   0;   ...
                         backplane_centerpoint];
                
                % The left edge needs to have the normal facing the other way
                verts = flipud(verts);
                
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            end % if
            
            % Create the Right edge and back plane
            if (i == m-1) % Check if we are on the Right edge                
                % Create the two edge facets
                verts = [m j   height_with_bias(heightmap(m, j), min_thickness, max_thickness);       ...
                         m j   0; ...
                         m j+1 0];
                
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                %%%%%%%%%%%%%%%%
                
                verts = [m j   height_with_bias(heightmap(m, j), min_thickness, max_thickness);       ...
                         m j+1 0;                                                                      ...
                         m j+1 height_with_bias(heightmap(m, j+1), min_thickness, max_thickness)];
                
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                %%%%%%%%%%%%%%%%
                
                % Add a back plane face
                verts = [m j+1 0;   ...
                         m j   0;   ...
                         backplane_centerpoint];

                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            end % if
            
            % Create the Bottom edges and back plane
            if (j == 1) % Check if we are on the Bottom edge
                % Create the two edge facets
                verts = [i   j height_with_bias(heightmap(i, j), min_thickness, max_thickness);       ...
                         i   j 0;                                                                     ...
                         i+1 j 0];
             
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                %%%%%%%%%%%%%%%%
                
                verts = [i   j height_with_bias(heightmap(i, j), min_thickness, max_thickness);       ...
                         i+1 j 0;                                                                     ...
                         i+1 j height_with_bias(heightmap(i+1, j), min_thickness, max_thickness)];
                
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                %%%%%%%%%%%%%%%%
                
                % Add a back plane face
                verts = [i+1 j 0;   ...
                         i   j 0;   ...
                         backplane_centerpoint];
                
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            end % if
            
            % Create the Top edges and back plane
            if (j == n-1) % Check if we are on the Top edge
                % Create the two edge facets
                verts = [i   n height_with_bias(heightmap(i, n), min_thickness, max_thickness);       ...
                         i   n 0;                                                                     ...
                         i+1 n 0];
                
                % The Top edge needs to have the normal facing the other way
                verts = flipud(verts);
                
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                %%%%%%%%%%%%%%%%
                
                verts = [i   n height_with_bias(heightmap(i, n), min_thickness, max_thickness);       ...
                         i+1 n 0;                                                                     ...
                         i+1 n height_with_bias(heightmap(i+1, n), min_thickness, max_thickness)];
                
                % The Top edge needs to have the normal facing the other way
                verts = flipud(verts);
                
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
                
                %%%%%%%%%%%%%%%%
                
                % Add a back plane face
                verts = [i+1 n 0;   ...
                         i   n 0;   ...
                         backplane_centerpoint];
                         
                % The Top edge needs to have the normal facing the other way
                verts = flipud(verts);
                
                verts(:,1:2) = verts(:,1:2) / pixel_density;
                norm = facet_norm(verts);
                facets(end+1) = struct('n', norm, 'v', verts);
            end % if
        end % for
    end % for
    
    fprintf('Face count: %d\n', length(facets));
end % function
