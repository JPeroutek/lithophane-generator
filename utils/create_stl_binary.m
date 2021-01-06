% Lithophane-generator
% utils/create_stl_binary.m
% 
% © Jacob Peroutek, 2020
% All rights reserved.

% Binary STL Format
% | Byte Range | Data Type | Usage     | Notes                         | 
% ----------------------------------------------------------------------
% | 0 - 80     | ASCII     | Header    | Should not begin with 'solid' |
% ----------------------------------------------------------------------
% | 80 - 84    | uint32    | Face Count| Little Endian                 |
% ----------------------------------------------------------------------
% 
% After the header section, the following section repeats for each face:
% | Byte Length | Data Type | Usage      | Notes                         | 
% ------------------------------------------------------------------------
% | 4           | float     | normal i   | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | normal j   | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | normal k   | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | vertex 1 x | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | vertex 1 y | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | vertex 1 z | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | vertex 2 x | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | vertex 2 y | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | vertex 2 z | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | vertex 3 x | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | vertex 3 y | little endian                 |
% ------------------------------------------------------------------------
% | 4           | float     | vertex 3 z | little endian                 |
% ------------------------------------------------------------------------
% | 2           | int       | attribute  | leave zero for now            |
% ------------------------------------------------------------------------
%
% This adds up to 50 bytes/face.

function create_stl_binary(file_name, solid_name, facets)
    if ~isstruct(facets)
        error('`facets` must be a vector of structs.');
    end % if
    if ~ischar(solid_name)
        error('`solid_name` must be a string.');
    end % if
    if length(solid_name) > 80
        error('`solid_name` must be 80 characters or less.');
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
