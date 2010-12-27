function [trn_ds, tst_ds] = data_sets(data, dbnm_ds, dbg);
% function [trn_ds, tst_ds] = data_sets(data, dbnm_ds, dbg);
% 
% train - test data set

fnm_trn_ds = 'trn_ds.mat';
fnm_tst_ds = 'tst_ds.mat';
ffnm_trn_ds = pathos(strcat(dbnm_ds, fnm_trn_ds));
ffnm_tst_ds = pathos(strcat(dbnm_ds, fnm_tst_ds));

if exist(ffnm_trn_ds) && exist(ffnm_tst_ds)
    load(ffnm_trn_ds);
    load(ffnm_tst_ds);
else
    trn_ds = struct('dnm', '', 'X', '', 'y', '');  ir = 1;     % index
    tst_ds = struct('dnm', '', 'X', '', 'y', '');  is = 1;

    sz = length(data);
    w = 3; 
    n = floor(sz/w);
    sp = 1 + (0:n)*w;
    sp = sp(sp <= sz);

    % train: 1-2, test: 3
    for f=sp
        trn_ds(ir) = data(f);           ir = ir + 1;

        if (f + 1) > sz,    break;      end
        trn_ds(ir) = data(f + 1);       ir = ir + 1;

        if (f + 2) > sz,    break;      end
        tst_ds(is) = data(f + 2);       is = is + 1;
    end

    curdir = pwd;
        mkdir(dbnm_ds);
        cd(dbnm_ds);
        save trn_ds.mat trn_ds
        save tst_ds.mat tst_ds
    cd(curdir);
end