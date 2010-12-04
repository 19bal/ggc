function features = db_ccrop2features(dbnm_ccrop, dbnm_features, dbg);
% function features = db_ccrop2features(dbnm_ccrop, dbnm_features, dbg);

fnm_features = 'features.mat';
ffnm_features = pathos(strcat(dbnm_features, fnm_features));

if exist(ffnm_features)
    load(ffnm_features);
else
    features = struct();

    dDIR = cat(1, dir(pathos(strcat(dbnm_ccrop, 'e*'))), ...
                  dir(pathos(strcat(dbnm_ccrop, 'k*'))));
    ds = size(dDIR);

    for d=1:ds,
        dnm = dDIR(d).name;
        if dbg, fprintf('dir nm: %s\n', dnm);   end    
        dfnm_ccrop = pathos(strcat(dbnm_ccrop, dnm, '/'));

        DIR = dir(strcat(dfnm_ccrop, '*.png'));
        sz = length(DIR);

        for f=1:sz,
            if dbg, fprintf('\t%2d. frame isleniyor\n', f); end
            imgnm = DIR(f).name;    
            bws = imread(strcat(dfnm_ccrop, imgnm));

            s = fextract(bws, dbg);

            moments(f, :) = cat(1, s.moments);
            W(:, f) = cat(1, s.W);
            H(:, f) = cat(1, s.H);
            angles(:, f) = cat(1, s.angle);
            areas(:, f)  = cat(1, s.area);
            w(:, f) = cat(1, s.w); % gaTech
            R(:,:, f) = cat(1, s.R); % MIT

            if dbg,
                figure(21);
                    imshow(bws);        

                figure(22);  
                    subplot(411);   plot(moments(:,1)); title('Hu1');
                    subplot(412);   plot(moments(:,2)); title('Hu2');
                    subplot(413);   plot(moments(:,3)); title('Hu8');
                    subplot(414);   plot(W);        
                    drawnow;
            end
        end

        features(d).dnm = dnm;
        features(d).moments = moments;
        features(d).W = W;
        features(d).H = H;
        features(d).angles = angles;
        features(d).areas = areas;
        features(d).w = w;
        features(d).R = R;
    end

    curdir = pwd;
        mkdir(dbnm_features);
        cd(dbnm_features);
        save features.mat features
    cd(curdir);
end