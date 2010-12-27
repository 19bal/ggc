function db_in2out(handle_image_process, dbnm_in, dbnm_out, dbg)
% function db_in2out(handle_image_process, dbnm_in, dbnm_out, dbg)

mkdir(dbnm_out);
if length(dir(dbnm_out)) > 2,   return,     end;

dDIR = dir(dbnm_in);
ds = length(dDIR);

for d=1:ds
    if ~dDIR(d).isdir || isempty(regexp(dDIR(d).name, '\w+'))
        continue
    end
    
    dnm = dDIR(d).name;
    if dbg, fprintf('dir nm: %s\n', dnm);   end
    dbnm_in   = pathos(strcat(dbnm_in,      dnm, '/'));        % Directory Full NaMe
    dbnm_out = pathos(strcat(dbnm_out, dnm, '/'));        mkdir(dbnm_out);
   
    dDIR2 = dir(dbnm_in);
    ds2 = length(dDIR2);
    
    for d2=1:ds2
        if ~dDIR2(d2).isdir || isempty(regexp(dDIR2(d2).name, '\w+'))
            continue
        end

        dnm2 = dDIR2(d2).name;
        if dbg, fprintf('\tdir nm: %s\n', dnm2);   end
        dbnm_in2   = pathos(strcat(dbnm_in,      dnm2, '/'));        % Directory Full NaMe
        dbnm_out2 = pathos(strcat(dbnm_out,    dnm2, '/'));        mkdir(dbnm_out2);
   
        DIR = dir(strcat(dbnm_in2, '*.png'));
        sz = length(DIR);

        for f=1:sz
            if dbg, fprintf('\t\t%02d / %02d. frame isleniyor\n', f, sz);    end
            fr_in = imread(strcat(dbnm_in2, DIR(f).name));

            fr_out = handle_image_process(fr_in, dbg);
            
            imwrite(fr_out, strcat(dbnm_out2, DIR(f).name));

            if dbg
                figure(11),  
                subplot(211),   imshow(fr_in);     title(num2str(f))
                subplot(212),   imshow(fr_out);
                drawnow
            end
        end
    end
end