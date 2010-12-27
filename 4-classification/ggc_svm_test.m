function [trn, tst] = ggc_svm_test(dbnm_ds, dbg)
% function [trn, tst] = ggc_svm_test(dbnm_ds, dbg)

[trn_ds, tst_ds] = load_datasets(dbnm_ds, dbg);

load(pathos('_bkp/model_svm.mat'));

[trn.err, trn.perf] = helper(trn_ds, model, dbg);
[tst.err, tst.perf] = helper(tst_ds, model, dbg);


% local function
function [err, perf] = helper(ds, model, dbg)

data.X = cat(1, ds.X)';
data.y = 1 + cat(1, ds.y)';
data.Etiket = {'E', 'K'};

y = svmclass(data.X, model);

%if dbg, Etiket = [data.Etiket(data.y'); data.Etiket(y')]',  end

err = mean(abs(data.y - y).^2);
perf = sum((data.y - y) == 0) / length(y);
