function [trn, tst] = ggc_lvq_test(dbnm_ds, dbg)
% function [trn, tst] = ggc_lvq_test(dbnm_ds, dbg)

[trn_ds, tst_ds] = load_datasets(dbnm_ds, dbg);

load(pathos('_bkp/net_lvq.mat'));

[trn.err, trn.perf] = helper(trn_ds, net, dbg);
[tst.err, tst.perf] = helper(tst_ds, net, dbg);

% local function
function [err, perf] = helper(ds, net, dbg)
P  = cat(1, ds.X)';
Tc = cat(1, ds.y)';

tY = sim(net, P); 

t = tY - repmat(Tc, [size(tY, 1) 1]);
err = mean(abs(t').^2);
perf = sum((t == 0)') / size(tY, 2);

