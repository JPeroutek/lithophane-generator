% Lithophane-generator
% utils/create_stl_ascii.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.
function create_stl_ascii(file_name, solid_name, facets)
    if ~isstruct(facets)
        error('`facets` must be a vector of structs.');
    end % if
    if ~ischar(solid_name)
        error('`solid_name` must be a string.');
    end % if
    if ~ischar(file_name)
        error('`file_name` must be a string.');
    end % if
    
    fo = fopen(file_name, 'w');
    
    fprintf(fo, 'solid %s\n', solid_name);
    for i=1:numel(facets)
        fprintf(fo, '    facet normal %e %e %e\n', facets(i).n) ;
        fprintf(fo, '        outer loop\n');
        fprintf(fo, '            vertex %e %e %e\n', facets(i).v(1,:));
        fprintf(fo, '            vertex %e %e %e\n', facets(i).v(2,:));
        fprintf(fo, '            vertex %e %e %e\n', facets(i).v(3,:));
        fprintf(fo, '        endloop\n');
        fprintf(fo, '    endfacet\n');
    end % for
    fprintf(fo, 'endsolid %s\n', solid_name);

    fclose(fo);
end % function
