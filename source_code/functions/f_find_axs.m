function [x1, x2, y1, y2] = f_find_axs(bw, hasX, B)
% when there is a y axis, find y axis
% find x1 index (left of the logo)
%tmp = sum(~bw);
tmp = sum(B);
% figure,plot(tmp),

tmp2 = tmp;
tmp3 = tmp + 1;
for i=(1+2):(length(tmp)-2)
    % Highlight the extreme point
    if tmp3(i)/tmp3(i-1) > 10 && tmp(i)>60 
    tmp2(i) = tmp(i) + tmp(i).*(1./(tmp(i-2)+0.01) + ...
      1./(tmp(i-1)+0.01) + 1./(tmp(i+1)+0.01) + 1./(tmp(i+2)+0.01) );        
    end
end
% figure,plot(tmp2),


tmp1 = find(tmp2 == max(tmp2 ));
x1 = tmp1(end) + 2;

% find y1 and y2
col = bw(1:end-5, x1-2);
% 
% tmp = find(col==0);
% y1 = tmp(1);
% y2 = tmp(end);
range = f_find_longest_seg(col);
y1=range(1);y2=range(2);


% ---------------------------------------
% find x2 index
% figure; plot(sum(~bw));
if hasX
    %row = bw(y2, x1:end);
    row = bw(y2, :);
    range = f_find_longest_seg(row');
    x2 = range(2);
else
    tmp = find(sum(~bw(y1:y2, :)) ~= 0  );
    x2 = tmp(end);
end
% ---------------------------------------

%
% refine the edges
tmp = ~bw(y1:y2, x1:x2);
tmp2=mean(tmp);
while tmp2(1) > 0.9
    % means this column is not usable, it is an edge, remove it.
    x1 = x1+1;
    tmp = ~bw(y1:y2, x1:x2);
    tmp2=mean(tmp);
end

tmp = ~bw(y1:y2, x1:x2);
tmp2=mean(tmp, 2);
while tmp2(end) > 0.9
    % means this column is not usable, it is an edge, remove it.
    y2 = y2-1;
    tmp = ~bw(y1:y2, x1:x2);
    tmp2=mean(tmp);
end




end
