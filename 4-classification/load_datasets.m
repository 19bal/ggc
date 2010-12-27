function [trn_ds, tst_ds] = load_datasets(dbnm_ds, dbg)
% function [trn_ds, tst_ds] = load_datasets(dbnm_ds, dbg)

fnm_trn_ds = 'trn_ds.mat';
fnm_tst_ds = 'tst_ds.mat';
ffnm_trn_ds = pathos(strcat(dbnm_ds, fnm_trn_ds));
ffnm_tst_ds = pathos(strcat(dbnm_ds, fnm_tst_ds));

load(ffnm_trn_ds);
load(ffnm_tst_ds);