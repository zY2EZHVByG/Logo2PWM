function f_logo_to_PWM_publish(img_fname, n_letters)

% Input the file name of a logo image file, output 4 files under the same 
%   folder:
%
%  1. The enologo format matrix file
%  2. The csv format matrix file
%  3. The meme format pssm file, which can be used for MAST scanning.
%  4. The re-generated logo image for verification purpose


if nargin<2
    % 0 means won't specify the number of letters in the logo, let the
    %  program to determine the number of letter.
    
    n_letters = 0;
else
    n_letters = str2num(n_letters);
end


%% generate the PWM from the logo image file
[PWM, consensus] = f_logo_to_PWM(img_fname, n_letters);


%% Prepare the names of output files
tmp = strsplit(img_fname,'.');
% I found an error, for some system such as CBI linux system, there are
%  lots of '.' in the path, so I need to recogonize only the last '.'
% And also, i cannot assume the last 3 letters are the extension, there
% might be expections such as .jpeg, which has 4 letters in the extension.
l=length(tmp);
prefix = tmp{1};
for i=2:l-1
    prefix = [prefix, '.', tmp{i}];
end
fname_enologo_txt = [prefix, '_enoLogo.txt' ];
fname_csv = [prefix, '.csv' ];
fname_meme_pssm_txt = [prefix, '_meme_pssm.txt' ];
fname_re_draw_logo_img = [prefix, '_rg_logo.png' ];


%% Re-format the PWM to a enologos format, generate a txt file
f_PWM_for_enologos(PWM, fname_enologo_txt);


%% Generate a csv file for the PWM
f_PWM_to_csv(PWM, fname_csv);


%% Generate a PSSM (Position-specific scoring matrix) and a MEME standard file for MEME-MAST motif scanning
PSSM = f_PWM_to_PSSM(PWM);
f_PSSMs_to_MEME_motif_file({PSSM}, {consensus}, fname_meme_pssm_txt);

%% Re-draw the logo image for verification purpose
seqs = f_pwm_to_fake_seqs(PWM');
[~, handle] = seqlogo(seqs);
print(handle, fname_re_draw_logo_img, '-dpng','-r60');
close(handle)

end

