function code = f_determin_color(a)
% Determin the input color, 
% a is a array with format [x, x, x] (1x3 array)
% Centers:
% 1. red:     (200, 25 , 32 )
% 2. green:   (57 , 178, 65 ) 
% 3. blue:    (43 , 60 , 147)
% 4. yellow:  (240, 173, 10 )
% 5. white:   (255, 255, 255)
% 6. black:   (0  , 0  , 0  )
tab = [200, 25 , 32 ;...
       57 , 178, 65 ;...
       43 , 60 , 147;...
       240, 173, 10 ;...
       255, 255, 255;...
       0  , 0  , 0  ];
   

dists = zeros(size(tab, 1), 1);
for i = 1:size(tab, 1)
    dists(i) = sqrt(sum( abs(tab(i, :) - a).^2 ) );
end

tmp = find(dists == min(dists));
code = tmp(1);







end

