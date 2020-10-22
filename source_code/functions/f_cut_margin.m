function [x1, x2, y1, y2] = f_cut_margin(a)
% a: matrix indicates the colorful pixels.

% cut left and right margin
b = sum(a);
% find the first non zero index
c = find(b>0);
x1 = c(1);

b2 = flip(b);
c = find(b2>0);
x2 = length(b) - c(1) + 1;


% cut upper and bottom margin
b = sum(a,2);
% find the first non zero index
c = find(b>0);
y1 = c(1);

b2 = flip(b);
c = find(b2>0);
y2 = length(b) - c(1) + 1;




end

