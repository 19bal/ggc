clear all;  close all;  clc;

dbg = true;

dbnm = pathos('../../db/silhouettes/fyc/00_1/');
dbnm_silh = pathos('_db/silh/');

db_orj2silh(dbnm, dbnm_silh, dbg);

DIR = dir(strcat(dbnm_silh, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%02d / %02d. frame isleniyor\n', f, sz);    end
    bws = boolean(imread(strcat(dbnm_silh, DIR(f).name)));
    
    bwm = immerge(bws, dbg);
    
    if dbg
        figure(1),  
        subplot(211),   imshow(bws);     title(num2str(f))
        subplot(212),   imshow(bwm);
        drawnow
    end
end