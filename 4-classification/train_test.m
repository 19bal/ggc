function sonuc = train_test(dbnm_ds, dbg)
% function sonuc = train_test(dbnm_ds, dbg)

% LVQ
sonuc.lvq = struct([]);
tic;
ggc_lvq_train(dbnm_ds, dbg);
[trn, tst] = ggc_lvq_test(dbnm_ds, dbg);
ct = toc;                    % computation time
sonuc.lvq = struct('trn', max(trn.perf)*100, 'tst', max(tst.perf)*100, 'ct', ct);

% SVM
sonuc.svm = struct([]);
tic;
ggc_svm_train(dbnm_ds, dbg);
[trn, tst] = ggc_svm_test(dbnm_ds, dbg);
ct = toc;                    % computation time
sonuc.svm = struct('trn', max(trn.perf)*100, 'tst', max(tst.perf)*100, 'ct', ct);