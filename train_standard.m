clear all, close all

standard_height = 36;
standard_width = 36;
standard_num_in_height = zeros(10,standard_height);
standard_num_in_width = zeros(10,standard_width);

for p = 0:9
    img_filename = ['img/standard/',int2str(p),'.png'];
    img = imread(img_filename);
    img_binary = im2bw(img);
    img_binary = img_binary .* 255;
    [valid_num_in_height valid_num_in_width] = get_character_number(img_binary);
    valid_height = length(valid_num_in_height);
    valid_width = length(valid_num_in_width);
    
    ratio_height = int16(standard_height / valid_height);
    ratio_width = int16(standard_width / valid_width);
    
    for m = 1:valid_height
        standard_num_in_height(p+1, ratio_height * (m - 1) + 1 : ratio_height * m ) = valid_num_in_height(m);
    end
    
    for m = 1:valid_width
        standard_num_in_width(p+1, ratio_width * (m - 1) + 1 : ratio_width * m ) = valid_num_in_width(m);
    end
end

save 'standard' standard_num_in_height standard_num_in_width