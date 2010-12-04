function [trn_basari, tst_basari] = ggc_test(dbnm_ds, dbg)
% function [trn_basari, tst_basari] = ggc_test(dbnm_ds, dbg)

[trn_ds, tst_ds] = data_sets([], dbnm_ds, dbg);

load(pathos('_bkp/net_lvq.mat'));

% Egitim verisi icin
P  = cat(1, trn_ds.X)';
Tc = cat(1, trn_ds.y)';

tY = sim(net, P);       

t = tY - repmat(Tc, [size(tY, 1) 1]);
trn_basari = sum((t == 0)') / size(tY, 2);

% Test verisi icin
P  = cat(1, tst_ds.X)';
Tc = cat(1, tst_ds.y)';

tY = sim(net, P); 

t = tY - repmat(Tc, [size(tY, 1) 1]);
tst_basari = sum((t == 0)') / size(tY, 2);

