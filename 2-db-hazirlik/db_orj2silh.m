function db_orj2silh(dbnm, dbnm_silh, dbg)
% function db_orj2silh(dbnm, dbnm_silh, dbg)

mkdir(dbnm_silh);
if length(dir(dbnm_silh)) > 2,   return,     end;

dDIR = dir(dbnm);
ds = length(dDIR);

for d=1:ds
    if ~dDIR(d).isdir || isempty(regexp(dDIR(d).name, '\w+'))
        continue
    end
    
    dnm = dDIR(d).name;
    if dbg, fprintf('dir nm: %s\n', dnm);   end
    dfnm_bw   = pathos(strcat(dbnm,      dnm, '/'));        % Directory Full NaMe
    dfnm_silh = pathos(strcat(dbnm_silh, dnm, '/'));        mkdir(dfnm_silh);
   
    dDIR2 = dir(dfnm_bw);
    ds2 = length(dDIR2);
    
    for d2=1:ds2
        if ~dDIR2(d2).isdir || isempty(regexp(dDIR2(d2).name, '\w+'))
            continue
        end

        dnm2 = dDIR2(d2).name;
        if dbg, fprintf('\tdir nm: %s\n', dnm2);   end
        dfnm_bw2   = pathos(strcat(dfnm_bw,      dnm2, '/'));        % Directory Full NaMe
        dfnm_silh2 = pathos(strcat(dfnm_silh,    dnm2, '/'));        mkdir(dfnm_silh2);
   
        DIR = dir(strcat(dfnm_bw2, '*.png'));
        sz = length(DIR);

        for f=1:sz
            if dbg, fprintf('\t\t%02d / %02d. frame isleniyor\n', f, sz);    end
            bw = imread(strcat(dfnm_bw2, DIR(f).name));

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
                T = 0.75 * majlen(idx);
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

            imwrite(bws, strcat(dfnm_silh2, DIR(f).name));

            if dbg
                figure(1),  
                subplot(211),   imshow(bw);     title(num2str(f))
                subplot(212),   imshow(bws);
                drawnow
            end
        end
    end
end