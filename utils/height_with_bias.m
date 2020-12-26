function height = height_with_bias(normalized_height, min_height, max_height)
    height = min_height + (normalized_height * (max_height - min_height));
endfunction