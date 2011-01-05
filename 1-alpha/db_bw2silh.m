function db_bw2silh(dbnm, dbnm_silh, dbg)
% function db_bw2silh(dbnm, dbnm_silh, dbg)

if length(dir(dbnm_silh)) > 2,    return;   end
    
mkdir(dbnm_silh);

dDIR = cat(1, dir(pathos(strcat(dbnm, 'e*'))), ...
              dir(pathos(strcat(dbnm, 'k*'))));      % Directory DIR
ds = size(dDIR);

for d=1:ds,
    dnm = dDIR(d).name;
    if dbg, fprintf('dir nm: %s\n', dnm);   end
    dfnm_bw   = pathos(strcat(dbnm,      dnm, '/'));        % Directory Full NaMe
    dfnm_silh = pathos(strcat(dbnm_silh, dnm, '/'));        mkdir(dfnm_silh);
    
    % < FIXME:
    %if length(dir(strcat(dfnm_bw, '*.png'))) < 1
    %    bg = bgmodel(dbnm, dbg);
    %    dfnm_bw = frm2bw_db(dbnm, bg, dbg);
    %end
    % >    
    
    DIR = dir(strcat(dfnm_bw, '*.png'));
    sz = length(DIR);

    for f=1:sz,
        if dbg, fprintf('\t%2d. frame isleniyor\n', f); end

        imgnm = DIR(f).name;    
        bw = imread(strcat(dfnm_bw, imgnm));        
        
        bws = bwsilh(bw, false);
        imwrite(bws, strcat(dfnm_silh, imgnm));
        
        if dbg
            figure(11); imshow(bws); drawnow;
        end
    end
end
