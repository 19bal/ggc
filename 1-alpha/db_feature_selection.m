function data = db_feature_selection(features, dbg);
% function data = db_feature_selection(features, dbg);
% 
% data.X, data.y

data = struct();

sz = length(features);

for d=1:sz
    cw = features(d).w;
    cR = features(d).R;
    
    X(1) = mean(cw(1, :));%mean
    X(2) = mean(cw(2, :));%mean
    X(3) = mean(cw(3, :));%mean
    X(4) = mean(cw(4, :));%mean
    X(5) = mean(cR(1, 3, :)) / mean(cR(1, 4, :));
    X(6) = mean(cR(1, 5, :));
    X(7) = abs(max(cR(2, 1, :)) - max(cR(3, 1, :)));
    X(8) = abs(max(cR(4, 1, :)) - max(cR(5, 1, :)));
    X(9) = abs(max(cR(6, 1, :)) - max(cR(7, 1, :)));
    X(10) = max(cR(7, 5, :)) / min(cR(7, 5, :));

    if (features(d).dnm(1) == 'e')
        y = 0;
    elseif (features(d).dnm(1) == 'k')
        y = 1;
    else
        y = -1;
    end
    
    data(d).X = X;
    data(d).y = y;
end

