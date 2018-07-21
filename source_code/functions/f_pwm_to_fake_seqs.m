function [seqs] = f_pwm_to_fake_seqs(pwm)
% 

seqs = repmat('T', 1000, size(pwm,1));
for i=1:size(pwm, 1)
    n_a = round(pwm(i, 1)*1000);
    n_c = round(pwm(i, 2)*1000);
    n_g = round(pwm(i, 3)*1000);
    seqs(1:n_a, i) = 'A';
    seqs(n_a+1:n_a+n_c , i) = 'C';
    seqs(n_a+n_c+1:n_a+n_c+n_g, i) = 'G';
    
end


seqs = cellstr(seqs);

end

