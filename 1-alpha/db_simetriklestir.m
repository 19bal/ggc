function db_simetriklestir(dbnm, dbnm_simetrik, dbg)
% function db_simetriklestir(dbnm, dbnm_simetrik, dbg)
DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%2d. frame isleniyor\n', f); end
    imgnm = DIR(f).name;    
    fr = imread(strcat(dbnm, imgnm));
    
    j = flipdim(fr, 2);
    imwrite(j, strcat(dbnm_simetrik, imgnm));
end