clear all;  close all;  clc;
warning off all
dbg = true;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % emre
dbnm_ds = pathos('_ds/emre/');
fprintf('DS: %s\n', dbnm_ds);

% LVQ
tic;
ggc_lvq_train(dbnm_ds, dbg);
[lvq_trn, lvq_tst] = ggc_lvq_test(dbnm_ds, dbg)
ct_lvq = toc                    % computation time

% SVM
tic;
ggc_svm_train(dbnm_ds, dbg);
[svm_trn, svm_tst] = ggc_svm_test(dbnm_ds, dbg)
ct_svm = toc                    % computation time

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% % % % % % bauckhage09
dbnm_ds = pathos('_ds/bauckhage09/');
fprintf('DS: %s\n', dbnm_ds);

% LVQ
tic;
ggc_lvq_train(dbnm_ds, dbg);
[lvq_trn, lvq_tst] = ggc_lvq_test(dbnm_ds, dbg)
ct_lvq = toc                    % computation time

% SVM
tic;
ggc_svm_train(dbnm_ds, dbg);
[svm_trn, svm_tst] = ggc_svm_test(dbnm_ds, dbg)
ct_svm = toc                    % computation time
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 