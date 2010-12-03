function db_silh2ccrop(dbnm_silh, dbnm_ccrop, dbg);
% function db_silh2ccrop(dbnm_silh, dbnm_ccrop, dbg);

if length(dir(dbnm_ccrop)) > 2,    return;   end

dDIR = cat(1, dir(pathos(strcat(dbnm_silh, 'e*'))), ...
              dir(pathos(strcat(dbnm_silh, 'k*'))));
ds = size(dDIR);

for d=1:ds,
    dnm = dDIR(d).name;
    if dbg, fprintf('dir nm: %s\n', dnm);   end    
    dfnm_silh = pathos(strcat(dbnm_silh, dnm, '/'));

    DIR = dir(strcat(dfnm_silh, '*.png'));
    sz = length(DIR);

    for f=1:sz,
        if dbg, fprintf('\t%2d. frame isleniyor\n', f); end
        imgnm = DIR(f).name;    
        bws = imread(strcat(dfnm_silh, imgnm));
        
        W = 
        
    end
    
    [cfrm, cS, cE] = cycle_crop(frm, W, false);
    
    imwrite
end