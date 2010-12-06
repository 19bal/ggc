function bwm = immerge(bws, dbg)
% function bwm = immerge(bws, dbg)

% 1. kopuk parcalari birlestir
dip_initialise('silent');
a = dip_image(bws);
b = bdilation(a,2,-1,0);
c = berosion(b,2,-1,1);

ch = hull(a,1);
bwm = boolean(ch .* or(a, c));

% 2. merge
L = bwlabel(bwm);
ns = max(L(:));

s = regionprops(L, {'area'});
areas = cat(1, s.Area);
[t, idx] = max(areas);    

% a) iki nesnenin birbirine en yakin uclarindan birlestir
if ns > 1        
    % contour image
    for n=1:ns
        C{n, :,:} = imcontour(ismember(L, n), 1);
    end

    for n=1:ns
        if n == idx,    continue;   end

        clear EM;
        nc = length(C{n, :,:});
        for c=1:nc
            A = C{idx, :,:}';
            B = C{n, :, :}'; B = B(c, :);

            t = euclid_distance(A, B);
            [mn, id] = min(t);
            EM(c, :) = [mn id]';
        end

        [t, idk] = min(EM(:, 1));
        idb = EM(idk, 2);

        % en yakin koordinatlar
        t = C{idx};     bkx = t(:, idb);
        t = C{n};       bky = t(:, idk);

        % gercel sayilar soz konusu: en yakina dogru sonuc uretmiyor
        % ne tarafa yuvarlanacak asagi/yukari
        % olasi koordinatlar icerisinde en yakin olanini bul
        asX = floor(bkx(1));   usX = ceil(bkx(1));
        asY = floor(bkx(2));   usY = ceil(bkx(2));
        cbkx = unique([[asY asX]; [asY usX]; [usY asX]; [usY usX]], 'rows');

        asX = floor(bky(1));   usX = ceil(bky(1));
        asY = floor(bky(2));   usY = ceil(bky(2));
        cbky = unique([[asY asX]; [asY usX]; [usY asX]; [usY usX]], 'rows');

        % foreground olanlari sec
        Lv = L(:);

        ind = sub2ind(size(L), cbkx(:,1), cbkx(:,2));
        t = find(Lv(ind) == idx);
        cbkx = cbkx(t, :);

        ind = sub2ind(size(L), cbky(:,1), cbky(:,2));
        t = find(Lv(ind) == n);
        cbky = cbky(t, :);

        clear EM;
        nc = size(cbky, 1);
        for c=1:nc
            t = euclid_distance(cbkx, cbky(c, :));

            [mn, id] = min(t);
            EM(c, :) = [mn id]';          
        end

        [t, idk] = min(EM(:, 1));
        idb = EM(idk, 2);

        % en yakin piksellerin koordinati -> 
        % birlestirme baslangic koordinatlari
        bkx = cbkx(idb, :);
        bky = cbky(idk, :);

        % birlestirme basl. koord. itibaren birlestir
        mn = min(bkx, bky);
        mx = max(bkx, bky);
        L(mn(1):mx(1), mn(2):mx(2)) = idx;

        % tum alt resmi idx ile doldur
        L(L == n) = idx;
    end
end

bwm = ismember(L, idx);

L = bwlabel(bwm);
if max(L(:)) > 1
    error('Merge edilmemis parca kalmis');
end