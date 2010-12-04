function ndata = db_normalization(data, dbg);
% function ndata = db_normalization(data, dbg);
% 
% 0 ile 1 arasinda normalizasyon

% struct -> array
tmp = cat(1, data.X);

mn = min(tmp, [], 1);
tmp = tmp - repmat(mn, [size(tmp, 1) 1]);
mx = max(tmp, [], 1);
tmp = tmp ./ repmat(mx, [size(tmp, 1) 1]);

% array -> struct
sz = length(data);

for d=1:sz
    ndata(d).X = tmp(d, :);
    ndata(d).y = data(d).y;
end