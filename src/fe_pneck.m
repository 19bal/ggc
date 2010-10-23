% function pNeck = fe_pneck(bw, dbg)
% function pNeck = fe_pneck(bw)
bw4 = bw(1:size(bw,1)/4, :);

bw4 = imfill(bw4, 'holes');

bw1 = imerode(bw4,  strel('line', 10,0));
bw1 = imdilate(bw1, strel('line', 10,0));

bw2 = bitxor(bw4, bw1);

if dbg
    subplot(221),   imshow(bw4)
    subplot(222),   imshow(bw1)
    subplot(223),   imshow(bw2)
end

L = bwlabel(bw2);
s = regionprops(L, 'boundingbox');
bbox = cat(1, s.BoundingBox);

pNeck = bbox(4);