function [wid, cnt] = f_determine_letter_width(x1,x2,y1,y2,hasX,hasY,bw, ...
    below_x_sum, below_x, I)
% determine the width of each letter,
% because of that the number from 1 to 9 is the most accurate to determine,
% since the number from 10 will has 2 digits.

% I think since that the number '2' and '9' have the same width (not as 
%  thin as '1'), so, I will use this 2 number to determine the width 

% vec is the summation of the numbers (x-ticks)


[cnt, wid] = f_determine_cnt_by_x_axis(x1,x2,y1,y2,hasX,hasY,bw, ...
    below_x_sum, below_x);
if cnt >=3 && cnt<=27
    %cnt,
    
else
    % prepocessing below_x_sum
    below_x_sum = f_preprocess_vec(below_x_sum);
    %figure, plot(below_x_sum);
    % figure, imagesc(below_x(1:2, :));
    % figure, plot(sum(below_x(1:2, :)));
    % sum(below_x(1:2, :)),

    cnt = 0;
    old = 0;
    posi2=0;
    posi9=0;

    for i=1:length(below_x_sum)
        new = below_x_sum(i);
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
        wid = (length(below_x_sum)-posi2)./(cnt-1);
    end

    cnt = round(length(below_x_sum)./wid);

end

end


function below_x_sum = f_preprocess_vec(below_x_sum)

tmp = below_x_sum;
a = 5;
% start point
p = round((a-1)/2);
for i=p+1:length(below_x_sum)-p-1
    tmp(i) = max(below_x_sum(i-p:i+p));
    
end

below_x_sum = tmp;

end


function [cnt, wid] = f_determine_cnt_by_x_axis(x1,x2,y1,y2,hasX,hasY,bw, ...
    below_x_sum, below_x)
cnt = 0;
tick_region = below_x(1:2, :);
tick_region_sum = sum(tick_region);

ct = (max(tick_region_sum(:)) + min(tick_region_sum(:))) / 2;

% remove consequtive same numbers
tmp = tick_region_sum(1);
for i=2:length(tick_region_sum)
    if tick_region_sum(i) ~= tmp(end)
        tmp = [tmp, tick_region_sum(i)];
    end
end
% tmp,

cnt = sum(tmp > ct) - 1;

wid = round(length(tick_region_sum)./cnt);




end







