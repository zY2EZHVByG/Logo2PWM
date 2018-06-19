function f_PSSMs_to_MEME_motif_file(PSSMs, consensuses, fname)
% 
f = fopen(fname, 'wt');
% fprintf(f, '');
fprintf(f, 'MEME version 4.4\n');
fprintf(f, '\n');
fprintf(f, 'ALPHABET= ACGT\n');
fprintf(f, '\n');
fprintf(f, 'strands: + -\n');
fprintf(f, '\n');
fprintf(f, 'Background letter frequencies (from uniform background):\n');
fprintf(f, 'A 0.25000 C 0.25000 G 0.25000 T 0.25000 \n');
fprintf(f, '\n');

for i=1:length(PSSMs)
    fprintf(f, 'MOTIF %s_%d\n', consensuses{i}, i);
    fprintf(f,'log-odds matrix: alength= 4 w= %d E= 0\n',size(PSSMs{i},2));
    PSSM = PSSMs{i}';
    for j=1:size(PSSM, 1)
        fprintf(f, '  %.4f\t%.4f\t%.4f\t%.4f\n', PSSM(j,1),PSSM(j,2),...
            PSSM(j,3),PSSM(j,4) );
    end
    fprintf(f, '\n\n');
    
end

fclose(f);

end

