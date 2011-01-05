function mn = mean_struct(st, dbg)
% function mn = mean_struct(st, dbg)
% 
% st(i).lvq.trn -> mean -> 
% mn.lvq.trn
c = struct2cell(st);

[n_om, t, n_s] = size(c);   % n_om: number of "ogrenen makine" alg., n_s: sample

for i=1:n_om
    if dbg,     fprintf('%d. ogr.mak.alg....\n', i);    end
    
    for j=1:n_s
        if dbg,     fprintf('\t%d. sample...\n', j);    end

        ct(j)  = c{i, 1, j}.ct;
        trn(j) = c{i, 1, j}.trn;
        tst(j) = c{i, 1, j}.tst;
    end
    
    mn(i).ct  = mean(ct);
    mn(i).trn = mean(trn);
    mn(i).tst = mean(tst);
end














% % rst = struct([]);
% % 
% % sz = length(st);
% % fnm_om = fieldnames(st); % ogrenen makine
% % 
% % for i=1:sz
% %     [a{1:sz}] = deal(getfield(st, char(fnm_om(i))))
% % end