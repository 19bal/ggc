clear all;  close all;  clc;
warning off all
dbg = true;

dbnm = pathos('../../db/ty/hepsi/');
dbnm_ds = pathos('_db/ds/');

% create dataset
ggc_dataset(dbnm, dbg);

% train
ggc_train(dbnm_ds, dbg);

% test
[trn_basari, tst_basari] = ggc_test(dbnm_ds, dbg)
