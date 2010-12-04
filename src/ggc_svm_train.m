function ggc_svm_train(dbnm_ds, dbg)
% function ggc_svm_train(dbnm_ds, dbg)

[trn_ds, tst_ds] = data_sets([], dbnm_ds, dbg);

% data yi bsvm nin arzu ettigi forma donustur
data.X = cat(1, trn_ds.X)';
data.y = 1 + cat(1, trn_ds.y)';
data.Etiket = {'E', 'K'};

options.solver = 'imdm';
model = bsvm2(data, options);

curdir = pwd;
    dnm = pathos('_bkp/');
    mkdir(dnm);
    cd(dnm);
    save model_svm model
cd(curdir);