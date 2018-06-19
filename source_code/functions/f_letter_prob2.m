function pwm = f_letter_prob2(letter, p, pwm)
    if letter == 'A'
        pwm(1) = p;
    elseif letter == 'C'
        pwm(2) = p;
    elseif letter == 'G'
        pwm(3) = p;
    elseif letter == 'T'
        pwm(4) = p;
        
    end
end
