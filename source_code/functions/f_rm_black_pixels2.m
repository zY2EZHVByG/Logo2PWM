function [B] = f_rm_black_pixels2(A)
% 
B=A;

ix = f_find_cp(A, 'k');

for i=1:3
    tmp = A(:,:,i);
    tmp(ix)=255;
    B(:,:,i) = tmp;
end


end

