clear all, close all

img_filename = 'img/qipu_test.jpg';
img = imread(img_filename);

figure;
imshow(img);

[width height] = size(img);

% img_hsv = rgb2hsv(img);
% img_h = img_hsv(:,:,1);
% 
% figure;
% imshow(img_h);
% 
% img_h = medfilt2(img_h,[3 3]);
% 
% level = graythresh(img_h);
% img_bw = im2bw(img_h,level);
% 
% figure;
% imshow(img_bw);

% image position
zero_point_x = 13;
zero_point_y = 18;
panel_x = 668;
panel_y = 683;
unit = 18;
qizi_size_x = floor(panel_x / unit);
qizi_size_y = floor(panel_y / unit);

qizi_center_x_vec = [];
qizi_center_y_vec = [];
for m = 1 : (unit + 1)
    qizi_center_x_vec = [qizi_center_x_vec (m * qizi_size_x + zero_point_x)];
    qizi_center_y_vec = [qizi_center_y_vec (m * qizi_size_y + zero_point_y)];
end

sub_image = zeros((unit + 1)*(unit + 1),qizi_size_x,qizi_size_y);
for x = 1 : (0 + 1)
    for y = 1 : (0 + 1)
        x,y
        c_x = qizi_center_x_vec(x);
        c_y = qizi_center_x_vec(y);
        left = c_x - floor(qizi_size_x / 2);
        if left < 0
            left = 0;
        end
        right = c_x + floor(qizi_size_x / 2);
        if right > width - 1
            right = width - 1;
        end
        top = c_y - floor(qizi_size_y / 2);
        if top < 0
            top = 0;
        end
        bottom = c_y + floor(qizi_size_y / 2);
        if bottom > height - 1
            bottom = height - 1;
        end        
        index = (x - 1) * (unit + 1) + y;
        for m = left : right
            for n = top : bottom
                sub_image(index,:,:) = img(m,n);
            end
        end        
    end
end

figure;
imshow(sub_image(1));
        