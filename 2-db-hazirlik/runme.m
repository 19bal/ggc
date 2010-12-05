clear all;  close all;  clc;

dbg = true;

dbnm = pathos('_db/orjinal/');
DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%02d / %02d. frame isleniyor\n', f, sz);    end
    bw = imread(strcat(dbnm, DIR(f).name));
    
    % 1- yabanci nesneler
    L = bwlabel(bw);
    
    if max(L(:)) == 1       % tek nesneyse o siluettir
        bws = bw;
    else
        s = regionprops(L, {'area', 'centroid', 'majoraxislength'});
        areas = cat(1, s.Area);
        centroids = cat(1, s.Centroid);
        majlen = cat(1, s.MajorAxisLength);

        % a) alani en buyuk olandir
        [t, idx] = max(areas);
        bws = ismember(L, idx);

        % b) kafa gibi bazi organlar vucuddan ayri kalmis olabilir    
        T = majlen(idx);
        ns = length(centroids);

        for n=1:ns
            if n ~= idx
                fark(n) = euclid_distance(centroids(n,:), centroids(idx,:));
            end            
        end
        idy = find(find(fark < T) ~= idx);
        
        if ~isempty(idy)
            bws = ismember(L, [idx idy]);
        end
    end
        
    if dbg
        figure(1),  
        subplot(211),   imshow(bw);     title(num2str(f))
        subplot(212),   imshow(bws);
        drawnow
    end
end