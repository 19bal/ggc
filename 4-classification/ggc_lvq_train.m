function ggc_train(dbnm_ds, dbg)
% function ggc_train(dbnm_ds, dbg)

[trn_ds, tst_ds] = load_datasets(dbnm_ds, dbg);

P  = cat(1, trn_ds.X)';

Tc = cat(1, trn_ds.y)';
T = [Tc; (1 - Tc)];

net = newlvq(P, 2, [.5 .5], 0.008, 'learnlv2'); % (P,4,[.5 .5],0.0016,'learnlv3')

net.trainParam.epochs = 25; % 17 10
net = train(net, P, T);

curdir = pwd;
    dnm = pathos('_bkp/');
    mkdir(dnm);
    cd(dnm);
    save net_lvq net
cd(curdir);


