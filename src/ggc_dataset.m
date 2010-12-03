% function ggc_dataset(dbnm, dbg)
% function ggc_dataset(dbnm, dbg)
% 
% GGC data setini uretir

%frm(:,:,f) = bw;

dbnm_silh = pathos('_db/silh/');
dbnm_ccrop = pathos('_db/ccrop/');
dbnm_features = pathos('_db/features/');

db_bw2silh(dbnm, dbnm_silh, dbg);
db_silh2ccrop(dbnm_silh, dbnm_ccrop, dbg);
features = db_ccrop2features(dbnm_ccrop, dbnm_features, dbg);

return

    % Gait Energy Image
    cfrm = cycle_crop(frm, W, false);

    gei = mean(double(cfrm), 3);
    gei = uint8(gei * 255); % normalization: 0-255

    if false,
        figure(13);
        imshow(gei);    title('Gait Energy Image');
    end

    % crop feature
    [cfrm, cS, cE] = cycle_crop(frm, W, false);
    cw = w(:, cS:cE);
    cR = R(:,:, cS:cE);
    
    % CG: tum numuneler, CC: tum numunelerin siniflari
    
    CG(d, 1) = mean(cw(1, :));%mean
    CG(d, 2) = mean(cw(2, :));%mean
    CG(d, 3) = mean(cw(3, :));%mean
    CG(d, 4) = mean(cw(4, :));%mean
    CG(d, 5) = mean(cR(1, 3, :)) / mean(cR(1, 4, :));
    CG(d, 6) = mean(cR(1, 5, :));
    CG(d, 7) = abs(max(cR(2, 1, :)) - max(cR(3, 1, :)));
    CG(d, 8) = abs(max(cR(4, 1, :)) - max(cR(5, 1, :)));
    CG(d, 9) = abs(max(cR(6, 1, :)) - max(cR(7, 1, :)));
    CG(d, 10) = max(cR(7, 5, :)) / min(cR(7, 5, :));
    
    if (dnm(1) == 'e')
        CC(d) = 0;
    elseif (dnm(1) == 'k')
        CC(d) = 1;
    else
        CC(d) = -1;
    end
    CC = CC';
%end

% 0 ile 1 arasinda normalizasyon
for i=1:size(CG, 2)
    if min(CG(:, i)) < 0
       CG(:, i) = CG(:, i) + abs(min(CG(:, i)));
       CG(:, i) = CG(:, i) / max(CG(:, i));
    else
       CG(:, i) = CG(:, i) - min(CG(:, i));
       CG(:, i) = CG(:, i) / max(CG(:, i));
    end
end

% normalizasyon sonu

C = CG; C(:, i+1) = CC; % nitelik-sinif bir arada C' nin icerisinde.

dlmwrite(pathos(strcat(dbnm, 'ds/dataset.bak')), CG, ',');
dlmwrite(pathos(strcat(dbnm, 'ds/dsclass.bak')), CC, ',');
