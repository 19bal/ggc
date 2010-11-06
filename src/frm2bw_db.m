function bw_dbnm = frm2bw_db(dbnm, bg, dbg);
% function bw_dbnm = frm2bw_db(dbnm, bg, dbg)
bw_dbnm = strcat(dbnm, 'bw/');

DIR = dir(strcat(dbnm, '*.png'));

Nf = 55:108;    %max(Nbg)+1:length(DIR);    % diger frameler

ind = 1;
mc = 25;    Mc = 45;
me = 15;     Me = 25;

for f=Nf,
    if dbg,
        fprintf('%2d. frame isleniyor\n', f);
    end
    
    imgnm = DIR(f).name;    
    frm = imread(strcat(dbnm, imgnm));
        
    confC = frm2confC(frm, bg, mc, Mc, false);
    
    %%<-- edge modeli aksiyor!
    % confE = frm2confE(frm, bg, me, Me, false);        
    % conf = max(confC, confE);
    %%-->
    conf = confC;
    
    bw = conf2bw(conf, dbg);
    
    bws = bwsilh(bw, dbg);   
    
    gifIMG(:,:,1,ind) = bws;    
    ind = ind + 1;
    imwrite(bws, strcat(bw_dbnm, imgnm));
end
imwrite(gifIMG, strcat(bw_dbnm, 'anim.gif'), 'DelayTime',0,'LoopCount',inf);

