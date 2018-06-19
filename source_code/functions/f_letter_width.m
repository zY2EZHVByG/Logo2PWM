function [len_lt, cnt] = f_letter_width(bw, y1,y2,x1,x2)
% determine the letter width and count 

% determine the width of each letter.
tmp = sum(~bw(y1:y2, x1:x2));
% give the array a cap (added 20160201)
tmp = f_cap_an_array(tmp);
% 
tmp2 = tmp;
for i=3:length(tmp)-2
    if tmp(i)<7
        %tmp2(i) = tmp(i) - (tmp(i-1)-tmp(i)) - (tmp(i-2)-tmp(i)) - (tmp(i+1)-tmp(i)) - (tmp(i+2)-tmp(i));
        tmp2(i) = tmp(i) - (tmp(i-1)-tmp(i)) - (tmp(i+1)-tmp(i)) ;
    end
end
%figure,plot(tmp2);
tmp3 = tmp2; tmp3(tmp3>=-3)=0;tmp3=-tmp3;
%figure,plot(tmp3);
[Maxima,MaxIdx] = findpeaks(tmp3);
lengs = diff(MaxIdx);
[counts,centers] = hist(lengs, unique(lengs));

%len_lt = f_find_true_center(counts,centers, length(tmp3));
len_lt = f_find_true_center(counts,centers);
cnt = round(length(tmp3)./len_lt);
% len_lt,cnt,

end