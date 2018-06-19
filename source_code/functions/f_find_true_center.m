function len_lt = f_find_true_center(counts,centers)
% e.g.:
%
% centers = [12,13,14,22,68]
% counts = [1,1,2,1,1]
% 14 has the most counts
%
% if change the cutoff, the two array becomes:
% centers = [4,5,12,13,14,56]
% counts = [1,1,3,2,2,1]
% 12 has the most counts.
% 
% and for both cases, 12 is the median. 
% however, 13 is the real center.
% So I come up with the idea that I will count the number of counts for
% each number with its neighbours with radius 1. 

% len is used to estimate the radius
radius = 1;
%radius = ceil();

con = zeros(size(counts));
for i=1:length(centers)
    ix_sm = centers == centers(i)-radius;
    ix_bg = centers == centers(i)+radius;
    
    if sum(ix_sm)==1
        con(i) = counts(i) + counts(ix_sm);
    else
        con(i) = counts(i);
    end
    if sum(ix_bg)==1
        con(i) = con(i) + counts(ix_bg);
    else
        con(i) = con(i);
    end
end


ix = find(con==max(con));
len_lt = centers(ix(end));


end

