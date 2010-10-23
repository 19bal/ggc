% demo gait analysis
%clear all; close all;  clc;
warning off all;

dbg = true;
isCreateBW = false;

% % dbnm = strcat(DB_ROOT(), 'gait/soton/');
dbnm = '../../db/hepsi/';
bw_dbnm = strcat(dbnm, 'k01/');
bw_dbnm = strrep(bw_dbnm, '/', filesep);

if isCreateBW
    bg = bgmodel(dbnm, dbg);
    bw_dbnm = frm2bw_db(dbnm, bg, dbg);
end

DIR = dir(strcat(bw_dbnm, '*.png'));
sz = length(DIR);

for f=1:sz,
    if dbg,
        fprintf('%2d. frame isleniyor\n', f);
    end
    
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

