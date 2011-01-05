clear all;  close all;  clc;
warning off all
dbg = true;

nr = 8;
nc = 6;

dbnm_ccrop  = pathos('_db/ccrop/');    
dbnm_ds_bau = pathos('_db/ds/bau/');
dbnm_ds_our = pathos('_db/ds/our/');

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
        seg = fe_b2yu09(Dist, nr, nc, dbg);
        
        DistN_bau(f, :) = Dist;
        DistN_our(f, :) = struct2array(seg);
        
        if dbg,
            figure(21);
                imshow(bw);        
        end
    end

    mn_bau = mean(DistN_bau, 1);    st_bau = std(DistN_bau, [], 1);
    mn_our = mean(DistN_our, 1);    st_our = std(DistN_our, [], 1);
    
    if dnm(1) == 'e'
        y = 0;
    elseif dnm(1) == 'k'
        y = 1;
    else
        y = -1;
    end
    
    data_bau(d).dnm = dnm;                  data_our(d).dnm = dnm;
    data_bau(d).X = [mn_bau st_bau];        data_our(d).X = [mn_our st_our];
    data_bau(d).y = y;                      data_our(d).y = y;
    
end

data_sets(data_bau, dbnm_ds_bau, dbg);
data_sets(data_our, dbnm_ds_our, dbg);
