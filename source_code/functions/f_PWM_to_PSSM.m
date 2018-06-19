function PSSM = f_PWM_to_PSSM(PWM)
% assume that the background is always 0.25
PWM = PWM + 0.01;
PSSM = 100.* log2(PWM./0.25);


end

