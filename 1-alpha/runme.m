% bauckhage09 - demo
dbg = true;
nr = 8;
nc = 6;

dbnm = pathos('_db/silh/e01/');
DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

for f=1:sz
    if dbg, fprintf('%d. frame isleniyor\n', f);    end
    bws = imread(strcat(dbnm, DIR(f).name));
    
    bws = imresize(bws, 2);
    
    BB = fe_bauckhage09(bws, nr, nc, true, false);
    
    if dbg
        figure(1),  imshow(bws);
        drawnow
    end
end