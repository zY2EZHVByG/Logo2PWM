function [x1, x2, y1, y2, below_x_sum, below_x] = f_determine_true_logo_edge(bw, B, hasX, hasY, I)
%

below_x_sum = [];
below_x = [];

if hasY==1 && hasX==0
    [x1, x2, y1, y2] = f_find_axs(bw, hasX, B);
    %figure,imshow(A(y1:y2, x1:x2));

% -----------------------------------------------------------------------
elseif hasY==0 && hasX==0
    below_x_sum = sum(~bw);
    ixs = find(below_x_sum~=0);
    x1 = ixs(1);
    x2 = ixs(end);

    below_x_sum = sum(~bw, 2);
    ixs = find(below_x_sum~=0);
    y1 = ixs(1);
    y2 = ixs(end);

    x1=x1-2;
    if x1<=0; x1=1; end;
% -----------------------------------------------------------------------
elseif hasY==1 && hasX==1
    % find y axis
    % find x1 index (left of the logo)
    [x1, x2, y1, y2] = f_find_axs(bw, hasX, B);

    I_sub_mean = mean(I(y1:y2, x1:x2), 2);
    gap = 0;
    while I_sub_mean(end) > 245
        y2 = y2-1;
        I_sub_mean = I_sub_mean(1:end-1);
        gap = gap+1;
    end
    %y2 = y2-3;
    % ***********************************************************
    %figure, imshow(I(y1:y2, x1:x2));
    %x1,x2,y1,y2,

    % count the number of letters
    % find how many times tmp changed from zero to non-zero.
    %  (find the number of x ticks)
    below_x = ~bw(y2+2+gap:end, x1:x2);
    % figure, imshow(tmp1);
    
    below_x_sum = sum(below_x);

    %figure, plot(tmp);
end
    
    

end

