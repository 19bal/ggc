clear all;  close all;  clc;
warning off all
dbg = true;

fprintf('LVQ - SVM\n');
fprintf('   ct  | trn | tst ||   ct   | trn | tst |\n');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % emre
dbnm_ds = pathos('_ds/emre/');

        % LVQ
        tic;
        ggc_lvq_train(dbnm_ds, dbg);
        [lvq_trn, lvq_tst] = ggc_lvq_test(dbnm_ds, dbg);
        ct_lvq = toc;                    % computation time

        % SVM
        tic;
        ggc_svm_train(dbnm_ds, dbg);
        [svm_trn, svm_tst] = ggc_svm_test(dbnm_ds, dbg);
        ct_svm = toc;                    % computation time

        fprintf('%6.3f | %03d | %03d || %6.3f | %03d | %03d |\t%s\n', ...
            ct_lvq, max(lvq_trn.perf)*100, max(lvq_tst.perf)*100, ...
            ct_svm, max(svm_trn.perf)*100, max(svm_tst.perf)*100, dbnm_ds);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% % % % % % bauckhage09
dbnm_ds = pathos('_ds/bauckhage09/');

        % LVQ
        tic;
        ggc_lvq_train(dbnm_ds, dbg);
        [lvq_trn, lvq_tst] = ggc_lvq_test(dbnm_ds, dbg);
        ct_lvq = toc;                    % computation time

        % SVM
        tic;
        ggc_svm_train(dbnm_ds, dbg);
        [svm_trn, svm_tst] = ggc_svm_test(dbnm_ds, dbg);
        ct_svm = toc;                    % computation time
        
        fprintf('%6.3f | %03d | %03d || %6.3f | %03d | %03d |\t%s\n', ...
            ct_lvq, max(lvq_trn.perf)*100, max(lvq_tst.perf)*100, ...
            ct_svm, max(svm_trn.perf)*100, max(svm_tst.perf)*100, dbnm_ds);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% % % % % % bauckhage09
dbnm_ds = pathos('_ds/felez10/');

        % LVQ
        tic;
        ggc_lvq_train(dbnm_ds, dbg);
        [lvq_trn, lvq_tst] = ggc_lvq_test(dbnm_ds, dbg);
        ct_lvq = toc;                    % computation time

        % SVM
        tic;
        ggc_svm_train(dbnm_ds, dbg);
        [svm_trn, svm_tst] = ggc_svm_test(dbnm_ds, dbg);
        ct_svm = toc;                    % computation time

        fprintf('%6.3f | %03d | %03d || %6.3f | %03d | %03d |\t%s\n', ...
            ct_lvq, max(lvq_trn.perf)*100, max(lvq_tst.perf)*100, ...
            ct_svm, max(svm_trn.perf)*100, max(svm_tst.perf)*100, dbnm_ds);
        
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
