function [B] = f_img_keepBlk(A)
% 
% B=repmat(255, size(A));
ct = 30;

% for channel = 1:3
%     tmp = B(:,:,channel);
%     ix = find(tmp>ct); 
%     %tmp(tmp>50) = 255;
%     [I,J] = ind2sub(size(tmp), ix);
%     
%     %B(:,:,channel) = tmp;
%     B(I,J,:) = 255;
% end

maxB = max(A, [], 3);
% ix = find(maxB<ct);
% [I,J] = ind2sub(size(maxB), ix);
% B(I,J,:) = 0;

maxB(maxB>ct) = 255;
B = maxB~=255;


end

