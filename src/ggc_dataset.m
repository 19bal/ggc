function ggc_dataset(dbnm, dbg)
% function ggc_dataset(dbnm, dbg)
% 
% GGC data setini uretir

mkdir(pathos('_db/'));
dbnm_silh       = pathos('_db/silh/');
dbnm_ccrop      = pathos('_db/ccrop/');
dbnm_features   = pathos('_db/features/');
dbnm_ds         = pathos('_db/ds/');

% bw2silh db uret
db_bw2silh(dbnm, dbnm_silh, dbg);

% silh2ccrop db uret
db_silh2ccrop(dbnm_silh, dbnm_ccrop, dbg);

% ccrop2features db uret
features = db_ccrop2features(dbnm_ccrop, dbnm_features, dbg);

% feature selection
data = db_feature_selection(features, dbg);

% normalizasyon
data = db_normalization(data, dbg);

% train - test data sets
[trn_ds, tst_ds] = data_sets(data, dbnm_ds, dbg);

