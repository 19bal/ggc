% function [R, aR] = fe_mit(bw, dbg);
% function [R, aR] = fe_mit(bw, dbg);
% 
% Makale:
% 1. Gait Analysis for Recognition and Classification
% 2. Gender Classification Based on Fusion of Multi-view Gait Sequences

%% pelvis: agirlik merkezi
pPelvis = fe_ppelvis(bw);

%% neck: boyun
pNeck = fe_pneck(bw, dbg);
% pNeckX = pPelvis(1);

%% knee: diz; yuzdesel al
H = size(bw, 1);
pf = H - pPelvis(2);
pKnee = round(0.4 * pf + pPelvis(2));
% pKneeX = pPelvis(1);

%% regions
% +-----------------+
% |                 |
% |        1        |
% |                 | neck
% +--------o--------+
% |   2    |   3    |
% +--------o--------+ pelvis
% |   4    |   5    |
% +--------o--------+ knee
% |   6    |   7    |
% +--------+--------+
% 
% RECT = [X, Y, W, H]
W = size(bw, 2);

N{:,:,1} = imcrop(bw, [1,           1,          W,                  pNeck - 1           ]);
N{:,:,2} = imcrop(bw, [1,           pNeck,      pPelvis(1) - 1,     (pPelvis(2) - pNeck)]);
N{:,:,3} = imcrop(bw, [pPelvis(1),  pNeck,      (W - pPelvis(1)),   (pPelvis(2) - pNeck)]);
N{:,:,4} = imcrop(bw, [1,           pPelvis(2), pPelvis(1) - 1,     (pKnee - pPelvis(2))]);
N{:,:,5} = imcrop(bw, [pPelvis(1),  pPelvis(2), (W - pPelvis(1)),   (pKnee - pPelvis(2))]);
N{:,:,6} = imcrop(bw, [1,           pKnee,      pPelvis(1) - 1,     (H - pKnee)         ]);
N{:,:,7} = imcrop(bw, [pPelvis(1),  pKnee,      (W - pPelvis(1)),   (H - pKnee)         ]);

%% R_i = (X_i, Y_i, L_i, alpha_i), i = 1..7
% fitellipse
ri = 1:7;
for i=ri %1:7,
    bbw = N{:,:,i};
    %if dbg,subplot(3,3,i), imshow(bbw),end
    a = myfitellipse(bbw, dbg);    
    R(i, :) = a;
end

aR = R;
aR(2,2) = R(2,2) + pNeck;
aR(3,1) = R(3,1) + pPelvis(1);
aR(3,2) = R(3,2) + pNeck;
aR(4,2) = R(4,2) + pPelvis(2);
aR(5,1) = R(5,1) + pPelvis(1);
aR(5,2) = R(5,2) + pPelvis(2);
aR(6,2) = R(6,2) + pKnee;
aR(7,1) = R(7,1) + pPelvis(1);
aR(7,2) = R(7,2) + pKnee;

if dbg,
    if ~true,
        figure(44),
        subplot(211),   imshow(bw)    
        subplot(212),   imshow(bw1)

        hold on;
        rectangle('Position', bbox(hi,:), 'EdgeColor', 'r', 'LineWidth', 1);
        rectangle('Position', bbox(bi,:), 'EdgeColor', 'g', 'LineWidth', 1);
        hold off;
    end
    
    figure(45),
    %imshow(zeros(size(bw))); 
    imshow(bw); 
    title('FE-MIT');
    hold on
    for i=ri %1:7
        %subplot(3,3,i+1),   imshow(N{:,:,i});   title(['N', num2str(i)]);                
        ellipse(aR(i,3), aR(i,4), aR(i,5), aR(i,1), aR(i,2), 'r');        
    end
    hold off

end

