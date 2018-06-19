function [len_lt, cnt] = f_letter_width2(I, y1,y2,x1,x2)
% determine the letter width and count 

% determine the width of each letter.
%tmp = sum(~I(y1:y2, x1:x2));

%y1,y2,x1,x2,
tmp = sum(1./double(I(y1:y2, x1:x2)));
% give the array a cap (added 20160201)
tmp = f_cap_an_array(tmp);

% 
tmp2 = tmp;
for i=4:length(tmp)-3
    if tmp(i)<0.3
        tmp2(i)=tmp(i)-(tmp(i-1)-tmp(i))-(tmp(i-2)-tmp(i))-(tmp(i-3)-tmp(i)) - ...
            (tmp(i+1)-tmp(i)) - (tmp(i+2)-tmp(i))-(tmp(i+3)-tmp(i));
        %tmp2(i) = tmp(i) - (tmp(i-1)-tmp(i)) - (tmp(i+1)-tmp(i)) ;
    end
end
% figure,plot(tmp2);
% -----------------------------------------------------
% Determine a cutoff
tmp3 = tmp2;
ct = f_Determine_a_cutoff(tmp2);
% -----------------------------------------------------
tmp3(tmp3>=ct) = ct; tmp3 = tmp3 -ct; tmp3=-tmp3;
% figure,plot(tmp3);
[Maxima,MaxIdx] = findpeaks(tmp3);
lengs = diff(MaxIdx);
[counts,centers] = hist(lengs, unique(lengs));

%len_lt = f_find_true_center(counts,centers, length(tmp3));
len_lt = f_find_true_center(counts,centers);
cnt = round(length(tmp3)./len_lt);
% len_lt,cnt,

end