function phead = fe_phead(bw, dbg)
% function phead = fe_phead(bw, dbg)
pNeck = fe_pneck(bw, dbg);

bw_head = bw(1:pNeck, :);

if dbg
    figure(61), imshow(bw_head);
end

L = bwlabel(bw_head);
s = regionprops(L, 'centroid');
phead = cat(1, s.Centroid);
