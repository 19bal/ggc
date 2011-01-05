clear all;  close all;  clc;
warning off all
dbg = true;

dbnm_ds_emreg = pathos('_ds/emre/');
dbnm_ds_bauck = pathos('_ds/bauckhage09/');
dbnm_ds_felez = pathos('_ds/felez10/');

fprintf('LVQ - SVM\n');
fprintf('   ct  | trn | tst ||   ct   | trn | tst |\n');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

for i = 1:3
    fprintf('%d. yineleme...\n', i);
    
    sonuc_emreg(i) = train_test(dbnm_ds_emreg, dbg);
    %sonuc_bauck(i) = train_test(dbnm_ds_bauck, dbg);
    %sonuc_felez(i) = train_test(dbnm_ds_felez, dbg);
end

