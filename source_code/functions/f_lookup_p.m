

function p = f_lookup_p(I, I_chart, p_chart)

abs_diff = abs(I_chart-I);
ix = abs_diff == min(abs_diff);
p = p_chart(ix);


end

