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
for m = 0 : unit
    qizi_center_x_vec = [qizi_center_x_vec (m * qizi_size_x + zero_point_x)];
    qizi_center_y_vec = [qizi_center_y_vec (m * qizi_size_y + zero_point_y)];
end

% type = 0 means no qizi, type = 1 means black, type = 2 means white
type_qipan = zeros(1 + unit,1 + unit);

for x = 10 : 10
    for y = 6 : 6
        % locate qizi position
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
    
        % extract sub qizi in the location
        sub_image = img(left+1:right,top+1:bottom,:);   
        %imwrite(sub_image,['img/qizi_', int2str(x), '_', int2str(y), '.jpg']);
        
        % distinguish white/black/no qizi
        [sub_width sub_height sub_color] = size(sub_image);
        sub_image_full_or_not = zeros(sub_width,sub_height,3);
        count_full_or_not = 0;
        count_black_or_white = 0;
        for m = 1 : sub_width
            for n = 1 : sub_height
                %flag = 0;
                avg = mean(sub_image(m,n,:));
                if avg > 127
                    %flag = 1;
                    count_black_or_white = count_black_or_white + 1;
                end                
                for k = 1 : 3
                    if abs(avg - sub_image(m,n,k)) > 10
                        %flag = 1;
                        count_full_or_not = count_full_or_not + 1;
                        break;
                    end     
                end
%                 if flag == 1
%                     sub_image_full_or_not(m,n,1) = 255;
%                     sub_image_full_or_not(m,n,2) = 255;
%                     sub_image_full_or_not(m,n,3) = 255;
%                 end
            end
        end
        
        if count_full_or_not > 0.5 * sub_width * sub_height
            type_qipan(x,y) = 0;
        else
            if count_black_or_white < 0.5 * sub_width * sub_height
                type_qipan(x,y) = 1;
            else
                type_qipan(x,y) = 2;
            end
        end
        
        figure;
        imshow(sub_image);  
                
        type_qipan(x,y)
        if type_qipan(x,y) > 0
            sub_image_grey = rgb2gray(sub_image);
            %sub_image_grey_s = medfilt2(sub_image_grey, [3 3]);
            sub_image_binary = im2bw(sub_image_grey);            
        
            figure;
            imshow(sub_image_binary);
            
            [L num] = bwlabel(sub_image_binary);
            S = regionprops(L,'Area');
        end       
        
%         figure;
%         imshow(sub_image_full_or_not);
        
    end
end
        