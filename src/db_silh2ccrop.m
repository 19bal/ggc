function db_silh2ccrop(dbnm_silh, dbnm_ccrop, dbg);
% function db_silh2ccrop(dbnm_silh, dbnm_ccrop, dbg);

if length(dir(strcat(dbnm_ccrop))) > 2,    return;   end

mkdir(dbnm_ccrop);

dDIR = cat(1, dir(pathos(strcat(dbnm_silh, 'e*'))), ...
              dir(pathos(strcat(dbnm_silh, 'k*'))));
ds = size(dDIR);

for d=1:ds,
    dnm = dDIR(d).name;
    if dbg, fprintf('dir nm: %s\n', dnm);   end    
    dfnm_silh  = pathos(strcat(dbnm_silh,  dnm, '/'));  % Directory Full NaMe
    dfnm_ccrop = pathos(strcat(dbnm_ccrop, dnm, '/'));  mkdir(dfnm_ccrop);

    DIR = dir(strcat(dfnm_silh, '*.png'));
    sz = length(DIR);

    clear W;
    for f=1:sz,
        if dbg, fprintf('\t%2d. frame isleniyor\n', f); end
        imgnm = DIR(f).name;    
        bws = imread(strcat(dfnm_silh, imgnm));
        
        L = bwlabel(bws);
        s = regionprops(L, 'boundingbox');
        bbox = cat(1, s.BoundingBox);
        W(f) = bbox(3);        
    end
    
    [cS, cE] = cycle_crop(W, dbg);
    
    for f=cS:cE,
        if dbg, fprintf('\t%2d. frame isleniyor\n', f); end
        imgnm = DIR(f).name;    
        
        copyfile(strcat(dfnm_silh,  imgnm), ...
                 strcat(dfnm_ccrop, imgnm));
    end
end