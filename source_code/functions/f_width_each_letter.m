function [len_lt, cnt]=f_width_each_letter(x1,x2,y1,y2,hasX,hasY,bw,below_x_sum, below_x, I)
% determine the width of each letter.

if hasY==1 && hasX==0
    % ----------------------------------------------------
    % determine the width of each letter.
    [len_lt, cnt] = f_letter_width(bw, y1,y2,x1,x2);
    % ---------------------------------------------------- 
elseif hasY==0 && hasX==0
    % ----------------------------------------------------
    % determine the width of each letter.
    %[len_lt, cnt] = f_letter_width(bw, y1,y2,x1,x2);
    [len_lt, cnt] = f_letter_width2(I, y1,y2,x1,x2);
    % ----------------------------------------------------   
elseif hasY==1 && hasX==1
    % -----------------------------------------------------------------
    % determine the width of each letter.
    [len_lt, cnt] = f_determine_letter_width(x1,x2,y1,y2,hasX,hasY,bw,below_x_sum, below_x, I);
    % -----------------------------------------------------------------

end


end

