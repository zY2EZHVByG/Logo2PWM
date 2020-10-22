function [letter,startp,endp,letterImg,restImg]=f_colImg_to_letter(colImg)


% convert to a line image
%figure, imagesc(f_find_cp(colImg, 'w'))
% figure, imshow(colImg);
whites = f_find_cp(colImg, 'w');
for i=1:size(colImg, 1)
    i,
    r = colImg(i, :, :);
    not_whites = r(1, ~whites(i,:), :);
    if size(not_whites,2) > 0 && sum(whites(i, :)) > 0
        m = median(not_whites, 2);
        r(1, whites(i,:), :) = repmat(reshape(m, [1,1,length(m)]),[1 sum(whites(i,:)) 1]);
        colImg(i, :, :) = r;
    end
end
% figure, imshow(colImg);
%tmp1 = min( colImg, [], 2 );
colImg_p = double(colImg);
whites = f_find_cp(colImg_p, 'w');
for i=1:3
    tmp = colImg_p(:, :, i);
    tmp(whites) = nan;
    colImg_p(:, :, i) = tmp;
end
%colImg_p(whites, :) = nan;
tmp1 = nanmedian( colImg, 2 );
% figure, imshow(tmp1);

% for a sub image, give every element a cluster code (color code)
codes = zeros(length(tmp1), 1);
for i=1:length(tmp1)
    codes(i) = f_determin_color( double(reshape(tmp1(i,1, :), [1,3]) ) );
end


% find the start and end points for the biggest letter (the biggest cluster)
startp = length(tmp1);
endp=startp;
% old_code = 5;
curr_code = 5; % start from white
ct = 0;
edge_secure = 2;


% 
for i=2:length(tmp1)
    if codes(i)==5
        
    elseif codes(i)~=5
        ct = ct +1;
        if ct==edge_secure
            curr_code = codes(i);
            startp = i-edge_secure+1;
            break
        end
    end
end


ct = 0;
%startp,
% find the end point
%for i=startp+4:length(tmp1)
if startp ~= 0
    
for i=startp:length(tmp1)
    if codes(i) ~= curr_code
        ct = ct +1;
        if ct==edge_secure
            endp = i-edge_secure+1;
            break;
        end
    end
end
%codes,
%startp, endp,

letterImg = colImg(startp:endp, :,:);
restImg = colImg(endp:end, :,:); % rest of image

if curr_code == 1
    letter = 'T';
elseif curr_code == 2
    letter = 'A';
elseif curr_code == 3
    letter = 'C';
elseif curr_code == 4
    letter = 'G';
else
    letter = '!';
end

% if ix == 3
%     startp,endp,
% end

end
