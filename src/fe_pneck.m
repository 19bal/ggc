function pNeck = fe_pneck(bw)
% function pNeck = fe_pneck(bw)
bw4 = bw(1:size(bw,1)/4, :);

bw1 = imerode(bw4,  strel('line', 10,0));
bw1 = imdilate(bw1, strel('line', 10,0));

bw2 = bitxor(bw4, bw1);
imshow(bw2)

L = bwlabel(bw2);
s = regionprops(L, 'boundingbox');
bbox = cat(1, s.BoundingBox);

pNeck = bbox(4);