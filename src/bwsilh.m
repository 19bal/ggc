function bws = bwsilh(bw)
% function bws = bwsilh(bw)
srBW = shadow_removal(bw);       
bwSilh = bw2silh(srBW);
cimg = bwscrop(bwSilh);
bws = bwsresize(cimg);