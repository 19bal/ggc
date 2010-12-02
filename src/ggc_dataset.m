function ggc_dataset(dbnm, dbg)
% demo gait analysis
% clear all; close all;  clc;
% warning off all;

%dbg = true;
isCreateBW = false;

% % dbnm = strcat(DB_ROOT(), 'gait/soton/');
%dbnm = '../../db/hepsi/';

e = dir(pathos(strcat(dbnm, 'e*')));
k = dir(pathos(strcat(dbnm, 'k*')));
ek = cat(1, e, k);
ds = size(ek);

for d=1:ds,
    dnm = ek(d).name;
    if dbg, fprintf('dir nm: %s\n', dnm);   end
    bw_dbnm = pathos(strcat(dbnm, dnm, '/'));

    if isCreateBW
        bg = bgmodel(dbnm, dbg);
        bw_dbnm = frm2bw_db(dbnm, bg, dbg);
    end

    DIR = dir(strcat(bw_dbnm, '*.png'));
    sz = length(DIR);

    for f=1:sz,
        if dbg, fprintf('\t%2d. frame isleniyor\n', f); end

        imgnm = DIR(f).name;    
        bw = imread(strcat(bw_dbnm, imgnm));

        frm(:,:,f) = bw;         

        bws = bwsilh(bw, false);

        s = fextract(bws, dbg);
        moments(f, :) = cat(1, s.moments);
        W(:, f) = cat(1, s.W);
        H(:, f) = cat(1, s.H);
        angles(:, f) = cat(1, s.angle);
        areas(:, f)  = cat(1, s.area);
        w(:, f) = cat(1, s.w); % gaTech
        R(:,:, f) = cat(1, s.R); % MIT

        if false,
            figure(11);
            imshow(bws);        

            figure(12);  
            subplot(411);   plot(moments(:,1)); title('Hu1');
            subplot(412);   plot(moments(:,2)); title('Hu2');
            subplot(413);   plot(moments(:,3)); title('Hu8');
            subplot(414);   plot(W);        
            drawnow;
        end

        if false,
            drawnow
            ffrm = getframe();
            [X, map] = rgb2ind(frame2im(ffrm), 256);
            gifIMG(:,:,1,f) = X;
        end
    end
    if false
        imwrite(gifIMG, map, 'anim_mit.gif', 'DelayTime',0,'LoopCount',inf);
    end

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
end

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
