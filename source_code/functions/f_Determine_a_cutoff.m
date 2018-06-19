function ct = f_Determine_a_cutoff(a)

% Determine a cutoff
% 'a' is an array, it represents a line with several extreme points 
%  (minimum values). The goal is to find a proper number of extreme points
%  to determine the width of a logo letter. Usually if there are 5 to 13
%  points, using some average computing tool can find the correct width. 
% This 5 to 13 bound is good for most of cases (most of motifs are within 
%  this range).  

% tmp3 = tmp2;

ct = 0;

cnt = 0;
while 1
    cnt = cnt + 1;
    if cnt >=2000
        break;
    end
    % sum(tmp3<ct) returns the number of extreme points
    if sum(a<ct)>5 && sum(a<ct)<13
        break;
    end
    if sum(a<ct)>=13 
        ct = ct-0.01;
    end
    if sum(a<ct)<=5
        ct = ct + 0.01;
    end
    %sum(tmp3<ct),
    %ct,
end


end

