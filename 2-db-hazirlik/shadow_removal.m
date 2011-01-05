function srBW = shadow_removal(bw)
% function srBW = shadow_removal(bw)
%bw1 = imfill(bw, 'holes');
bw1 = bw; 
bw2 = imerode(bw1, ones(10));
bw3 = imdilate(bw2, ones(30));%strel('line', 55, 90));
srBW = bw1 & bw3;