function [wid, cnt] = f_determine_letter_width(vec)
% determine the width of each letter,
% because of that the number from 1 to 9 is the most accurate to determine,
% since the number from 10 will has 2 digits.

% I think since that the number '2' and '9' have the same width (not as 
%  thin as '1'), so, I will use this 2 number to determine the width 

% vec is the summation of the numbers (x-ticks)

% prepocessing vec
vec = f_preprocess_vec(vec);
%figure, plot(vec);

cnt = 0;
old = 0;
posi2=0;
posi9=0;

for i=1:length(vec)
    new = vec(i);
    if old ==0 && new~=0  
        cnt=cnt+1;
        if cnt==2
            posi2 = i;
        elseif cnt == 9
            posi9 = i;
        end
    end
    old = new;
end



% length of each letter
if cnt>=9
    wid = (posi9-posi2)./7;
    % wid,
else
    wid = (length(vec)-posi2)./(cnt-1);
end

cnt = round(length(vec)./wid);



end


function vec = f_preprocess_vec(vec)

tmp = vec;
a = 5;
% start point
p = round((a-1)/2);
for i=p+1:length(vec)-p-1
    tmp(i) = max(vec(i-p:i+p));
    
end

vec = tmp;

end










