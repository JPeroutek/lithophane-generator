% Lithophane-generator
% utils/create_stl_ascii.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.
function create_stl_ascii(file_name, solid_name, facets)
    if !isstruct(facets)
        error('`facets` must be a vector of structs.');
    endif
    if !ischar(solid_name)
        error('`solid_name` must be a string.');
    endif
    if !ischar(file_name)
        error('`file_name` must be a string.');
    endif
    
    fo = fopen(file_name, 'w');
    
    fputs(fo, sprintf('solid %s\n', solid_name));
    for i=1:numel(facets)
        fputs(fo, sprintf('    facet normal %e %e %e\n', facets(i).n)) ;
        fputs(fo, sprintf('        outer loop\n'));
        fputs(fo, sprintf('            vertex %e %e %e\n', facets(i).v(1,:)));
        fputs(fo, sprintf('            vertex %e %e %e\n', facets(i).v(2,:)));
        fputs(fo, sprintf('            vertex %e %e %e\n', facets(i).v(3,:)));
        fputs(fo, sprintf('        endloop\n'));
        fputs(fo, sprintf('    endfacet\n'));
    endfor
    fputs(fo, sprintf('endsolid %s\n', solid_name));
    
    % write the file contents
    
    fclose(fo);
endfunction