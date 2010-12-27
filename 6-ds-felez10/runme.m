clear all;  close all;  clc;
warning off all
dbg = true;

dbnm_ccrop = pathos('_db/ccrop/');
ffnm_features = pathos('_db/features.mat');
dbnm_ds  = pathos('_db/ds/');

features = struct();

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
        bws = imread(strcat(dfnm_ccrop, imgnm));

        fe = fe_mit(bws, dbg);
        
        [H, W] = size(bws);
        
        s = regionprops(double(bws), 'centroid');
        centroid = cat(1, s.Centroid);
        
        for i=1:size(fe,1)
            X = fe(i, 1);
            Y = fe(i, 2);            
            R = euclid_distance([X Y], centroid) / H;
            
            Maj = fe(i, 3) / H;
            Oran = fe(i, 3) / fe(i, 4);
            Alpha = fe(i, 5);
            
            feN(i, :, f) = [R Maj Oran Alpha];
        end        
    end
    
    mn = mean(feN, 3);
    st = std(feN, [], 3);
            
    if dnm(1) == 'e'
        y = 0;
    elseif dnm(1) == 'k'
        y = 1;
    else
        y = -1;
    end
    
    data(d).dnm = dnm;
    data(d).X = [mn(:)' st(:)'];
    data(d).y = y;
end

data_sets(data, dbnm_ds, dbg);



