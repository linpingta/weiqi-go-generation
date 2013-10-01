function [valid_num_in_height valid_num_in_width] = get_character_number(img_binary,INTERVAL)
    [img_height img_width] = size(img_binary);
    is_white = size(find(img_binary == 0)) < 0.5 * img_height * img_width;
    if is_white == true
        valid_num_grey = 0;
    else 
        valid_num_grey = 255;
    end        
    valid_num_in_width = zeros(img_width,1);
    valid_num_in_height = zeros(img_height,1);    
    % calculate valid number in x axis
    for m = 1:img_height
        valid_num_in_height(m) = sum(img_binary(m,:) == valid_num_grey);
    end
    valid_num_in_height = normalize_number(trunc_number(valid_num_in_height),INTERVAL);

    % calcualte valid number in y axis
    for n = 1:img_width
        valid_num_in_width(n) = sum(img_binary(:,n) == valid_num_grey);
    end

    trunc_number(valid_num_in_width)
    valid_num_in_width = normalize_number(trunc_number(valid_num_in_width),INTERVAL);
end