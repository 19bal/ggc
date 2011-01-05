clear all;  close all;  %clc;
warning off all
dbg = false;

dbnm_ds_emreg = pathos('_ds/emre/');
dbnm_ds_bauck = pathos('_ds/bauckhage09/bau/');
dbnm_ds_b_our = pathos('_ds/bauckhage09/our/');
dbnm_ds_felez = pathos('_ds/felez10/');

for i = 1:50 %3
    if dbg, fprintf('%d. yineleme...\n', i);    end
    
    sonuc_emreg(i) = train_test(dbnm_ds_emreg, dbg);
    sonuc_bauck(i) = train_test(dbnm_ds_bauck, dbg);
    sonuc_b_our(i) = train_test(dbnm_ds_b_our, dbg);
    sonuc_felez(i) = train_test(dbnm_ds_felez, dbg);
end

mn_emreg = mean_struct(sonuc_emreg, dbg);
mn_bauck = mean_struct(sonuc_bauck, dbg);
mn_b_our = mean_struct(sonuc_b_our, dbg);
mn_felez = mean_struct(sonuc_felez, dbg);

NM_OM = {'LVQ', 'SVM'};

fprintf(' OM:    E     B     O     F      | E      B     O     F    | E      B     O    F   |\n');
for i=1:length(mn_emreg)
    fprintf('%s: ', char(NM_OM{i}));
    
    fprintf('%.4f %.4f %.4f %.4f | ', ...
        mn_emreg(i).ct, mn_bauck(i).ct, mn_b_our(i).ct, mn_felez(i).ct);
    
    fprintf('%5.1f %5.1f %5.1f %5.1f | ', ...
        mn_emreg(i).trn, mn_bauck(i).trn, mn_b_our(i).trn, mn_felez(i).trn);
    
    fprintf('%5.1f %5.1f %5.1f %5.1f \n', ...
        mn_emreg(i).tst, mn_bauck(i).tst, mn_b_our(i).tst, mn_felez(i).tst);
    
end
