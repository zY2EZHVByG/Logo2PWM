function [res] = f_find_cp(img, code)
%

if code == 'k'
    res = f_find_black(img);
    % show binary image where the black pixels were
    %imshow(blackpixelsmask)
    if any(res(:))
        disp("black pixels in image found!")
    end
elseif code == 'w'
    res = f_find_white(img);
elseif code == 'r'
    res = f_find_red(img);
elseif code == 'g'
    res = f_find_green(img);
elseif code == 'b'
    res = f_find_blue(img);
elseif code == 'y'
    res = f_find_yellow(img);
elseif strcmp(code, 'rgby')
    res = f_find_rgby(img);
elseif strcmp(code, 'nkw')
    res = ~f_find_black(img) & ~f_find_white(img);
elseif strcmp(code, 'nrgbyw')
    res = ~f_find_rgby(img) & ~f_find_white(img);
end


end

function [res] = f_find_black(img)
rc = img(:,:,1); gc = img(:,:,2); bc = img(:,:,3);
% c: center
c = [0, 0, 0];
%r: radius
r = 80;
res = rc < c(1)+r & gc < c(2)+r & bc < c(3)+r;
end


function [res] = f_find_white(img)
rc = img(:,:,1); gc = img(:,:,2); bc = img(:,:,3);
% c: center
c = [255, 255, 255];
%r: radius
r = 100;
res = rc > c(1)-r & gc > c(2)-r & bc > c(3)-r;
end

function [res] = f_find_red(img)
rc = img(:,:,1); gc = img(:,:,2); bc = img(:,:,3);
% c: center
c = [200, 25, 32];
%r: radius
r = 50;
res = rc > c(1)-r & rc < c(1)+r ...
     &gc > c(2)-r & gc < c(2)+r ...
     &bc > c(3)-r & bc < c(3)+r;

end


function [res] = f_find_green(img)
rc = img(:,:,1); gc = img(:,:,2); bc = img(:,:,3);
% c: center
c = [57 , 178, 65];
%r: radius
r = 50;
res = rc > c(1)-r & rc < c(1)+r ...
     &gc > c(2)-r & gc < c(2)+r ...
     &bc > c(3)-r & bc < c(3)+r;

end


function [res] = f_find_blue(img)
rc = img(:,:,1); gc = img(:,:,2); bc = img(:,:,3);
% c: center
c = [43 , 60 , 147];
%r: radius
r = 50;
res = rc > c(1)-r & rc < c(1)+r ...
     &gc > c(2)-r & gc < c(2)+r ...
     &bc > c(3)-r & bc < c(3)+r;
end


function [res] = f_find_yellow(img)
rc = img(:,:,1); gc = img(:,:,2); bc = img(:,:,3);
% c: center
c = [240, 173, 10];
%r: radius
r = 50;
res = rc > c(1)-r & rc < c(1)+r ...
     &gc > c(2)-r & gc < c(2)+r ...
     &bc > c(3)-r & bc < c(3)+r;
end

function [res] = f_find_rgby(img)
res = f_find_red(img) | f_find_green(img) | ...
      f_find_blue(img)| f_find_yellow(img);
end