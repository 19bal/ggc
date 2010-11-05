function pNeck = fe_pneck(bw, dbg)
% function pNeck = fe_pneck(bw)
bw4 = bw(1:size(bw,1)/4, :);

bw4 = imfill(bw4, 'holes');

L = bwlabel(bw4);
s = regionprops(L, 'centroid');
cent = round(cat(1, s.Centroid));
bw4 = bw4(:,1:cent(1));

t = sum(bw4');
mx = max(t);

bw1 = imerode(bw4,  strel('line', mx - 1,0));
bw1 = imdilate(bw1, strel('line', mx - 1,0));

%bw2 = bitxor(bw4, bw1);
bw2 = bw1;

if dbg
    figure(54);
    subplot(221),   imshow(bw4)
    subplot(222),   imshow(bw1)
    subplot(223),   imshow(bw2)
end

L = bwlabel(bw2);
s = regionprops(L, 'boundingbox');
bbox = cat(1, s.BoundingBox);

% y si enkucuk olan kafadir
[y, i] = min(bbox(:,2));

pNeck = bbox(i,4);