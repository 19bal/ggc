clear all;  close all;  clc;
warning off all
dbg = true;

nr = 8;
nc = 6;

dbnm_ccrop = pathos('_db/ccrop/');    
dbnm_ds    = pathos('_db/ds/');

dDIR = cat(1, dir(pathos(strcat(dbnm_ccrop, 'e*'))), ...
dir(pathos(strcat(dbnm_ccrop, 'k*'))));
ds = size(dDIR);

for d=1:ds,
    dnm = dDIR(d).name;
    if dbg, fprintf('dir nm: %s\n', dnm);   end    
    dfnm_ccrop = pathos(strcat(dbnm_ccrop, dnm, '/'));

    DIR = dir(strcat(dfnm_ccrop, '*.png'));
    sz = length(DIR);

    for f=1:sz,
        if dbg, fprintf('\t%2d. frame isleniyor\n', f); end
        imgnm = DIR(f).name;    
        bw = imread(strcat(dfnm_ccrop, imgnm));

        Dist = fe_bauckhage09_dist(bw, nr, nc, dbg);
        DistN(f, :) = Dist;
        
        if dbg,
            figure(21);
                imshow(bw);        
        end
    end

    mn = mean(DistN, 1);
    st = std(DistN, [], 1);
    
    if dnm(1) == 'e'
        y = 0;
    elseif dnm(1) == 'k'
        y = 1;
    else
        y = -1;
    end
    
    data(d).dnm = dnm;
    data(d).X = [mn st];
    data(d).y = y;
    
end

data_sets(data, dbnm_ds, dbg);
