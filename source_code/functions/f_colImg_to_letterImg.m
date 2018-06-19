function [letter,I,I_main,pwm,letterImg]=f_colImg_to_letterImg(colImg, ix)
%

% firstly trim the edges for a better quality
if size(colImg, 2)<= 10
    % trim for the letter image (for a position)
    lr_dege = 1;
    colImg = colImg(:, lr_dege: end-lr_dege, :);
elseif size(colImg, 2) > 10 && size(colImg, 2) <= 25
    lr_dege = 2;
    colImg = colImg(:, lr_dege: end-lr_dege, :);
else
    lr_dege = 4;
    colImg = colImg(:, lr_dege-2 : end-lr_dege, :);
end
    


tmp1 = min( colImg, [], 2 );
len = length(tmp1);

% for the first letter (the biggest one)
[letter,startp,endp,letterImg,restImg]=f_colImg_to_letter(colImg);
%letter,

% if ix == 3
%     figure, subplot(1,2,1), imshow(letterImg);subplot(1,2,2),imshow(restImg);
% end
I = 2.* (len-startp) ./ len;
I_main = 2.* (endp-startp) ./ len;

% for the second letter
if size(restImg,1)>3
    [l2, startp2,endp2,letterImg2,restImg]=f_colImg_to_letter(restImg);
    I_2 = 2.* (endp2-startp2) ./ len;
    if strcmp(l2, letter) == 1
        l2 = '';
        I_2 = 0;
    end
else
    l2 = '';
    I_2 = 0;
end

% % for the 3rd letter
% if size(restImg,1)>3
%     [l3, startp3,endp3,letterImg3,restImg]=f_colImg_to_letter(restImg);
%     I_3 = 2.* (endp3-startp3) ./ len;
% else
%     l3 = '';
%     I_3 = 0;
% end
% 


pwm=zeros(4, 1);


I_chart = get_I_chart();
p_chart = get_p_chart();
% for the main letter
% if I<0.2
if (endp-startp) <=1
    pwm=repmat(0.25, [4,1]);
else
    %
    %pwm_e = 1 - I_main./I - I_2./I - I_3./I;
    pwm_e = 0;
    
    p_main=f_lookup_p(I_main, I_chart, p_chart);

    
    if I_2==0 %&& I_3==0                % When there is only one big letter
        pwm_e = (1 - p_main)./3;
        pwm = repmat(pwm_e, [4,1]);
        %pwm = f_letter_prob(letter, I_main, I, pwm);
        pwm = f_letter_prob2(letter, p_main, pwm);
        
    elseif I_2~=0 %&& I_3==0                  % If there are 2 big letters. 
        %p2 = f_lookup_p(I_2, I_chart, p_chart);
        p2 = I_2/I;
        if (p_main+p2) > 1
            remain = p_main + p2 -1;
            p_main = p_main - remain./2;
            p2 = p2 - remain./2;
            
        end
        pwm_e = (1 - p_main - p2)./2;
        pwm = repmat(pwm_e, [4,1]);
        pwm = f_letter_prob2(letter, p_main, pwm);
        pwm = f_letter_prob2(l2, p2, pwm);
        %pwm = f_letter_prob(l2, I_2, I, pwm);
        
%     elseif I_2~=0 && I_3~=0
%         pwm_e = 1 - I_main./I - I_2./I - I_3./I;
%         pwm = repmat(pwm_e, [4,1]);
%         pwm = f_letter_prob(letter, I_main, I, pwm);
%         pwm = f_letter_prob(l2, I_2, I, pwm);
%         pwm = f_letter_prob(l3, I_3, I, pwm);

    end
    
    
    
        
end

end




