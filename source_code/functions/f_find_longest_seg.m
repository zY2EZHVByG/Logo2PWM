function range = f_find_longest_seg(vec)
% find the longest segment
% vec is a n by 1 boolean vector, 1 is for background, 0 is for the segment


ranges = [];


flag = 1;
range = [0, 0];
for i=1:length(vec)
    
    if flag==1 && vec(i)==1
        
    elseif flag==1 && vec(i)==0
        flag = 0;
        range = [i, 0];
    elseif flag==0 && vec(i)==1
        flag = 1;
        range(2) = i-1;
        ranges = [ranges; range];
        range=[0, 0];
    elseif flag==0 && vec(i)==0
        if i==length(vec)
            range(2) = length(vec);
            ranges = [ranges; range];
        end
    end
           
end

difff=ranges(:,2)-ranges(:,1);
range = ranges(difff==max(difff) , :);




end

