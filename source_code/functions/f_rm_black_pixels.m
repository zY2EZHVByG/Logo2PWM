function [B] = f_rm_black_pixels(A)
% 
B=A;
ix = A(:,:,1)==0&A(:,:,2)==0&A(:,:,3)==0;
for i=1:3
    tmp = A(:,:,i);
    tmp(ix)=255;
    B(:,:,i) = tmp;
end


end

