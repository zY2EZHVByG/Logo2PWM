function PWM = f_normpwm(PWM)
% 
for i = 1:size(PWM, 2)
    col = PWM(:,i);
    if min(col) < 0
        col = col + min(col);
    end
    s = sum(col);
    if s ~= 0
        col(1) = col(1) / s;
        col(2) = col(2) / s;
        col(3) = col(3) / s;
        col(4) = col(4) / s;
        
        PWM(:,i) = col;
    end
        
end

end

