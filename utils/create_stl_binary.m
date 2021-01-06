% Lithophane-generator
% utils/create_stl_binary.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.
function create_stl_binary(file_name, solid_name, facets)
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
    
    % Write the 80 byte header
    fwrite(fo, [solid_name blanks(80-length(solid_name))], 'uint8');
    % Write the facet count
    fwrite(fo, length(facets), 'uint32', 'l');
    for i=1:numel(facets)
        % Create a sequence of bytes.  Normal first, then the three vertices.
        facet_byte_sequence = [facets(i).n reshape(facets(i).v', 1, 9)];
        fwrite(fo, facet_byte_sequence, 'float32', 'l');
        % Write a 2-byte attribute.  (0 in this instance)
        fwrite(fo, 0, 'uint16', 'l');
    end % for

    fclose(fo);
end % function
