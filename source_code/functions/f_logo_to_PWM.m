function [PWM, consensus] = f_logo_to_PWM(img_name, cnt)
% convert a image format motif logo to PWM
% cnt: number of letters of the logo.
if nargin < 2
    cnt = 0;
end

PWM=[];consensus='';

img_name = char(img_name);
% if the image is gif file, convert it to png first.
if strcmp(img_name(end-2:end), 'gif')
    [A, map] = imread(img_name);
    if ~isempty(A), A = ind2rgb(A, map); end
    %imshow(A);
    img_name = [img_name(1:end-3), '.png'];
    
    imwrite(A, img_name);
    
end

[A,map2,~] = imread(img_name);
% I is the grey scale image
%figure,imshow(A);
if ~isempty(map2)
    A = ind2rgb(A, map2);
end
if max(A(:)) == 1
    A = A.*255;
end

% ------------------ find the colorful pixels ------------------
ix = f_find_cp(A, 'rgby');
[x1, x2, y1, y2] = f_cut_margin(ix);
% pre-cut the images to the colorful logo area
A = A(y1:y2, x1:x2, :);
% ---------------- remove unuseable black pixels ----------------
A = f_rm_black_pixels2(A);


I = rgb2gray(A);
% figure,imshow(I);


% convert to black and white image
% --------------------------------------------
% level = graythresh(A);
% level = level + 0.25;
% if level >1
%     level = 0.9;
% end
level = 0.8;
% --------------------------------------------
bw = im2bw(A,level);
%figure,imshow(bw)

% determine if the logo has coordinates, if yes, use the old code, if
%  no coordinates, use the revised code. 
B = f_img_keepBlk(A);
%figure, imagesc(B);




[hasY, hasX] = f_if_have_XY_axis(B);

% cut the image, get only the true logo area 
[x1, x2, y1, y2,below_x_sum, below_x] = ...
    f_determine_true_logo_edge(bw, B, hasX, hasY, I);
% ----------------------- added on 20160201 -----------------------------
% if the image is too short that not even a single character can be seen,
%  then quit.
if x2-x1<=6
    % do nothing just quit
else
% -----------------------------------------------------------------------
    % from the true logo area, get the column count
    %  len_lt: width of letter; cnt: count of letters.
    if cnt == 0 % let the program determine the number of letters
        [len_lt, cnt]=f_width_each_letter(x1,x2,y1,y2,hasX,hasY,bw, ...
            below_x_sum, below_x, I);
    else
        % specifiy the number of letters by user
        len_lt = round(abs(x2-x1) ./ cnt);
    end

    % find the start and end nodes for each letter image
    nodes_x = zeros(cnt + 1, 1);
    nodes_x(1) = 1;
    for i=1:cnt
        nodes_x(i+1) = ceil(len_lt .* i);
    end
    nodes_x(end) = x2-x1;

    % the pure logo area
    I_sub = I(y1:y2, x1:x2);
    A_sub = A(y1:y2, x1:x2, :);
    PWM = zeros(4, cnt);
    %figure, imshow(A_sub);

    % information content for each position
    Is = zeros(1, cnt);
    I_main_s = zeros(1, cnt);
    consensus = repmat(' ', [1, cnt]);
    %for i=1:cnt

    %A_sub = f_rm_black_pixels(A_sub);
%     figure, imshow(A_sub);

    % --------------------------------------
%      figure,
    % --------------------------------------
    for i=1:cnt
        colImg = A_sub(:, nodes_x(i):nodes_x(i+1), : );
        %figure, imshow(colImg);
        %size(colImg),
        % --------------------------------------
%          subplot(1,cnt,i), imshow(colImg);
        % --------------------------------------
        %i,
        %size(colImg),
        colImg = f_rm_black_pixels2(colImg);
        [letter, I, I_main, pwm, letterImg] = f_colImg_to_letterImg(colImg, i);
        %subplot(1,cnt,i),imshow(letterImg);
        consensus(i) = letter;
        Is(i) = I;
        I_main_s(i) = I_main;
        PWM(:, i) = pwm;

    end
    %consensus,
    %Is,
    %PWM, 
    %sum(PWM),


end % from 'if image is too narrow'
PWM = f_normpwm(PWM);
% pwd,
% which f_logo_to_PWM
end


