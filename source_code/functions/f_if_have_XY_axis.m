function [hasY, hasX] = f_if_have_XY_axis(bw)
% input a black and white boolean array

hasY = max(sum(bw,1))> size(bw,1) * 0.29; % cover at least 0.29 is very 
                        %likely to be a y-axis
hasX = max(sum(bw,2))> size(bw,2) * (2/3);

fprintf('has Y axis? -- %d\n', hasY);
fprintf('has X axis? -- %d\n', hasX);

% tf = hasY & hasX;


end

