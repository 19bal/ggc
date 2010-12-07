function bws = bwsilh(bw, dbg)
% function bws = bwsilh(bw)
% bw goruntuyu alir, 64x64 lik sluet resmini dondurur
srBW = shadow_removal(bw);       
silh = bw2silh(srBW);
cimg = bwscrop(silh);
bws = bwsresize(cimg);

if dbg,
    figure(55);
    subplot(221);   imshow(bw);
    subplot(222);   imshow(silh);
    subplot(223);   imshow(cimg);
    subplot(224);   imshow(bws);
end
