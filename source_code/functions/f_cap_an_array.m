function b = f_cap_an_array(a)
% Gives an array a cap, any element larger than the median value will give
%  the median value instead.

b=a;

ix = f_consecutive_0s(a);
tmp = a(~ix);
% m: median value
m = median(tmp);

% let the 0s becomes the largest number to avoid mistake
b(ix) = max(b);

% let the regions larger than the cutoff becaomes the cutoff value.
b(a>=m) = m;


end

