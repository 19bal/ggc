function [cS, cE] = cycle_crop(W, dbg)
% function [cS, cE] = cycle_crop(W, dbg)

y = sgolayfilt(W, 0, 3);
[ymax2,imax2,ymin2,imin2] = extrema(y);

cS = min(imin2(1), imin2(3));
cE = max(imin2(1), imin2(3));

if dbg,
    figure(55);
    plot(W);
    t = 1:length(W);
    hold on; 
    plot(cS, y(cS), 'r*', ...
         cE, y(cE), 'r*'); 
    hold off
end