function f_PWM_to_csv(PWM, fname)
%
if nargin<2
    fname = '';
end
if strcmp(fname, '')
    f = 1;
else
    f = fopen(fname, 'wt');
end

%fprintf(f, '# energy matrix (horizontal)\n');
%fprintf(f, 'PO ');

len = size(PWM, 2);
% for i=1:len
%     fprintf(f, '\t%d', i);
% end
% fprintf(f, '\n');

%fprintf(f, 'A ');
for i=1:len
    fprintf(f, '\t%f,', PWM(1, i));
end
fprintf(f, '\n');


%fprintf(f, 'C ');
for i=1:len
    fprintf(f, '\t%f,', PWM(2, i));
end
fprintf(f, '\n');

%fprintf(f, 'G ');
for i=1:len
    fprintf(f, '\t%f,', PWM(3, i));
end
fprintf(f, '\n');

%fprintf(f, 'T ');
for i=1:len
    fprintf(f, '\t%f,', PWM(4, i));
end
fprintf(f, '\n');

fclose(f);


end

