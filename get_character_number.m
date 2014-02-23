function [valid_num_in_height valid_num_in_width] = get_character_number(img_binary)     
    [img_width img_height] = size(img_binary);
    valid_num_in_width = zeros(img_width,1);
    valid_num_in_height = zeros(img_height,1);    
    % calculate valid number in x axis
    for m = 1:img_height
        valid_num_in_height(m) = sum(img_binary(m,:) == 255);
    end
    valid_num_in_height = trunc_number(valid_num_in_height);
    
    % calcualte valid number in y axis
    for n = 1:img_width
        valid_num_in_width(n) = sum(img_binary(:,n) == 255);
    end

    trunc_number(valid_num_in_width);
    valid_num_in_width = trunc_number(valid_num_in_width);
end