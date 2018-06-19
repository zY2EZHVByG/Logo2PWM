function ix = f_consecutive_0s(a)
% Find the consequtive 0s in an array and label them
t=0; % target number is 0

ix = zeros(length(a), 1);
for i=2:length(a)-1
    if a(i-1)==t && a(i+1)==t
        ix(i) = 1;
    end
end

ix = logical(ix);

end

